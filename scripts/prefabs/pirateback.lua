local Musha_Api = require "apis/CommonAPIs"

local assets = {
	Asset("ANIM", "anim/swap_pirate_musha_bag.zip"),
	Asset("ANIM", "anim/armor_pirate.zip")
}

local function Updata(inst, display)
	inst.level = Musha_Api.GetLevel(inst)
	if inst.components.fueled:IsEmpty() then
		inst.components.armor:InitIndestructible(0)
		return
	end

	local armor_value = inst.level < 16 and inst.level * 2 or inst.level + 15

	inst.components.armor:InitIndestructible(armor_value * 0.01)
	if nil == display then
		inst.components.talker:Say(
			string.format(STRINGS.MUSHA_ARMOR_PIRATE .. " (LV%d)\n" .. STRINGS.MUSHA_ARMOR .. " (%d)", inst.level, armor_value)
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

local function SpawnGold(inst, owner) --#TODO:尝试简化代码
	inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")

	local goldnugget = SpawnPrefab("goldnugget")
	local pt = Vector3(inst.Transform:GetWorldPosition()) + Vector3(0, 2, 0)

	goldnugget.Transform:SetPosition(pt:Get())
	local angle = owner.Transform:GetRotation() * (PI / 180)
	local sp = (math.random() + 1) * -1
	goldnugget.Physics:SetVel(sp * math.cos(angle), math.random() * 2 + 2, -sp * math.sin(angle))
	goldnugget.components.inventoryitem:OnDropped()
end

local function OnBlocked(owner)
	owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

local function OnOpen(inst)
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
end

local function OnClose(inst)
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
end

local function OnEquip(inst, owner)
	inst.Equippable_Check(inst, owner)
	inst:ListenForEvent("blocked", OnBlocked, owner)

	Updata(inst)

	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end

	local switch = {
		["pirate"] = [[owner.AnimState:OverrideSymbol("swap_body", "armor_pirate", "swap_body")]],
		["green"] = [[owner.AnimState:OverrideSymbol("swap_body", "armor_mushaa", "swap_body")]],
		["pink"] = [[owner.AnimState:OverrideSymbol("swap_body", "armor_mushab", "swap_body")]],
		["blue"] = [[owner.AnimState:OverrideSymbol("swap_body", "armor_frostar", "swap_body")]],
		["chest"] = [[owner.AnimState:OverrideSymbol("swap_body", "swap_pirate_musha_bag", "backpack")\nowner.AnimState:OverrideSymbol("swap_body", "swap_pirate_musha_bag", "swap_body")]]
	}

	loadstring(switch[string.lower(inst.armor_visual)])

	local switch = {
		["BMM"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack5_mini", "swap_body_tall")]],
		["BT"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack4_mini", "swap_body_tall")]],
		["BS"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack3", "swap_body_tall")]],
		["BM"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack", "swap_body_tall")]],
		["BL"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "musha_backpack2", "swap_body_tall")]],
		["WSP"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_pink_s", "swap_body_tall")]],
		["WSR"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_s", "swap_body_tall")]],
		["WSB"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_blue_s", "swap_body_tall")]],
		["WSH"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_green_s", "swap_body_tall")]],
		["WLR"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly", "swap_body_tall")]],
		["WLB"] = [[owner.AnimState:OverrideSymbol("swap_body_tall", "armor_butterfly_blue", "swap_body_tall")]]
	}

	if inst.back_visual ~= "off" then
		loadstring(switch[string.upper(inst.back_visual)])
	end

	inst.goldnugget_task =
		inst:DoPeriodicTask(
		TUNING.TOTAL_DAY_TIME,
		function()
			SpawnGold(inst, owner)
		end
	)

	inst.defense = function(attacked, data)
		if math.random() < 0.75 then
			-- local shadowangle = math.random(1, 360)
			-- local offset = FindWalkableOffset(inst:GetPosition(), drakeangle*DEGREES, math.random(2,8), 30, false, false)
			local tentacle = SpawnPrefab("tentacle_shadow")
			local x, y, z = inst.Transform:GetWorldPosition()
			tentacle.Transform:SetPosition(x, y + math.random(1, 1) * 1 or y, z)
		end
	end

	inst:ListenForEvent("attacked", inst.BeAttacked, owner)
	inst:ListenForEvent("attacked", inst.defense, owner)
end

local function OnUnequip(inst, owner)
	inst:RemoveEventCallback("blocked", OnBlocked, owner)
	owner.AnimState:ClearOverrideSymbol("swap_body")
	owner.AnimState:ClearOverrideSymbol("backpack")
	owner.AnimState:ClearOverrideSymbol("swap_body_tall")
	inst:RemoveEventCallback("attacked", inst.BeAttacked, owner)
	inst:RemoveEventCallback("attacked", inst.defense, owner)
	if inst.components.container ~= nil then
		inst.components.container:Close(owner)
	end
	inst.goldnugget_task:Cancel()
	inst.goldnugget_task = nil
end

local function fn()
	local inst = Musha_Api.fn_common({maxfuel = 850, type = "armor", OnEquip = OnEquip, OnUnequip = OnUnequip})

	inst.AnimState:SetBank("pirate_booty_bag")
	inst.AnimState:SetBuild("swap_pirate_musha_bag")
	inst.AnimState:PlayAnimation("anim")

	inst.MiniMapEntity:SetIcon("pirateback.tex")

	inst:AddTag("backpack")
	inst:AddTag("lowcool")
	inst:AddTag("marble")
	inst:AddTag("aquatic")

	inst.foleysound = "dontstarve/movement/foley/marblearmour"

	if TheNet:GetIsClient() then
		return inst
	end

	inst.components.inventoryitem.atlasname = "images/inventoryimages/pirateback.xml"

	inst.components.equippable.equipslot = EQUIPSLOTS.BACK or EQUIPSLOTS.PACK or EQUIPSLOTS.BODY

	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
	ChangeInsulation(inst)

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("pirateback")
	inst.components.container.onopenfn = OnOpen
	inst.components.container.onclosefn = OnClose

	inst.Updata = Updata
	inst.OnBroken = function(inst)
		if inst.components.armor.absorb_percent ~= 0 then
			inst.components.fueled:StopConsuming()
			inst.components.armor:InitIndestructible(0)
			inst.components.talker:Say(
				STRINGS.MUSHA_ARMOR_BROKEN .. "\n" .. STRINGS.MUSHA_ARMOR .. " (0)\n" .. STRINGS.MUSHA_ITEM_DUR .. " (0)"
			)
		end
		inst.components.fueled:StopConsuming()
	end

	return inst
end

return Prefab("common/inventory/pirateback", fn, assets)
