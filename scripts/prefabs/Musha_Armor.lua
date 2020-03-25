local assets = {
	Asset("ANIM", "anim/musha_armor_prototype.zip"),
	Asset("ANIM", "anim/musha_armor_princess.zip"),
	Asset("ANIM", "anim/musha_armor_frostB.zip"),
	Asset("ANIM", "anim/musha_armor_frostG.zip"),
	Asset("ANIM", "anim/musha_armor_frostO.zip"),
	Asset("ANIM", "anim/musha_armor_frostold.zip"),
	Asset("ANIM", "anim/musha_armor_frostP.zip"),
	Asset("ANIM", "anim/musha_armor_frostveryold.zip"),
	
	Asset("ATLAS", "images/inventoryimages/musha_armor_prototype.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_armor_prototype.tex"),
	
	Asset("ATLAS", "images/inventoryimages/musha_armor_princess.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_armor_princess.tex"),
	
	Asset("ATLAS", "images/inventoryimages/musha_armor_frost.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_armor_frost.tex"),
	
	Asset("ATLAS", "images/oldassets/broken_frosthammer.xml"),
	Asset("IMAGE", "images/oldassets/broken_frosthammer.tex"),
}

--告诉玩家装备每一级升级所需的经验算法
local function CountLevel(value)--这个是经验需求
if value <= 10 then
local result = math.ceil(value/5)*5
return result
elseif value <= 110 then
local result = math.ceil((value-10)/20)*20+10
return result
elseif value <= 410 then
local result = math.ceil((value-110)/60)*60+110
return result
elseif value <= 1010 then
local result = math.ceil((value-410)/120)*120+410
return result
elseif value <= 2010 then
local result = math.ceil((value-1010)/200)*200+1010
return result
elseif value <= 3210 then
local result = math.ceil((value-2010)/280)*280+2010
return result
elseif value <= 4000 then
local result = math.ceil((value-3210)/395)*395+3210
return result
end
end

local function ArmorLevel(value)--这个是等级上限
if value <= 10 then
local result = math.ceil(value/5)
return result
elseif value <= 110 then
local result = math.ceil((value-10)/20)+2
return result
elseif value <= 410 then
local result = math.ceil((value-110)/60)+7
return result
elseif value <= 1010 then
local result = math.ceil((value-410)/120)+12
return result
elseif value <= 2010 then
local result = math.ceil((value-1010)/200)+17
return result
elseif value <= 3210 then
local result = math.ceil((value-2010)/280)+22
return result
elseif value <= 4000 then
local result = math.ceil((value-3210)/395)+27
return result
end
end

--随机经验
local function Random_EXP(inst)
	local lucky = math.random()
	if lucky < 0.12 then
		return 8
	elseif lucky < 0.2 then
		return 5
	elseif lucky < 0.3 then
		return 4
	elseif lucky < 1 then
		return 1
	end
end

--有炉子？那么
local function forgelab(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 6, {"forge_musha"})
	if not (#ents) then
		return false
	end
	for k, v in pairs(ents) do
		if v.is_On and v.components.fueled.currentfuel >= 3 then
			v.Player_Upgrade()
			return true
		end
	end
	return false
end

--强化时候说的内容
local function Armor_level(inst, lucky_point)
	local level_exp = math.min(CountLevel(inst.level), inst.maxexp)
	if inst.level <= inst.maxexp then
		if nil == lucky_point then
			inst.components.talker:Say(
				inst:GetDisplayName "\n" .. "\n[" .. STRINGS.MUSHA_ITEM_GROWPOINTS .. "]" .. (inst.level) .. "/" .. level_exp
			)
		elseif lucky_point == 1 then
			inst.components.talker:Say(
				inst:GetDisplayName "\n" .. "\n" .. STRINGS.MUSHA_ITEM_GROWPOINTS .. "[1]\n" .. (inst.level) .. "/" .. level_exp
			)
		else
			inst.components.talker:Say(
				inst:GetDisplayName "\n" ..
					"\n" .. STRINGS.MUSHA_ITEM_LUCKY .. "[" .. lucky_point .. "]\n" .. (inst.level) .. "/" .. level_exp
			)
		end
	else
		inst.components.talker:Say(STRINGS.MUSHA_LEVEL_INFORMATION)
	end
end

--强化更新装备参数
local function UpgradeArmor(inst, data)
if inst.components.fueled:IsEmpty() then
inst.broken = true
elseif not inst.components.fueled:IsEmpty() then
inst.broken = false
end
if inst.broken then
inst.components.fueled:StopConsuming()        
inst.components.armor:InitIndestructible(0)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_BROKEN.."\n"..STRINGS.MUSHA_ARMOR.." (0)\n"..STRINGS.MUSHA_ITEM_DUR.." (0)")
  
elseif not inst.broken then
inst.components.armor:InitIndestructible(0.80)
inst.components.talker:Say(STRINGS.MUSHA_ARMOR_MUSHAA.." (LV30)\n"..STRINGS.MUSHA_ARMOR.." (80)")
end
end

--给装备升级的参数
local function Gain_Exp(inst)
	if forgelab(inst) then
		local Exp = Random_EXP() * 5
		inst.level = inst.level + Exp
		inst.SoundEmitter:PlaySound("dontstarve/common/fireAddFuel")
		inst.level = math.min(inst.level, inst.maxexp)
		local level_exp = math.min(CountLevel(inst.level), inst.maxexp)
		inst.components.talker:Say(
			STRINGS.MUSHA_TALK_FORGE_LUCKY ..
				"\n+(" .. Exp .. ")\n[" .. STRINGS.MUSHA_ITEM_GROWPOINTS .. "]" .. (inst.level) .. "/" .. level_exp
		)
	else
		local Exp = Random_EXP()
		inst.level = inst.level + Exp
		inst.level = math.min(inst.level, inst.maxexp)
		Armor_level(inst, Exp)
	end
end

--增加燃料，增加经验
local function OnGetItemFromPlayer(inst, giver, item)
	inst.components.fueled:DoDelta(50)
	SpawnPrefab("splash").Transform:SetPosition(inst:GetPosition():Get())
	if inst.level < inst.maxexp then
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

--自动回血
local function healowner(inst, owner)
    if (owner.components.health and owner.components.health:IsHurt())
    and (owner.components.hunger and owner.components.hunger.current > 160)then
        owner.components.health:DoDelta(2,false)
elseif (owner.components.health and owner.components.health:IsHurt())
    and (owner.components.hunger and owner.components.hunger.current < 160 and owner.components.hunger and owner.components.hunger.current > 30  )then
        owner.components.health:DoDelta(1,false)
        owner.components.sanity:DoDelta(1,false)
elseif (owner.components.health and owner.components.health:IsHurt())
    and (owner.components.hunger and owner.components.hunger.current < 30 )then
        owner.components.sanity:DoDelta(2,false)
    end
end

local function FindEntity(inst, owner)
	if not owner then
		return
	end

	local hounded = TheWorld.components.hounded
	local danger = hounded ~= nil and (hounded:GetWarning() or hounded:GetAttacking())

	if danger then
		if not inst.on_shield then
			if inst.level < 10 then
				inst.components.equippable.walkspeedmult = 1.15
			elseif inst.level < 15 then
				inst.components.equippable.walkspeedmult = 1.2
			elseif inst.level < 20 then
				inst.components.equippable.walkspeedmult = 1.25
			elseif inst.level < 30 then
				inst.components.equippable.walkspeedmult = 1.3
			else
				inst.components.equippable.walkspeedmult = 1.35
			end
		end
	else
		inst.components.equippable.walkspeedmult = 1.0
	end
	inst.in_danger = danger
end

--下面都是冰甲技能 看不懂
local function consume(inst, owner)
if not inst.broken and inst.shield then
inst.components.fueled:DoDelta(-500)
end
if inst.broken and inst.shield then
inst.components.fueled:DoDelta(0)
end
end

local function on_shield(inst, owner)
if inst.shield and not inst.broken then
inst.components.talker:Say(STRINGS.MUSHA_ITEM_SHIELD.."\n"..STRINGS.MUSHA_ARMOR.."(100)\n"..STRINGS.MUSHA_ITEM_COOL)
inst.components.armor:InitIndestructible(1)
inst.consume = inst:DoPeriodicTask(1, function() consume(inst, owner) end)
elseif inst.shield and inst.broken then
inst.components.talker:Say(STRINGS.MUSHA_ITEM_SHIELD_BROKEN.."\n"..STRINGS.MUSHA_ARMOR.."(0)")
inst.components.armor:InitIndestructible(0)
if inst.consume then inst.consume:Cancel() inst.consume = nil end
end end

local function off_shield(inst)
if inst.shield then
inst.shield = false
UpgradeArmor(inst)
if inst.consume then inst.consume:Cancel() inst.consume = nil end
end
	if inst.components.heater then
	inst:RemoveComponent("heater")
	end
end

local function onuseshield(inst,owner)
if inst.components.container ~= nil and inst.no_butterfly_shield then
inst.components.container:Open(owner)
end
if not inst.broken and not inst.no_butterfly_shield then
inst.shield = true
on_shield(inst)
local owner = inst.components.inventoryitem.owner
if owner then
owner.sg:GoToState("shell_enter")
owner.SoundEmitter:PlaySound("dontstarve/wilson/pickup_reeds")
end
elseif inst.broken then
end
end

local function offuseshield(inst,owner)
if inst.consume then inst.consume:Cancel() inst.consume = nil end
off_shield(inst)
end

--变冷
local function sanity_cost(inst, owner)
	if not inst.components.heater and inst.shield then
	inst:AddComponent("heater")
	end
    if owner.components.sanity and inst.shield then
	 
        owner.components.sanity:DoDelta(-1,false)
		inst.components.heater:SetThermics(false, true)
		inst.components.heater.equippedheat = -2
		inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	end
	
end

--冬暖夏凉？
local function ChangeInsulation(inst)
if TheWorld.state.issummer then
    inst.components.insulator:SetSummer()
elseif not TheWorld.state.issummer then
 	inst.components.insulator:SetWinter()
	end
end	

--提示玩家状态
local function applyupgrades(inst,data)

	local max_exp = 4500
	local exp = math.min(inst.level, max_exp)
	local levelup = (CountLevel(inst.level))
	if inst.level ~= 0 or inst.level ~= nil then
	inst.components.talker:Say(STRINGS.MUSHA_ARMOR_MUSHAA.." \n["..STRINGS.MUSHA_ITEM_GROWPOINTS.."]\n".. (inst.level).."/"..levelup)
	end
end

--停止掉耐久
local function OnDurability(inst, data)
	inst.components.fueled:StopConsuming()        
end

--保存经验和数据
local function OnLoad(inst, data)
	-- inst.UpgradeArmor(inst)
end

local function onsave(inst, data)
    data.level = inst.level > 0 and inst.level or nil
end

--读取经验
local function onpreload(inst, data)
    if data ~= nil and data.level ~= nil then
        inst.level = data.level
        applyupgrades(inst)
	end
end

--似乎是声音？我不确定，辣椒你有空帮我改改qwq
local function OnBlocked(owner)
	owner.SoundEmitter:PlaySound("dontstarve/wilson/hit_armour")
end

--开启背包的代码
local function onopen(inst, owner)
	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end
end

--关闭背包的代码
local function onclose(inst, owner)
	if inst.components.container ~= nil then
		inst.components.container:Close(owner)
	end
end

--穿上装备的函数
local function onequip(inst, owner)
local armor_prefab = inst.prefab --先等于身上穿着的装备
local musha = owner.prefab
if armor_prefab == "armor_mushaa" or armor_prefab == "musha_armor_prototype" then
armor_prefab = TUNING.musha_armor_prototype
elseif armor_prefab == "armor_mushab" or armor_prefab == "musha_armor_princess" then
armor_prefab = TUNING.musha_armor_princess
elseif armor_prefab == "musha_armor_frost" or armor_prefab == "broken_frosthammer" then
armor_prefab = TUNING.musha_armor_frost
elseif armor_prefab == "musha_armor_pirate" then
armor_prefab = TUNING.musha_armor_pirate
end
if inst.share_item then --然后判断共享条件
	if musha == "musha" then --如果是musha，那么就执行以下语句
	owner.AnimState:OverrideSymbol("swap_body", armor_prefab, "swap_body")--中间填入动画名称
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end
	else --否则装备会掉下来
	owner:DoTaskInTime(0, function()
	local inventory = owner.components.inventory 
	if inventory then
		inventory:DropItem(inst)
	end
	local talker = owner.components.talker 
	if talker then
		talker:Say("我不能使用它")
	end
		end)
end
else --如果开了共享，那么执行以下语句
	owner.AnimState:OverrideSymbol("swap_body", armor_prefab, "swap_body")--中间填入动画名称
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
	if inst.components.container ~= nil then
		inst.components.container:Open(owner)
	end
end	
if armor_prefab == "musha_armor_frost" or armor_prefab == "broken_frosthammer" then
inst.freezefn = function(_, data)
		local attacker = data.attacker
		if data and attacker and attacker.components.freezable and attacker.components.combat then
			local fx = SpawnPrefab("icespike_fx_" .. math.random(4))
			local freeze_value
			if inst.level < 25 then
				freeze_value = math.ceil(inst.level * 0.1) * 0.1 + 0.1
			else
				freeze_value = 0.5
			end
			if math.random() < freeze_value then
				attacker.components.freezable:AddColdness(freeze_value)
				attacker.components.freezable:SpawnShatterFX()
				fx.Transform:SetScale(1, math.ceil(inst.level * 0.1) * 0.25 + 0.5, 1)
				fx.Transform:SetPosition(attacker:GetPosition():Get())
			end
		end
	end

	inst:ListenForEvent("attacked", inst.freezefn, owner)
end
end

--如果共享没有开，捡起来的人不是musha，那么它就会掉下来。
local function onpickupfn(inst, pickupguy)
	if inst.share_item then
	if owner.prefab == "musha" then
		if pickupguy.components.inventory then
			pickupguy:DoTaskInTime(0, function()
				pickupguy.components.inventory:DropItem(inst, true, true)
			end)
		end
	end
	end
end

--解除装备
local function onunequip(inst, owner)
	inst:RemoveEventCallback("blocked", OnBlocked, owner)
	local armor_prefab = inst.prefab --先等于身上穿着的装备
	owner.AnimState:ClearOverrideSymbol("swap_body")
	owner.AnimState:ClearOverrideSymbol("armor_prefab")
	owner.AnimState:ClearOverrideSymbol("swap_body")
	onclose(inst)
end


--装备实体函数
local function armor_mushaa()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, nil, nil)	
      	
    inst.AnimState:SetBank("musha_armor_prototype")
    inst.AnimState:SetBuild("musha_armor_prototype")
    inst.AnimState:PlayAnimation("anim")
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "armor_mushaa.tex" )
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 40
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.9, 1, 0.75, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"
	
	inst:AddTag("backpack")
	inst:AddTag("waterproofer")
	inst:AddTag("aquatic")
	
	inst:AddTag("ruins")
    inst:AddTag("metal")

    inst.foleysound = "dontstarve/movement/foley/metalarmour"
	
    inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end
	
    inst:AddComponent("inspectable")
    inst.boost = true
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.onpickupfn = onpickupfn
    inst.components.inventoryitem.atlasname = "images/oldassets/armor_mushaa.xml"
	
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
	
    inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.50)
	inst:AddTag("hide_percentage")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip( onequip )
    inst.components.equippable:SetOnUnequip( onunequip )
   
    inst:AddComponent("container")
 	inst.components.container:WidgetSetup("backpack")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(5000)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
    inst.components.fueled:StartConsuming()        

	inst.level = 0
	inst:ListenForEvent("levelup", applyupgrades)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.OnLoad = OnLoad

    return inst
end

local function musha_armor_prototype()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
    MakeInventoryFloatable(inst, nil, nil)	
      	
    inst.AnimState:SetBank("musha_armor_prototype")
    inst.AnimState:SetBuild("musha_armor_prototype")
    inst.AnimState:PlayAnimation("anim")
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_armor_prototype.tex" )
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 40
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.9, 1, 0.75, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"
	
	inst:AddTag("backpack")
	inst:AddTag("waterproofer")
	inst:AddTag("aquatic")
	
	inst:AddTag("ruins")
    inst:AddTag("metal")

    inst.foleysound = "dontstarve/movement/foley/metalarmour"
	
    inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end
	
    inst:AddComponent("inspectable")
    inst.boost = true
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.onpickupfn = onpickupfn
    inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_armor_prototype.xml"
	
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
	
    inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.50)
	inst:AddTag("hide_percentage")

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
   
    inst:AddComponent("container")
 	inst.components.container:WidgetSetup("backpack")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(5000)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
    inst.components.fueled:StartConsuming()        

	inst.level = 0
	inst:ListenForEvent("levelup", applyupgrades)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.OnLoad = OnLoad

    return inst
end

local function armor_mushab()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, nil, nil)

    inst.AnimState:SetBank("musha_armor_princess")
    inst.AnimState:SetBuild("musha_armor_princess")
    inst.AnimState:PlayAnimation("anim")
    
	inst:AddTag("backpack")
	inst:AddTag("waterproofer")
	inst:AddTag("aquatic")
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "armor_mushab.tex" )
	
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 40
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 0.8, 0.95, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"	
	

	inst:AddTag("ruins")
    inst:AddTag("metal")

    inst.foleysound = "dontstarve/movement/foley/metalarmour"
	
    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.onpickupfn = onpickupfn
	inst.components.inventoryitem.atlasname = "images/oldassets/armor_mushab.xml"
	
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)

    inst:AddComponent("container")
 	inst.components.container:WidgetSetup("musha_armor_princess")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
    inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
	ChangeInsulation(inst)
  
    inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.34)
	inst:AddTag("hide_percentage")
 
    inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	inst.level = 0
	inst:ListenForEvent("levelup", applyupgrades)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.OnLoad = OnLoad
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(5000)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
    inst.components.fueled:StartConsuming()      

    return inst
end

local function musha_armor_princess()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, nil, nil)

    inst.AnimState:SetBank("musha_armor_princess")
    inst.AnimState:SetBuild("musha_armor_princess")
    inst.AnimState:PlayAnimation("anim")

	inst:AddTag("backpack")
	inst:AddTag("waterproofer")
	inst:AddTag("aquatic")
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_armor_princess.tex" )
	
    inst:AddComponent("talker")
    inst.components.talker.fontsize = 40
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(1, 0.8, 0.95, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"	
	

	inst:AddTag("ruins")
    inst:AddTag("metal")

    inst.foleysound = "dontstarve/movement/foley/metalarmour"
	
    inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
		return inst
	end

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.onpickupfn = onpickupfn
	inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_armor_princess.xml"
	
    inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)

    inst:AddComponent("container")
 	inst.components.container:WidgetSetup("musha_armor_princess")
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
	
    inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
	ChangeInsulation(inst)
 -------------------------   
    inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.34)
	inst:AddTag("hide_percentage")
 
    inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	inst.level = 0
	inst:ListenForEvent("levelup", applyupgrades)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.OnLoad = OnLoad
	
	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(5000)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
    inst.components.fueled:StartConsuming()

    return inst
end

local function musha_armor_frost()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, nil, nil)
	
    inst.AnimState:SetBank("musha_armor_frostP")
    inst.AnimState:SetBuild("musha_armor_frostP")
    inst.AnimState:PlayAnimation("anim")
	
	inst:AddTag("waterproofer")
	inst:AddTag("butterfly")
	inst:AddTag("backpack")
	inst:AddTag("aquatic")
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "musha_armor_frost.tex" )
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 40
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"

	inst:AddTag("shell")

    inst.foleysound = "dontstarve/movement/foley/shellarmour"

	inst.entity:SetPristine()	

	if not TheWorld.ismastersim then
		return inst
	end

    if not inst.no_butterfly_shield then
    inst:AddComponent("useableitem")
       inst.components.useableitem:SetOnUseFn(onuseshield)
       inst.components.useableitem:SetOnStopUseFn(offuseshield)
	end
	
    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
    inst.components.insulator:SetSummer()

    inst:AddComponent("container")
 	inst.components.container:WidgetSetup("backpack")  --主机设置容日  
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
 
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.onpickupfn = onpickupfn
    inst.components.inventoryitem.atlasname = "images/oldassets/musha_armor_frost.xml"
	
	inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

    inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.03)

    inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
	inst.components.insulator:SetSummer()
	--inst.components.insulator.insulation = TUNING.INSULATION_SMALL

    inst.level = 0
	inst:ListenForEvent("levelup", applyupgrades)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.OnLoad = OnLoad

    inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(5000)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
    inst.components.fueled:StartConsuming()
	
	MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

local function broken_frosthammer()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	MakeInventoryFloatable(inst, nil, nil)
	
    inst.AnimState:SetBank("musha_armor_frostP")
    inst.AnimState:SetBuild("musha_armor_frostP")
    inst.AnimState:PlayAnimation("anim")
	
	inst:AddTag("waterproofer")
	inst:AddTag("butterfly")
	inst:AddTag("backpack")
	inst:AddTag("aquatic")
	inst:AddTag("fridge")
	inst:AddTag("lowcool")
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "broken_frosthammer.tex" )
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 40
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"

	inst:AddTag("shell")

    inst.foleysound = "dontstarve/movement/foley/shellarmour"

	inst.entity:SetPristine()	

	if not TheWorld.ismastersim then
		return inst
	end

	if not inst.no_butterfly_shield then
    inst:AddComponent("useableitem")
       inst.components.useableitem:SetOnUseFn(onuseshield)
       inst.components.useableitem:SetOnStopUseFn(offuseshield)
	end
	
    inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
    inst.components.insulator:SetSummer()

    inst:AddComponent("container")
 	inst.components.container:WidgetSetup("backpack")  --主机设置容日  
	inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
 
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.onpickupfn = onpickupfn
    inst.components.inventoryitem.atlasname = "images/oldassets/broken_frosthammer.xml"
	
	inst:AddComponent("waterproofer")
    inst.components.waterproofer.effectiveness = 0

    inst:AddComponent("armor")
	inst.components.armor:InitIndestructible(0.03)

    inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
	inst.components.insulator:SetSummer()
	--inst.components.insulator.insulation = TUNING.INSULATION_SMALL

    inst.level = 0
	inst:ListenForEvent("levelup", applyupgrades)
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	
	inst.OnLoad = OnLoad

    inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "CHEMICAL"
	inst.components.fueled:InitializeFuelLevel(5000)
	inst.components.fueled:SetDepletedFn(OnDurability)
	inst.components.fueled.ontakefuelfn = OnGetItemFromPlayer
	inst.components.fueled.accepting = true
    inst.components.fueled:StartConsuming()
	
	MakeHauntableLaunchAndDropFirstItem(inst)

    return inst
end

return Prefab("armor_mushaa", armor_mushaa, assets),
Prefab("musha_armor_prototype", musha_armor_prototype, assets),
Prefab("armor_mushab", armor_mushab, assets),
Prefab("musha_armor_princess", musha_armor_princess, assets),
Prefab("musha_armor_frost", musha_armor_frost, assets),
Prefab("broken_frosthammer", broken_frosthammer, assets)