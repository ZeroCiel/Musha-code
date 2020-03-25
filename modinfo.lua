--MOD Name
name = "[DST]Musha[Beta]"

-- Mod Authors
author = "Sunnyyyyholic maintain:Ciel"

--MOD Version
version = "1.25"

--MOD Description
description =
	"Version log please move to steam pack.\n\n版本日志请移步Steam页面。"

--link

--MOD priority 优先级设置，需要调整优先级请到这里更改Priority信息
api_version = 10
priority = -100000

-- Engine/DLC Compatibility
-- Don't Starve Together
dst_compatible = true
-- Don't Starve(it‘s to not work)
dont_starve_compatible = false
-- Don't Starve: Shipwrecked
shipwrecked_compatible = false
-- Don't Starve: Reign of Giants
reign_of_giants_compatible = false

-- Mods which add new objects are required by all clients.
all_clients_require_mod = true
-- Client-only mods don't affect other players or the server.
client_only_mod = false
--Server special
--server_only_mod = false

-- Preview image
icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = {"musha"}

--Refer to other mod designs 增加标题。
local never = {{description = "", data = false}}
local function Breaker(title, hover)
	return {
		name = title,
		hover = hover,
		options = never,
		default = false
	}
end

--Add mod setting/增加MOD设置
local function AddConfig(name, label, hover, options, default)
    return {name = name, label = label, hover = hover or "", options = options, default = default}
end

--Key/键位
local keys ={
{"BACKSPACE", 8},{"TAB", 9},{"ENTER", 13},{"PAUSE", 19},{"ESCAPE", 27},{"SPACE", 32},{"MINUS", 45},{"PERIOD", 46},{"SLASH", 47},{"0", 48},{"1", 49},{"2", 50},{"3", 51},{"4", 52},{"5", 53},{"6", 54},{"7", 55},{"8", 56},{"9", 57},{"EQUALS", 61},{"LEFTBRACKET", 91},{"BACKSLASH", 92},{"RIGHTBRACKET", 93},{"TILDE", 96},{"A", 97},{"B", 98},{"C", 99},{"D", 100},{"E", 101},{"F", 102},{"G", 103},{"H", 104},{"I", 105},{"J", 106},{"K", 107},{"L", 108},{"M", 109},{"N", 110},{"O", 111},{"P", 112},{"Q", 113},{"R", 114},{"S", 115},{"T", 116},{"U", 117},{"V", 118},{"W", 119},{"X", 120},{"Y", 121},{"Z", 122},{"DELETE", 127},{"KP_PERIOD",266},{"KP_DIVIDE",267},{"KP_MULTIPLY",268},{"KP_MINUS",269},{"KP_PLUS",270},{"KP_ENTER",271},{"KP_EQUALS",272},{"UP",273},{"DOWN",274},{"RIGHT",275},{"LEFT",276},{"INSERT",277},{"HOME",278},{"END",279},{"PAGEUP",280},{"PAGEDOWN",281},{"F1", 282},{"F2",283},{"F3",284},{"F4",285},{"F5",286},{"F6",287},{"F7",288},{"F8",289},{"F9",290},{"F10",291},{"F11",292},{"F12",292},{"CAPSLOCK",301},{"SCROLLOCK",302},{"RSHIFT",303},{"LSHIFT",304},{"RCTRL",305},{"LCTRL",306},{"RALT",307},{"LALT",308},{"ALT",400},{"CTRL",401},{"SHIFT",402}
}

local key = {}
for k=1 ,#keys do
		key[k] = {description = keys[k][1], data = keys[k][2]}
end

--封装MOD设置函数
local function Setparameters_a(a,b,c,d)
    return {
	{description = a, data = b},
	{description = c, data = d}
	}
end

local function Setparameters_b(a,b,c,d,e,f)
    return {
	{description = a, data = b},
	{description = c, data = d},
	{description = e, data = f}
	}
end

local function Setparameters_c(a,b,c,d,e,f,g,h)
    return {
	{description = a, data = b},
	{description = c, data = d},
	{description = e, data = f},
	{description = g, data = h}
	}
end

local function Difficulty_A(a,b,c,d)
    return {
	{description = "Easy", data = a},
	{description = "Normal", data = b},
	{description = "Hard", data = c},
	{description = "VeryHard", data = d}
	}
end

local function Difficulty_B(a,b,c,d,e)
	return{
	{description = "VeryEasy", data = a},
	{description = "Easy", data = b},
	{description = "Normal", data = c},
	{description = "Hard", data = d},
	{description = "VeryHard", data = e}}
end

local function Difficulty_C(a,b,c,d,e,f)
	return{
	{description = "Super Easy", data = a},
	{description = "VeryEasy", data = b},
	{description = "Easy", data = c},
	{description = "Normal", data = d},
	{description = "Hard", data = e},
	{description = "VeryHard", data = f}}
end

local Switch = {{description = "Enable", data = true},{description = "Disable", data = false}}

local Backpack_appearance = {
{description = "Prototype", data = "musha_armor_prototype"},
{description = "Princess", data = "musha_armor_princess"},
{description = "Frost News", data = "musha_armor_frostP"},
{description = "Frost Original", data = "musha_armor_frostold"},
{description = "Frost Blue", data = "musha_armor_frostB"},
{description = "Frost Green", data = "musha_armor_frostG"},
{description = "Frost Orange", data = "musha_armor_frostO"},
{description = "Frost Old", data = "musha_armor_frostveryold"},
{description = "Pirate", data = "musha_armor_pirate"}
}

--Write Setting
configuration_options = {

	Breaker("Language", "Choose your language."),
	AddConfig("modlanguage","Mod Language","Please select language.",{{description = "Semi-Auto", data = "_en"},{description = "English", data = "_en"},{description = "한글", data = "_ko"},{description = "中文", data = "_cn"},{description = "русский", data = "_ru"}},"_en"),
	
	Breaker("Game Recipe"),--设定配方
	AddConfig("recipesNormal","Version [recipe]","Please select the version.",Setparameters_a("Easy Recipe","easy","Normal Recipe","normal"),"normal"),
	AddConfig("recipesgem","Gem [recipe]","In the past, sunnyyyyholic wrote some wrong code.. So I want to set right Recipe.",Setparameters_c("Out Gem","oldGem","Out More gem","oldMoreGem","Normal Gem","normalgem","More Gem","moregem"),"oldGem"),
	AddConfig("rabbitrecipe","Rabbit [recipe]","Do you want to change it?.",Setparameters_a("Pigskin",true,"Deserthat",false),true),
	AddConfig("BOW","Bow [recipe]","Do you want to use it?.",Switch,true),
	
	Breaker("Armor appearance"),--设定外观
	AddConfig("musha_armor_princess","Princess armor","Set princess armor appearance",Backpack_appearance,"musha_armor_princess"),
	AddConfig("musha_armor_prototype","Prototype armor","Set prototype armor appearance",Backpack_appearance,"musha_armor_prototype"),
	AddConfig("musha_armor_frostP","Frost armor","Set frost armor appearance",Backpack_appearance,"musha_armor_frostP"),
	AddConfig("musha_armor_pirate","pirate armor","Set frost armor appearance",Backpack_appearance,"musha_armor_pirate"),
	
	Breaker("Musha Skill Key"),--设定技能
	AddConfig("key","Level","Show Musha Level.",key,108),
	AddConfig("key5","Skill","Show Musha skills information.",key,107),
	AddConfig("key2","Lightning and Valkyrie","Power Lightning and Valkyrie.",key,114),
	AddConfig("key11","Hide and Sneak Attack","Hide in shadow and assassinate enemy.",key,103),
	AddConfig("key3","Shield","Spark Shield Spell.",key,99),
	AddConfig("key4","Performance","Performance and summon.",key,120),
	AddConfig("key12","Sleep","Sleep or Wake.",key,116),
	AddConfig("key7","Hold to Visual","Change Musha's appearance.",key,112),
	AddConfig("key15","Resest[Hold Visual]","return to base appearance.",key,111),
	AddConfig("key10","Sleep Badge","turn on/off.",key,110),
	
	Breaker("Musha Order Key"),--设定命令
	AddConfig("key6","Yamche Order: Follow or Stay","Command: [Follow or Stay and Retreat]",key,122),
	AddConfig("key8","Yamche Order: Battle Command","Command: [Hunt,Guard,Avoid]",key,118),
	AddConfig("key9","Yamche-Order: Gethering","Command: [Gethering Stuffs]",key,98),
	AddConfig("key13","Arong Order: Follow or Stay","Companion Arong",key,282),
	AddConfig("key14","Dall Order: Follow or Stay","Companion Dall",key,283),
	
	Breaker("Musha"),--设置游戏参数
	AddConfig("Musha_health","Musha Health","Musha Health/Sanity",Difficulty_A(10,5,2,1),5),--这个搞定了呀
	AddConfig("Musha_sanity","Sanity [Regen]","Musha Sanity Regen",Difficulty_B(1,2,3,4,5),2),--需要重写
	AddConfig("Musha_sniff","Sniff [Regen]","treasure smell",Difficulty_B(4,3,2,1,0.5),2),
	AddConfig("Musha_mana","Mana [Regen]","difficulty of mana regen",Difficulty_B(2.5,1.75,1.25,0.75,0.25),1.25),
	AddConfig("Musha_tired","Tired","difficulty of Tired",Difficulty,"normal"),--查不出 等崩溃结果
	AddConfig("Musha_sleep","Sleep","how much regenerate [Sleep] during sleeping",Difficulty,"normal"),
	AddConfig("Musha_music","Music","how much regenerate [Music] during sleeping",Difficulty,"normal"),
	AddConfig("Musha_smart","Knowledge","Science Bonus",Setparameters_b("Normal(+0)",0,"Smart(+1)",1,"Genius(+2)",2),0),
	AddConfig("Musha_staste","food setting","[Princess]: She can not eat a something when 'hunger' is more than 90%.\n[Piggy]: She can always eat a something.",Setparameters_a("Piggy",true,"Princess",false),true),
	
	AddConfig("Musha_damage_Melee","Weapon Melee Damage","Musha Basic Melee Damage",Difficulty_C(1.5,1.25,1,0.75,0.5,0.25),0.75),
	AddConfig("Musha_damage_range","Weapon Range Damage","Musha Basic Range Damage",Difficulty_B(2.5,1.75,1.25,0.75,0.25),1.75),
	
	AddConfig("death_Penalty","Death Penalty","Decrease EXP from death",Switch,true),
	
	Breaker("Musha food Setting"),
	AddConfig("Musha_diet","Edible Food Type","The Type of food she can eat.\nRegardless of this option, she can eat all of food type when her hunger is below 0.",Setparameters_b("Both","normal","Only-Meat","meat","Only-Veggie","veggie"),"normal"),
	AddConfig("Musha_favorite","Dislike Food Type","'Dis' meaning is Dislike food type.(sanity penalty)\nRegardless this option, she like caffeine apple and doesn't like eating butterflies.",Setparameters_b("Normal","normal","Dis-Meat","dis_meat","Dis-Veggie","dis_veggie"),"normal"),
	
	Breaker("Enemy difficulty"),
	AddConfig("Musha_over","Enemy Difficulty","Enemies power",Setparameters_c("Default","monster1x","Hard","monster2x","Hardcore","monster3x","Hell","monster4x"),"monster1x"),

	Breaker("API Component"),
	AddConfig("Components_Api","Pick Components[Warning/Test]","If you want harvest x2 or more, you can disable it.\nBut you can't use yamache pick up the farm and Cookpot and item!The game will be cause!",Switch,true),

	Breaker("Other Setting"),
	
	AddConfig("bodyguardwilson","Wilson","Bodyguard Wilson (random skill)",Switch,false),
	AddConfig("shareitems","Share items","can share musha's gears with another character",Switch,false),
	AddConfig("frostblade3rd","[Frost Blade]:Change 3rd booster","[Only Visual]:Change Frost blade visual of 3rd boost\n[V +Range]:Change Visual + Change boost weapon range",Setparameters_b("Normal",1,"SpearVisual",2,"V + Range",3),3),
	AddConfig("musha_incontainer","Compact Armor","Musha's armor can go in container.",Switch,true),
	AddConfig("stop_spawning","Dall: servant","[No spawn]:Moontree(Dall) stop spawning his servant and plants\n[Small Radius]: the plants are summoned in a small radius. ",Setparameters_b("Default",1,"Small Radius",2,"No Spawn",3),1),
	AddConfig("loudlightning","Loud Lightning Effect","Recommended for single play.\nOption1:effect with Power Lightning(R-key)\nOption2:effect with Power and Call Lightning(R-key)\nOption3:effect with All skill Lightning(passive valkyrie lightning)",Setparameters_c("Default","off","Option1","loud1","Option2","loud2","Option3","loud3"),"off")
}
