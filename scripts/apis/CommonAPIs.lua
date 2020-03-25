local _Musha_Api = {}

local function CountLevel(value)
	if value <= 80 then
		return value > 0 and math.ceil(value / 20) * 20 or 20
	elseif value <= 280 then
		return math.ceil((value - 80) / 40) * 40 + 80
	elseif value <= 680 then
		return math.ceil((value - 280) / 80) * 80 + 280
	elseif value <= 1280 then
		return math.ceil((value - 680) / 120) * 120 + 680
	elseif value <= 2580 then
		return math.ceil((value - 1280) / 260) * 260 + 1280
	else
		return math.ceil((value - 2600) / 350) * 350 + 2580
	end
end



local function Armor_level(inst, lucky_point)
	local level_exp = math.min(CountLevel(inst.exp), inst.maxexp)
	if inst.exp <= inst.maxexp then
		if nil == lucky_point then
			inst.components.talker:Say(
				inst:GetDisplayName "\n" .. "\n[" .. STRINGS.MUSHA_ITEM_GROWPOINTS .. "]" .. (inst.exp) .. "/" .. level_exp
			)
		elseif lucky_point == 1 then
			inst.components.talker:Say(
				inst:GetDisplayName "\n" .. "\n" .. STRINGS.MUSHA_ITEM_GROWPOINTS .. "[1]\n" .. (inst.exp) .. "/" .. level_exp
			)
		else
			inst.components.talker:Say(
				inst:GetDisplayName "\n" ..
					"\n" .. STRINGS.MUSHA_ITEM_LUCKY .. "[" .. lucky_point .. "]\n" .. (inst.exp) .. "/" .. level_exp
			)
		end
	else
		inst.components.talker:Say(STRINGS.MUSHA_LEVEL_INFORMATION)
	end
end

local function Gain_Exp(inst)
	if forgelab(inst) then
		local Exp = Random_EXP() * 5
		inst.exp = inst.exp + Exp
		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		inst.exp = math.min(inst.exp, inst.maxexp)
		local level_exp = math.min(CountLevel(inst.exp), inst.maxexp)
		inst.components.talker:Say(
			STRINGS.MUSHA_TALK_FORGE_LUCKY ..
				"\n+(" .. Exp .. ")\n[" .. STRINGS.MUSHA_ITEM_GROWPOINTS .. "]" .. (inst.exp) .. "/" .. level_exp
		)
	else
		local Exp = Random_EXP()
		inst.exp = inst.exp + Exp
		inst.exp = math.min(inst.exp, inst.maxexp)
		Armor_level(inst, Exp)
	end
end

---Give item,Then Level up
local function OnGetItemFromPlayer(inst, giver, item)
	inst.components.fueled:DoDelta(50)
	SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())
	if inst.exp < inst.maxexp then
		Gain_Exp(inst)
	else
		inst.components.talker:Say(STRINGS.MUSHA_LEVEL_INFORMATION)
	end
	inst.Updata(inst, false)
	inst.components.fueled:StartConsuming()
	if inst.Rebind ~= nil then
		inst.Rebind(inst)
	end
end

local function OnPreLoad(inst, data)
	if data ~= nil then
		if data.exp ~= nil or data.level ~= nil then
			inst.exp = math.min(data.exp or data.level, inst.maxexp)
			Armor_level(inst)
		end
		if data.fueled ~= nil and data.fueled.fuel > inst.maxfuel then
			data.fueled.fuel = inst.maxfuel * data.fueled.fuel / 30000000
		end
	end
end

local function OnLoad(inst, data)
	inst.Updata(inst)
end

local function OnSave(inst, data)
	data.exp = inst.exp
end

function _Musha_Api.fn_common(setting_table)
	local inst = CreateEntity()

	inst.maxfuel = setting_table.maxfuel
	inst.maxexp = setting_table.maxexp or 4000

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, nil, nil)

	inst:AddTag("musha_items")
	inst:AddComponent("waterproofer")
	inst.entity:AddMiniMapEntity()

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 30
	inst.components.talker.font = TALKINGFONT
	inst.components.talker.colour = Vector3(0.9, 1, 0.75, 1)
	inst.components.talker.offset = Vector3(0, 150, 0)
	inst.components.talker.symbol = "swap_object"

	if TheNet:GetIsClient() then
		return inst
	end

	inst:AddComponent("inventoryitem")
	inst:AddComponent("inspectable")
	inst.entity:SetPristine()

	inst:AddComponent("fueled")
	inst.components.fueled.rate = 0
	inst.components.fueled.period = 0.1
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(inst.maxfuel)
	inst.components.fueled:SetDepletedFn(function(inst)
			inst.OnBroken(inst)
		end
	)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
	inst.components.fueled:StartConsuming()

	inst:AddComponent("equippable")
	inst.components.equippable:SetOnEquip(setting_table.OnEquip)
	inst.components.equippable:SetOnUnequip(setting_table.OnUnequip)

	if setting_table.type == "weapon" then
		inst:AddComponent("weapon")
		inst.components.equippable.equipslot = EQUIPSLOTS.HANDS
		inst.components.waterproofer:SetEffectiveness(0)
		inst.components.weapon:SetOnAttack(
			function(inst, attacker, target)
				if inst.components.useableitem ~= nil and inst.components.useableitem.inuse then
					inst.components.fueled:DoDelta(-3)
				else
					inst.components.fueled:DoDelta(-2)
				end
				if target then
					if target.components.sleeper and target.components.sleeper:IsAsleep() then
						target.components.sleeper:WakeUp()
					end
					if target.components.burnable and target.components.burnable:IsBurning() and not target:HasTag("buzzard") then
						target.components.burnable:Extinguish()
					end
					if target.components.combat and not target:HasTag("companion") then
						target.components.combat:SuggestTarget(attacker)
					end
				end
				inst.OnAttack(inst, attacker, target)
			end
		)
	elseif setting_table.type == "armor" then
		inst:AddComponent("armor")
		inst.components.equippable.equipslot = EQUIPSLOTS.BODY
		inst.components.armor:InitIndestructible(0)
		inst.components.waterproofer:SetEffectiveness(0)
		inst.BeAttacked = function(_, data)
			if inst.components.fueled:IsEmpty() then
				return
			end
			if data and data.attacker and data.attacker.components.combat then
				inst.components.fueled:DoDelta(-data.attacker.components.combat.defaultdamage)
			end

			if math.random() < 0.5 and inst.exp < inst.maxexp then
				inst.exp = inst.exp + 1
				inst.Updata(inst, false)
			end
		end
	elseif setting_table.type == "hat" then
		inst:AddTag("hat")
		inst:AddComponent("armor")
		inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
		inst.components.waterproofer:SetEffectiveness(0)
		inst.components.armor:InitIndestructible(0)
		inst.BeAttacked = function(_, data)
			print(inst.components.fueled.currentfuel)
			if inst.components.fueled:IsEmpty() then
				return
			end
			if data and data.attacker and data.attacker.components.combat then
				inst.components.fueled:DoDelta(-data.attacker.components.combat.defaultdamage)
			end

			if math.random() < 0.5 and inst.exp < inst.maxexp then
				inst.exp = inst.exp + 1
				inst.Updata(inst, false)
			end
		end
	end

	inst.exp = 0
	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	inst.OnPreLoad = OnPreLoad
	inst.Equippable_Check = function(inst, owner)
		if not inst.share_item and owner and not owner:HasTag("musha") and owner.components.inventory then
			owner.components.inventory:Unequip(inst.components.equippable.equipslot, true)
			owner:DoTaskInTime(
				0.5,
				function()
					owner.components.inventory:DropItem(inst)
				end
			)
		end
	end

	MakeHauntableLaunch(inst)

	return inst
end

function _Musha_Api.GetLevel(inst)
	if inst.exp <= 80 then
		return inst.exp > 0 and math.ceil(inst.exp / 20) or 1
	elseif inst.exp <= 280 then
		return math.ceil((inst.exp - 80) / 40) + 5
	elseif inst.exp <= 680 then
		return math.ceil((inst.exp - 280) / 80) + 10
	elseif inst.exp <= 1280 then
		return math.ceil((inst.exp - 680) / 120) + 15
	elseif inst.exp <= 2580 then
		return math.ceil((inst.exp - 1280) / 260) + 20
	elseif inst.exp < 4000 then
		return math.ceil((inst.exp - 2580) / 355) + 25
	else
		return 30
	end
end

return _Musha_Api
