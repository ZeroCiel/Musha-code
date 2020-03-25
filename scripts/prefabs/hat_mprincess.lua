local Musha_Api = require "apis/CommonAPIs"

local assets = {
    Asset("ANIM", "anim/hat_mprincess.zip"),
    Asset("ATLAS", "images/inventoryimages/hat_mprincess.xml"),
    Asset("IMAGE", "images/inventoryimages/hat_mprincess.tex"),
    Asset("ANIM", "anim/hat_mcrown.zip")
}

local function Updata(inst, display)
    inst.level = Musha_Api.GetLevel(inst)
    if inst.components.fueled:IsEmpty() then
        inst.components.armor:InitIndestructible(0)
        return
    end
    inst.components.armor:InitIndestructible(math.max(inst.level + 10, inst.level * 2 - 10) * 0.01)
    inst.components.equippable.dapperness = inst.level < 20 and TUNING.DAPPERNESS_TINY or TUNING.DAPPERNESS_SMALL
    if nil == display then
        inst.components.talker:Say(
            string.format(
            (inst.level < 20 and STRINGS.MUSHA_HAT_PRINCESS or STRINGS.MUSHA_HAT_QUEEN) ..
                " (LV%d)\n" ..
                STRINGS.MUSHA_ITEM_SANITY_REGEN ..
                "(%s)\n" ..
                (inst.level > 20 and STRINGS.MUSHA_ITEM_REGEN .. "(slow)\n" or "") .. STRINGS.MUSHA_ARMOR .. " (%d)\n",
                inst.level,
                inst.level < 20 and "Tiny" or "Small",
                math.max(inst.level + 10 and inst.level * 2 - 10)
    )
    )
    end
end

local function OnHaunt(inst, haunter)
    if inst.cooldowntime ~= 0 or inst.level < 10 then
        return false
    end
    
    inst.components.fueled:MakeEmpty()
    inst.cooldowntime = 300
    inst.incooltime = math.ceil(GetTime())
    inst:DoTaskInTime(
        inst.cooldowntime,
        function()
            inst.cooldowntime = 0
        end
    )
    SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
    inst:DoTaskInTime(
        3,
        function()
            SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
            SpawnPrefab("glowdust").Transform:SetPosition(inst:GetPosition():Get())
            if not (inst.level >= 20 and haunter:HasTag("musha")) then
                inst:Remove()
            end
        end
    )
    return true
end

local function healowner(inst, owner)
    if inst.healing1 and not inst.broken then
        if (owner.components.health and owner.components.health:IsHurt()) then
            owner.components.health:DoDelta(1, false)
        end
    end
end

local function OnEquip(inst, owner)
    inst.Equippable_Check(inst, owner)
    
    Updata(inst)
    
    if inst.level < 20 then
        inst.components.equippable.dapperness = TUNING.DAPPERNESS_TINY
        owner.AnimState:OverrideSymbol("swap_hat", "hat_mprincess", "swap_hat")
    else
        inst.healing1 = true
        owner.AnimState:OverrideSymbol("swap_hat", "hat_mcrown", "swap_hat")
        
        inst.components.equippable.dapperness = TUNING.DAPPERNESS_SMALL
        if inst.healing1 and not inst.broken then
            inst.heal =
                inst:DoPeriodicTask(
                    60,
                    function()
                        healowner(inst, owner)
                    end
        )
        end
    end
    
    owner.AnimState:Hide("HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Show("HAT_HAIR")
    owner.AnimState:Show("HAT")
    
    inst:ListenForEvent("attacked", inst.BeAttacked)
end

local function StopShield(inst, data)
    if not (data.statename == "shell_idle" or data.statename == "shell_hit" or data.statename == "shell_enter") then
        inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD).components.useableitem:StartUsingItem()
    end
end

local function State_Change(inst)
    local owner = inst.components.inventoryitem.owner
    if not inst.on_shield then
        if inst.components.fueled:IsEmpty() then
            inst.components.talker:Say(STRINGS.MUSHA_ITEM_SHIELD_BROKEN .. "\n" .. STRINGS.MUSHA_ARMOR .. "(0)")
            inst.components.armor:InitIndestructible(0)
            return
        end
        
        inst.components.armor:InitIndestructible(1)
        inst.components.talker:Say(STRINGS.MUSHA_ITEM_SHIELD .. "\n" .. STRINGS.MUSHA_ARMOR .. "(100)")
        inst.components.fueled.rate = 0.008
        
        if owner then
            owner.sg:GoToState("hide")
            owner.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
        end
        inst:ListenForEvent("newstate", StopShield, owner)
        Updata(inst)
    else
        inst.components.fueled.rate = 0
        inst.healing1 = false
        inst:RemoveEventCallback("newstate", StopShield, owner)
        owner.sg:GoToState("idle")
    end
    inst.on_shield = not inst.on_shield
    inst.components.useableitem:StopUsingItem()
end

local function OnUnequip(inst, owner)
    if inst.on_shield then
        State_Change(inst)
    end
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
    if inst.consume then
        inst.consume:Cancel()
        inst.consume = nil
    end
    if inst.healowner then
        inst.healowner:Cancel()
        inst.healowner = nil
    end
    
    inst:RemoveEventCallback("attacked", inst.BeAttacked)
end

local function fn()
    local inst = Musha_Api.fn_common({maxfuel = 1050, type = "hat", OnEquip = OnEquip, OnUnequip = OnUnequip})
    inst.AnimState:SetBank("bushhat")
    inst.AnimState:SetBuild("hat_mprincess")
    inst.AnimState:PlayAnimation("anim")
    
    inst:AddTag("metal")
    inst:AddTag("hide")
    
    inst.MiniMapEntity:SetIcon("hat_mprincess.tex")
    
    inst.entity:SetPristine()
    if TheNet:GetIsClient() then
        return inst
    end
    
    inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mprincess.xml"
    inst.components.inventoryitem.foleysound = "dontstarve/movement/foley/bushhat"
    
    inst:AddComponent("useableitem")
    inst.components.useableitem:SetOnUseFn(State_Change)
    
    ----------resurrect
    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_INSTANT_REZ)
    inst.components.hauntable:SetOnHauntFn(OnHaunt)
    inst:ListenForEvent(
        "activateresurrection",
        function(inst, guy)
            TheWorld:PushEvent("ms_sendlightningstrike", inst:GetPosition())
            inst.SoundEmitter:PlaySound("dontstarve/common/resurrectionstone_break")
        end
    )
    inst.on_shield = false
    
    inst.Updata = Updata
    inst.OnBroken = function(inst)
            --[[ if inst.on_shield then
            State_Change(inst)
            end ]]
            if inst.components.armor.absorb_percent ~= 0 then
                inst.components.fueled:StopConsuming()
                inst.components.armor:InitIndestructible(0)
                inst.components.equippable.walkspeedmult = 1
                inst.components.talker:Say(
                    STRINGS.MUSHA_HAT_BROKEN .. "\n" .. STRINGS.MUSHA_ITEM_DUR .. " (0)\n" .. STRINGS.MUSHA_ITEM_SPEED .. "(0)"
            )
            end
            inst.components.fueled:StopConsuming()
    end
    inst.OnSave = function(inst, data)
        data.exp = inst.exp
        data.cooldowntime = inst.cooldowntime ~= 0 and math.ceil(GetTime()) - inst.incooltime or 0
    end
    
    inst.OnLoad = function(inst, data)
        if data ~= nil then
            inst.cooldowntime = data.cooldowntime or 0
            inst:DoTaskInTime(
                inst.cooldowntime,
                function()
                    inst.cooldowntime = 0
                end
        )
        end
    end
    
    return inst
end

return Prefab("common/inventory/hat_mprincess", fn, assets)
