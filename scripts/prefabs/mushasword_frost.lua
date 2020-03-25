local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/mushasword_frost.zip"),
	Asset("ATLAS", "images/inventoryimages/mushasword_frost.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword_frost.tex"),
	Asset("ANIM", "anim/swap_mushasword_base.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost1.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost2.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost3.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost1_boost.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost2_boost.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost3_boost.zip"),
	Asset("ANIM", "anim/swap_phoenixspear3rd.zip")
}

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.weapon:SetDamage(1)
		return
	end
	if inst.level == 11 then
		inst:PushEvent("level11")
	end

	inst.components.weapon:SetDamage(28 + inst.level * 2)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				STRINGS.MUSHA_WEAPON_SWORD_FROST .. " (LV%d)\n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
				inst.level,
				28 + inst.level * 2
			)
		)
	end
end

local function OnAttack(inst, attacker, target)
	if target and target.components.health and not target.components.health:IsDead() and target.components.freezable then
		local fx = SpawnPrefab("icespike_fx_" .. math.random(1, 4))
		if math.random() < 0.2 * math.ceil(inst.level * 0.1) * (inst.EnergyOn and 2 or 1) then
			target.components.freezable:AddColdness(0.12 * math.ceil(inst.level * 0.1) * (inst.EnergyOn and 2 or 1))
			target.components.freezable:SpawnShatterFX()
			target.components.health:DoDelta(-2 * math.ceil(inst.level * 0.1) * (inst.EnergyOn and 2 or 1))
			fx.Transform:SetScale(1, (0.4 + math.ceil(inst.level * 0.1) * 0.2) * (inst.EnergyOn and 2 or 1), 1)
			fx.Transform:SetPosition(target:GetPosition():Get())
		end
	end
	if math.random() < 0.1 and inst.exp < inst.maxexp then
		inst.exp = inst.exp + 1
		inst.Updata(inst, false)
	end
end

local function Transfer_Owner(inst)
	if not inst.components.blinkstaff then
		inst:AddComponent("blinkstaff")
		inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
		inst.components.blinkstaff.onblinkfn = function(staff, pos, caster)
			if caster.components.sanity ~= nil then
				caster.components.sanity:DoDelta(-6)
			end
		end
	end
end

local function Add_Transfer(inst)
	inst:RemoveEventCallback("level11", Add_Transfer)
	Transfer_Owner(inst)
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)
	Updata(inst)

	inst.Light:SetRadius(.4)
	inst.Light:SetFalloff(.5)
	inst.Light:SetIntensity(.5)
	if inst.level < 10 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
	elseif inst.level < 20 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost1", "swap_nightmaresword")
	else
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost2", "swap_nightmaresword")
		inst.Light:SetRadius(.8)
		inst.Light:SetFalloff(.5)
		inst.Light:SetIntensity(.5)
	end

	inst.Light:Enable(true)
	owner.AnimState:Hide("ARM_normal")
	owner.AnimState:Show("ARM_carry")
end

local function Energy_Switch(inst)
	local owner = inst.components.inventoryitem.owner
	if not inst.EnergyOn then
		if inst.components.fueled:IsEmpty() then
			return
		end

		inst.EnergyOn = true
		local owner = inst.components.inventoryitem.owner
		if inst.level > 10 then
			Transfer_Owner(inst)
		else
			inst:ListenForEvent("level11", Add_Transfer)
		end

		local change_fx = SpawnPrefab("splash")
		local follower = change_fx.entity:AddFollower()
		follower:FollowSymbol(owner.GUID, "swap_object", 1, -150, 1)

		inst.components.fueled.rate = 0.02
		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		if inst.level < 10 then
			inst.components.talker:Say(
				STRINGS.MUSHA_WEAPON_SWORD_POWER_1 ..
					"\n" .. STRINGS.MUSHA_ITEM_LIGHT .. "(1-)\n" .. STRINGS.MUSHA_ITEM_FREEZE .. "(4D/40C)"
			)
			inst.Light:SetRadius(.3)
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost1_boost", "swap_nightmaresword")
		elseif inst.level < 20 then
			inst.components.talker:Say(
				STRINGS.MUSHA_WEAPON_SWORD_POWER_2 ..
					"\n" ..
						STRINGS.MUSHA_ITEM_SPEED ..
							"(10)\n" ..
								STRINGS.MUSHA_ITEM_LIGHT .. "(2-)\n" .. STRINGS.MUSHA_ITEM_FREEZE .. "(8D/60C) \n" .. STRINGS.MUSHA_WEAPON_BLINK
			)
			inst.components.equippable.walkspeedmult = 1.1
			inst.components.equippable.runspeedmult = 1.1
			inst.Light:SetRadius(.5)
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost2_boost", "swap_nightmaresword")
		else
			inst.components.talker:Say(
				STRINGS.MUSHA_WEAPON_SWORD_POWER_3 ..
					"\n" ..
						STRINGS.MUSHA_ITEM_SPEED ..
							"(15)\n" ..
								STRINGS.MUSHA_ITEM_LIGHT ..
									"(3-)\n" .. STRINGS.MUSHA_ITEM_FREEZE .. "(12D/80C) \n" .. STRINGS.MUSHA_WEAPON_BLINK
			)
			inst.components.equippable.walkspeedmult = 1.15
			inst.components.equippable.runspeedmult = 1.15
			inst.Light:SetRadius(.8)

			if not inst.frostblade3rd_spear then
				owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost3_boost", "swap_nightmaresword")
			else
				owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear3rd", "phoenixspear")
			end
			if inst.frostblade3rd_spear_range then
				inst.components.weapon:SetRange(1.1)
			end

			inst.Light:SetFalloff(.5)
			inst.Light:SetIntensity(.5)
			inst.Light:Enable(true)
		end
	else
		inst.EnergyOn = false
		inst.components.fueled.rate = 0
		inst.components.talker:Say("-" .. STRINGS.MUSHA_WEAPON_SWORD_FROST .. "\n" .. STRINGS.MUSHA_WEAPON_SWORD_POWER_OFF)
		if inst.level >= 11 then
			inst:RemoveComponent("blinkstaff")
		else
			inst:RemoveEventCallback("level11", Add_Transfer)
		end
		inst.components.equippable.walkspeedmult = 1
		inst.components.equippable.runspeedmult = 1
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.components.weapon:SetRange(0)
		inst.Light:SetRadius(.4)
		inst.Light:SetFalloff(.5)
		inst.Light:SetIntensity(.5)
		if inst.level < 10 then
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
		elseif inst.level < 20 then
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost1", "swap_nightmaresword")
		else
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_frost2", "swap_nightmaresword")
			inst.Light:SetRadius(.8)
			inst.Light:SetFalloff(.5)
			inst.Light:SetIntensity(.5)
		end
	end
	inst.components.useableitem:StopUsingItem()
end

local function OnUnequip(inst, owner)
	if inst.EnergyOn then
		Energy_Switch(inst)
	end

	inst.Light:Enable(false)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
	owner.frost = false
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 750, type = "weapon", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.entity:AddLight()
	inst.Light:SetColour(80 / 255, 120 / 255, 250 / 255)

	inst.AnimState:SetBank("nightmaresword")
	inst.AnimState:SetBuild("mushasword_frost")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetMultColour(1, 1, 1, 0.7)

	inst.MiniMapEntity:SetIcon("blade_f.tex")
	inst:AddTag("sharp")
	inst:AddTag("aquatic")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword_frost.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Energy_Switch)

	inst.Updata = Updata
	inst.OnAttack = OnAttack
	inst.OnBroken = function(inst)
		if inst.EnergyOn then
			Energy_Switch(inst)
			inst.EnergyOn = true
		end
		local owner = inst.components.inventoryitem.owner
		owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
		inst.components.talker:Say("-" .. STRINGS.MUSHA_WEAPON .. "\n" .. STRINGS.MUSHA_ITEM_DUR .. " (0)")
		Updata(inst)
	end
	inst.Rebind = function(inst)
		if inst.EnergyOn then
			inst.EnergyOn = false
			Energy_Switch(inst)
		end
	end
	return inst
end

return Prefab("common/inventory/mushasword_frost", fn, assets)
