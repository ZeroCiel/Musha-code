PrefabFiles = {
--不要直接抄代码说明！！要么你就直接把出处作者都标明了！！

--musha
"musha",              --musha原型
"assasin_wilson",

--armor                    护甲
"musha_armor",

--weapon               
"mushasword_base",         --损坏的剑
"mushasword",              --原型剑
"mushasword_frost",        --冰霜凤凰剑
"mushasword4",             --凤凰长剑
"frosthammer",             --冰霜之锤
"bowm",                    --凤凰弓
"phoenixspear",            --凤凰斧
"arrowm",                  --弓箭
"arrowm_broken",           --损坏的弓箭

--hat                      头盔
"hat_mprincess",           --公主皇冠
"hat_mbunny",              --兔子侦察帽
"hat_mphoenix",            --公主头盔
"hat_mwildcat",            --钢铁猫头盔
"hat_mbunnya",             --钢铁兔子帽

--shadowpower
--"musha_shadowbook", 

--item                    物品
"musha_flute",            --治疗之笛
"cristal",                --水晶

"musha_exp",              --经验值
--"musha_apple",          --苹果
"portion_e",              --能量饮料
"glowdust",               --光尘
"tunacan",
"tunacan_musha",

--followers                --追随者
"tentacle_frost",          --冰霜触手
"tentacle_shadow",
"ghosthound",	           --大猎犬
"ghosthound2",	           --小猎犬
"shadowmusha",             --musha之影
   

----yamache                凤凰
"musha_small",             --小凤凰
"musha_egg",
"musha_egg1",
"musha_egg2",
"musha_egg3",
"musha_eggs1",
"musha_eggs2",
"musha_eggs3",
"musha_egg8",

"musha_egg_random",       --随机蛋

--musha's build           建筑
"tent_musha",             --musha帐篷
"forge_musha",            --熔炉
--"musha_hut",            --musha雨棚
"musha_oven",             --青蛙烤箱
	
--musha's arong we think not need this,And dettle it.beacso kiel have this.
"musha_egg_arong",        --musha牛蛋
"arong_baby",             --牛宝宝
"arong",                  --成年的牛
"arom",                   --？？？这啥牛，看上去很厉害

--Moontree and his followers 树人和它的追随者
"musha_moon_tree",        --月之树人
"moonnutdrake",
"moonnutdrake2",
"moonbush",               --浆果从
"moonlight_plant",        --浆果树

--The special effects
"forcefieldfxx"  ,--护盾
"lightning2",     --闪电
"lightning_blue", --闪电

"musha_ovenfire", --凤凰火焰
"musha_ovenfire_cold",--凤凰冷火
"musha_treasure2",--宝藏脚印
"bowm_projectile",--飞行中的弓箭
"poisonbubble2",  --中毒
"musha_debuff",
"musha_ferns",
"musha_spin_fx",  --特效闪电
"stalker_shield_musha",--特效黑暗护盾

---start treasure
"musha_hidden_egg",--隐藏的凤凰蛋 初始宝藏

--Custom plants
"green_apple_plant",--苹果树
"musha_berry",      --地下浆果
"musha_bulb",       --荧光花
"apple_berry",      --不一样的苹果树

--Custom monster
--"monster",
"greenworm",

-----? i don't know what's this 我不明白他们是什么
"musha_spores",
"musha_spores2",
"musha_spores_fire",
"green_ferns",
"light_ferns",
"musha_debuff",
"sporecloud2",	
"splash_water_yamche",
"debuff",
"green_fruit",
}

Assets = {
--Sound/声音
Asset("SOUNDPACKAGE", "sound/bowm.fev"),
Asset("SOUND", "sound/bowm_sounds.fsb"),

Asset("ANIM", "anim/swap_sailface_musha.zip"),--还不明白在哪里会使用到它
Asset("ANIM", "anim/musha_spin_fx.zip"),
--UI
Asset("ANIM", "anim/spellpower.zip" ),
Asset("ANIM", "anim/stamina.zip" ),
Asset("ANIM", "anim/fatigue.zip" ),
--Musha

Asset("ANIM", "anim/musha_normal.zip"),
Asset("ANIM", "anim/musha_battle.zip"),
Asset("ANIM", "anim/musha_hunger.zip"),

Asset("ANIM", "anim/musha_full_sw2.zip"),
Asset("ANIM", "anim/musha_normal_sw2.zip"),
Asset("ANIM", "anim/musha_battle_sw2.zip"),
Asset("ANIM", "anim/musha_hunger_sw2.zip"),
----
Asset("ANIM", "anim/musha_normal_k.zip"),
Asset("ANIM", "anim/musha_battle_k.zip"),
Asset("ANIM", "anim/musha_full_k.zip"),
Asset("ANIM", "anim/musha_hunger_k.zip"),
Asset("ANIM", "anim/musha_old.zip"),
Asset("ANIM", "anim/musha_normal_old.zip"),
Asset("ANIM", "anim/musha_battle_old.zip"),
Asset("ANIM", "anim/musha_hunger_old.zip"),
----
Asset("ANIM", "anim/player_actions_telescope.zip"),
Asset("ANIM", "anim/player_actions_uniqueitem_2.zip"),
Asset("ANIM", "anim/swap_telescope.zip"),
Asset("ANIM", "anim/messagebottle.zip"),
Asset("ANIM", "anim/player_actions_speargun.zip" ),

--Armor Anim 动画写在这里
Asset("ANIM", "anim/musha.zip"),

Asset("ANIM", "anim/musha_armor_prototype.zip"),
Asset("ANIM", "anim/musha_armor_princess.zip"),
Asset("ANIM", "anim/musha_armor_frostB.zip"),
Asset("ANIM", "anim/musha_armor_frostG.zip"),
Asset("ANIM", "anim/musha_armor_frostO.zip"),
Asset("ANIM", "anim/musha_armor_frostold.zip"),
Asset("ANIM", "anim/musha_armor_frostveryold.zip"),

--Armor asset 装备资源写在这里
Asset("ATLAS", "images/inventoryimages/musha_armor_prototype.xml"),
Asset("IMAGE", "images/inventoryimages/musha_armor_prototype.tex"),
Asset("ATLAS", "images/inventoryimages/musha_armor_princess.xml"),
Asset("IMAGE", "images/inventoryimages/musha_armor_princess.tex"),
Asset("ATLAS", "images/inventoryimages/musha_armor_frost.xml"),
Asset("IMAGE", "images/inventoryimages/musha_armor_frost.tex"),
Asset("ATLAS", "images/inventoryimages/musha_armor_frostB.xml"),
Asset("IMAGE", "images/inventoryimages/musha_armor_frostB.tex"),
Asset("ATLAS", "images/inventoryimages/musha_armor_frostG.xml"),
Asset("IMAGE", "images/inventoryimages/musha_armor_frostG.tex"),
Asset("ATLAS", "images/inventoryimages/musha_armor_frostO.xml"),
Asset("IMAGE", "images/inventoryimages/musha_armor_frostO.tex"),

Asset("ATLAS", "images/oldassets/armor_mushaa.xml"),
Asset("IMAGE", "images/oldassets/armor_mushaa.tex"),
Asset("ATLAS", "images/oldassets/armor_mushab.xml"),
Asset("IMAGE", "images/oldassets/armor_mushab.tex"),
Asset("ATLAS", "images/oldassets/broken_frosthammer.xml"),
Asset("IMAGE", "images/oldassets/broken_frosthammer.tex"),
Asset("ATLAS", "images/inventoryimages/pirateback.xml"),
Asset("IMAGE", "images/inventoryimages/pirateback.tex"),

--新版本资源 下面是人物有关的加载不需要动
Asset("ATLAS", "images/names_musha.xml"),--人物名字
Asset("IMAGE", "images/names_musha.tex"),

Asset("ATLAS", "bigportraits/musha.xml"),--人物大图
Asset("IMAGE", "bigportraits/musha.tex"),

-- Asset( "IMAGE", "bigportraits/musha_none.tex" ),  --人物大图（椭圆的那个）
-- Asset( "ATLAS", "bigportraits/musha_none.xml" ),

Asset("IMAGE", "images/musha.tex"),
Asset("ATLAS", "images/musha.xml"),

Asset("ATLAS", "images/musha_mapicon.xml"),
Asset("IMAGE", "images/musha_mapicon.tex"),

Asset("IMAGE", "images/avatars/avatar_musha.tex"),
Asset("ATLAS", "images/avatars/avatar_musha.xml"),

Asset("IMAGE", "images/avatars/avatar_ghost_musha.tex"),
Asset("ATLAS", "images/avatars/avatar_ghost_musha.xml"),

Asset("ATLAS", "images/avatars/self_inspect_musha.xml"),--人物检查按钮的图片
Asset("IMAGE", "images/avatars/self_inspect_musha.tex"),

-- Asset( "IMAGE", "images/map_icons/musha.tex" ), --小地图显示的头像
-- Asset( "ATLAS", "images/map_icons/musha.xml" ),

Asset( "IMAGE", "images/saveslot_portraits/musha.tex" ), --存档图片
Asset( "ATLAS", "images/saveslot_portraits/musha.xml" ),

--bow	
	Asset("ANIM", "anim/arrowm.zip"),
	Asset("ANIM", "anim/bowm.zip"),
    Asset("ANIM", "anim/swap_bowm.zip"),
	Asset("ANIM", "anim/swap_bowm2.zip"),
	Asset("ANIM", "anim/swap_bowm_boost.zip"),
	Asset("ANIM", "anim/swap_bowm_broken.zip"),
    Asset("ATLAS", "images/inventoryimages/bowm.xml"),
    Asset("IMAGE", "images/inventoryimages/bowm.tex"),
    Asset("ATLAS", "images/inventoryimages/arrowm.xml"),
    Asset("IMAGE", "images/inventoryimages/arrowm.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow0.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow0.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow1.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow1.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow2.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow2.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow3.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow3.tex"),
	Asset("ATLAS", "images/inventoryimages/dummy_arrow4.xml"),
    Asset("IMAGE", "images/inventoryimages/dummy_arrow4.tex"),
	Asset("ATLAS", "images/inventoryimages/arrowm_broken.xml"),
    Asset("IMAGE", "images/inventoryimages/arrowm_broken.tex"),
	
	Asset("ANIM", "anim/poison.zip"),
	Asset("ANIM", "anim/debuff_spark.zip"),
	Asset("ANIM", "anim/debuff_frozen.zip"),
	Asset("ANIM", "anim/debuff_spark_0.zip"),
	Asset("ANIM", "anim/sleep_debuff_30.zip"),
	Asset("ANIM", "anim/sleep_debuff_50.zip"),
	Asset("ANIM", "anim/sleep_debuff_70.zip"),
	Asset("ANIM", "anim/sleep_debuff_90.zip"),
	Asset("ANIM", "anim/tired_debuff_30.zip"),
	Asset("ANIM", "anim/tired_debuff_50.zip"),
	Asset("ANIM", "anim/tired_debuff_70.zip"),
	Asset("ANIM", "anim/tired_debuff_90.zip"),
	Asset("ANIM", "anim/sporecloud2.zip"),
----
Asset("ANIM", "anim/musha_egg_random.zip"),
Asset("ANIM", "anim/musha_egg8.zip"),
Asset("ANIM", "anim/musha_egg.zip"),
Asset("ANIM", "anim/musha_egg1.zip"),
Asset("ANIM", "anim/musha_egg2.zip"),
Asset("ANIM", "anim/musha_egg3.zip"),
Asset("ANIM", "anim/musha_eggs1.zip"),
Asset("ANIM", "anim/musha_eggs2.zip"),
Asset("ANIM", "anim/musha_eggs3.zip"),
Asset("ANIM", "anim/musha_ice.zip"),
Asset("ANIM", "anim/musha_small.zip"),
Asset("ANIM", "anim/musha_teen.zip"),
Asset("ANIM", "anim/musha_tall.zip"),
Asset("ANIM", "anim/musha_tall2.zip"),
Asset("ANIM", "anim/musha_tall3.zip"),
Asset("ANIM", "anim/musha_tall4.zip"),
Asset("ANIM", "anim/musha_tall5.zip"),

Asset("ANIM", "anim/frosthammer.zip"),
Asset("ANIM", "anim/swap_frosthammer.zip"),
Asset("ANIM", "anim/swap_frosthammer2.zip"),
Asset("ANIM", "anim/hat_mwildcat.zip"),
Asset("ANIM", "anim/hat_mwildcat2.zip"),
Asset("ANIM", "anim/hat_mbunny.zip"),
Asset("ANIM", "anim/hat_mbunny2.zip"),
Asset("ANIM", "anim/hat_mbunnya.zip"),
Asset("ANIM", "anim/hat_mbunnya2.zip"),
Asset("ANIM", "anim/hat_mphoenix.zip"),
Asset("ANIM", "anim/hat_mphoenix2.zip"),
Asset("ANIM", "anim/hat_mcrown.zip"),
Asset("ANIM", "anim/hat_mprincess.zip"),
Asset("ANIM", "anim/ghosthound.zip"),


Asset("ANIM", "anim/tent_musha.zip"),
Asset("ANIM", "anim/tent_musha_on.zip"),
Asset("ANIM", "anim/tent_musha_broken.zip"),

Asset("ANIM", "anim/forge_musha.zip"),
Asset("ANIM", "anim/forge_musha_on.zip"),
Asset("ANIM", "anim/forge_musha_broken.zip"),

Asset("ANIM", "anim/armor_pirate.zip"),

Asset("ANIM", "anim/ui_chest_yamche0.zip"),
Asset("ANIM", "anim/ui_chest_yamche1.zip"),
Asset("ANIM", "anim/ui_chest_yamche2.zip"),
Asset("ANIM", "anim/hat_yamche.zip"),
Asset("ANIM", "anim/hat_yamche_on.zip"),
Asset("ANIM", "anim/hat_house.zip"),

Asset("ANIM", "anim/lightning_blue.zip"),
Asset("ANIM", "anim/forcefieldx.zip"),
Asset("ANIM", "anim/glowdust.zip"),
Asset("ANIM", "anim/portion_e.zip"),
Asset("ANIM", "anim/cristal.zip"),
Asset("ANIM", "anim/musha_exp.zip"),
Asset("ANIM", "anim/musha_flute.zip"),
Asset("ANIM", "anim/mushasword_base.zip"),
Asset("ANIM", "anim/mushasword_frost.zip"),
Asset("ANIM", "anim/mushasword.zip"),
Asset("ANIM", "anim/mushasword2.zip"),
Asset("ANIM", "anim/mushasword3.zip"),
Asset("ANIM", "anim/mushasword4.zip"),
Asset("ANIM", "anim/swap_mushasword_base.zip"),
Asset("ANIM", "anim/swap_mushasword_frost1.zip"),
Asset("ANIM", "anim/swap_mushasword_frost2.zip"),
Asset("ANIM", "anim/swap_mushasword_frost3.zip"),
Asset("ANIM", "anim/swap_mushasword.zip"),
Asset("ANIM", "anim/swap_mushasword2.zip"),
Asset("ANIM", "anim/swap_mushasword3.zip"),
Asset("ANIM", "anim/swap_phoenixaxe.zip"),
Asset("ANIM", "anim/swap_phoenixaxe2.zip"),
Asset("ANIM", "anim/swap_phoenixaxe_broken.zip"),
	Asset("ANIM", "anim/phoenixspear.zip"),
	Asset("ANIM", "anim/swap_phoenixspear.zip"),
	Asset("ANIM", "anim/swap_phoenixspear2.zip"),
	Asset("ANIM", "anim/swap_phoenixspear_2r.zip"),
	Asset("ANIM", "anim/swap_phoenixspear_broken.zip"),
Asset("ANIM", "anim/tentacle_frost.zip"),

Asset("ANIM", "anim/swap_mushasword_frost1_boost.zip"),
Asset("ANIM", "anim/swap_mushasword_frost2_boost.zip"),
Asset("ANIM", "anim/swap_mushasword_frost3_boost.zip"),
Asset("ANIM", "anim/swap_phoenixspear3rd.zip"),
Asset("ANIM", "anim/swap_mushasword_boost.zip"),
Asset("ANIM", "anim/swap_mushasword2_boost.zip"),
Asset("ANIM", "anim/swap_mushasword3_boost.zip"),


Asset("ANIM", "anim/arong_build.zip"),
Asset("ANIM", "anim/arom_build.zip"),
Asset("ANIM", "anim/musha_egg_arong.zip"),

 	Asset("ANIM", "anim/arong_baby_build.zip"),
	Asset("ANIM", "anim/arong_mini1_build.zip"),
	Asset("ANIM", "anim/arong_mini2_build.zip"),
	Asset("ANIM", "anim/arong_mini3_build.zip"),
	Asset("ANIM", "anim/arong_mini4_build.zip"),
	Asset("ANIM", "anim/arong_mini4_v_build.zip"),
	Asset("ANIM", "anim/arong_grow1_v_build.zip"),
	Asset("ANIM", "anim/arong_grow1_build.zip"),

Asset("ANIM", "anim/arom_personality_pudgy.zip"),
Asset("ANIM", "anim/arom_personality_ornery.zip"),
Asset("ANIM", "anim/arom_personality_docile.zip"),

Asset("ANIM", "anim/arong_personality_pudgy.zip"),
Asset("ANIM", "anim/arong_personality_ornery.zip"),
Asset("ANIM", "anim/arong_personality_docile.zip"),

Asset("ANIM", "anim/leif_moon_spring_build.zip"),
Asset("ANIM", "anim/leif_moon_build.zip"),
Asset("ANIM", "anim/leif_moon_fall_build.zip"),
Asset("ANIM", "anim/leif_moon_winter_build.zip"),

Asset("ANIM", "anim/apple_glowberry.zip"),
Asset("ANIM", "anim/green_ferns.zip"),
Asset("ANIM", "anim/light_ferns.zip"),
Asset("ANIM", "anim/moonbush.zip"),
Asset("ANIM", "anim/moondrake_build.zip"),
Asset("ANIM", "anim/moondrake2_build.zip"),

Asset("ANIM", "anim/swap_pirate_booty_bag.zip"),
Asset("ANIM", "anim/swap_pirate_musha_bag.zip"),

	
Asset("ANIM", "anim/musha_oven.zip"),
Asset("ANIM", "anim/musha_oven_open.zip"),
Asset("ANIM", "anim/musha_oven_fire.zip"),
Asset("ANIM", "anim/musha_oven_fire_cold.zip"),
Asset("ATLAS", "images/inventoryimages/musha_oven.xml"),

Asset("ATLAS", "images/inventoryimages/hat_mwildcat.xml"),
Asset("IMAGE", "images/inventoryimages/hat_mwildcat.tex"),
	Asset("ANIM", "anim/x_marks_spot.zip"),
	Asset("IMAGE", "images/inventoryimages/x_mark.tex"),
	Asset("ATLAS", "images/inventoryimages/x_mark.xml"),
	Asset("IMAGE", "images/inventoryimages/musha_treasure2.tex"),
	Asset("ATLAS", "images/inventoryimages/musha_treasure2.xml"),
	Asset("ANIM", "anim/green_apple.zip"),
	Asset("ANIM", "anim/green_fruit.zip"),	
	Asset("ANIM", "anim/green_fruit_cooked.zip"),	
	Asset("IMAGE", "images/inventoryimages/green_fruit.tex"),
	Asset("ATLAS", "images/inventoryimages/green_fruit.xml"),
	Asset("IMAGE", "images/inventoryimages/lesserf.tex"),
	Asset("ATLAS", "images/inventoryimages/lesserf.xml"),
	Asset("ATLAS", "images/inventoryimages/green_fruit_cooked.xml"),
	Asset("IMAGE", "images/inventoryimages/green_fruit_cooked.tex"),
	Asset("ANIM", "anim/swap_tunacan.zip"),
	Asset("ANIM", "anim/tuna.zip"),	
	Asset("IMAGE", "images/inventoryimages/tunacan.tex"),
	Asset("ATLAS", "images/inventoryimages/tunacan.xml"),	
	Asset("IMAGE", "images/inventoryimages/tunacan_musha.tex"),
	Asset("ATLAS", "images/inventoryimages/tunacan_musha.xml"),	
	Asset("IMAGE", "images/inventoryimages/tunacan_open.tex"),
	Asset("ATLAS", "images/inventoryimages/tunacan_open.xml"),	
--宝石
	Asset("IMAGE", "images/inventoryimages/bluegem.tex"),
	Asset("ATLAS", "images/inventoryimages/bluegem.xml"),	
	Asset("IMAGE", "images/inventoryimages/redgem.tex"),
	Asset("ATLAS", "images/inventoryimages/redgem.xml"),
	Asset("IMAGE", "images/inventoryimages/yellowgem.tex"),
	Asset("ATLAS", "images/inventoryimages/yellowgem.xml"),
	Asset("IMAGE", "images/inventoryimages/orangegem.tex"),
	Asset("ATLAS", "images/inventoryimages/orangegem.xml"),
	Asset("IMAGE", "images/inventoryimages/greengem.tex"),
	Asset("ATLAS", "images/inventoryimages/greengem.xml"),
--yamche
Asset("ANIM", "anim/splash_water_drop.zip"),
Asset("IMAGE", "images/inventoryimages/musha_small.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teen.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_teenice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrr6.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tall5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrr6.tex"),
Asset("IMAGE", "images/inventoryimages/musha_tallrrrrrice.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp4.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp5.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp6.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rp7.tex"),
Asset("IMAGE", "images/inventoryimages/musha_rpice.tex"),

Asset("ATLAS", "images/inventoryimages/musha_small.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teen.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_teenice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrr6.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tall5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrr6.xml"),
Asset("ATLAS", "images/inventoryimages/musha_tallrrrrrice.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp5.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp6.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rp7.xml"),
Asset("ATLAS", "images/inventoryimages/musha_rpice.xml"),
	
-------------------------------musha_egg_random
Asset("IMAGE", "images/inventoryimages/musha_egg_random.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_eggs1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_eggs2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_eggs3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_random_cracked.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_cracked.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_cracked1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_cracked2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_cracked3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_crackeds1.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_crackeds2.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_crackeds3.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_cooked.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg8.tex"),
Asset("IMAGE", "images/inventoryimages/musha_egg_cracked8.tex"),

Asset("IMAGE", "images/inventoryimages/frosthammer.tex"),
Asset("IMAGE", "images/inventoryimages/frostback.tex"),
Asset("IMAGE", "images/inventoryimages/hat_mbunny.tex"),
Asset("IMAGE", "images/inventoryimages/hat_mbunnya.tex"),
Asset("IMAGE", "images/inventoryimages/hat_mphoenix.tex"),
Asset("IMAGE", "images/inventoryimages/hat_mcrown.tex"),
Asset("IMAGE", "images/inventoryimages/hat_mprincess.tex"),

Asset("IMAGE", "images/inventoryimages/musha_flute.tex"),
Asset("IMAGE", "images/inventoryimages/mushasword_base.tex"),
Asset("IMAGE", "images/inventoryimages/mushasword_frost.tex"),
Asset("IMAGE", "images/inventoryimages/mushasword.tex"),
Asset("IMAGE", "images/inventoryimages/mushasword2.tex"),
Asset("IMAGE", "images/inventoryimages/mushasword3.tex"),
Asset("IMAGE", "images/inventoryimages/mushasword4.tex"),
Asset("IMAGE", "images/inventoryimages/phoenixspear.tex"),
Asset("ATLAS", "images/inventoryimages/phoenixspear.xml"),
Asset("IMAGE", "images/inventoryimages/blade_b.tex"),
Asset("IMAGE", "images/inventoryimages/blade_1.tex"),
Asset("IMAGE", "images/inventoryimages/blade_2.tex"),
Asset("IMAGE", "images/inventoryimages/blade_3.tex"),
Asset("IMAGE", "images/inventoryimages/blade_f.tex"),
Asset("IMAGE", "images/inventoryimages/glowdust.tex"),
Asset("IMAGE", "images/inventoryimages/portion_e.tex"),
Asset("ATLAS", "images/inventoryimages/portion_e.xml"),
Asset("IMAGE", "images/inventoryimages/cristal.tex"),
Asset("IMAGE", "images/inventoryimages/musha_exp.tex"),
Asset("IMAGE", "images/mushatab.tex"),
Asset("ATLAS", "images/mushatab.xml"),
Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mbunny.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mcrown.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mprincess.xml"),


Asset("ATLAS", "images/inventoryimages/musha_flute.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword_base.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword2.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword3.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword4.xml"),
Asset("ATLAS", "images/inventoryimages/blade_f.xml"),
Asset("ATLAS", "images/inventoryimages/blade_b.xml"),
Asset("ATLAS", "images/inventoryimages/blade_1.xml"),
Asset("ATLAS", "images/inventoryimages/blade_2.xml"),
Asset("ATLAS", "images/inventoryimages/blade_3.xml"),

Asset("ATLAS", "images/mushas.xml"),

Asset("ATLAS", "images/inventoryimages/frosthammer.xml"),
Asset("ATLAS", "images/inventoryimages/frostback.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mbunny.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mphoenix.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mcrown.xml"),
Asset("ATLAS", "images/inventoryimages/hat_mprincess.xml"),
Asset("ATLAS", "images/inventoryimages/musha_armor_prototype.xml"),
Asset("ATLAS", "images/inventoryimages/musha_armor_princess.xml"),
Asset("ATLAS", "images/inventoryimages/musha_flute.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword_base.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword_frost.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword2.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword3.xml"),
Asset("ATLAS", "images/inventoryimages/mushasword4.xml"),
Asset("ATLAS", "images/inventoryimages/blade_b.xml"),
Asset("ATLAS", "images/inventoryimages/blade_1.xml"),
Asset("ATLAS", "images/inventoryimages/blade_2.xml"),
Asset("ATLAS", "images/inventoryimages/blade_3.xml"),
--Asset("ATLAS", "images/inventoryimages/blade_4.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg8.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cracked8.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_random.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_random_cracked.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cracked.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cracked1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cracked2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cracked3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_eggs1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_eggs2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_eggs3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cracked.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_crackeds1.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_crackeds2.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_crackeds3.xml"),
Asset("ATLAS", "images/inventoryimages/musha_egg_cooked.xml"),

Asset("ATLAS", "images/inventoryimages/glowdust.xml"),
Asset("ATLAS", "images/inventoryimages/cristal.xml"),
Asset("ATLAS", "images/inventoryimages/musha_exp.xml"),
Asset("ATLAS", "images/inventoryimages/tent_musha.xml"),
Asset("ATLAS", "images/inventoryimages/forge_musha.xml"),

Asset( "IMAGE", "images/inventoryimages/musha_egg_arong.tex" ),
Asset( "ATLAS", "images/inventoryimages/musha_egg_arong.xml" ),
Asset( "IMAGE", "images/inventoryimages/musha_egg_cracked_arong.tex" ),
Asset( "ATLAS", "images/inventoryimages/musha_egg_cracked_arong.xml" ),
Asset( "IMAGE", "images/inventoryimages/musha_egg_arong_cooked.tex" ),
Asset( "ATLAS", "images/inventoryimages/musha_egg_arong_cooked.xml" ),
Asset( "IMAGE", "images/inventoryimages/arong.tex" ),
Asset( "ATLAS", "images/inventoryimages/arong.xml" ),
Asset( "IMAGE", "images/inventoryimages/arom.tex" ),
Asset( "ATLAS", "images/inventoryimages/arom.xml" ),
Asset( "IMAGE", "images/inventoryimages/arongbaby.tex" ),
Asset( "ATLAS", "images/inventoryimages/arongbaby.xml" ),
Asset( "IMAGE", "images/inventoryimages/musha_moon_tree.tex" ),
Asset( "ATLAS", "images/inventoryimages/musha_moon_tree.xml" ),
	
}

local Loading = {}

local RegisterPrefabs = GLOBAL.RegisterPrefabs
GLOBAL.RegisterPrefabs = function( prefab, ...)
    for i,asset in ipairs(prefab.assets) do
        if Loading[ asset.file ] then
            asset.file = Loading[asset.file]
        end
    end
    RegisterPrefabs( prefab, ...)
end

AddMinimapAtlas("images/musha.xml")
AddMinimapAtlas("images/musha_mapicon.xml")

-- local minimaps = {
	-- "hat_mwildcat","hat_mphoenix","hat_mbunny","hat_mprincess","musha_armor_prototype","musha_armor_princess","musha_egg_random","musha_egg_random_cracked","musha_egg8","musha_egg_cracked8","musha_egg","musha_egg_cracked","musha_egg1","musha_egg_cracked1","musha_egg2","musha_egg_cracked2","musha_egg3","musha_egg_cracked3","musha_eggs1","musha_egg_crackeds1","musha_eggs2","musha_egg_crackeds2","musha_eggs3","musha_egg_crackeds3","frosthammer","broken_frosthammer","mushasword_base","mushasword","mushasword4","blade_f","blade_b","blade_1","cristal","tent_musha","forge_musha","arong","arom","arongbaby","musha_egg_arong","musha_moon_tree","pirateback","musha_oven","x_mark","musha_treasure2","bowm","mushasword_frost","musha_small","musha_teen","musha_teenr1","musha_teenr2","musha_teenr3","musha_teenr4","musha_teenice","musha_tall","musha_tallr1","musha_tallr2","musha_tallr3","musha_tallr4","musha_tallrice","musha_tall2","musha_tallrr1","musha_tallrr2","musha_tallrr3","musha_tallrr4","musha_tallrr5","musha_tallrrice","musha_tall3","musha_tallrrr1","musha_tallrrr2","musha_tallrrr3","musha_tallrrr4","musha_tallrrr5","musha_tallrrrice","musha_tall4","musha_tallrrrr1","musha_tallrrrr2","musha_tallrrrr3","musha_tallrrrr4","musha_tallrrrr5","musha_tallrrrr6","musha_tallrrrrice","musha_tall5","musha_tallrrrrr1","musha_tallrrrrr2","musha_tallrrrrr3","musha_tallrrrrr4","musha_tallrrrrr5","musha_tallrrrrr6","musha_tallrrrrrice","musha_rp1","musha_rp2","musha_rp3","musha_rp4","musha_rp5","musha_rp6","musha_rp7","musha_rpice"
-- }

-- for i,v in ipairs(minimaps) do 
	-- AddMinimapAtlas("images/inventoryimages/"..v..".xml")
-- end