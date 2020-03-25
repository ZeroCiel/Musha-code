local IsServer = GLOBAL.TheNet:GetIsServer()

--Musha Data
local Musha_sanity = GetModConfigData("Musha_sanity")
local Musha_Damage = GetModConfigData("Musha_damage")
local Musha_Mana = GetModConfigData("Musha_mana")
local Sniff = GetModConfigData("Musha_sniff")
local Tired = GetModConfigData("Musha_tired")
local Sleep = GetModConfigData("Musha_sleep")
local Music = GetModConfigData("Musha_music")

--Musha food
local Princess = GetModConfigData("Musha_staste")
local Diet = GetModConfigData("Musha_diet")
local Dislike = GetModConfigData("Musha_favorite")


--other Setting
local death_penalty = GetModConfigData("deathPenalty")
local Badge_type = GetModConfigData("badge_type")

local function Difficulty_A(value,modsetting,a,b,c,d)
if modsetting == "easy" then
local result = value * a
return result
elseif modsetting == "normal" then
local result = value * b
return result
elseif modsetting == "hard" then
local result = value * c
return result
elseif modsetting == "hardcore" then
local result = value * d
return result
end
end

local function Difficulty_C(value,modsetting,a,b,c,d,e)
if modsetting == "veryeasy" then
local result = value * a
return result
elseif modsetting == "easy" then
local result = value * b
return result
elseif modsetting == "normal" then
local result = value * c
return result
elseif modsetting == "hard" then
local result = value * d
return result
elseif modsetting == "hardcore" then
local result = value * e
return result
end
end

local function Difficulty_D(value,modsetting,a,b,c,d,e)
if modsetting == "veryeasy" then
local result = value/a
return result
elseif modsetting == "easy" then
local result = value/b
return result
elseif modsetting == "normal" then
local result = value/c
return result
elseif modsetting == "hard" then
local result = value/d
return result
elseif modsetting == "hardcore" then
local result = value/e
return result
end
end

--外观设置
TUNING.musha_armor_prototype = GetModConfigData("musha_armor_prototype")
TUNING.musha_armor_princess = GetModConfigData("musha_armor_princess")
TUNING.musha_armor_frost = GetModConfigData("musha_armor_frostP")
TUNING.musha_armor_pirate = GetModConfigData("musha_armor_pirate")

TUNING.Musha_health = GetModConfigData("Musha_health")--血量设置 第一个
TUNING.Musha_damage_Melee = GetModConfigData("Musha_damage_Melee")
TUNING.Musha_damage_range = GetModConfigData("Musha_damage_range")

TUNING.Musha_DamageMax = Difficulty_C(0.25,Musha_Damage,5,4,3,2,1)
TUNING.Musha_Sniff = Difficulty_A(1,Sniff,0.1,0.05,0.025,0.001)
TUNING.Musha_Tired = Difficulty_C(0.05,Tired,1,2,4,8,16)
TUNING.Musha_Music = Difficulty_C(0.25,Music,5,4,3,2,1)
TUNING.Musha_Tired_valkyrie = Difficulty_C(1,Tired,0.2,0.3,0.4,0.6,0.8)

--other setting 我没好想法优化它了
if IsServer then
local function Musha_sanity(inst)--这串要检查
if Musha_sanity == "veryeasy" then
inst.newbies = true
elseif Musha_sanity == "easy" then
inst.easys = true
elseif Musha_sanity == "normal" then
inst.normals = true
elseif Musha_sanity == "hard" then
inst.hards = true
elseif Musha_sanity == "hardcore" then
inst.hardcores = true
end
end
AddPrefabPostInit("musha", Musha_sanity)

--知识，聪明才智
local function SmartSetting(inst)
inst.components.builder.science_bonus = GetModConfigData("Musha_smart")
end
AddPrefabPostInit("musha", SmartSetting)

--你是猪人还是公主？
if Princess then
local function musha_princess_taste(inst)
inst.princess_taste = true
end
AddPrefabPostInit("musha", musha_princess_taste)
end

--设置死亡经验
local function Death_Penalty(inst)   
if death_penalty then
inst.no_panalty = true
end
end
AddPrefabPostInit("musha", Death_Penalty)

--Musha food 下面的也差不多吧
local function exp_type_meat(inst)
		inst:AddComponent("edible")
		inst.components.edible.foodtype = FOODTYPE.MEAT
end

local function exp_type_veggie(inst)
		inst:AddComponent("edible")
		inst.components.edible.foodtype = FOODTYPE.VEGGIE
end

local function musha_dis_meat(inst)
inst.dis_meat_taste = true
end

local function musha_dis_veggie(inst)
inst.dis_veggie_taste = true
end

local function musha_normal(inst)
inst.normal_taste = true
end

local function musha_meat(inst)
inst.meat_taste = true
end

local function musha_veggie(inst)
inst.veggie_taste = true
end

if Dislike == "dis_meat" then
	AddPrefabPostInit("musha", musha_dis_meat)
elseif Dislike == "dis_veggie" then
	AddPrefabPostInit("musha", musha_dis_veggie)
end

if Diet == "normal" then
	AddPrefabPostInit("musha", musha_normal)
elseif Diet == "meat" then
	AddPrefabPostInit("musha", musha_meat)
elseif Diet == "veggie" then
	AddPrefabPostInit("musha", musha_veggie)
end
--这是一串无用的代码，但我得查到它的关联，防止再次崩溃。
-- local function SleepnTired(inst)
	-- if Badge_type == 0 then
		-- inst.No_Sleep_Princess = true
	-- else
		-- inst.No_Sleep_Princess = false
	-- end
-- end
-- AddPrefabPostInit("musha", SleepnTired)

local function never_eat(inst)
	inst:AddTag("no_edible")
end

local list_eat = {"powcake","mandrake","cookedmandrake","spoiled_food"}

for k, v in pairs(list_eat) do
	AddPrefabPostInit(v, never_eat)
end

local function Range_Weapon(inst)
	inst:AddTag("range_weapon")
end

local list_RWeapon = {"boomerang","blowdart_sleep","blowdart_fire","blowdart_pipe","blowdart_walrus","blowdart_poison","blowdart_yellow"}

for k, v in pairs(list_RWeapon) do
	AddPrefabPostInit(v, Range_Weapon)
end
end