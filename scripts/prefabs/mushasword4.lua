local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/mushasword4.zip"),
	Asset("ANIM", "anim/swap_phoenixaxe.zip"),
	Asset("ANIM", "anim/swap_phoenixaxe2.zip"),
	Asset("ANIM", "anim/swap_phoenixaxe_broken.zip"),
	Asset("ATLAS", "images/inventoryimages/mushasword4.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword4.tex")
}
---------------------------

local function CreateLight(inst, target, pos)
	if inst.components.fueled:IsEmpty() then
		return
	end
	local caster = inst.components.inventoryitem.owner
	if caster.components.sanity.current >= 35 then
		local light = SpawnPrefab("lightning")
		local light2 = SpawnPrefab("musha_spore_fire")

		light.Transform:SetPosition(pos.x, pos.y, pos.z)
		light2.Transform:SetPosition(pos.x, pos.y, pos.z)
		light2.components.follower:SetLeader(caster)

		caster.components.sanity:DoDelta(-20)
	elseif caster.components.sanity.current < 30 then
		local fail1 = SpawnPrefab("statue_transition")
		local fail2 = SpawnPrefab("statue_transition_2")

		fail1.Transform:SetPosition(pos.x, pos.y, pos.z)
		fail2.Transform:SetPosition(pos.x, pos.y, pos.z)
	end
end

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.weapon:SetDamage(1)
		return
	end
	inst.components.weapon:SetDamage((inst.is_Pick and 73 or 28) + inst.level * 2)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				(inst.is_Pick and STRINGS.MUSHA_WEAPON_SWORD_PAXE or STRINGS.MUSHA_WEAPON_SWORD_AXE) ..
					" (LV%d)\n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
				inst.level,
				(inst.is_Pick and 73 or 28) + inst.level * 2
			)
		)
	end
end

local function OnAttack(inst, attacker, target)
	if inst.components.fueled:IsEmpty() then
		return
	end

	if target then
		local splash = SpawnPrefab("splash")
		local pos = Vector3(target.Transform:GetWorldPosition())
		splash.Transform:SetPosition(pos:Get())

		if
			target.components.health and not target.components.health:IsDead() and not target:HasTag("structure") and
				not target:HasTag("stalkerminion") and
				not target:HasTag("smashable") and
				not target:HasTag("alignwall") and
				not target:HasTag("shadowminion")
		 then
			if math.random() < ((inst.level < 10 and 0.12) or (inst.level < 20 and 0.20) or (inst.level < 24 and 0.28) or 0.36) then
				local fx = SpawnPrefab("firesplash_fx")
				fx.Transform:SetScale(0.4, 0.4, 0.4)
				fx.Transform:SetPosition(target:GetPosition():Get())
				if target.components.burnable then
					target.components.burnable:Ignite()
				end
				local fx2 = SpawnPrefab("statue_transition")
				local pos = Vector3(target.Transform:GetWorldPosition())
				fx2.Transform:SetPosition(pos:Get())
				target.components.health:DoDelta(inst.level < 24 and -5 - math.ceil(inst.level * 0.1) * 5 or 25)
				attacker.components.sanity:DoDelta(1)
			end

			if inst.is_Pick then
				local fx3 = SpawnPrefab("groundpoundring_fx")
				local pos = Vector3(target.Transform:GetWorldPosition())
				fx3.Transform:SetScale(0.3, 0.3, 0.3)
				fx3.Transform:SetPosition(pos:Get())

				if
					(target.components.burnable or target.components.freezable) and not target:HasTag("structure") and
						not target:HasTag("smashable") and
						not target:HasTag("companion") and
						not target:HasTag("yamcheb") and
						not target:HasTag("yamche") and
						math.random() < 0.45 + math.ceil(inst.level * 0.1) * 0.5 and
						not target:HasTag("slow_poison")
				 then
					local harm = (inst.level < 10 and 4) or (inst.level < 20 and 7) or 9
					local poison = SpawnPrefab("debuff_blood")
					poison.Transform:SetPosition(target:GetPosition():Get())
					target:AddTag("slow_poison")
					local follower = poison.entity:AddFollower()
					if target:HasTag("cavedweller") then
						follower:FollowSymbol(target.GUID, "body", 0, -10, 0.5)
					else
						follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, -10, 0.5)
					end

					TheWorld:DoPeriodicTask(
						3,
						function()
							if target:HasTag("slow_poison") and not target.components.health:IsDead() then
								attacker.components.health:DoDelta(harm)
								if target:HasTag("slow_poison") and target.components.combat and not target.components.health:IsDead() then
									if not target:HasTag("epic") then
										target.components.combat:GetAttacked(inst, harm)
									else
										target.components.health:DoDelta(-harm)
									end
								end
							elseif poison and target.components.health:IsDead() then
								poison:Remove()
							end
						end
					)

					TheWorld:DoTaskInTime(
						15,
						function()
							if target ~= nil and target.components.locomotor and poison then
								target.components.locomotor.groundspeedmultiplier = 1
								target:RemoveTag("slow_poison")
								poison:Remove()
							end
						end
					)
				end
			end
		end
	end

	if math.random() < 0.05 and inst.exp < 4000 then
		inst.exp = inst.exp + 1
		inst.Updata(inst, false)
	end
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)

	Updata(inst)

	if inst.is_Pick then
		inst.components.weapon:SetRange(1)
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe2", "phoenixaxe")
		inst:AddTag("phoenix_axe")
		if not inst.components.spellcaster then
			inst:AddComponent("spellcaster")
			inst.components.spellcaster:SetSpellFn(createlight)
			inst.components.spellcaster.canuseonpoint = true
		end
	else
		inst.components.weapon:SetRange(0)
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe", "phoenixaxe")
		inst:RemoveTag("phoenix_axe")
	end
	owner.AnimState:Hide("ARM_normal")
	owner.AnimState:Show("ARM_carry")

	--owner:AddTag("phoenixblade")
end

local function OnUnequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")

	--owner:RemoveTag("phoenixblade")
	inst:RemoveTag("phoenix_axe")

	inst:RemoveComponent("spellcaster")
end

local function Transform(inst)
	local owner = inst.components.inventoryitem.owner

	local change_fx = SpawnPrefab("small_puff")
	local puff = change_fx.entity:AddFollower()
	puff:FollowSymbol(owner.GUID, "swap_object", 1, -150, 0.5)

	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	if inst.is_Pick then
		inst:RemoveComponent("spellcaster")
		inst.components.tool:OnRemoveFromEntity()
		inst.components.tool:SetAction(ACTIONS.CHOP)
		--#TODO:删掉
		inst:RemoveTag("phoenix_axe")
		inst.components.weapon:SetRange(0)
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe", "phoenixaxe")
	else
		inst:AddComponent("spellcaster")
		inst.components.spellcaster:SetSpellFn(CreateLight)
		inst.components.spellcaster.canuseonpoint = true
		inst.components.tool:OnRemoveFromEntity()
		inst.components.tool:SetAction(ACTIONS.MINE)

		inst:AddTag("phoenix_axe")
		inst.components.weapon:SetRange(.9)
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixaxe2", "phoenixaxe")
	end
	Updata(inst)
	inst.is_Pick = not inst.is_Pick
	inst.components.useableitem:StopUsingItem()
	--#TODO:添加提示
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 850, type = "weapon", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.AnimState:SetBank("mushasword4")
	inst.AnimState:SetBuild("mushasword4")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("sharp")
	inst:AddTag("metal")

	inst.MiniMapEntity:SetIcon("mushasword4.tex")

	if TheNet:GetIsClient() then
		return inst
	end

	inst:AddComponent("tool")

	inst.is_Pick = false

	--TODO:凤凰稿的装备栏
	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword4.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Transform)

	inst.Updata = Updata
	inst.OnAttack = OnAttack
	inst.OnBroken = function(inst)
		inst.components.inventoryitem.owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
		inst.components.talker:Say("-" .. STRINGS.MUSHA_WEAPON .. "\n" .. STRINGS.MUSHA_ITEM_DUR .. " (0)")
		Updata(inst)
	end
	inst.OnSave = function(inst, data)
		data.exp = inst.exp
		data.is_Pick = inst.is_Pick
	end

	inst.OnLoad = function(inst, data)
		if data ~= nil then
			if data.is_Pick ~= nil then
				inst.is_Pick = data.is_Pick
			end
		end
	end

	return inst
end

return Prefab("common/inventory/mushasword4", fn, assets)
