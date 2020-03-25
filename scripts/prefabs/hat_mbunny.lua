local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/hat_mbunny.zip"),
	Asset("ANIM", "anim/hat_mbunny2.zip"),
	Asset("ATLAS", "images/inventoryimages/hat_mbunny.xml"),
	Asset("IMAGE", "images/inventoryimages/hat_mbunny.tex")
}

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.armor:InitIndestructible(0)
		return
	end

	if not inst.EnergyOn then
		if inst.level < 10 then
			inst.components.equippable.walkspeedmult = 1.05
		elseif inst.level < 20 then
			inst.components.equippable.walkspeedmult = 1.08
		elseif inst.level < 30 then
			inst.components.equippable.walkspeedmult = 1.12
		else
			inst.components.equippable.walkspeedmult = 1.15
		end
	else
		if inst.level < 30 then
			inst.components.equippable.walkspeedmult = 1.20 + math.floor((inst.level - 1) / 5) * 0.05
		else
			inst.components.equippable.walkspeedmult = 1.50
		end
	end

	if inst.level < 15 then
		inst.components.insulator.insulation = TUNING.INSULATION_SMALL
	elseif inst.level < 30 then
		inst.components.insulator.insulation = TUNING.INSULATION_MED
	else
		inst.components.insulator.insulation =
			(inst.EnergyOn and inst.components.fueled:IsEmpty()) and TUNING.INSULATION_LARGE * 2 or TUNING.INSULATION_MED * 2
	end

	inst.components.armor:InitIndestructible(math.max(19 + inst.level, inst.level * 2 - 12) * 0.01)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				STRINGS.MUSHA_HAT_BUNNY ..
					" (LV%d)\n" ..
						STRINGS.MUSHA_ITEM_SPEED ..
							"(" ..
								(inst.components.equippable.walkspeedmult - 1) * 100 ..
									")\n" .. STRINGS.MUSHA_ITEM_WARMNCOOL .. "(%s)\n" .. STRINGS.MUSHA_ARMOR .. " (%d)",
				inst.level,
				(inst.level < 15 and "Small") or (inst.level < 30 and "MED") or
					((inst.EnergyOn and inst.components.fueled:IsEmpty()) and "Great") or
					"Large",
				math.max(19 + inst.level, inst.level * 2 - 12)
			)
		)
	end
	print((inst.components.equippable.walkspeedmult - 1) * 100)
end

local function ChangeInsulation(inst)
	if TheWorld.state.issummer then
		inst.components.insulator:SetSummer()
	elseif not TheWorld.state.issummer then
		inst.components.insulator:SetWinter()
	end
end

local function Enable_Goggle(inst)
	local owner = inst.components.inventoryitem.owner
	if not inst.components.fueled:IsEmpty() and owner:HasTag("player") then
		if owner:GetSandstormLevel() >= TUNING.SANDSTORM_FULL_LEVEL and not owner.components.playervision:HasGoggleVision() then
			if not inst:HasTag("goggles") then
				inst:AddTag("goggles")
			end
		else
			inst:RemoveTag("goggles")
		end
	end
end

local function Energy_Switch(inst)
	local owner = inst.components.inventoryitem.owner
	if not inst.EnergyOn then
		if inst.components.fueled:IsEmpty() then
			return
		end

		inst.Goggle = inst:DoPeriodicTask(0.5, Enable_Goggle)
		inst.components.fueled.rate = 0.027
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny2", "swap_hat")
	else
		if inst.Goggle then
			inst.Goggle:Cancel()
			inst.Goggle = nil
		end
		inst.components.fueled.rate = 0
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny", "swap_hat")
	end
	inst.EnergyOn = not inst.EnergyOn
	Updata(inst)
	inst.components.useableitem:StopUsingItem()
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)

	ChangeInsulation(inst)
	inst:ListenForEvent("seasonChange", ChangeInsulation)
	inst:ListenForEvent("attacked", inst.BeAttacked, owner)

	owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny", "swap_hat")

	owner.AnimState:Hide("HAIR")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Show("HAT_HAIR")
	owner.AnimState:Show("HAT")

	Updata(inst)
end

local function OnUnequip(inst, owner)
	if inst.EnergyOn then
		Energy_Switch(inst)
	end

	inst:RemoveEventCallback("seasonChange", ChangeInsulation)
	inst:RemoveEventCallback("attacked", inst.BeAttacked, owner)

	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 450, type = "hat", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst:AddTag("musha_items")
	--inst:AddTag("goggles")

	inst.AnimState:SetBank("beehat")
	inst.AnimState:SetBuild("hat_mbunny")
	inst.AnimState:PlayAnimation("anim")
	inst.MiniMapEntity:SetIcon("hat_mbunny.tex")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mbunny.xml"

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
		inst.components.inventoryitem.owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny", "swap_hat")
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

return Prefab("common/inventory/hat_mbunny", fn, assets)
