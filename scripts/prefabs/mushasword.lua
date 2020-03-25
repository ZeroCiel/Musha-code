local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/mushasword.zip"),
	Asset("ATLAS", "images/inventoryimages/mushasword.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword.tex"),
	Asset("ANIM", "anim/swap_mushasword_base.zip"),
	Asset("ANIM", "anim/swap_mushasword.zip"),
	Asset("ANIM", "anim/swap_mushasword2.zip"),
	Asset("ANIM", "anim/swap_mushasword3.zip"),
	Asset("ANIM", "anim/swap_mushasword_boost.zip"),
	Asset("ANIM", "anim/swap_mushasword2_boost.zip"),
	Asset("ANIM", "anim/swap_mushasword3_boost.zip")
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
				STRINGS.MUSHA_WEAPON_SWORD_FIRE .. " (LV%d)\n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
				inst.level,
				28 + inst.level * 2
			)
		)
	end
end

local function OnAttack(inst, attacker, target)
	if
		target and target.components.health and not target.components.health:IsDead() and not target:HasTag("structure") and
			not target:HasTag("stalkerminion") and
			not target:HasTag("smashable") and
			not target:HasTag("alignwall") and
			not target:HasTag("shadowminion")
	 then
		local flamechance = math.random()
		local fx = SpawnPrefab("firesplash_fx")
		fx.Transform:SetScale(0.4, 0.4, 0.4)

		if not inst.EnergyOn then
			if (flamechance < 0.12 and inst.level <= 10) or (flamechance < 0.2 and inst.level <= 20) or flamechance < 0.28 then
				fx.Transform:SetPosition(target:GetPosition():Get())
				if target.components.burnable then
					target.components.burnable:Ignite()
				end
				target.components.health:DoDelta(-math.ceil(inst.level * 0.1) * 5)
			end
		else
			if flamechance < 0.17 and inst.level < 10 then
				fx.Transform:SetPosition(target:GetPosition():Get())
				if target.components.burnable then
					target.components.burnable:Ignite()
				end
				target.components.health:DoDelta(-10)
			elseif flamechance < 0.25 and inst.level < 20 then
				if target.components.burnable then
					target.components.burnable:Ignite()
				end
				target.components.health:DoDelta(-20)
				fx.Transform:SetPosition(target:GetPosition():Get())
				if math.random() < 0.33 then
					SpawnPrefab("statue_transition").Transform:SetPosition(Vector3(target.Transform:GetWorldPosition()):Get())
					attacker.components.sanity:DoDelta(2)
				end
			elseif flamechance < 0.33 then
				fx.Transform:SetPosition(target:GetPosition():Get())
				if target.components.burnable then
					target.components.burnable:Ignite()
				end
				target.components.health:DoDelta(-30)

				if math.random() < 0.4 then
					SpawnPrefab("statue_transition").Transform:SetPosition(Vector3(target.Transform:GetWorldPosition()):Get())
					attacker.components.sanity:DoDelta(2)
				end
			end
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
	inst.Light:SetColour(80 / 255, 120 / 255, 250 / 255)

	if inst.level < 10 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
	elseif inst.level < 20 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword", "swap_nightmaresword")
	else
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword2", "swap_nightmaresword")
		inst.Light:SetRadius(.8)
		inst.Light:SetFalloff(.5)
		inst.Light:SetIntensity(.5)
		inst.Light:SetColour(225 / 255, 120 / 255, 80 / 255)
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
		if not TheWorld.state.issummer and not inst.components.heater then
			inst:AddComponent("heater")
			inst.components.heater:SetThermics(false, true)
			inst.components.heater.equippedheat = 2
		end

		if inst.level > 10 then
			Transfer_Owner(inst)
		else
			inst:ListenForEvent("level11", Add_Transfer)
		end

		local change_fx = SpawnPrefab("small_puff")
		local follower = change_fx.entity:AddFollower()
		follower:FollowSymbol(owner.GUID, "swap_object", 1, -100, 1)

		inst.components.fueled.rate = 0.02
		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		if inst.level < 10 then
			inst.components.talker:Say(
				STRINGS.MUSHA_WEAPON_SWORD_POWER_1 ..
					"\n" .. STRINGS.MUSHA_ITEM_LIGHT .. "(1+)\n" .. STRINGS.MUSHA_WEAPON_FIRE_D .. " X2(10D)"
			)
			inst.Light:SetRadius(.4)
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_boost", "swap_nightmaresword")
		elseif inst.level < 20 then
			inst.components.talker:Say(
				STRINGS.MUSHA_WEAPON_SWORD_POWER_2 ..
					"\n" ..
						STRINGS.MUSHA_ITEM_LIGHT ..
							"(2+)\n" .. STRINGS.MUSHA_WEAPON_FIRE_D .. " X2(20D)) \n" .. STRINGS.MUSHA_WEAPON_BLINK
			)
			inst.Light:SetRadius(.7)
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword2_boost", "swap_nightmaresword")
		else
			inst.components.talker:Say(
				STRINGS.MUSHA_WEAPON_SWORD_POWER_2 ..
					"\n" ..
						STRINGS.MUSHA_ITEM_LIGHT ..
							"(3+)\n" .. STRINGS.MUSHA_WEAPON_FIRE_D .. " X2(30D)) \n" .. STRINGS.MUSHA_WEAPON_BLINK
			)
			inst.Light:SetRadius(1)
			inst.AnimState:PlayAnimation("idle")
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword3_boost", "swap_nightmaresword")
		end
		inst.Light:SetFalloff(.5)
		inst.Light:SetIntensity(.5)
		inst.Light:SetColour(225 / 255, 120 / 255, 80 / 255)
		inst.Light:Enable(true)
	else
		inst.EnergyOn = false
		inst.components.fueled.rate = 0
		inst.components.talker:Say("-" .. STRINGS.MUSHA_WEAPON_SWORD_FIRE .. "\n" .. STRINGS.MUSHA_WEAPON_SWORD_POWER_OFF)

		if inst.components.heater then
			inst:RemoveComponent("heater")
		end

		if inst.level >= 11 then
			inst:RemoveComponent("blinkstaff")
		else
			inst:RemoveEventCallback("level11", Add_Transfer)
		end
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.Light:SetRadius(.4)
		inst.Light:SetFalloff(.5)
		inst.Light:SetIntensity(.5)
		inst.Light:SetColour(80 / 255, 120 / 255, 250 / 255)

		if inst.level < 10 then
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")
		elseif inst.level < 20 then
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword", "swap_nightmaresword")
		else
			owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword2", "swap_nightmaresword")
			inst.Light:SetRadius(.8)
			inst.Light:SetFalloff(.5)
			inst.Light:SetIntensity(.5)
			inst.Light:SetColour(225 / 255, 120 / 255, 80 / 255)
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
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 750, type = "weapon", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.entity:AddLight()

	inst.AnimState:SetBank("nightmaresword")
	inst.AnimState:SetBuild("mushasword")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetMultColour(1, 1, 1, 0.7)

	inst.MiniMapEntity:SetIcon("blade_1.tex")

	inst:AddTag("sharp")
	inst:AddTag("aquatic")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword.xml"

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

return Prefab("common/inventory/mushasword", fn, assets)
