local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/hat_mphoenix.zip"),
	Asset("ATLAS", "images/inventoryimages/hat_mphoenix.xml"),
	Asset("IMAGE", "images/inventoryimages/hat_mphoenix.tex")
}

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.armor:InitIndestructible(0)
		return
	end
	inst.components.armor:InitIndestructible((inst.level < 30 and 64 + inst.level or 95) * 0.01)
	if not inst.EnergyOn then
		inst.components.equippable.walkspeedmult = math.floor(inst.level / 10) * 0.03 + 1.02
		inst.components.equippable.dapperness = 0
		inst.components.insulator.insulation = TUNING.INSULATION_MED
		if nil == display then
			inst.components.talker:Say(
				string.format(
					STRINGS.MUSHA_HAT_PHOENIX ..
						" (LV%d)\n" ..
							STRINGS.MUSHA_ARMOR .. " (%d)\n" .. STRINGS.MUSHA_ITEM_WARM .. "(MED)\n" .. STRINGS.MUSHA_ITEM_SPEED .. "(%d)",
					inst.level,
					inst.level < 30 and 64 + inst.level or 95,
					(inst.components.equippable.walkspeedmult - 1) * 100
				)
			)
		end
	else
		inst.components.equippable.walkspeedmult = math.floor(inst.level / 10) * 0.05 + 0.8
		inst.components.equippable.dapperness = inst.level <= 10 and TUNING.DAPPERNESS_MED or TUNING.DAPPERNESS_LARGE
		inst.components.insulator.insulation = TUNING.INSULATION_LARGE
		if nil == display then
			inst.components.talker:Say(
				string.format(
					"[" ..
						STRINGS.MUSHA_HAT_PHOENIX ..
							" (LV%d)\n" ..
								STRINGS.MUSHA_ARMOR ..
									" (%d)\n" ..
										STRINGS.MUSHA_ITEM_WARM ..
											"(Large)\n" ..
												STRINGS.MUSHA_ITEM_REGEN ..
													"(2)\n" .. STRINGS.MUSHA_ITEM_SANITY_REGEN .. "(%s)\n" .. STRINGS.MUSHA_ITEM_SPEED_DOWN .. "(20)",
					inst.level,
					inst.level < 30 and 64 + inst.level or 95,
					inst.level <= 10 and "MED" or "Large",
					(1 - inst.components.equippable.walkspeedmult) * 100
				)
			)
		end
	end
end

local function heal_owner(inst, owner)
	if (owner.components.health and owner.components.health:IsHurt()) then
		owner.components.health:DoDelta(1, false)
	end
end

local function Energy_Switch(inst)
	local owner = inst.components.inventoryitem.owner
	if not inst.EnergyOn then
		if inst.components.fueled:IsEmpty() then
			return
		end
		inst.heal_owner_task = inst:DoPeriodicTask(6, heal_owner, nil, owner)
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix", "swap_hat")
		inst.sleep_attacker = function(attacked, data)
			local attacker = data.attacker
			if data and attacker and attacker.components.sleeper then
				data.attacker.components.sleeper:AddSleepiness(5, 24)
				SpawnPrefab("small_puff").Transform:SetPosition(attacker:GetPosition():Get())
			end
		end
		inst:ListenForEvent("attacked", inst.sleep_attacker, owner)
	else
		if inst.heal_owner_task then
			inst.heal_owner_task:Cancel()
			inst.heal_owner_task = nil
		end
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix2", "swap_hat")
		inst:ListenForEvent("attacked", inst.sleep_attacker, owner)
	end
	inst.EnergyOn = not inst.EnergyOn
	Updata(inst)
	inst.components.useableitem:StopUsingItem()
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)

	Updata(inst)

	owner.AnimState:OverrideSymbol("swap_hat", "hat_mphoenix2", "swap_hat")

	owner.AnimState:Hide("HAIR")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Show("HAT_HAIR")
	owner.AnimState:Show("HAT")

	inst:ListenForEvent("attacked", inst.BeAttacked, owner)
end

local function OnUnequip(inst, owner)
	if inst.EnergyOn then
		Energy_Switch(inst)
	end

	if inst.health then
		inst.health:Cancel()
		inst.health = nil
	end

	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")

	inst:RemoveEventCallback("attacked", inst.BeAttacked, owner)
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 1800, type = "hat", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst:AddTag("metal")
	inst.AnimState:SetBank("beehat")
	inst.AnimState:SetBuild("hat_mphoenix")
	inst.AnimState:PlayAnimation("anim")
	inst.MiniMapEntity:SetIcon("hat_mphoenix.tex")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mphoenix.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Energy_Switch)

	inst:AddComponent("insulator")
	inst.EnergyOn = false

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

return Prefab("common/inventory/hat_mphoenix", fn, assets)
