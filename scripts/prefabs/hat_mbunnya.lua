local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/hat_mbunnya.zip"),
	Asset("ANIM", "anim/hat_mbunnya2.zip"),
	Asset("ATLAS", "images/inventoryimages/hat_mbunnya.xml"),
	Asset("IMAGE", "images/inventoryimages/hat_mbunnya.tex")
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

	if inst.level < 10 then
		inst.components.insulator.insulation = TUNING.INSULATION_SMALL
	elseif inst.level < 20 then
		inst.components.insulator.insulation = TUNING.INSULATION_MED
	elseif inst.level < 30 then
		inst.components.insulator.insulation = TUNING.INSULATION_MED_LARGE
	else
		inst.components.insulator.insulation = TUNING.INSULATION_LARGE
	end

	inst.components.armor:InitIndestructible(math.max(39 + inst.level, inst.level * 2 + 20) * 0.01)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				STRINGS.MUSHA_HAT_BUNNYA ..
					" (LV%d)\n" .. STRINGS.MUSHA_ARMOR .. " (%d)\n" .. STRINGS.MUSHA_ITEM_WARMNCOOL .. "(%s)",
				inst.level,
				math.max(19 + inst.level, inst.level * 2 - 12),
				(inst.level < 10 and "Small") or (inst.level < 20 and "MED") or (inst.level < 20 and "MED2") or "Large"
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

local function drop_Cat(inst, ranout)
	inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
	inst.Light:Enable(false)
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
		owner.SoundEmitter:PlaySound("dontstarve_DLC001/common/moggles_on")
		inst.Light:Enable(true)
		inst.components.fueled.rate = 0.075
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunny2", "swap_hat")

		inst.components.equippable.walkspeedmult =
			(inst.level <= 20 and 1.25 + 0.05 * math.floor(inst.level / 5)) or (inst.level <= 20 and 1.45) or 1.50

		inst.components.talker:Say(
			string.format(
				STRINGS.MUSHA_HAT_BUNNY .. "(%s)\n" .. STRINGS.MUSHA_ITEM_LIGHT .. "\n" .. STRINGS.MUSHA_ITEM_SPEED .. "(%d)",
				string.rep("I", (inst.components.equippable.walkspeedmult - 1.2) / 0.05),
				(inst.components.equippable.walkspeedmult - 1) * 100
			)
		)
	else
		owner.SoundEmitter:PlaySound("dontstarve_DLC001/common/moggles_off")
		inst.components.equippable.walkspeedmult = 1
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.Light:Enable(false)

		if inst.Goggle then
			inst.Goggle:Cancel()
			inst.Goggle = nil
		end
		inst.components.fueled.rate = 0
		owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunnya", "swap_hat")
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

	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")

	owner.AnimState:OverrideSymbol("swap_hat", "hat_mbunnya", "swap_hat")
	inst.Light:Enable(false)
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

	inst.boost = false
	--owner.components.playervision:ForceGoggleVision(false)
	--owner.components.playervision:ForceNightVision(false)

	owner.AnimState:Hide("HAT")
	owner.AnimState:Hide("HAT_HAIR")
	owner.AnimState:Show("HAIR_NOHAT")
	owner.AnimState:Show("HAIR")
end

local function fn(sim)
	local inst = Musha_Api.fn_common({maxfuel = 750, type = "hat", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.entity:AddLight()
	inst.Light:SetFalloff(0.4)
	inst.Light:SetIntensity(.7)
	inst.Light:SetRadius(1.8)
	inst.Light:SetColour(155 / 255, 175 / 255, 195 / 255)
	inst.Light:Enable(false)

	inst.AnimState:SetBank("hat_mbunnya")
	inst.AnimState:SetBuild("hat_mbunnya")

	inst.AnimState:PlayAnimation("idle")

	--TODO:删掉
	--inst:AddTag("nightvision")
	--inst:AddTag("goggles")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/hat_mbunnya.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Energy_Switch)

	inst.components.inventoryitem:SetOnDroppedFn(drop_Cat)

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
return Prefab("common/inventory/hat_mbunnya", fn, assets)
