local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/phoenixspear.zip"),
	Asset("ANIM", "anim/swap_phoenixspear.zip"),
	Asset("ANIM", "anim/swap_phoenixspear2.zip"),
	Asset("ANIM", "anim/swap_phoenixspear_2r.zip"),
	Asset("ANIM", "anim/swap_phoenixspear_broken.zip"),
	Asset("ATLAS", "images/inventoryimages/phoenixspear.xml"),
	Asset("IMAGE", "images/inventoryimages/phoenixspear.tex")
}

local function onblink(staff, pos, caster)
	if caster.components.sanity ~= nil then
		caster.components.sanity:DoDelta(-6)
	end
end

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.weapon:SetDamage(1)
		return
	end
	inst.components.weapon:SetDamage((inst.Is_Frost and 73 or 28) + inst.level * 2)
	if nil == display then
		inst.components.talker:Say(
			string.format(
				(inst.Is_Frost and STRINGS.MUSHA_WEAPON_SPEAR_FROST or STRINGS.MUSHA_WEAPON_SPEAR_FIRE) ..
					" (LV%d)\n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
				inst.level,
				(inst.Is_Frost and 73 or 28) + inst.level * 2
			)
		)
	end
end

local function OnAttack(inst, attacker, target)
	if inst.components.fueled:IsEmpty() then
		local splash = SpawnPrefab("splash")
		local pos = Vector3(target.Transform:GetWorldPosition())
		splash.Transform:SetPosition(pos:Get())
		return
	end
	if
		target and not target:HasTag("structure") and not target:HasTag("stalkerminion") and not target:HasTag("smashable") and
			not target:HasTag("alignwall") and
			not target:HasTag("shadowminion") and
			target.components.health and
			not target.components.health:IsDead()
	 then
		if
			not inst.Is_Frost and
				math.random() < ((inst.level < 10 and 0.12) or (inst.level < 20 and 0.20) or (inst.level < 25 and 0.28) or 0.36)
		 then
			local fx = SpawnPrefab("firesplash_fx")
			fx.Transform:SetScale(0.4, 0.4, 0.4)
			fx.Transform:SetPosition(target:GetPosition():Get())
			if target.components.burnable then
				target.components.burnable:Ignite()
			end
			target.components.health:DoDelta(-(inst.level < 25 and math.ceil(inst.level * 0.1) * 5 + 5 or 20))
		elseif
			inst.Is_Frost and target and target.components.locomotor and target.components.freezable and
				math.random() < ((inst.level < 10 and 0.3) or (inst.level < 20 and 0.4) or (inst.level < 25 and 0.5) or 0.6)
		 then
			local fx = SpawnPrefab("groundpoundring_fx")
			local pos = Vector3(target.Transform:GetWorldPosition())
			fx.Transform:SetScale(0.3, 0.3, 0.3)
			fx.Transform:SetPosition(pos:Get())

			target.components.freezable:AddColdness(inst.level < 25 and math.ceil(inst.level * 0.1) * 0.12 or 0.40)
			target.components.freezable:SpawnShatterFX()
			target.components.health:DoDelta(-2)
			local prefab = "icespike_fx_" .. math.random(1, 4)
			local fx = SpawnPrefab(prefab)
			fx.Transform:SetScale(
				1,
				(inst.level < 20 and math.ceil(inst.level * 0.1) * 0.2 + 0.4) or (inst.level < 25 and 0.9) or 1.1,
				1
			)
			fx.Transform:SetPosition(target:GetPosition():Get())
		end
	end

	if math.random() < 0.05 and inst.level < inst.maxexp then
		inst.exp = inst.exp + 1
		Updata(inst)
	end
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)
	Updata(inst)

	if inst.Is_Frost then
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
	else
		--inst:RemoveTag("frost_spear")
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear", "phoenixspear")
	end
	owner.AnimState:Hide("ARM_normal")
	owner.AnimState:Show("ARM_carry")

	if inst.level == 30 then
		inst.blink_weapon =
			inst:DoPeriodicTask(
			1,
			function()
				if not inst.components.fueled:IsEmpty() and inst.level >= 30 then
					if not inst.boost and not inst.components.blinkstaff and owner.components.sanity.current >= 10 then
						inst:AddComponent("blinkstaff")
						inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
						inst.components.blinkstaff.onblinkfn = onblink
					elseif not inst.boost and inst.components.blinkstaff and owner.components.sanity.current < 10 then
						inst:RemoveComponent("blinkstaff")
					elseif inst.boost and inst.components.blinkstaff then
						inst:RemoveComponent("blinkstaff")
					end
				end
			end
		)
	end
end

local function OnUnequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")

	if inst.blink_weapon then
		inst.blink_weapon:Cancel()
		inst.blink_weapon = nil
	end

	if inst.components.blinkstaff then
		inst:RemoveComponent("blinkstaff")
	end
end

local function Transform(inst)
	if inst.components.fueled:IsEmpty() then
		return
	end
	if not inst.Is_Frost then
		local owner = inst.components.inventoryitem.owner
		local change_fx = SpawnPrefab("splash")
		local follower = change_fx.entity:AddFollower()
		follower:FollowSymbol(owner.GUID, "swap_object", 1, -150, 1)
		--owner.frost = true
		--owner.fire = false

		inst.components.tool:OnRemoveFromEntity()
		inst.components.tool:SetAction(ACTIONS.DIG)
		inst:AddTag("frost_spear")
		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear2", "phoenixspear")
	else
		local change_fx = SpawnPrefab("small_puff")
		local follower = change_fx.entity:AddFollower()
		local owner = inst.components.inventoryitem.owner
		follower:FollowSymbol(owner.GUID, "swap_object", 1, -150, 1)
		if inst.components.blinkstaff then
			inst:RemoveComponent("blinkstaff")
		end
		--owner.fire = true
		--owner.frost = false
		inst.components.tool:OnRemoveFromEntity()
		inst:RemoveTag("frost_spear")

		if inst.level == 30 then
			inst.blink_weapon =
				inst:DoPeriodicTask(
				1,
				function()
					if not inst.components.fueled:IsEmpty() then
						if not inst.boost and not inst.components.blinkstaff and owner.components.sanity.current >= 10 then
							inst:AddComponent("blinkstaff")
							inst.components.blinkstaff:SetFX("sand_puff_large_front", "sand_puff_large_back")
							inst.components.blinkstaff.onblinkfn = onblink
						elseif not inst.boost and inst.components.blinkstaff and owner.components.sanity.current < 10 then
							inst:RemoveComponent("blinkstaff")
						elseif inst.boost and inst.components.blinkstaff then
							inst:RemoveComponent("blinkstaff")
						end
					end
				end
			)
		end

		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		owner.AnimState:OverrideSymbol("swap_object", "swap_phoenixspear", "phoenixspear")
	end
	Updata(inst)
	inst.Is_Frost = not inst.Is_Frost
	inst.components.useableitem:StopUsingItem()
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 1050, type = "weapon", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.AnimState:SetBank("phoenixspear")
	inst.AnimState:SetBuild("phoenixspear")
	inst.AnimState:PlayAnimation("idle")

	inst:AddTag("sharp")
	inst:AddTag("metal")

	inst.MiniMapEntity:SetIcon("phoenixspear.tex")

	if TheNet:GetIsClient() then
		return inst
	end

	inst:AddComponent("tool")
	inst.components.weapon:SetRange(1.1)

	inst.Is_Frost = false

	inst.components.inventoryitem.atlasname = "images/inventoryimages/phoenixspear.xml"

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(Transform)

	inst.Updata = Updata
	inst.OnAttack = OnAttack
	inst.OnBroken = function(inst)
		inst.components.inventoryitem.owner.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN_TALK)
		inst.components.talker:Say("-" .. STRINGS.MUSHA_WEAPON .. "\n" .. STRINGS.MUSHA_ITEM_DUR .. " (0)")
		Updata(inst)
		inst.components.tool:OnRemoveFromEntity()
		inst.components.inventoryitem.owner.AnimState:OverrideSymbol(
			"swap_object",
			"swap_phoenixspear_broken",
			"phoenixspear"
		)
	end
	inst.OnSave = function(inst, data)
		data.exp = inst.exp
		data.Transformed = inst.Is_Frost
	end

	inst.OnLoad = function(inst, data)
		if data ~= nil then
			if data.Transformed ~= nil then
				inst.Is_Frost = data.Transformed
			end
		end
	end

	return inst
end

return Prefab("common/inventory/phoenixspear", fn, assets)
