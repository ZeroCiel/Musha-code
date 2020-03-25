GLOBAL.setmetatable(
	env,
	{__index = function(t, k)
			return GLOBAL.rawget(GLOBAL, k)
		end}
)

GLOBAL.STRINGS.TABS.MUSHA = "musha"
GLOBAL.RECIPETABS["MUSHA"] = {
	str = "musha",
	sort = 12,
	icon = "mushatab.tex",
	icon_atlas = "images/mushatab.xml",
	owner_tag = "musha"
}

--读取配方参数
local recipes_Normal = GetModConfigData("recipesNormal")
local recipes_gem = GetModConfigData("recipesgem")
local rabbit_recipe = GetModConfigData("rabbitrecipe")
local Archer = GetModConfigData("BOW")
--测定配方难易度
local a = 2
if recipes_Normal == "easy" then
a = 1
end
--开始生成材料数量
local NA,NB,NC,ND,NE,NF,NG,NH,NJ,NK,NL,NM,NN,NO,NP,NQ,NR = a*1,a*1+1,a*2,a*2+1,a*3,a*4,a*5,a*6,a*7+1,a*10,a*12,a*15,a*20,a*30,a*40,a*80,a*12+1
--写入可重复使用简化字节符
local glowdust01 = Ingredient( "glowdust", 1,"images/inventoryimages/glowdust.xml")
local musha_armor_a = Ingredient("armor_mushaa",1,"images/inventoryimages/musha_armor_prototype.xml")
local musha_broken_sword = Ingredient("mushasword_base",1,"images/inventoryimages/mushasword_base.xml")
local hat_rabbit = Ingredient("deserthat", 1)
--插入宝石配方序列
local Gem_level = TECH.MAGIC_FIVE
local Red_Gem = Ingredient( "bluegem", 1)
local Blue_Gem = Ingredient( "redgem", 1)
local FRW = Ingredient("nitre", 1)
local RW= Ingredient("nitre", 1)
--测定玩家配置
if rabbit_recipe then
hat_rabbit = Ingredient("pigskin", NA)
end
if recipes_gem == "normalgem" or recipes_gem == "moregem" then 
	Red_Gem = Ingredient("goldnugget",NG)
	Blue_Gem = Ingredient("goldnugget",NG)
	FRW = Ingredient("feather_robin_winter", 1)
	RW= Ingredient("feather_robin", 1)
end

--那么写入配方
local Musha_recipe = {
	{
		name = "glowdust",ingredients = {Ingredient("ash",1), Ingredient("honey", ND), Ingredient("green_fruit_cooked", 1,"images/inventoryimages/green_fruit_cooked.xml") }, level = TECH.NONE ,
	},
	{
		name = "tunacan_musha",ingredients = {Ingredient("fish_cooked",1), Ingredient("charcoal", 1) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "cristal",ingredients = {Ingredient("glowdust",ND,"images/inventoryimages/glowdust.xml"), Ingredient("purplegem", 1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "musha_flute",ingredients = {Ingredient("glowdust",NG,"images/inventoryimages/glowdust.xml"), Ingredient("horn", 1), Ingredient("spidergland", NN) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "redgem",ingredients = {Red_Gem,glowdust01,RW}, level = TECH.NONE ,
	},
	{
		name = "bluegem",ingredients = {Blue_Gem,glowdust01,FRW}, level = TECH.NONE ,
	},
	{
		name = "greengem",ingredients = {Ingredient("purplegem", NC),Ingredient("goldnugget",NF),Ingredient( "glowdust", ND,"images/inventoryimages/glowdust.xml")}, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "yellowgem",ingredients = {Ingredient("purplegem", NC),Ingredient("goldnugget",NF),Ingredient( "glowdust", ND,"images/inventoryimages/glowdust.xml")}, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "orangegem",ingredients = {Ingredient("purplegem", NC),Ingredient("goldnugget",NF),Ingredient( "glowdust", ND,"images/inventoryimages/glowdust.xml")}, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "musha_armor_prototype",ingredients = {Ingredient("glowdust",NB,"images/inventoryimages/glowdust.xml"), Ingredient("goldnugget", NK), Ingredient("rope", NB) }, level = TECH.NONE ,
	},
	{
		name = "musha_armor_princess",ingredients = {musha_armor_a, Ingredient("goldnugget", NK), Ingredient("orangegem", ND), Ingredient("bearger_fur", NC) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "musha_armor_frost",ingredients = {musha_armor_a,Ingredient("bluegem",NG), Ingredient("butterfly", NG), Ingredient("gears", NC) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "pirateback",ingredients = {musha_armor_a,Ingredient("goldnugget",NN), Ingredient("yellowgem", ND), Ingredient("livinglog", NF) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "hat_mbunny",ingredients = {Ingredient("cutgrass",NH), Ingredient("redgem", NA), hat_rabbit}, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "hat_mwildcat",ingredients = {Ingredient("purplegem",NC), Ingredient("gears", NC) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "hat_mbunnya",ingredients = {Ingredient("hat_mbunny",1,"images/inventoryimages/hat_mbunny.xml"), Ingredient("walrus_tusk", NA), Ingredient("orangegem", NA) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "hat_mprincess",ingredients = {Ingredient("glowdust",ND,"images/inventoryimages/glowdust.xml"), Ingredient("redgem", NB), Ingredient("amulet", 1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "hat_mphoenix",ingredients = {Ingredient("panflute",1), Ingredient("dragon_scales", 1), Ingredient("yellowgem", NC) , Ingredient("greengem", NC) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "mushasword_base",ingredients = {glowdust01, Ingredient("goldnugget", NC) }, level = TECH.NONE ,
	},
	{
		name = "mushasword",ingredients = {musha_broken_sword, Ingredient("redgem",NC), Ingredient("glowdust", 1,"images/inventoryimages/glowdust.xml") }, level = TECH.SCIENCE_ONE ,
	},
	{	
		name = "mushasword_frost",ingredients = {musha_broken_sword, Ingredient("bluegem",NC), Ingredient("glowdust", 1,"images/inventoryimages/glowdust.xml") }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "phoenixspear",ingredients = {Ingredient("mushasword_frost",1,"images/inventoryimages/mushasword_frost.xml"), Ingredient("mushasword",1,"images/inventoryimages/mushasword.xml"), Ingredient("goldnugget", NM), Ingredient("glowdust", NB,"images/inventoryimages/glowdust.xml") }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "mushasword4",ingredients = {Ingredient("goldnugget",NQ), Ingredient("purplegem",NH), Ingredient("greengem", NH), Ingredient("cristal", 1,"images/inventoryimages/cristal.xml") }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "frosthammer",ingredients = {Ingredient("deerclops_eyeball",1), Ingredient("bluegem",NL), Ingredient("livinglog", NG), Ingredient("gears", NE) }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "bowm",ingredients = {Ingredient("mushasword",1,"images/inventoryimages/mushasword.xml"), Ingredient("spidergland",NH), Ingredient("glowdust", NB,"images/inventoryimages/glowdust.xml") }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "dummy_arrow0",ingredients = {Ingredient("stinger",1), Ingredient("feather_crow",1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "dummy_arrow1",ingredients = {Ingredient("stinger",1), Ingredient("feather_robin",1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "dummy_arrow2",ingredients = {Ingredient("stinger",1), Ingredient("feather_robin_winter",1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "dummy_arrow4",ingredients = {Ingredient("stinger",NC), Ingredient("feather_canary",1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "dummy_arrow4",ingredients = {Ingredient("stinger",NC), Ingredient("feather_canary",1) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "dummy_arrow4",ingredients = {Ingredient("broken_arrow",1,"images/inventoryimages/arrowm_broken.xml") }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "tent_musha",ingredients = {Ingredient( "glowdust", ND,"images/inventoryimages/glowdust.xml"), Ingredient("fireflies",1),Ingredient("papyrus",NC),Ingredient("cutgrass", NM)}, level = TECH.SCIENCE_TWO , placer = "tent_musha_placer"
	},
	{
		name = "forge_musha",ingredients = {Ingredient( "cristal", 1,"images/inventoryimages/cristal.xml"), Ingredient("gears",NE),Ingredient("transistor",1),Ingredient("livinglog", NG)}, level = TECH.SCIENCE_TWO , placer = "forge_musha_placer"
	},
	{
		name = "musha_moon_tree",ingredients = {Ingredient( "glowdust", NK,"images/inventoryimages/glowdust.xml"), Ingredient("livinglog",NR),Ingredient("musha_egg_arong",1,"images/inventoryimages/musha_egg_arong.xml")}, level = TECH.SCIENCE_TWO , placer = "musha_moon_tree_placer"
	},
	{
		name = "musha_oven",ingredients = {Ingredient( "glowdust", ND,"images/inventoryimages/glowdust.xml"), Ingredient("rocks",NN),Ingredient("froglegs",1),Ingredient("purplegem", NA)}, level = TECH.SCIENCE_TWO , placer = "musha_oven_placer"
	},
	{
		name = "musha_egg_arong",ingredients = {Ingredient("glowdust",ND,"images/inventoryimages/glowdust.xml"), Ingredient("amulet",1), Ingredient("beefalowool", NN), Ingredient("purplegem", NF) }, level = TECH.SCIENCE_ONE ,
	},
	{
		name = "musha_egg_random",ingredients = {Ingredient("musha_egg",1,"images/inventoryimages/musha_egg.xml"), Ingredient("glowdust",ND,"images/inventoryimages/glowdust.xml") }, level = TECH.NONE ,
	},
	{
		name = "musha_egg",ingredients = {Ingredient("amulet",1), Ingredient("redgem",NJ), Ingredient("bluegem",NJ) }, level = TECH.NONE ,
	},
	{
		name = "musha_eggs1",ingredients = {Ingredient("musha_egg",1,"images/inventoryimages/musha_egg.xml"), Ingredient("goldnugget",NC), glowdust01 }, level = TECH.NONE ,
	},
	{
		name = "musha_eggs2",ingredients = {Ingredient("musha_eggs1",1,"images/inventoryimages/musha_eggs1.xml"), Ingredient("goldnugget",NG), glowdust01 }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "musha_eggs3",ingredients = {Ingredient("musha_eggs2",1,"images/inventoryimages/musha_eggs2.xml"), Ingredient("goldnugget",NK), glowdust01 }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "musha_egg1",ingredients = {Ingredient("musha_eggs3",1,"images/inventoryimages/musha_eggs3.xml"), Ingredient("goldnugget",NM), Ingredient("glowdust",ND,"images/inventoryimages/glowdust.xml") }, level = TECH.SCIENCE_TWO ,
	},
	{
		name = "musha_egg2",ingredients = {Ingredient("musha_egg1",1,"images/inventoryimages/musha_egg1.xml"), Ingredient("goldnugget",NO), Ingredient("purplegem",1), Ingredient("glowdust",NG,"images/inventoryimages/glowdust.xml") }, level = TECH.MAGIC_TWO ,
	},
	{
		name = "musha_egg3",ingredients = {Ingredient("musha_egg2",1,"images/inventoryimages/musha_egg2.xml"), Ingredient("goldnugget",NN), Ingredient("purplegem",ND), Ingredient("glowdust",NJ,"images/inventoryimages/glowdust.xml") }, level = TECH.MAGIC_TWO ,
	},
	{
		name = "musha_egg8",ingredients = {Ingredient("musha_egg3",1,"images/inventoryimages/musha_egg3.xml"), Ingredient("goldnugget",NP), Ingredient("purplegem",NG), Ingredient("glowdust",NK,"images/inventoryimages/glowdust.xml") }, level = TECH.MAGIC_THREE ,
	},
}

for k,v in ipairs(Musha_recipe) do 	
	AddRecipe(v.name,v.ingredients,RECIPETABS['MUSHA'],v.level,
	v.placer or nil, nil, nil, nil, "musha",
	"images/inventoryimages/"..v.name..".xml",	
	v.name..".tex"
	)
end

if recipes_gem == "oldGem" or recipes_gem == "normalgem" then
local Gem = {"greengem","yellowgem","orangegem"}
for i,v in ipairs(Gem) do
local Recipe =  GLOBAL.AllRecipes[v]
if Recipe then
Recipe.builder_tag	= "nodohere"
end	
end
end

if not Archer then
local Archer_Recipe = {"bowm","dummy_arrow0","dummy_arrow1","dummy_arrow2","dummy_arrow4"}
for i,v in ipairs(Archer_Recipe) do
local Recipe =  GLOBAL.AllRecipes[v]
if Recipe then
Recipe.builder_tag	= "nodohere"
end
end
end

--Book 这个配方写法没问题！丢后面都可以的！
Recipe("book_birds", 	 {Ingredient("papyrus", NA), Ingredient("bird_egg", NA)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
Recipe("book_gardening", {Ingredient("papyrus", NA), Ingredient("seeds", 1), Ingredient("poop", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
Recipe("book_sleep", 	 {Ingredient("papyrus", NA), Ingredient("nightmarefuel", NA)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
Recipe("book_brimstone", {Ingredient("papyrus", NA), Ingredient("redgem", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")
Recipe("book_tentacles", {Ingredient("papyrus", NA), Ingredient("tentaclespots", 1)}, CUSTOM_RECIPETABS.BOOKS, TECH.NONE, nil, nil, nil, nil, "bookbuilder")