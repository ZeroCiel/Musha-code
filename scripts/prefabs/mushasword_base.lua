local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/mushasword_base.zip"),
	Asset("ANIM", "anim/swap_mushasword_base.zip"),
	Asset("ANIM", "anim/swap_mushasword_frost1.zip"),
	Asset("ATLAS", "images/inventoryimages/mushasword_base.xml"),
	Asset("IMAGE", "images/inventoryimages/mushasword_base.tex")
}

local function Upgrade_to_mushasword(inst)
	local owner = inst.components.inventoryitem.owner
	local inv = inst.components.inventoryitem
	local mushasword = SpawnPrefab("mushasword")
	mushasword.exp = inst.exp
	if inv ~= nil and owner ~= nil then
		local solt = owner.components.inventory:GetItemSlot(inst)
		owner.components.inventory:DropItem(inst)
		SpawnPrefab("statue_transition_2").Transform:SetPosition(owner:GetPosition():Get())
		if solt then
			owner.components.inventory:GiveItem(mushasword, solt)
		else
			owner.components.inventory:Equip(mushasword)
		end
	else
		SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
		mushasword.Transform:SetPosition(inst:GetPosition():Get())
	end
	inst:Remove()
end

local function Updata(inst, display)
	if inst.exp == inst.maxexp then
		Upgrade_to_mushasword(inst)
	end
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.weapon:SetDamage(1)
		return
	end
	inst.components.weapon:SetDamage(18 + inst.level * 2)
	if nil == display then
		if inst.level < 10 then
			inst.components.talker:Say(
				string.format(
					STRINGS.MUSHA_WEAPON_SWORD_BASE .. " (LV%d)\n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
					inst.level,
					20 + inst.level * 2
				)
			)
		else
			inst.components.talker:Say(
				string.format(
					STRINGS.MUSHA_WEAPON_SWORD_BASE_UP .. " \n" .. STRINGS.MUSHA_WEAPON_DAMAGE .. " (%d)",
					20 + inst.level * 2
				)
			)
		end
	end
end

local function OnAttack(inst, attacker, target)
	if
		target.components.burnable and target.components.health and not target.components.health:IsDead() and
			not target:HasTag("structure") and
			not target:HasTag("stalkerminion") and
			not target:HasTag("smashable") and
			not target:HasTag("wall") and
			not target:HasTag("alignwall") and
			not target:HasTag("shadowminion") and
			inst.level >= 10
	 then
		target.components.burnable:Ignite()
		target.components.health:DoDelta(-12)
	end
	if math.random() < 0.2 and inst.exp < inst.maxexp then
		inst.exp = inst.exp + 1
		inst.Updata(inst, false)
	end
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)

	Updata(inst)

	owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword_base", "swap_nightmaresword")

	if inst.level >= 10 then
		owner.AnimState:OverrideSymbol("swap_object", "swap_mushasword", "swap_nightmaresword")
	end
	owner.AnimState:Hide("ARM_normal")
	owner.AnimState:Show("ARM_carry")
end

local function OnUnequip(inst, owner)
	--owner.fire = false
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function fn()
	local inst =
		Musha_Api.fn_common({maxfuel = 750, type = "weapon", maxexp = 330, OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.entity:AddLight()
	inst.Light:SetRadius(.4)
	inst.Light:SetFalloff(.5)
	inst.Light:SetIntensity(.5)
	inst.Light:SetColour(80 / 255, 120 / 255, 250 / 255)
	inst.Light:Enable(true)

	inst.AnimState:SetBank("nightmaresword")
	inst.AnimState:SetBuild("mushasword_base")
	inst.AnimState:PlayAnimation("idle")
	inst.AnimState:SetMultColour(1, 1, 1, 0.7)

	inst.MiniMapEntity:SetIcon("blade_b.tex")
	-- inst:AddTag("sharp")
	inst:AddTag("aquatic")

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/mushasword_base.xml"

	inst.Updata = Updata
	inst.OnAttack = OnAttack
	inst.OnBroken = function(inst)
		inst.components.weapon:SetDamage(1)
		SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())
		inst.components.talker:Say(STRINGS.MUSHA_WEAPON_BROKEN .. " \nDamage (1)")
	end

	return inst
end

return Prefab("common/inventory/mushasword_base", fn, assets)
