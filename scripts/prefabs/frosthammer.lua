local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/frosthammer.zip"),
	Asset("ANIM", "anim/swap_frosthammer.zip"),
	Asset("ANIM", "anim/swap_frosthammer2.zip"),
	Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
	Asset("IMAGE", "images/inventoryimages/frosthammer.tex")
}

local prefabs = {
	"icespike_fx_1",
	"icespike_fx_2",
	"icespike_fx_3",
	"icespike_fx_4"
}

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.weapon:SetDamage(1)
		return
	end
	inst.components.weapon:SetDamage(73 + inst.level * 2)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				STRINGS.MUSHA_WEAPON_FROSTHAMMER .. " (LV%d)\n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
				inst.level,
				73 + inst.level * 2
			)
		)
	end
end

local function sanity_cost_change(inst, season)
	inst.components.equippable.dapperness = season == SEASONS.WINTER and 0 or 0.33
end

local function Frosta_hammer(inst, owner)
	local player = inst.components.inventoryitem.owner
	local weapon = player.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if weapon and (inst.power or player.switch) then
		player.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
	else
		player.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
	end
end

local function SpawnIceFx(inst, target)
	if not inst or not target then
		return
	end
	local numFX = math.random(3, 5)
	local pos = target:GetPosition()
	local targetPos = target:GetPosition()
	local vec = targetPos - pos
	vec = vec:Normalize()
	local dist = pos:Dist(targetPos)
	local angle = inst:GetAngleToPoint(targetPos:Get())

	for i = 1, numFX do
		inst:DoTaskInTime(
			math.random() * 0.1,
			function(inst)
				local prefab = "icespike_fx_" .. math.random(1, 4)
				local fx = SpawnPrefab(prefab)
				if fx then
					local x = GetRandomWithVariance(0, 1)
					local z = GetRandomWithVariance(0, 1)
					local offset = (vec * math.random(dist * 0.1, dist)) + Vector3(x, 0, z)
					fx.Transform:SetPosition((offset + pos):Get())
				end
			end
		)
	end
end

local function OnAttack(inst, attacker, target)
	if
		not inst.EnergyOn and target and target.components.freezable and not target:HasTag("smashable") and
			not target:HasTag("companion") and
			not target:HasTag("yamcheb") and
			not target:HasTag("yamche") and --TODO: yamche or yamache?
			not target:HasTag("critter") and
			not target:HasTag("slow_frozen") and
			not target:HasTag("follower") and
			math.random() < ((inst.level < 10 and 0.42) or (inst.level < 20 and 0.52) or 0.62) and
			inst.level < 10
	 then
		target.components.freezable:AddColdness(0.6 + math.ceil(inst.level * 0.1))
		local prefab = "icespike_fx_" .. math.random(1, 4)
		local fx = SpawnPrefab(prefab)
		fx.Transform:SetScale(1, 1.20 + math.ceil(inst.level * 0.1) * 0.15, 1)
		fx.Transform:SetPosition(target:GetPosition():Get())
		--target.components.health:DoDelta(-math.ceil(inst.level * 0.1)*10)
		if
			target.components.locomotor and target.components.health and not target.components.health:IsDead() and
				not target:HasTag("shadowcreature") and
				not target:HasTag("structure") and
				not target:HasTag("slow_frozen") and
				not target:HasTag("follower")
		 then
			target:AddTag("slow_frozen")
			local frozen = SpawnPrefab("debuff_frozen")
			frozen.Transform:SetPosition(target:GetPosition():Get())
			frozen.Transform:SetScale(0.5, 0.8, 0.5)
			if frozen and target:HasTag("slow_frozen") then
				local follower = frozen.entity:AddFollower()
				follower:FollowSymbol(target.GUID, target.components.combat.hiteffectsymbol, 0, 0, 0)
			end
			TheWorld:DoTaskInTime(
				4,
				function()
					target.components.locomotor.groundspeedmultiplier = 1
					target:RemoveTag("slow_frozen")
					frozen:Remove()
				end
			)
		end
	end

	local fx = SpawnPrefab("groundpoundring_fx")
	local fx2 = SpawnPrefab("groundpoundring_fx")
	local pos = Vector3(target.Transform:GetWorldPosition())
	if not inst.EnergyOn then
		fx.Transform:SetScale(0.3, 0.3, 0.3)
		fx2.Transform:SetScale(0.45, 0.45, 0.45)
	else
		fx.Transform:SetScale(0.45, 0.45, 0.45)
		fx2.Transform:SetScale(0.6, 0.6, 0.6)
	end
	fx.Transform:SetPosition(pos:Get())
	TheWorld:DoTaskInTime(
		0.2,
		function()
			fx2.Transform:SetPosition(pos:Get())
		end
	)

	if target.components.freezable then
		if not inst.power then
			target.components.freezable:AddColdness(0.15)
			target.components.freezable:SpawnShatterFX()
		elseif inst.power then
			target.components.freezable:AddColdness(1.65)
			target.components.freezable:SpawnShatterFX()
			SpawnIceFx(inst, attacker.components.combat.target)
			inst.power = false
			local prefab = "icespike_fx_" .. math.random(1, 4)
			local fx = SpawnPrefab(prefab)
			fx.Transform:SetScale(1.0, 2, 1.0)
			fx.Transform:SetPosition(target:GetPosition():Get())
		end
	end

	Frosta_hammer(inst)

	if math.random() < 0.1 and not inst.broken and inst.exp <= inst.maxexp then
		inst.exp = inst.exp + 1
		Updata(inst)
	end
end

local function summoning(staff, target, pos)
	local caster = staff.components.inventoryitem.owner
	if caster.components.sanity.current >= 25 and caster.components.leader:CountFollowers("frost_tentacle") < 8 then
		local tentacle_frost = SpawnPrefab("tentacle_frost")

		SpawnPrefab("statue_transition").Transform:SetPosition(pos.x, pos.y, pos.z)
		SpawnPrefab("statue_transition_2").Transform:SetPosition(pos.x, pos.y, pos.z)
		SpawnPrefab("splash").Transform:SetPosition(pos.x, pos.y, pos.z)
		tentacle_frost.Transform:SetPosition(pos.x, pos.y, pos.z)
		tentacle_frost.components.follower:SetLeader(caster)

		caster.components.sanity:DoDelta(-25)
	elseif caster.components.sanity.current < 25 then
		SpawnPrefab("small_puff").Transform:SetPosition(pos.x, pos.y, pos.z)
		caster.components.talker:Say(STRINGS.MUSHA_TALK_CANNOT)
	elseif caster.components.leader:CountFollowers("frost_tentacle") >= 8 then
		SpawnPrefab("small_puff").Transform:SetPosition(pos.x, pos.y, pos.z)
		caster.components.talker:Say(STRINGS.MUSHA_TALK_CANNOT2)
	end
end

local function Release_Frost(inst, owner, data)
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	if not TheWorld.state.iswinter and not inst.components.heater then
		inst:AddComponent("heater")
		inst.components.heater:SetThermics(false, true)
		inst.components.heater.equippedheat = -2
	end

	if inst.level >= 10 then
		if not inst.components.spellcaster then
			inst:AddComponent("spellcaster")
			inst.components.spellcaster:SetSpellFn(summoning)
			inst.components.spellcaster.canuseonpoint = true
		end
	end

	AddHauntableCustomReaction(
		inst,
		function(inst, haunter)
			if math.random() <= TUNING.HAUNT_CHANCE_RARE then
				local pos = Vector3(inst.Transform:GetWorldPosition())
				local start_angle = math.random() * 2 * PI
				local offset = FindWalkableOffset(pos, start_angle, math.random(3, 12), 60, false, true)
				local pt = pos + offset
				createlight(inst, nil, pt)
				inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
				return true
			end
			return false
		end,
		true,
		false,
		true
	)
end

local function Energy_Switch(inst)
	local owner = inst.components.inventoryitem.owner
	if not inst.EnergyOn then
		--#TODO:添加冻结率提示
		inst.components.fueled.rate = 0.02
		inst:ListenForEvent("seasonChange", sanity_cost_change)
		inst.power_recharge:Cancel()

		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
		Release_Frost(inst)
	else
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
		inst.components.fueled.rate = 0
		inst.power_recharge:Cancel()
		inst.power_recharge =
			inst:DoPeriodicTask(
			3,
			function()
				inst.power = true
			end
		)
		if inst.components.heater then
			inst:RemoveComponent("heater")
		end
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		if inst.components.reticule then
			inst:RemoveComponent("reticule")
		end
		if inst.components.spellcaster then
			inst:RemoveComponent("spellcaster")
		end
		Frosta_hammer(inst)
	end
	inst.EnergyOn = not inst.EnergyOn
	inst.components.useableitem:StopUsingItem()
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)

	inst.boost = true
	owner.frost = true
	owner.frosthammer2 = true

	Updata(inst)

	owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
	owner.AnimState:Hide("ARM_normal")
	owner.AnimState:Show("ARM_carry")
end

local function OnUnequip(inst, owner)
	owner.frost = false
	owner.frosthammer2 = false
	inst:RemoveEventCallback("seasonChange", sanity_cost_change)

	if inst.components.heater then
		inst:RemoveComponent("heater")
	end

	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")

	if inst.components.reticule then
		inst:RemoveComponent("reticule")
	end

	if inst.components.spellcaster then
		inst:RemoveComponent("spellcaster")
	end

	if inst.task then
		inst.task:Cancel()
		inst.task = nil
	end
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 1400, type = "weapon", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.AnimState:SetBank("frosthammer")
	inst.AnimState:SetBuild("frosthammer")
	inst.AnimState:PlayAnimation("idle")

	inst.MiniMapEntity:SetIcon("frosthammer.tex")

	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.HAMMER)

	inst:AddTag("frost_hammer")

	inst:AddComponent("reticule")
	inst.components.reticule.targetfn = function()
		return Vector3(ThePlayer().entity:LocalToWorldSpace(5, 0, 0))
	end
	inst.components.reticule.ease = true

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.equippable.dapperness = 0
	inst.components.inventoryitem.atlasname = "images/inventoryimages/frosthammer.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Energy_Switch)
	inst.EnergyOn = false

	inst.power_recharge =
		inst:DoPeriodicTask(
		3,
		function()
			inst.power = true
		end
	)

	inst.Updata = Updata
	inst.OnAttack = OnAttack
	inst.OnBroken = function(inst)
		if inst.EnergyOn then
			Energy_Switch(inst)
			inst.EnergyOn = true
		end
		Updata(inst)
		local owner = inst.components.inventoryitem.owner
		owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
		inst.components.talker:Say("-" .. STRINGS.MUSHA_WEAPON .. "\n" .. STRINGS.MUSHA_ITEM_DUR .. " (0)")
		Updata(inst)
		owner.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
	end
	inst.Rebind = function(inst)
		if inst.EnergyOn then
			inst.EnergyOn = false
			Energy_Switch(inst)
		end
	end

	return inst
end

return Prefab("common/inventory/frosthammer", fn, assets, prefabs)
