local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/hat_mwildcat.zip"),
	Asset("ANIM", "anim/hat_mwildcat2.zip"),
	Asset("ATLAS", "images/inventoryimages/hat_mwildcat.xml"),
	Asset("IMAGE", "images/inventoryimages/hat_mwildcat.tex")
}

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.armor:InitIndestructible(0)
		return
	end
	inst.components.insulator.insulation = inst.level > 10 and TUNING.INSULATION_SMALL or TUNING.INSULATION_MED
	inst.components.armor:InitIndestructible(math.max(45 + inst.level, 30 + inst.level * 2) * 0.01)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				STRINGS.MUSHA_HAT_CAT .. " (LV%d)\n" .. STRINGS.MUSHA_ARMOR .. " (%d)\n" .. STRINGS.MUSHA_ITEM_WARMNCOOL .. "(%s)",
				inst.level,
				math.max(45 + inst.level, 30 + inst.level * 2),
				inst.level > 10 and "SMALL" or "MED"
			)
		)
	end
end

local function ChangeInsulation(inst)
	if TheWorld.state.issummer then
		inst.components.insulator:SetSummer()
	elseif not TheWorld.state.issummer then
		inst.components.insulator:SetWinter()
	end
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)

	ChangeInsulation(inst)
	inst:ListenForEvent("seasonChange", ChangeInsulation)
	inst:ListenForEvent("attacked", inst.BeAttacked, owner)

	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	owner.AnimState:OverrideSymbol("swap_hat", "hat_mwildcat", "swap_hat")
	owner.AnimState:Hide("HAIR")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Show("HAT_HAIR")
	owner.AnimState:Show("HAT")
	Updata(inst)
end

local function Energy_Switch(inst, data, owner, fname_override)
	local owner = inst.components.inventoryitem.owner
	if not inst.EnergyOn then
		if inst.components.fueled:IsEmpty() then
			return
		end
		inst.components.fueled.rate = 0.09
		SpawnPrefab("collapse_small").Transform:SetPosition(inst:GetPosition():Get())
		inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mwildcat2", "swap_hat")
		inst.Light:Enable(true)
	else
		inst.components.fueled.rate = 0
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mwildcat", "swap_hat")
		inst.Light:Enable(false)
	end
	inst.EnergyOn = not inst.EnergyOn
	Updata(inst)
	inst.components.useableitem:StopUsingItem()
end

local function OnUnequip(inst, owner)
	if inst.EnergyOn then
		Energy_Switch(inst)
	end
	inst.Light:Enable(false)
	inst:RemoveEventCallback("attacked", inst.BeAttacked, owner)
	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 850, type = "hat", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.entity:AddLight()
	inst.Light:SetFalloff(0.4)
	inst.Light:SetIntensity(.7)
	inst.Light:SetRadius(2.5)
	inst.Light:SetColour(155 / 255, 175 / 255, 195 / 255)
	inst.Light:Enable(false)

	inst.AnimState:SetBank("hat_mwildcat")
	inst.AnimState:SetBuild("hat_mwildcat")

	inst.AnimState:PlayAnimation("idle")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mwildcat.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Energy_Switch)
	inst.components.inventoryitem:SetOnDroppedFn(
		function()
			inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
		end
	)

	inst:AddComponent("insulator")

	inst.Updata = Updata
	inst.OnBroken = function(inst)
		if inst.EnergyOn then
			Energy_Switch(inst)
			inst.EnergyOn = true
		end
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
	inst.Rebind = function(inst)
		if inst.EnergyOn then
			inst.EnergyOn = false
			Energy_Switch(inst)
		end
	end

	return inst
end

return Prefab("common/inventory/hat_mwildcat", fn, assets)
