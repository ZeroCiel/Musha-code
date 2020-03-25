--translated From Ciel,Correct those mistakes!
return {

--adds action start
	ACTIONFAIL =
	{
        REPAIR =
        {
            WRONGPIECE = "Musha认为那是不对的.",
        },
        BUILD =
        {
            MOUNTED = "Musha不能把它放在这么高的地方.",
            HASPET = "我已经有一只宠物了.",
        },
		SHAVE =
		{
			AWAKEBEEFALO = "Musha觉得在它醒着的时候不能那么做.",
			GENERIC = "我不能那么做！",
			NOBITS = "已经没有毛毛了~~~",
		},
		STORE =
		{
			GENERIC = "它已经满了，装不下啦！",
			NOTALLOWED = "我去不到那里.",
			INUSE = "应该等一会，还没有轮到Musha呢.",
		},
		RUMMAGE =
		{	
			GENERIC = "Musha做不到.",
			INUSE = "他们还在寻找东西！",
		},
		USEKLAUSSACKKEY =
        {
        	WRONGKEY = "哎呀！这样不对！",
        	KLAUS = "Musha做不到那样!!",
			QUAGMIRE_WRONGKEY = "Musha需要找另一把钥匙.",
        },
		ACTIVATE = 
		{
			LOCKED_GATE = "门是锁着的.",
		},
        COOK =
        {
            GENERIC = "Musha不能把它放进去煮.",
            INUSE = "你也和Musha这么认为吗？",
            TOOFAR = "对Musha来说太遥远了.",
        },
		GIVE =
        {
            GENERIC = "我去不到那里.",
            DEAD = "也许Musha只能将它们留下了.",
            SLEEPING = "他正在睡觉，不要打扰他.",
            BUSY = "Musha应该等一会再试一次.",
            ABIGAILHEART = "它值得我试试.",
            GHOSTHEART = "Musha认为这是个坏主意.",
            NOTGEM = "Musha不能把它放进去!",
            WRONGGEM = "Musha认为这块宝石不能放在这里.",
            NOTSTAFF = "Musha认为它的形状不对.",
            MUSHROOMFARM_NEEDSSHROOM = "蘑菇可能会很有用.",
            MUSHROOMFARM_NEEDSLOG = "活木可能会很有用.",
            SLOTFULL = "Musha有东西放在了这里了.",
            FOODFULL = "这里已经有很多食物了.",
            NOTDISH = "它不想吃这个.",
            DUPLICATE = "我们已经知道了那是什么.",
            NOTSCULPTABLE = "没有科学的方式,那就不能把它做成雕塑 .",
            NOTATRIUMKEY = "Musha认为它的形状不对.",
            CANTSHADOWREVIVE = "它不会复活.",
            WRONGSHADOWFORM = "它们没有放在一起.",
        },
        GIVETOPLAYER =
        {
            FULL = "嘿!你的口袋太满了!",
            DEAD = "也许Musha会留着这些.",
            SLEEPING = "没人关心它们。",
            BUSY = "我会再试一次.",
        },
        GIVEALLTOPLAYER =
        {
            FULL = "嘿!你的口袋太满了!",
            DEAD = "也许我还是留着吧.",
            SLEEPING = "他在睡觉.",
            BUSY = "Musha会再试一次.",
        },
        WRITE =
        {
            GENERIC = "Musha认为这很棒.",
            INUSE = "我们需要一个艺术家来写好它！",
        },
        DRAW =
        {
            NOIMAGE = "如果把一些东西放在Musha面前，那么就容易得多了.",
        },
        CHANGEIN =
        {
            GENERIC = "Musha现在不能这样做.",
            BURNING = "现在太危险了！",
            INUSE = "在一个时间段里只能使用一次.",
        },
        ATTUNE =
        {
            NOHEALTH = "Musha感觉不太好.",
        },
        MOUNT =
        {
            TARGETINCOMBAT = "Musha认为不应该去打扰一头生气的牛!",
            INUSE = "需要一些东西来控制!",
        },
        SADDLE =
        {
            TARGETINCOMBAT = "当它很生气的时候，它不会让Musha这么做的.",
        },
        TEACH =
        {
            --Recipes/Teacher
            KNOWN = "Musha已经知道它们了.",
            CANTLEARN = "Musha学不会那些东西.",

            --MapRecorder/MapExplorer
            WRONGWORLD = "这张地图是为了满足某种需要才画的.",
        },
        WRAPBUNDLE =
        {
            EMPTY = "Musha需要打包才能带走它们.",
        },
        PICKUP =
        {
			RESTRICTION = "Musha水平还不够.",
			INUSE = "科学上讲，必须等一会才能轮到Musha.",
        },
        SLAUGHTER =
        {
            TOOFAR = "它逃走了.",
        },
        REPLATE =
        {
            MISMATCH = "It needs another type of dish.", 
            SAMEDISH = "", 
        },
	},
	ACTIONFAIL_GENERIC = "Musha不能那么做.",
	ANNOUNCE_DIG_DISEASE_WARNING = "现在看起来好多了.",
	ANNOUNCE_PICK_DISEASE_WARNING = "呕, Musha不喜欢那种气味.",
	--adds action end	

	ANNOUNCE_HATEFOOD = "我吃不下了！",
	ANNOUNCE_ADVENTUREFAIL = "Musha的手动不了啦...!",
	ANNOUNCE_BOOMERANG = "有东西砸到Musha了！ Musha要扔掉那块坏东西!",
	ANNOUNCE_CHARLIE = "有东西跟着Musha！",
	ANNOUNCE_CHARLIE_ATTACK = "别打Musha的头！Musha会打你的！",
	ANNOUNCE_COLD = "啊！Musha冻僵啦！",
	ANNOUNCE_HOT = "Musha感觉好热！",
	ANNOUNCE_DUSK = "太阳下山啦！\nMusha得准备点个灯!",
	ANNOUNCE_EAT =
      {
                GENERIC = "好吃，这个味道我喜欢！",
                PAINFUL = "呕！我不喜欢吃这个！",
                SPOILED = "这根本不是食物！我不想要吃这个QAQ！",
                STALE = "我真的不想吃这个！！",
		YUCKY = "不行啦！！我真的不想吃这个！呕",
	},
	ANNOUNCE_NOSLEEPONFIRE = "Musha不想在这里睡觉！\n Musha会感冒的！",
	ANNOUNCE_NODANGERSIESTA = "好像有东西在附近，Musha得去看看...",
	ANNOUNCE_NONIGHTSIESTA = "在这睡觉太冷了！Musha要温暖的地方！",
	ANNOUNCE_NONIGHTSIESTA_CAVE = "这里真的太冷了！",
	ANNOUNCE_NOHUNGERSIESTA = "Musha肚子饿啦！Musha要吃东西！",
	ANNOUNCE_SHELTER = "Musha感觉还可以.",
	ANNOUNCE_BURNT = "这好像是燃料...",
	ANNOUNCE_TOOL_SLIP = "哇！？它太滑了！",
	ANNOUNCE_DAMP = "Musha好像湿透了！",
	ANNOUNCE_WET = "现在太难把内衣弄干了.",
	ANNOUNCE_WETTER = "Musha已经湿透了.",
	ANNOUNCE_SOAKED = "Musha想要换一件内衣...",
	ANNOUNCE_HOUNDS = "你听到了吗？是猎犬的声音.",
	--ANNOUNCE_HUNGRY = "Musha要吃肉.有人吗？",
	ANNOUNCE_HUNGRY = "Musha要吃食物..有人有吃的吗？Musha肚子好饿..",
	ANNOUNCE_HUNT_BEAST_NEARBY = "Musha看见它了！Musha可以抓住它吗？",
	ANNOUNCE_HUNT_LOST_TRAIL = "Musha找不到脚印了.\n 它是什么呢？",
	ANNOUNCE_HUNT_LOST_TRAIL_SPRING = "泥巴把足迹抹去了！Musha讨厌泥巴.",
	ANNOUNCE_ACCOMPLISHMENT= "去吧！去吧！飞翔吧，我的箭啊！",
	ANNOUNCE_ACCOMPLISHMENT_DONE = "Musha做到了！",
	ANNOUNCE_LIGHTFIRE =
	{
		[1] = "我想要光!",
		[2] = "这是火焰！!",
		[3] = "火是个好东西!",
		[4] = "闪闪红光！",
		[5] = "它不能用来做饭，但是很温暖!",
		[6] = "耶!",
	},
	ANNOUNCE_PECKED = "坏蛋!",
	ANNOUNCE_TORCH_OUT = "我的另一个火把在哪？",
	ANNOUNCE_WORMHOLE = "Musha不喜欢这样来旅行...",
	ANNOUNCE_TRAP_WENT_OFF = "啊！!",
	ANNOUNCE_CRAFTING_FAIL = "哇？这个不起作用。",
    ANNOUNCE_QUAKE = "听起来像是肚子痛一样！这个世界也会生病吗？",
    ANNOUNCE_NODANGERSLEEP = "Musha听到有声音，Musha觉得得去看看！",
    ANNOUNCE_NOHUNGERSLEEP = "Musha肚子太饿啦！\n Musha睡不着!",
    ANNOUNCE_FREEDOM = "Musha是自由的！没有人能困住Musha!",
    ANNOUNCE_RESEARCH = "Musha认识它!Musha知道怎么使用它!",
    ANNOUNCE_NO_TRAP = "对Musha来说太轻松了!",
    ANNOUNCE_HIGHRESEARCH = "太棒了！Musha做到了！",
    ANNOUNCE_THORNS = "啊！这植物真糟糕！",
    ANNOUNCE_NODAYSLEEP_CAVE = "Musha想去玩！\n Musha还不感到困。",
    ANNOUNCE_BEES = "有只蜜蜂在Musha耳边嗡嗡响！",
    ANNOUNCE_KNOCKEDOUT = "噢..看呐,天上都是星星..",
    ANNOUNCE_LOWRESEARCH = "Musha做得太多了。",
    ANNOUNCE_DEERCLOPS = "只有神话里的奥丁才是最强的! 但你不是！",
    ANNOUNCE_MOSQUITOS = "臭虫子，Musha要咬回去！",
    ANNOUNCE_NODAYSLEEP = "睡觉？Musha想到处去玩！",
    ANNOUNCE_INSUFFICIENTFERTILIZER = "Musha觉得, 这些植物好像生病了...",
    ANNOUNCE_CANFIX = "\nMusha能够修好它！",
    ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Musha能比光更快！",
        BATTLECRY =
        {
                GENERIC = "Musha比你更强！",
                PIG = "那头猪真是坏猪猪！",
                PREY = "你不喜欢Musha吗？\n 别担心，Musha一样也不喜欢你!",
                SPIDER = "这是Musha的经验值！",
                SPIDER_WARRIOR = "来战吧!小蜘蛛！",
        },
        COMBAT_QUIT =
        {
                GENERIC = "Musha也是这么想的！",
                PIG = "真是头强壮的猪.\n 但下一次,它就会成为Musha的晚餐!",
                PREY = "Musha下次再来打败你！",
                SPIDER = "如果Musha能变得更强,\n Musha就可以打败这些怪物！",
                SPIDER_WARRIOR = "跳来跳去的蜘蛛！Musha最讨厌了！",
        },
		
--adds 4 start
	--ANNOUNCE_TOOL_SLIP = "Whoa! It's slippery!",
	--ANNOUNCE_LIGHTNING_DAMAGE_AVOIDED = "Musha is safe from that scary lightning!",
	ANNOUNCE_TOADESCAPING = "它对我失去了兴趣.",
	ANNOUNCE_TOADESCAPED = "癞蛤蟆逃走了.",
	
	ANNOUNCE_BECOMEGHOST = "啊啊啊啊啊啊!!",
	ANNOUNCE_GHOSTDRAIN = "Musha正在失去她的人性...",
	ANNOUNCE_PETRIFED_TREES = "只有Musha才能听到它们尖叫吗？",
	ANNOUNCE_KLAUS_ENRAGE = "现在没有办法打败它!!",
	ANNOUNCE_KLAUS_UNCHAINED = "它的锁链掉下来了!",
	ANNOUNCE_KLAUS_CALLFORHELP = "它在呼救，快想想办法！!",

    --lavaarena event
    ANNOUNCE_REVIVING_CORPSE = "让Musha来帮你!",
    ANNOUNCE_REVIVED_OTHER_CORPSE = "来吧，我的朋友!",
    ANNOUNCE_REVIVED_FROM_CORPSE = "Musha感觉还不错，谢谢你。",
    --quagmire event
    QUAGMIRE_ANNOUNCE_NOTRECIPE = "这些东西什么也不能做。",
    QUAGMIRE_ANNOUNCE_MEALBURNT = "Musha和它分开的太久了.",
    QUAGMIRE_ANNOUNCE_LOSE = "Musha有一些不太好的感觉.",
    QUAGMIRE_ANNOUNCE_WIN = "是时候了!",

    ANNOUNCE_ROYALTY =
    {
        "陛下.",
        "公主殿下.",
        "公主!",
    },
	
--adds 4 end		
		
	DESCRIBE =
	{
	
--adds 5 start (DESCRIBE)
	--MULTIPLAYER_PORTAL = "This ought to be a scientific impossibility.",
		ANTLION = 
		{
			GENERIC = "它想从Musha这里得到些东西.",
			VERYHAPPY = "Musha感觉它是个很棒的朋友.",
			UNHAPPY = "它看起来很可怕!Musha很害怕!",
		},
		ANTLIONTRINKET = "有人可能会对它们有兴趣.",
		SANDSPIKE = "Musha不能拿起它们，Musha做不到!",
        SANDBLOCK = "它太坚固了！",
        GLASSSPIKE = "Memories of the time Musha wasn't skewered.",
        GLASSBLOCK = "这对你来说很科学.",
		ABIGAIL_FLOWER = 
		{ 
			GENERIC ="这真是非常漂亮...",
			LONG = "看那个东西，它会伤害Musha的灵魂.",
			MEDIUM = "这让Musha浑身起鸡皮疙瘩.",
			SOON = "那朵花有点不对劲!",
			HAUNTED_POCKET = "Musha认为Musha不应该抓住这个.",
			HAUNTED_GROUND = "Musha会死的！",
		},

		BALLOONS_EMPTY = "它看起来就像小丑.",
		BALLOON = "它是如何飘起来的？",

		BERNIE_INACTIVE =
		{
			BROKEN = "它已经崩溃了.",
			GENERIC = "它们都已经烧焦了.",
		},

		BERNIE_ACTIVE = "那只泰迪熊在到处跑,真有趣.",

        PLAYER =
        {
            GENERIC = "哦,你在这里, %s!",
            ATTACKER = "%s 很聪明...",
            MURDERER = "凶手!",
            REVIVER = "%s, 我的幽灵朋友.",
            GHOST = "%s 需要一颗心脏来复活.",
            FIRESTARTER = "燃烧？那并不科学, %s.",
        },
		WILSON = 
		{
			GENERIC = "Stars and atoms! Are you Musha's doppelganger, %s?",
			ATTACKER = "Yeesh. Does Musha always look that creepy?",
			MURDERER = "Your existence is an affront to the laws of science, %s!",
			REVIVER = "%s has expertly put our theories into practice.",
			GHOST = "Better concoct a revival device. Can't leave another man of science floating.",
			FIRESTARTER = "Burning that wasn't very scientific, %s.",
		},
		WOLFGANG = 
		{
			GENERIC = "很高兴看见你, %s!",
			ATTACKER = "Musha不应该和他打架...",
			MURDERER = "凶手! Musha会打败你!",
			REVIVER = "%s 像是一只笨熊.",
			GHOST = "Musha听说你搬不动它们, %s. 看来他们是错的.",
			FIRESTARTER = "你真的不能 \"fight\" fire, %s!",
		},
		WAXWELL = 
		{
			GENERIC = "Decent day to you, %s!",
			ATTACKER = "Seems you've gone from \"dapper\" to \"slapper\".",
			MURDERER = "Musha will show you Logic and Reason... those're Musha's fists!",
			REVIVER = "%s is using his powers for good.",
			GHOST = "Don't look at Musha like that, %s! Musha is working on it!",
			FIRESTARTER = "%s's just asking to get roasted.",
		},
		WX78 = 
		{
			GENERIC = "早上好！ %s!",
			ATTACKER = "Musha thinks Musha needs to tweak your primary directive, %s...",
			MURDERER = "%s! You've violated the first law!",
			REVIVER = "Musha guesses %s got that empathy module up and running.",
			GHOST = "Musha always thought %s could use a heart. Now Musha is certain!",
			FIRESTARTER = "You look like you're gonna melt, %s. What happened?",
		},
		WILLOW = 
		{
			GENERIC = "早上好！ %s!",
			ATTACKER = "%s is holding that lighter pretty tightly...",
			MURDERER = "Murderer! Arsonist!",
			REVIVER = "%s, friend of ghosts.",
			GHOST = "Musha bets you're just burning for a heart, %s.",
			FIRESTARTER = "再来一次?",
		},
		WENDY = 
		{
			GENERIC = "Greetings, %s!",
			ATTACKER = "%s doesn't have any sharp objects, does she?",
			MURDERER = "Murderer!",
			REVIVER = "%s treats ghosts like family.",
			GHOST = "Musha is seeing double! I'd better concoct a heart for %s.",
			FIRESTARTER = "Musha knows you set those flames, %s.",
		},
		WOODIE = 
		{
			GENERIC = "Greetings, %s!",
			ATTACKER = "%s has been a bit of a sap lately...",
			MURDERER = "Murder! Bring Musha an axe and we'll get in the swing of things!",
			REVIVER = "%s saved everyone's backbacon.",
			GHOST = "Does \"universal\" coverage include the void, %s?",
			BEAVER = "%s's gone on a wood chucking rampage!",
			BEAVERGHOST = "Will you bea-very mad if Musha doesn't revive you, %s?",
			FIRESTARTER = "Don't burn yourself out, %s.",
		},
		WICKERBOTTOM = 
		{
			GENERIC = "早上好, %s!",
			ATTACKER = "Musha thinks %s's planning to throw the book at Musha.",
			MURDERER = "Here comes Musha's peer review!",
			REVIVER = "Musha has deep respect for %s's practical theorems.",
			GHOST = "This doesn't seem very scientific, does it, %s?",
			FIRESTARTER = "Musha is sure you had a very clever reason for that fire.",
		},
		WES = 
		{
			GENERIC = "Greetings, %s!",
			ATTACKER = "%s is silent, but deadly...",
			MURDERER = "Mime this!",
			REVIVER = "%s thinks outside the invisible box.",
			GHOST = "How do you say \"I'll concoct a revival device\" in mime?",
			FIRESTARTER = "Wait, don't tell Musha. You lit a fire.",
		},
		WEBBER = 
		{
			GENERIC = "早上好, %s!",
			ATTACKER = "Musha is gonna roll up a piece of papyrus newspaper, just in case.",
			MURDERER = "Murderer! Musha will squash you, %s!",
			REVIVER = "%s is playing well with others.",
			GHOST = "%s is really buggin' me for a heart.",
			FIRESTARTER = "We need to have a group meeting about fire safety.",
		},
		WATHGRITHR = 
		{
			GENERIC = "早上好, %s!",
			ATTACKER = "Musha doesn't want a punch from %s, if possible.",
			MURDERER = "%s's gone berserk!",
			REVIVER = "%s has full command of spirits.",
			GHOST = "Nice try. You're not escaping to Valhalla yet, %s.",
			FIRESTARTER = "%s is really heating things up today.",
		},
        WINONA =
        {
            GENERIC = "祝你有个不错的一天, %s!",
            ATTACKER = "%s is a safety hazard.",
            MURDERER = "It ends here, %s!",
            REVIVER = "You're pretty handy to have around, %s.",
            GHOST = "Looks like someone threw a wrench into your plans.",
            FIRESTARTER = "Things are burning up at the factory.",
        },
        MIGRATION_PORTAL = 
        {
            GENERIC = "If Musha had any friends, this could take me to them.",
            OPEN = "If Musha would step through, will Musha still be Musha?",
            FULL = "It seems to be popular over there.",
        },
	
	
--adds 5 end (DESCRIBE)	
	
	    MUSHA_EGG ="像是一只非常小的花芽.",
        MUSHA_EGGS1 ="Yamche已经准备好和我一起冒险了.",
        MUSHA_EGGS2 ="Yamache，我的伙伴.",
        MUSHA_EGGS3 ="现在它正在成长.",
        MUSHA_EGG1 ="现在它很强壮！",
        MUSHA_EGG2 ="它现在已经长大了.",
        MUSHA_EGG3 ="哦，但愿它能睡个好觉.",
        MUSHA_EGG8 ="没有人可以阻拦我们!",
        MUSHA_EGG_CRACKED = "像是一只非常小的花芽.",
		MUSHA_EGG_CRACKEDS1 = "Musha正在等你,Yamche!",
		MUSHA_EGG_CRACKEDS2 = "它正在成长，不是吗?",
		MUSHA_EGG_CRACKEDS3 = "它是Musha最好的伙伴.",
		MUSHA_EGG_CRACKED1 = "快点!",
		MUSHA_EGG_CRACKED2 = "非常强壮.",
		MUSHA_EGG_CRACKED3 = "它正在醒来!",
		MUSHA_EGG_CRACKED8 = "Musha正在等你!",

       	MUSHA_SMALL = "哇，太可爱了!\n 命令(Z,V,B)",

		MUSHA_TEEN = "Yamache虽然还很年轻，但是它是一只勇敢的鸟！\n命令：(Z,V,B)",
		MUSHA_TEENR1 = "Yamache虽然还很年轻，但是它是一只勇敢的鸟！\n命令：(Z,V,B)",
		MUSHA_TEENR2 = "Yamache虽然还很年轻，但是它是一只勇敢的鸟！\n命令：(Z,V,B)",
		MUSHA_TEENR3 = "Yamache虽然还很年轻，但是它是一只勇敢的鸟！\n命令：(Z,V,B)",
		MUSHA_TEENR4 = "Yamache虽然还很年轻，但是它是一只勇敢的鸟！\n命令：(Z,V,B)",
		MUSHA_TEENICE = "Yamache虽然还很年轻，但是它是一只勇敢的鸟！\n命令：(Z,V,B)",

		MUSHA_TALL = "Yamche正在成长，它会拥有自己的力量。\n命令：(Z,V,B)",
		MUSHA_TALLR1 = "Yamche正在成长，它会拥有自己的力量。\n命令：(Z,V,B)",
		MUSHA_TALLR2 = "Yamche正在成长，它会拥有自己的力量。\n命令：(Z,V,B)",
		MUSHA_TALLR3 = "Yamche正在成长，它会拥有自己的力量。\n命令：(Z,V,B)",
		MUSHA_TALLR4 = "Yamche正在成长，它会拥有自己的力量。\n命令：(Z,V,B)",
		MUSHA_TALLRICE = "Yamche正在成长，它会拥有自己的力量。\n命令：(Z,V,B)",

		MUSHA_TALL2 = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		MUSHA_TALLRR1 = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		MUSHA_TALLRR2 = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		MUSHA_TALLRR3 = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		MUSHA_TALLRR4 = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		MUSHA_TALLRR5 = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		MUSHA_TALLRRICE = "谁更强？Yamche还是牛牛？\n命令：(Z,V,B)",
		
		MUSHA_TALL3 = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",
		MUSHA_TALLRRR1 = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",
		MUSHA_TALLRRR2 = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",
		MUSHA_TALLRRR3 = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",
		MUSHA_TALLRRR4 = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",
		MUSHA_TALLRRR5 = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",
		MUSHA_TALLRRRICE = "Yamche是Musha最好的伙伴！\n命令：(Z,V,B)",

		MUSHA_TALL4 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRR1 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRR2 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRR3 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRR4 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRR5 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRR6 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRICE = "Yamche有最强的力量！\n命令：(Z,V,B)",

		MUSHA_TALL5 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRR1 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRR2 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRR3 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRR4 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRR5 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRR6 = "Yamche有最强的力量！\n命令：(Z,V,B)",
		MUSHA_TALLRRRRRICE = "Yamche有最强的力量！\n命令：(Z,V,B)",

		MUSHA_RP1 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RP2 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RP3 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RP4 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RP5 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RP6 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RP7 = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",
		MUSHA_RPICE = "没有任何人能够阻挡我们！\n命令：(Z,V,B)",

        GHOSTHOUND = "一起行动吧，伙计！",
        GHOSTHOUND2 = "喔，Musha不是故意的。",
        SHADOWMUSHA = "喔，Musha的影子要觉醒了！",
        --item
        MUSHA_FLUTE = "Yamche喜欢Musha的歌.",
		MUSHASWORD_BASE = "这是Musha的剑!",
		MUSHASWORD = "火焰！听从Musha指挥!", -- War3 Pandaren Brewmaster
		MUSHASWORD_FROST = "冰霜！听从Musha指挥!", -- War3 Pandaren Brewmaster
		FROSTHAMMER = "大地！听从Musha指挥!", -- War3 Pandaren Brewmaster
		BROKEN_FROSTHAMMER =  "Musha喜欢这冰冷的装备.",  -- this is frost armor, grow up : frost armor II
		HAT_MPHOENIX = "暴君的头盔！Musha很想要!",
		HAT_MPRINCESS = "Musha的皇冠！",   --grow up : Queen crown
		HAT_MBUNNY = "开始行动。", -- Lol Caitlyn
		ARMOR_MUSHAA = "看见它了吗？\n这是Musha的基础装备。",
		ARMOR_MUSHAB = "这是Musha最喜欢的装备。",
		--WIP
		GLOWDUST ="尝起来甜甜的。",
		CRISTAL = "发光的糖果！",
		EXP = "这就是本质！",

		--EXP1000CHEAT = "Show me the money!", -- Starcraft

        BOOK_BIRDS = "这是用鸟语写的吗？",
        BOOK_TENTACLES = "这让Musha知道怎样养一条大蚯蚓。",
        BOOK_GARDENING = "植物们都喜欢这本书。",
        BOOK_SLEEP = "一本糟糕的书，弄得Musha犯困",
        BOOK_BRIMSTONE = "这书不好..",

		GLOMMER = "那小可爱有双翅膀！它会飞！",
        GLOMMERFLOWER =
        {
        	GENERIC = "巨型花朵！它是怎么盛开的？",
        	DEAD = "这花怎么是灰色的？但它之前为什么是红色的。",
        },
        GLOMMERWINGS = "他们真小！",
        GLOMMERFUEL = "Musha可以吃这个吗？不行？为什么？",
        BELL = "这是晚饭的钟声吗？谁要给Musha食物？",
        STATUEGLOMMER =
        {
        	GENERIC = "Musha认识那个！唔...那是什么？",
        	EMPTY = "Musha几星期前见过花朵。",
    	},
		WEBBERSKULL = "This skull seems to have a story.",
		MOLE =
		{
			HELD = "看！它有个有趣的鼻子！",
			UNDERGROUND = "有东西藏着这里下面。\n Musha会找出来的。",
			ABOVEGROUND = "它拿了Musha的东西！",
		},
		MOLEHILL = "那儿有东西。Musha知道。",
		MOLEHAT = "闻起来...",
		NIGHTSTICK = "这个有用吗？",
		
		--adds 6 start
	    MUSHROOMHAT = "穿起来看上去会很有趣.",
        MUSHROOM_LIGHT2 =
        {
            ON = "蓝色是科学的颜色！",
            OFF = "We could make a prime light source with some primary colors.",
            BURNT = "穆沙发誓，它没有发霉.",
        },
        MUSHROOM_LIGHT =
        {
            ON = "科学可以制造光!",
            OFF = "它很大, 是一个科学的房间.",
            BURNT = "o!它被烧毁了！",
        },
        SLEEPBOMB = "当Musha把它扔出去的时候，它们会打起瞌睡来.",
        MUSHROOMBOMB = "一个蘑菇云正在形成!",
        SHROOM_SKIN = "毫无保留!",
        TOADSTOOL_CAP =
        {
            EMPTY = "这只是一个普通的洞.",
            INGROUND = "有东西要出来了.",
            GENERIC = "那个霉菌必须被砍掉.",
        },
        TOADSTOOL =
        {
            GENERIC = "耶!! Musha并没有亲吻它!",
            RAGE = "它现在发疯了!",
        },
        MUSHROOMSPROUT =
        {
            GENERIC = "How scientific!",
            BURNT = "How im-morel!",
        },
        MUSHTREE_TALL =
        {
            GENERIC = "那个蘑菇长得太大了，对它自己没有好处.",
            BLOOM = "你从远处看它的时候还没什么感觉，但实际上接近后就会觉得味道很难闻.",
        },
        MUSHTREE_MEDIUM =
        {
            GENERIC = "它们都曾经生长在Musha的浴室里.",
            BLOOM = "Musha对此并不高兴.",
        },
        MUSHTREE_SMALL =
        {
            GENERIC = "一个魔法房间?",
            BLOOM = "它在试图繁殖.",
        },
        MUSHTREE_TALL_WEBBED = "蜘蛛们认为它很重要.",
        SPORE_TALL =
        {
            GENERIC = "它在到处漂流.",
            HELD = "它会在Musha的口袋里发光的！",
        },
        SPORE_MEDIUM =
        {
            GENERIC = "Hasn't a care in the world.",
            HELD = "它会在Musha的口袋里发光的.",
        },
        SPORE_SMALL =
        {
            GENERIC = "这是孢子的眼睛.",
            HELD = "它会在Musha的口袋里发光的.",
        },
		
		BEEQUEEN = "别让那它们靠近穆萨!",
		BEEQUEENHIVE = 
		{
			GENERIC = "太黏了，走不动.",
			GROWING = "以前有这些东西吗？",
		},
        BEEQUEENHIVEGROWN = "从科学上讲，它是如何变得如此庞大的?!",
        BEEGUARD = "它们在守卫女王.",
        HIVEHAT = "当穆萨戴着它的时候，世界似乎变得那么疯狂.",
        MINISIGN =
        {
            GENERIC = "Musha可以画得更好!",
            UNDRAWN = "我们应该在上面画点东西.",
        },
        MINISIGN_ITEM = "It's not much use like this. We should place it.",
		
		BERRYBUSH_JUICY =
		{
			BARREN = "在这个状态下，它不会生成任何浆果.",
			WITHERED = "高温使得它们脱水了!",
			GENERIC = "Musha应该把它们留在那里，值到它们可以吃为止.",
			PICKED = "它们正在努力生长.",
			DISEASED = "看起来很恶心.",
			DISEASING = "呃，有点不对劲.",
			BURNING = "它非常火.",
		},
		
		CANARY =
		{
			GENERIC = "某种由科学制成的黄色生物.",
			HELD = "Musha并不是要压榨你……对吧?",
		},
        CANARY_POISONED = "它看起来还不错.",

		CRITTERLAB = "里面有什么东西吗?",
        CRITTER_GLOMLING = "What an aerodynamical creature!",
        CRITTER_DRAGONLING = "It's wyrmed its way into Musha's heart.",
		CRITTER_LAMB = "Much less mucusy than its momma.",
        CRITTER_PUPPY = "小怪物是很可爱的!",
        CRITTER_KITTEN = "You'd make a good lab assistant for Musha.",
        CRITTER_PERDLING = "My feathered friend.",
		
		LAVA_POND = "Magmificent!",
		LAVAE = "太热了，没办法接触.",
		LAVAE_COCOON = "冷却下来吧！",
		LAVAE_PET = 
		{
			STARVING = "可怜的家伙，一定饿坏了.",
			HUNGRY = "Musha听到它的肚子在咕咕叫.",
			CONTENT = "它似乎很快乐.",
			GENERIC = "哇啊啊，它是个快乐的小怪物。",
		},
		LAVAE_EGG = 
		{
			GENERIC = "有一股微弱的暖意从里面散发出来.",
		},
		LAVAE_EGG_CRACKED =
		{
			COLD = "Musha认为那个蛋还不够热.",
			COMFY = "这是一个快乐的蛋.",
		},
		LAVAE_TOOTH = "它是蛋的牙齿!",
		
		ENDTABLE = 
		{
			BURNT = "烧焦的桌子上的一只烧焦的花瓶.",
			GENERIC = "桌上花瓶里的一朵花.",
			EMPTY = "Musha应该放点东西进去.",
			WILTED = "看起来不太新鲜.",
			FRESHLIGHT = "有亮光真好.",
			OLDLIGHT = "我们忘记买新灯泡了吗?", -- will be wilted soon, light radius will be very small at this point
		},
		
		TWIGGYTREE = 
		{
			BURNING = "What a waste of wood.",
			BURNT = "Musha觉得Musha本可以阻止这一切.",
			CHOPPED = "大自然!",
			GENERIC = "It's all stick-y.",			
			DISEASED = "它看起来生病了.",
		},
		TWIGGY_NUT_SAPLING = "它不需要任何帮助就能成长.",
        TWIGGY_OLD = "那棵树看起来很弱小.",
		TWIGGY_NUT = "里面有一棵粘糊糊的树想要出去。",
		
		FLOWER_WITHERED = "Musha认为这还不够.",
		
		FOSSIL_PIECE = "奇怪的骨头!我们应该把它们重新组装起来.",
        FOSSIL_STALKER =
        {
			GENERIC = "还缺一些东西.",
			FUNNY = "我的直觉告诉我这并不完全正确。",
			COMPLETE = "它还活着!等等，它已经死了.",
        },
        STALKER = "骨架与阴影融为一体!",
        STALKER_ATRIUM = "为什么它如此庞大?",
        STALKER_MINION = "Anklebiters!",
        THURIBLE = "闻起来像化学品.",
        ATRIUM_OVERGROWTH = "Musha不认识这些符号.",
		
		LUCY = "这把斧头比Musha用过的还要漂亮.",
		
		MINIFAN = "不知为什么，这里的风比之前的更猛烈了.",
		
		OASISLAKE = "这是海市蜃楼吗?",
		
		PINECONE_SAPLING = "很快就会成长成树木了!",
        LUMPY_SAPLING = "这棵树是怎么繁殖的?",
		
--adds 6 end
		
		RABBITHOUSE=
		{
			GENERIC = "兔子在里面。",
			BURNT = "没东西在里面。\n但是Musha可以找人进去。",
		},
		TURF_DECIDUOUS = "许多腐烂的叶子。",
		TURF_SANDY = "沙子很适合躲藏！",
		TURF_BADLANDS = "太硬了！",
		BEARGER = "Musha要怎样才能长得跟你一样大？",
		BEARGERVEST = "毛茸茸的衣服！",
		ICEPACK = "毛茸茸的背包！",
		BEARGER_FUR = "是毛皮，不过Musha有个主意。",
		FURTUFT = "*咳咳* Musha吃掉了毛皮！",
		BIGFOOT = "一个大脚印！",
		BONESHARD = "一块骨头。",
		BUZZARD = "从天上来的。",
		CACTUS =
		{
			GENERIC = "为什么这些植物有刺？\n 没人会吃这个的。",
			PICKED = "哦，我不喜欢这个。",
		},
		CACTUS_MEAT_COOKED = "Musha可以吃掉它...也许。",
		CACTUS_MEAT = "很讨厌！",
		CACTUS_FLOWER = "仙人掌顶上的花。不过Musha不吃那个。",
		COLDFIRE =
		{
			EMBERS = "啊哈。燃料吗？",
			GENERIC = "蓝色的火焰，但是不能用来烧饭。",
			HIGH = "这火焰为什么能让Musha感到凉快！",
			LOW = "Musha怎样才能把它变大？",
			NORMAL = "yamche说蓝色的火焰非常热，但这个不是。",
			OUT = "哇。结束了。",
		},
		CATCOON = "这小可爱吃Musha不吃的东西！",
		CATCOONDEN =
		{
			GENERIC = "猫咪的小屋！有个猫咪的印记。",
			EMPTY = "里面没有猫。\n Musha不再感兴趣了。",
		},
		CATCOONHAT = "有...比没有好。",
		COONTAIL = "Musha不知道为什么Musha从猫咪上砍来的。",
		COOKPOT =
		{
			COOKING_LONG = "这要煮好久，我们可以去玩一会。",
			COOKING_SHORT = "很快就煮好了。",
			DONE = "Musha喜欢那个！你呢？",
			EMPTY = "没有人使用它，现在轮到Musha啦！",
			BURNT = "为什么那石头烧坏了？",
		},
		EYEBRELLAHAT =	"它能阻挡风暴！但它太重了。",
		ARMORDRAGONFLY = "如果有人碰到Musha，他们会烧起来。",
		DRAGON_SCALES = "这很酷！而且还不会冷。",
		DRAGONFLYCHEST = "这箱子可以吸收火焰，它不会烧起来！",
		DECIDUOUSTREE =
		{
			BURNING = "哇啊啊啊！",
			BURNT = "一棵树。",
			CHOPPED = "Musha能在这休息吗？",
			GENERIC = "树。",
			POISON = "哇！哇！哇！",
		},
		ACORN_COOKED = "闻起来不错！",
		BIRCHNUTDRAKE = "不是矛！用斧头砍掉它！",
		FARMPLOT =
		{
			GENERIC = "这是种子们的家园。",
			GROWING = "快点，Musha还要使用呢。",
			NEEDSFERTILIZER = "它需要便便。",
			BURNT = "Musha不吃烧坏的食物。",
		},
		COLDFIREPIT =
		{
			EMBERS = "嗯,任何燃料都可以吗？",
			GENERIC = "蓝色的火焰。但是不能用来烧饭。",
			HIGH = "这火焰为什么会让Musha感到凉快！",
			LOW = "Musha怎样才能把它变大？",
			NORMAL = "花花说蓝色的火焰非常热，但这个不是。",
			OUT = "哇。结束了。",
		},
		FIRESUPPRESSOR =
		{
			ON = "它需要很多燃料。别忘了检查一下。",
			OFF = "夏天的话，\n Musha得放燃料进去。",
			LOWFUEL = "燃料正在减少。Musha检查过了。",
		},
		ICEHAT = "问题是Musha的鞋底还很热。",
		LIGHTNINGGOAT =
		{
			GENERIC = "奇怪的长角山羊。",
			CHARGED = "带电的山羊！不过看上去像会伤害Musha。",
		},
		LIGHTNINGGOATHORN = "无敌大钻头！！！\n 什么？为什么不？超有趣的！",
		GOATMILK = "噢，发光的牛奶！",
		MEATRACK =
		{
			DONE = "你打算什么时候收集？都完成了。",
			DRYING = "Musha不知道它什么时候完成。",
			DRYINGINRAIN = "好像需要一把雨伞。",
			GENERIC = "Musha可以用这个弄肉干。\n 肉干很美味。",
			BURNT = "把烤熟的肉放在晾架上是弄肉干最快的方法。",
		},
		MERMHEAD =
		{
			GENERIC = "噢。Musha不喜欢他，而他也不喜欢Musha。",
			BURNT = "他死了两次，真的太菜了。",
		},
		MERMHOUSE =
		{
			GENERIC = "沼泽怪物在这生活。",
			BURNT = "噢，Musha不知道发生了什么。",
		},
		FLOWERSALAD = "比花的味道感觉更好。",
        ICECREAM = "真是罕见的款待！谢谢！",
        WATERMELONICLE = "这冰冻的水果让Musha很凉快！",
        TRAILMIX = "嚼 嚼 嚼！",
        HOTCHILI = "这东西闻起来很热。",
        GUACAMOLE = "有人会喜欢这个。",
		MOOSE = "让我们采很多肉。这是只鹅。",
		MOOSEEGG = "哇，好大~一只！",
		MOSSLING = "快点！它会召唤雷电和风雨！",
		FEATHERFAN = "Musha不知道为什么它那么大。",
		GOOSE_FEATHER = "这可以做风扇，但不能做毛笔。",
		STAFF_TORNADO = "呼！刮大风！",
		PIGHEAD =
		{
			GENERIC = "它传递着一个黑暗的信息。",
			BURNT = "有人不喜欢猪，后来它就烧着了。",
		},
		PIGHOUSE =
		{
			FULL = "抱歉，你能帮Musha吗？Musha有麻烦。",
			GENERIC = "猪人经常帮Musha...不过有时候它们不会那么做。",
			LIGHTSOUT = "好吧，Musha不介意。",
			BURNT = "怎么了？",
		},
		FERTILIZER = "满满一桶便便。",
		RAINOMETER =
		{
			GENERIC = "这是一个快下雨的信号。",
			BURNT = "Musha不会读这个信号。",
		},
		RAINCOAT = "它太小了。",
		RAINHAT = "Musha喜欢喝水，但是别把Musha头发弄湿啦。",
		RESEARCHLAB =
		{
			GENERIC = "这是生存的开始。",
			BURNT = "啊...Musha的实验室消失了。",
		},
		RESEARCHLAB2 =
		{
			GENERIC = "Musha可以创造所有东西！或者不可以...",
			BURNT = "Musha还要那个！",
		},
		RESEARCHLAB3 =
		{
			GENERIC = "噢噢噢噢！这东西会创造魔法！",
			BURNT = "没有人能抵挡火焰的破坏力...",
		},
		RESEARCHLAB4 =
		{
			GENERIC = "为什么弄个高帽在这？为了科学？",
			BURNT = "就算魔法也受火焰影响。",
		},
		RESURRECTIONSTATUE =
		{
			GENERIC = "看着像...威尔逊？",
			BURNT = "Musha觉得她听到了惊呼。",
		},
	--adds 1 start
		CAVEIN_BOULDER =
        {
            GENERIC = "Musha认为，musha能举起这个.",
            RAISED = "Musha够不着它!",
        },
        ROCK = "Musha的口袋装不下它.",
        PETRIFIED_TREE = "它看起来吓坏了.",
        ROCK_PETRIFIED_TREE = "它看起来吓坏了.",
        ROCK_PETRIFIED_TREE_OLD = "它看起来吓坏了.",
	--adds 1 end
		ROCK_ICE =
		{
			GENERIC = "如果你想等它结冰，只需要呆在这。",
			MELTED = "解冻需要一点时间。",
		},
		ROCK_ICE_MELTED = "解冻需要好长时间。",
		ICE = "冰冰的。",
        REFLECTIVEVEST = "Musha不能在地上游泳啦。",
		HAWAIIANSHIRT = "衬衫在呼唤夏日！",
		TENT =
		{
			GENERIC = "Musha能在那里睡个好觉！",
			BURNT = "Musha的基地被烧成灰啦。",
		},
		-- SIESTAHUT =
		-- {
			-- GENERIC = "At least this can keep me dry without an umbrella.",
			-- BURNT = "Musha's dry place has been burned to the ground.",
		-- },
		TRANSISTOR = "Musha不知道它怎么运作。",
		TREASURECHEST =
		{
			GENERIC = "Musha需要很多东西，所以Musha会造很多箱子。",
			BURNT = "完蛋了！全部都！Musha的东西没了！",
		},
		TUMBLEWEED = "停！Musha说停！",
		GRASS_UMBRELLA = "看起来漂亮而且也挺放水。",
		UNIMPLEMENTED = "这还没见效。",
		WALL_HAY =
		{
			GENERIC = "这可以隔离东西，但它怕火..",
			BURNT = "Musha跟你说了！这个很容易烧起来的！",
		},
		WALL_WOOD =
		{
			GENERIC = "挺坚硬的，但火还是能毁掉它。",
			BURNT = "*叹气* Musha尽最大努力了。",
		},
		WARG = "看！猎犬的头领。",
		WATERMELON = "它很大，但不够Musha填饱肚子。",
		WATERMELON_COOKED = "Musha现在就想吃那个！",
		WATERMELONHAT = "这很有趣！不过黏糊糊的！",
		WINTEROMETER =
		{
			GENERIC = "越来越热，越来越高。",
			BURNT = "它不能用来测量火。",
		},
		HOMESIGN =
		{
			GENERIC = "Musha现在可以写东西。",
			BURNT = "Musha可以回收它。",
		},
		BEEBOX =
		{
			READY = "你看到了吗？是蜜蜂箱！",
			FULLHONEY = "箱子里全是蜂蜜！",
			GENERIC = "蜜蜂和花朵进去变出蜂蜜来！",
			NOHONEY = "Musha没有看到蜂蜜。",
			SOMEHONEY = "噢，蜜蜂还在工作。",
			BURNT = "Musha不喜欢烤熟的蜂蜜...",
		},
		LIVINGTREE = "这触感让Musha以为它是活的。",
		ICESTAFF = "这让Musha很安全。",
		WORMLIGHT = "Musha可以把它跟其他东西混合，但是Musha喜欢光尘多点。",
		WORM =
		{
		    PLANT = "炫酷的灯。它看起来像植物。",
		    DIRT = "有东西在地下移动！",
		    WORM = "噢！那是什么！？",
		},
		EEL = "长长的，古怪的，绿色的鱼。",
		EEL_COOKED = "它的味道很古怪...",
		UNAGI = "Musha没做什么，但鳗鱼就已经完了！",
		EYETURRET = "高高的眼骨，他能打败任何东西。",
		EYETURRET_ITEM = "就是个小玩具，当把它放地上时就会变大和激活。",
		MINOTAURHORN = "这是在漆黑洞穴里一个征服者的象征。",
		MINOTAURCHEST = "一个大箱子！比Musha还要高！",
		THULECITE_PIECES = "如果Musha有更多的那个，\n Musha能造更多的铥矿物品。",
		POND = "我们去钓鱼！",
		POND_ALGAE = "它在阴暗潮湿的地方生长。",
		GREENSTAFF = "它倒回构造和物品的时间\n 还给Musha建造的材料。",
		POTTEDFERN = "它没什么用，但是很好看。",

		THULECITE = "它太旧了。",
		ARMORRUINS = "它很重，但很安全。",
		RUINS_BAT = "Musha知道的最强的石头蝙蝠。",
		RUINSHAT = "这顶王冠做起来很容易。",
		NIGHTMARE_TIMEPIECE = --Keeps track of the nightmare cycle
		{
		CALM = "没事发生，这里没问题。",	--Calm phase
		WARN = "这对Musha来说是个警告。",	--Before nightmare
		WAXING = "哦噢...有东西告诉Musha这地方不安全。", --Nightmare Phase first 33%
		STEADY = "有些事情对Musha来说变得越来越糟！", --Nightmare 33% - 66%
		WANING = "还要点时间，Musha必须再坚持一会。", --Nightmare 66% +
		DAWN = "Musha觉得快完蛋了。", --After nightmare
		NOMAGIC = "这里没有魔法，这里没有危险。", --Place with no nightmare cycle.
		},
		BISHOP_NIGHTMARE = "你为什么还在这里？",
		ROOK_NIGHTMARE = "烂头，烂脚，烂眼睛。但你还在动。",
		KNIGHT_NIGHTMARE = "废弃的士兵。",
		MINOTAUR = "这很危险，不过Musha知道更好。",	--Monster in labyrinth
		SPIDER_DROPPER = "白蜘蛛。他们的巢穴在洞顶。",	--White spider that comes from the roof
		NIGHTMARELIGHT = "这光让Musha头疼。",	--Lights that activate during nightmare.
		GREENGEM = "对Musha很重要的宝石！",
		RELIC = "有人修好了。",	--Fixed relic
		RUINS_RUBBLE = "还缺些东西。",	--Broken relic
		MULTITOOL_AXE_PICKAXE = "多漂亮！Musha可以破坏石头和木头了！",	--Works as axe and pickaxe
		ORANGESTAFF = "Musha知道这是什么，Musha可以用这个传送",	--Teleports player.
		YELLOWAMULET = "无限力量！",	--Emits light, player walks faster.
		GREENAMULET = "减少50%消耗！",	--Reduce cost of crafting

		SLURPER = "大绒球！",
		SLURPER_PELT = "你看到了吗？好像还活着！",
		ARMORSLURPER = "太紧了！这让Musha不那么饿...",
		ORANGEAMULET = "它会自动捡物品！",
		YELLOWSTAFF = "Musha也知道！", 
		YELLOWGEM = "闪亮的黄石头。",
		ORANGEGEM = "Musha感觉有个奇怪的光晕。",
		TELEBASE =
		{
			VALID = "哇...Musha怎么做？",
			GEMS = "Musha要做什么？",
		},
		GEMSOCKET =
		{
			VALID = "Musha感到这紫色的宝石有一股魔力。",
			GEMS = "Musha需要更多的魔力！",
		},
		STAFFLIGHT = "啊...好棒！",

        LIGHTER = "小型打火机。",


        ANCIENT_ALTAR =
        {
        	WORKING = "它直接在Musha脑袋里说话。",
        	BROKEN = "它能运作，不过需要更多东西来使出全部力量。",
        },
        ANCIENT_ALTAR_BROKEN = "它能运作，不过需要更多东西来使出全部力量。",

        ANCIENT_STATUE = "古怪又古典的样子。",

        LICHEN = "看着像石头。",
		CUTLICHEN = "看着坏掉了。",

        CAVE_BANANA = "Musha在洞里得到的。",
        CAVE_BANANA_COOKED = "香蕉！",
        CAVE_BANANA_TREE = "它在黑暗里怎么生长的？",
        ROCKY = "真大。",

        BLUEAMULET = "这护身符感觉凉凉的！",
		PURPLEAMULET = "Musha能看见死去的人...",
		TELESTAFF = "Pop! Pop! Pop!",
		MINERHAT = "Musha不是矿工，不过它能让Musha在洞穴里看见东西。",
		MONKEY = "抓住他！他偷了Musha的东西！",
		MONKEYBARREL = "猴子做了个房子看着好像他们的脸。",

		HOUNDSTOOTH="这很锋利。能给Musha做出好的武器！",
		ARMORSNURTLESHELL="皇冠会更好，不过这个很可爱！",
		BAT="生气的蝙蝠！",
		BATBAT = "Musha能用它打Musha的敌人。",
		BATWING="Musha要怎么用它？Musha能烤了它吗？",
		BATWING_COOKED="它缩小了。",
		BEDROLL_FURRY="Musha可以在上面睡觉。",
		BUNNYMAN="小心，他们不喜欢肉。",
		FLOWER_CAVE="这是个好光源。",
		FLOWER_CAVE_DOUBLE="这是个好光源。",
		FLOWER_CAVE_TRIPLE="这是个好光源。",
		GUANO="干燥的白便便。",
		LANTERN="灯笼只会发光。Musha不能用它来打架。",
		LIGHTBULB="发光的蔬菜！",
		MANRABBIT_TAIL="小白尾！",
		MUSHTREE_TALL="蓝色的常绿植物。",
		MUSHTREE_MEDIUM="双头蘑菇！",
		MUSHTREE_SMALL="丑陋的，大头，绿蘑菇。",
		SLURTLE="这些能做出适合Musha脑袋的东西。",
		SLURTLE_SHELLPIECES="Musha知道它坏了。",
		SLURTLEHAT="看着Musha！这是坚硬的头盔！",
		SLURTLEHOLE="看着像大仙人掌。",
		SLURTLESLIME="它会爆炸！",
		SNURTLE="它能做出适合Musha身体的东西。",
		SPIDER_HIDER="那蜘蛛有顶奇怪的帽子！",
		SPIDER_SPITTER="那些蜘蛛会喷网！",
		SPIDERHOLE="那是个蜘蛛巢。",
		STALAGMITE="向上长的古老岩石。",
		STALAGMITE_FULL="那块古老岩石真大！\n Musha觉得在那看见了珠宝。",
		STALAGMITE_LOW="这有一块小滑石。",
		STALAGMITE_MED="这有一块大滑石，它好像还在长大",
		STALAGMITE_TALL="长又尖的岩石。",
		STALAGMITE_TALL_FULL="一块巨大锋利的岩石！\n Musha觉得在那看见了珠宝。",
		STALAGMITE_TALL_LOW="这有一块小尖石。",
		STALAGMITE_TALL_MED="这有大尖石，它好像还在长高",

		TURF_CARPETFLOOR = "哈哈！",
		TURF_CHECKERFLOOR = "这块草皮是人造的。",
		TURF_DIRT = "植物在泥土上生长。",
		TURF_FOREST = "这有很多苔藓。",
		TURF_GRASS = "青绿草皮。",
		TURF_MARSH = "成吨的树叶！",
		TURF_ROAD = "Musha在这草皮上能跑得更快！",
		TURF_ROCKY = "岩石是非常重要的资源。",
		TURF_SAVANNA = "兔子和牛牛喜欢在这地皮上生活。",
		TURF_WOODFLOOR = "地板让Musha感到舒适。",

		TURF_CAVE="白色条纹草皮。",
		TURF_FUNGUS="这片区域看着很不同。",
		TURF_SINKHOLE="绿色条纹草皮。",
		TURF_UNDERROCK="岩石都分开了。",
		TURF_MUD="泥泞。",

		TURKEYDINNER = "火鸡，火鸡，火鸡！",
		TWIGS = "不够树枝！",
		POWCAKE = "成吨味精。",
        CAVE_ENTRANCE =
        {
            GENERIC="有人把东西塞住了，\n 下面有什么东西？",
            OPEN = "Musha有绳子，你呢？",
        },
        CAVE_EXIT = "绳子？",

		MAXWELLPHONOGRAPH = "放更多音乐！",
		PIGGUARD = "他是农场主人！",
		BOOMERANG = "弧形的木头击中敌人后又回到Musha这。",
		ADVENTURE_PORTAL = "门？这在哪连接？",
		AMULET = "我是无敌的！好吧，也许不是。\n 但是感觉不错。",
		ANIMAL_TRACK = "好狩猎。",
		ARMORGRASS = "低级装备，不能保护Musha太多。",
		ARMORMARBLE = "好吧，也不坏。就是有点重。",
		ARMORWOOD = "这个世界的标准装备。",
		ARMOR_SANITY = "这个能保护Musha吗？",
		ASH =
		{
			GENERIC = "Musha不知道那是什么，但是现在变成灰了。",
			REMAINS_GLOMMERFLOWER = "天啊。旧铃铛消失了。",
			REMAINS_EYE_BONE = "Musha要怎样才能找到另一个眼骨？",
			REMAINS_THINGIE = "Musha想念它。",
		},
		AXE = "我们开砍吧！",
		BABYBEEFALO =
		{
			GENERIC = "不要伤害它，还不是时候。",
			SLEEPING = "还不行。它只是个宝宝！",
		},
		BACKPACK = "这不能保护Musha,不过Musha能用它装更多东西。",
		BACONEGGS = "Musha喜欢这个，这是培根和蛋！",
		BANDAGE = "坚持下去！",
		BASALT = "哇！真硬，Musha弄不烂它！",
		BEARDHAIR = "用威尔逊的头发，做出威尔逊的雕像。",
		BEDROLL_STRAW = "Musha可以在上面睡觉。",
		BEE =
		{
			GENERIC = "它在工作。",
			HELD = "嗡嗡嗡。",
		},
		BEEFALO =
		{
			FOLLOWER = "它在追Musha！",
			GENERIC = "看着很笨重和迟钝。",
			NAKED = "Musha没有做。Musha不知道发生什么事。",
			SLEEPING = "他们家在哪？",
		},
		BEEFALOHAT = "闻起来有点凶...像牛牛",
		BEEFALOWOOL = "Musha可以把它留到冬天。",
		BEEHIVE = "那是蜂蜜。Musha要怎么拿到？",
		BEEMINE = "现在...蜜蜂在里面",
		BEEMINE_MAXWELL = "这里有蚊子，不是蜜蜂！",
		BEEHAT = "它能让Musha的脸安全而不被蛰！",
		BERRIES = "美味的红浆果！",
		BERRIES_COOKED = "烤熟的浆果更好。",
		BERRYBUSH =
		{
			BARREN = "只是一个灌木丛，里面有红浆果吗？",
			WITHERED = "化肥在哪？",
			GENERIC = "需要时间长出浆果！",
			PICKED = "Musha什么时候才能拿到浆果？",
		},
		BIRDCAGE =
		{
			GENERIC = "小鸟能在这里生活。",
			OCCUPIED = "这里有只小鸟，Musha要喂养它！",
			SLEEPING = "小鸟睡着了。",
		},
		BIRDTRAP = "你想知道Musha是怎么得到小鸟的吗？",
		BIRD_EGG = "会下多少个蛋？",
		BIRD_EGG_COOKED = "适合做早餐。",
		BISHOP = "那个敌人很危险！它会在远处攻击Musha！",
		BLOWDART_FIRE = "这些吹箭加了火元素！",
		BLOWDART_SLEEP = "这吹箭可以轻易干掉Musha的敌人。",
		BLOWDART_PIPE = "这么多的吹箭来自海象。",
		BLUEGEM = "冷冰冰的。",
		BLUEPRINT = "唔...是这样吗？",
		BELL_BLUEPRINT = "它来自天空。",
		BLUE_CAP = "闻起来...什么都不像。",
		BLUE_CAP_COOKED = "Musha用火烤它！",
		BLUE_MUSHROOM =
		{
			GENERIC = "一个蓝色的蘑菇。",
			INGROUND = "一个蓝色的蘑菇。",
			PICKED = "一个蓝色的蘑菇。",
		},
		BOARDS = "木头变成木板。Musha现在可以造东西了。",
		BONESTEW = "这是Musha能做的最好的炖肉。",
		BUGNET = "去抓些虫子吧！",
		BUSHHAT = "如果Musha穿上它就没人能发现Musha了！",
		BUTTER = "蝴蝶有黄油。",
		BUTTERFLY =
		{
			GENERIC = "会飞的黄油，就是蝴蝶！",
			HELD = "Musha怎么做到的？你要黄油吗？", --☺
		},
		BUTTERFLYMUFFIN = "这奶油松饼上面有只蝴蝶装饰。",
		BUTTERFLYWINGS = "薄薄的，漂亮的翅膀。",
		CAMPFIRE =
		{
			EMBERS = "Musha需要放燃料进坑里。",
			GENERIC = "它能提供光和温暖。",
			HIGH = "火焰冲天！",
			LOW = "黑暗要到来。",
			NORMAL = "明亮的火。",
			OUT = "Musha要打开它吗？",
		},
		CANE = "Musha现在可以跑更快！",
		CARROT = "是的，Musha可以吃萝卜。",
		CARROT_COOKED = "你知道烤萝卜是什么味道吗？",
		CARROT_PLANTED = "谁放的萝卜？那儿有兔子吗？",
		CARROT_SEEDS = "难吃的橙色蔬菜种子。",
		CAVE_FERN = "紫色的花只会生长在洞里。",
		CHARCOAL = "树木能烧两次。",
        CHESSJUNK1 = "好多破烂的东西。",
        CHESSJUNK2 = "好多破烂的东西。",
        CHESSJUNK3 = "好多破烂的东西。",
		CHESTER = "他毛茸茸的！",
		CHESTER_EYEBONE =
		{
			GENERIC = "骨头上的眼？它为什么是活的？",
			WAITING = "安息吧。你是个好彻斯特...",
		},
		COOKEDMEAT = "烤熟尝起来比生的时候要好。",
		COOKEDMONSTERMEAT = "Musha依然不想吃它...除非Musha忍不住",
		COOKEDSMALLMEAT = "这肉有点小，不过还是比生的好。",
		CORN = "你要给Musha煮汤吗？",
		CORN_COOKED = "闻起来很棒！",
		CORN_SEEDS = "Musha可以用这些做蛋糕，玉米粉蛋糕！",
		CROW =
		{
			GENERIC = "小鸟给Musha种子和蛋。",
			HELD = "Musha赢了！Musha抓住小鸟了。",
		},
		CUTGRASS = "我们需要更多的草！",
		CUTREEDS = "纸莎草纸！",
		CUTSTONE = "你知道Musha能用石头修理Musha的装备吗？",
		DEADLYFEAST = "不要吃那个！",
		DEERCLOPS = "那巨鹿只有一个眼睛... Musha得小心它！",
		DEERCLOPS_EYEBALL = "眼球伞，盔甲，锤子，剑！\n Musha需要更多！",
		DIRTPILE = "Musha发现脚印！",
		DIVININGROD =
		{
			COLD = "什么声音？蜜蜂？",
			GENERIC = "这东西有什么用？ \n 它能找到出口吗？",
			HOT = "它发现到东西！Musha看见它了！",
			WARM = "它感知到东西了。",
			WARMER = "它开始作用了...Musha不知道有什么用。",
		},
		DIVININGRODBASE =
		{
			GENERIC = "钥匙的持有人！",
			READY = "Musha准备要捡起来！",
			UNLOCKED = "Musha能再用一次杖吗？",
		},
		DIVININGRODSTART = "Musha准备去找东西，\n 也许能帮到Musha。",
		DRAGONFLY = "Musha找到蜻蜓了！超级强大！",
		LAVASPIT =
		{
			HOT = "好热！好热！",
			COOL = "现在凉快了",
		},
		DRAGONFRUIT = "噢，这很美味！",
		DRAGONFRUIT_COOKED = "噢，这很美味！",
		DRAGONFRUIT_SEEDS = "火龙果！Musha喜欢！",
		DRAGONPIE = "它鼓励了Musha！",
		DRUMSTICK = "Musha要杀了所有火鸡！",
		DRUMSTICK_COOKED = "火鸡是坏的，鸡腿是好的！",
		DURIAN = "Musha可以吃里面的肉！",
		DURIAN_COOKED = "唔，Musha不介意它的味道。",
		DURIAN_SEEDS = "种个榴莲！",
		EARMUFFSHAT = "小兔子能做暖耳套！",
		EGGPLANT = "如果煮一下它会变软。",
		EGGPLANT_COOKED = "现在茄子很嫩，但有些人不喜欢吃。",
		EGGPLANT_SEEDS = "谁会只吃一个茄子？",
		STUFFEDEGGPLANT = "我能全部吃掉！",
		DUG_BERRYBUSH = "把它带回家！",
		DUG_GRASS = "把它带回家！",
		DUG_MARSH_BUSH = "把它带回家！",
		DUG_SAPLING = "把它带回家！",
		EARMUFFS = "小耳套。",
		DECIDUOUSTREE =
		{
			BURNING = "啊！好热！好热！火！火！树木要水，快点！",
			BURNT = "一棵烧焦的树。",
			CHOPPED = "Musha能在这里休息吗？",
			GENERIC = "这是树。",
		},
		ACORN =
		{
		    GENERIC = "橡木种子。",
		    PLANTED = "很快就会变成大树。",
		},
		EVERGREEN =
		{
			BURNING = "啊！好热！好热！火！火！树木要水，快点！",
			BURNT = "一棵烧焦的树。",
			CHOPPED = "Musha能在这里休息吗？",
			GENERIC = "这是树。",
		},
		EVERGREEN_SPARSE =
		{
			BURNING = "啊！好热！好热！火！火！树木要水，快点！",
			BURNT = "一棵烧焦的树。",
			CHOPPED = "Musha能在这里休息吗？",
			GENERIC = "这是树。",
		},
		EYEPLANT = "它会收集附近的物品。\n 然后吞噬它们，让它们离Musha远点！",
		FEATHERHAT = "让我们带着羽毛帽子一起跳舞玩耍吧！",
		FEATHER_CROW = "黑羽毛能用来做催眠吹箭！",
		FEATHER_ROBIN = "红羽毛能用来做火焰吹箭！",
		FEATHER_ROBIN_WINTER = "白羽毛能用来做吹箭！",
		FEM_PUPPET = "额...谁要做，有什么用？", --what was that?
		FIREFLIES =
		{
			GENERIC = "Musha喜欢他们的光！",
			HELD = "唔...看着那么...古怪。",
		},
		FIREHOUND = "别让它们靠近Musha的宝物！把它们带出去然后烧掉！",
		FIREPIT =
		{
			EMBERS = "Musha需要放燃料进坑里。",
			GENERIC = "它能提供光和温暖。",
			HIGH = "火焰冲天！",
			LOW = "黑暗就要到来。",
			NORMAL = "现在足够明亮了。",
			OUT = "Musha要打开它吗？",
		},
		FIRESTAFF = "这是危险的魔杖。",
		FISH = "Musha从池塘里得到的...或者是人鱼？",
		FISHINGROD = "钓鱼能让Musha生存。",
		FISHSTICKS = "炸鱼条！很容易做，也很方便吃！",
		FISHTACOS = "你知道玉米卷吗？这些玉米卷里，有‘鱼’！",
		FISH_COOKED = "Musha想吃烟熏三文鱼。",
		FLINT = "这个碎石能让Musha做很多工具。",
		FLOWER = "Musha也许能用它做点什么",
		FLOWERHAT = "一个花环。这让Musha感觉很好。",
		FLOWER_EVIL = "额，这花很糟糕，不像其他的",
		FOLIAGE = "Musha从洞里得到的。",
		FOOTBALLHAT = "让Musha脑袋变得安全！",
		FROG =
		{
			DEAD = "死的掉青蛙就是好青蛙。",
			GENERIC = "Musha不喜欢青蛙...",
			SLEEPING = "睡着的青蛙，Musha要不要偷袭它们？",
		},
		FROGGLEBUNWICH = "三明治里有只青蛙。",
		FROGLEGS = "Musha只吃青蛙腿。",
		FROGLEGS_COOKED = "好吃！",
		FRUITMEDLEY = "好吃，水果！",
		GEARS = "合金装备Musha.",
		GHOST = "用剑打败鬼魂！！",
		GOLDENAXE = "金闪闪的斧头！",
		GOLDENPICKAXE = "金闪闪的锄头！",
		GOLDENPITCHFORK = "金闪闪的叉子！",
		GOLDENSHOVEL = "金闪闪的铲子！",
		GOLDNUGGET = "Musha得收集它们！",
		GRASS =
		{
			BARREN = "它需要便便。",
			WITHERED = "骨子都干了。",
			BURNING = "火！火！Musha需要水！",
			GENERIC = "草是生存之本。",
			PICKED = "草会长出来的。",
		},
		GREEN_CAP = "是的，别生吃。会有幻觉。",
		GREEN_CAP_COOKED = "这能让你精神保持健康。",
		GREEN_MUSHROOM =
		{
			GENERIC = "它能当镇静剂用。",
			INGROUND = "Musha晚上再来。",
			PICKED = "有人捡走了。也许是Musha。",
		},
		GUNPOWDER = "也许Musha要留着这个，万一Musha要跟蜻蜓打架！",
		HAMBAT = "很高兴你变成‘肉’！",
		HAMMER = "锤弟！",
		HEALINGSALVE = "它救了Musha好多次。",
		HEATROCK =
		{
			FROZEN = "好冷！",
			COLD = "这石头好冷。",
			GENERIC = "Musha需要它在夏天凉快，冬天温暖。",
			WARM = "温暖的黄石头。",
			HOT = "炽热的红石头！",
		},
		HONEY = "哈！蜂蜜！",
		HONEYCOMB = "蜜蜂也许不想让Musha拿走。",
		HONEYHAM = "好多肉，好多蜂蜜。",
		HONEYNUGGETS = "Musha喜欢肉。Musha喜欢蜂蜜。两个Musha都有！",
		HORN = "它能发出响而低沉的声音。",
		HOUND = "它们是朋友，但它们让Musha现在更强大。",
		HOUNDMOUND = "猎犬从哪来的？地里？",
		HOUNDBONE = "这曾经是只猎犬，现在变成骨头了",
		ICEBOX = "可以让Musha更长时间的储存食物！",
		ICEHOUND = "它的毛皮很雪白！",
		INSANITYROCK =
		{
			ACTIVE = "在Musha精神太低的时候会出现。",
			INACTIVE = "打开了。",
		},
		JAMMYPRESERVES = "慢慢吃！",
		KABOBS = "串着的一大块肉！",
		KILLERBEE =
		{
			GENERIC = "这不是蜜蜂！\n 为什么杀人蜂和蜜蜂住一起？",
			HELD = "红魔鬼！",
		},
		KNIGHT = "不是Musha的小马！",
		KOALEFANT_SUMMER = "象...那是什么？",
		KOALEFANT_WINTER = "象...那是什么？",
		KRAMPUS = "魔鬼！",
		KRAMPUS_SACK = "它比Musha还大！",
		LAVAE = "它喜欢到处放火... Musha讨厌它们...",
		LEIF = "会动的树！",
		LEIF_SPARSE = "会动的树！",
		LIGHTNING_ROD =
		{
			CHARGED = "噢，充电的铁！别碰它！",
			GENERIC = "它能让附近不被雷劈。",
		},
		LITTLE_WALRUS = "没武器的宝宝跟着爸爸！",
		LIVINGLOG = "从老树上来的",
		LOCKEDWES = "他被困住了！",
		LOG =
		{
			BURNING = "火！它烧起来了！",
			GENERIC = "木头很有用！Musha要用它来做什么？",
		},
		LUREPLANT = "这植物有个很大的胃。",
		LUREPLANTBULB = "它是我的了。",
		MALE_PUPPET = "看着像...威尔逊？",
		MANDRAKE =
		{
			DEAD = "它有一张人脸和茂密的头发。",
			GENERIC = "这不太是萝卜。",
			PICKED = "它有一张人脸和茂密的头发。",
		},
		COOKEDMANDRAKE = "这次Musha烤曼德拉草，\n 不过Musha更喜欢曼德拉汤。",
		MANDRAKESOUP = "曼德拉汤！无敌棒！",
		MARBLE = "噢...好重！",
		MARBLEPILLAR = "看着不错。",
		MARBLETREE = "谁做的，用来做什么？",
		MARSH_BUSH =
		{
			BURNING = "火！火！喂，Musha需要水！",
			GENERIC = "太多刺了！",
			PICKED = "Musha没兴趣。",
		},
		MARSH_PLANT = "这地方的植物尖尖的。",
		MARSH_TREE =
		{
			BURNING = "噢，这不是Musha的错。",
			BURNT = "被烧焦的树木全都变成煤炭了。",
			CHOPPED = "剩下一个树桩。",
			GENERIC = "那棵树好像生病了。",
		},
		MAXWELL = "他好高。",
		MAXWELLHEAD = "叽里咕噜。",
		MAXWELLLIGHT = "它自己能发光！",
		MAXWELLLOCK = "唔，Musha需要一条钥匙。",
		MAXWELLTHRONE = "看着很危险...",
		MEAT = "Musha现在可以吃了,肉干可能会好点，不过烤熟最好。",
		MEATBALLS = "肉丸！",
		MEAT_DRIED = "Musha喜欢那个！",
		MERM = "噢，他们好像不喜欢Musha。",
		MONSTERLASAGNA = "这是食物，但对Musha不健康。 \n 也许有人会吃它",
		MONSTERMEAT = "谁会吃这个。额",
		MONSTERMEAT_DRIED = "难闻的味道没了。\n 不过还是... ‘不好’。",
		MOSQUITO =
		{
			GENERIC = "Musha的血味道不好！",
			HELD = "现在，是我的了，没有痒痒的蚊子了！",
		},
		MOSQUITOSACK = "软软的！",
		MOUND =
		{
			DUG = "没有人能安稳。\n 如果有人死了我们得再来...",
			GENERIC = "谁的猎犬？",
		},
		MULTIPLAYER_PORTAL = "这是全部\n 开始和终结。",
		NIGHTLIGHT = "它的燃料是人们的噩梦。",
		NIGHTMAREFUEL = "小可怕还活着！",
		NIGHTSWORD = "Musha的梦魇之刃能消灭实体梦魇！",
		NITRE = "其他人用这个做火药，\n Musha能用这个修装备。",
		ONEMANBAND = "一起来玩耍跳舞吧！",
		PANDORASCHEST = "一个古老的箱子？怎么会在这里？",
		PANFLUTE = "催眠野兽。",
		PAPYRUS = "有用的植物！Musha可以做纸莎草纸！",
		PENGUIN = "它们在地上滑行！你敢相信？",
		PERD = "有人有浆果和蘑菇吗？ \n Musha可以用它们来吸引小鸟。",
		PEROGIES = "幸运甜饼！噢，等下，里面有肉？",
		PETALS = "气味不错。但不够Musha填饱肚子。",
		PETALS_EVIL = "额，这些花闻起来很糟，不像附近的另一种。",
		PHLEGM = "有什么...Musha能做的？",
		PICKAXE = "采石头，建个家！",
		PIGGYBACK = "大的，耐水火的背包。",
		PIGKING = "他有好多金币，Musha要和他交易！",
		PIGMAN =
		{
			DEAD = "死掉的猪人和猪没区别。",
			FOLLOWER = "走吧！我们去砍树杀蜘蛛！",
			GENERIC = "它们对Musha很友好。",
			GUARD = "噢，来吧！",
			WEREPIG = "你不是猪人了！你是怪物！",
		},
		PIGSKIN = "一块猪皮！",
		PIGTORCH = "它们好像在装饰自己的火把。",
		PINECONE =
		{
		    GENERIC = "常绿的种子。",
		    PLANTED = "很快会变成大树。",
		},
		PITCHFORK = "Musha能拉起草皮。",
		PLANTMEAT = "额，它要融化了。",
		PLANTMEAT_COOKED = "噢，闻起来像肉块！",
		PLANT_NORMAL =
		{
			GENERIC = "蔬菜...蔬菜。",
			GROWING = "快长大~快长大~",
			READY = "完成！Musha要拿起来！",
			WITHERED = "它完全干了... Musha得把它弄出来。",
		},
		POMEGRANATE = "那不是苹果！是石榴！",
		POMEGRANATE_COOKED = "这让Musha感觉好多了。\n 所以，Musha可以吃了吗？",
		POMEGRANATE_SEEDS = "一个红色的小种子",
		POOP = "呕...非常难用而且难闻...不过很有用。",
		PUMPKIN = "南瓜！Musha喜欢南瓜灯！",
		PUMPKINCOOKIE = "南瓜饼！",
		PUMPKIN_COOKED = "它有煮过。",
		PUMPKIN_LANTERN = "看着像猎犬的脸，不是吗？",
		PUMPKIN_SEEDS = "你还要南瓜吗？",
		PURPLEGEM = "紫色的宝石让世界疯狂。",
		RABBIT =
		{
			GENERIC = "它好快！不过Musha有个主意！",
			HELD = "Musha要怎么做？杀掉？还是养着？",
		},
		RABBITHOLE =
		{
			GENERIC = "你听到了吗？那儿还有兔子。",
			SPRING = "洞里全是雪。不过兔子还在里面。",
		},
		RATATOUILLE = "肉在哪？没有？噢...",
		RAZOR = "Musha会剃掉你的头发！",
		REDGEM = "红宝石是生命和火的象征。",
		RED_CAP = "通常颜色鲜艳的蘑菇都是有毒的。",
		RED_CAP_COOKED = "没用，不是吗？",
		RED_MUSHROOM =
		{
			GENERIC = "通常颜色鲜艳的蘑菇都是有毒的。",
			INGROUND = "它只在白天冒头。",
			PICKED = "有人捡走了蘑菇。",
		},
		REEDS =
		{
			BURNING = "火！来人帮帮Musha！",
			GENERIC = "大多情况下，芦苇是用来做吹箭和绷带的。",
			PICKED = "Musha希望能得到更多这个。",
		},
        RELIC =
        {
            GENERIC = "唔。Musha可以拿这个吗？",
            BROKEN = "需要修理。",
        },
        RUBBLE = "时光飞逝。",
		RESURRECTIONSTONE = "这不是复活。\n 这让Musha又要死一次。",
		ROBIN =
		{
			GENERIC = "红色的鸟。火的颜色，跟Yamche一样。",
			HELD = "Musha要做什么？笼子在哪？Musha要放它进去。",
		},
		ROBIN_WINTER =
		{
			GENERIC = "蓝色的鸟好温暖。Yamche却不是。奇怪。",
			HELD = "Musha要做什么？笼子在哪？Musha要放它进去。",
		},
		ROBOT_PUPPET = "没有人能逃脱死亡。",
		ROCK_LIGHT =-- what the flame blast?
		{
			GENERIC = "Musha不知道为什么会发生。",
			OUT = "不亮了。",
			LOW = "岩浆在冷却。",
			NORMAL = "是的，它非常非常的热。",
		},
		ROCKS = "Musha能用这些做很多东西。",
        ROOK = "钢铁犀牛！",
        ROPE = "Musha可以用这个绑东西！",
		ROTTENEGG = "烂掉的蛋味道难闻，不过还是很有用的。\n 特别是做火药。",
		SANITYROCK =
		{
			ACTIVE = "在Musha的精神很好的时候它会出现.",
			INACTIVE = "它打开了。",
		},
	--adds 2 start
		SCARECROW = 
   		{
			GENERIC = "把它打扮得漂漂亮亮的.",
			BURNING = "有些人用它来吓跑乌鸦.",
			BURNT = "有人谋杀了它!",
   		},
   		SCULPTINGTABLE=
   		{
			EMPTY = "我们可以用这个做雕像.",
			BLOCK = "准备好雕刻它了.",
			SCULPTURE = "一个杰作!",
			BURNT = "烧光了.",
   		},
        SCULPTURE_KNIGHTHEAD = "剩下的在哪儿?",
		SCULPTURE_KNIGHTBODY = 
		{
			COVERED = "这是一座奇怪的大理石雕像.",
			UNCOVERED = "Musha猜他在受到损伤而开裂了.",
			FINISHED = "原来它缺少了一块，现在做好了.",
			READY = "我感觉里面有东西在动.",
		},
        SCULPTURE_BISHOPHEAD = "这是谁的头?",
		SCULPTURE_BISHOPBODY = 
		{
			COVERED = "它看来很老了，但它是崭新的.",
			UNCOVERED = "还少了一些东西.",
			FINISHED = "现在呢?",
			READY = "我感觉里面有东西在动.",
		},
        SCULPTURE_ROOKNOSE = "Where did this come from?",
		SCULPTURE_ROOKBODY = 
		{
			COVERED = "这是某种大理石雕像.",
			UNCOVERED = "这样子不是最完美的.",
			FINISHED = "修补完成了.",
			READY = "我感觉里面有东西在动.",
		},
        GARGOYLE_HOUND = "Musha不喜欢它看着Musha的样子.",
        GARGOYLE_WEREPIG = "它看起来非常逼真.",
	--adds 2 end	
	
		SAPLING =
		{
			BURNING = "薇洛！？她又烧东西了吗！？",
			WITHERED = "它需要水，或者便便。",
			GENERIC = "这是必要的。",
			PICKED = "它会回到Musha这",
		},
		SEEDS = "肉和蔬菜。这是个问题。",
		SEEDS_COOKED = "Musha可以吃这个填肚子。它们很容易找到。",
		SEWING_KIT = "Musha可以缝衣服！",
		SHOVEL = "Musha可以挖东西！",
		SILK = "Musha一直打蜘蛛，\n 所以Musha有很多蛛网。",
		SKELETON = "它的灵魂在另一个世界受苦。",
		--SKELETON_PLAYER = "That gives me the willies.",

		SKELETON_PLAYER =
		{
			MALE = "这是 %s 的尸体，因为 %s。",
			FEMALE = "这是 %s 的骨头，因为 %s。",
			ROBOT = "这是 %s 的残骸，因为 %s。",
			DEFAULT = "这是 %s 的尸体，因为 %s。",
		},

		SKULLCHEST = "有什么用？这设计好像是个坏征兆！", --what was that?
		SMALLBIRD =
		{
			GENERIC = "这好像Yamche，有点儿。",
			HUNGRY = "你饿了吗？",
			STARVING = "等下，等下。Musha知道，你饿了。",
		},
		SMALLMEAT = "看着像腿，身体，头还是翅膀。",
		SMALLMEAT_DRIED = "闻着不错！",
		SPAT = "羊？不...犀牛？不...",
		SPEAR = "Musha会战斗！",
		SPIDER =
		{
			DEAD = "Musha需要更多蜘蛛来变强。",
			GENERIC = "轻易打败，简单的训练！",
			SLEEPING = "蜘蛛在睡觉，Musha要偷袭它还是让它继续睡？",
		},
		SPIDERDEN = "Musha不怕它！",
		SPIDEREGGSACK = "Musha能把它拿去Musha的后院。",
		SPIDERGLAND = "这能治愈Musha！ \n 也能治愈奴隶！",
		SPIDERHAT = "Musha是你的母亲！",
		SPIDERQUEEN = "大母蜘蛛，大蜘蛛可以给Musha涨经验！",
		SPIDER_WARRIOR =
		{
			DEAD = "你尽力了，但是Musha太强大了！",
			GENERIC = "它能跳咬一段距离。Musha得小心。",
			SLEEPING = "战士在睡觉，Musha这次要冲过去吗？",
		},
		SPOILED_FOOD = "Musha说那不好吃。",
		STATUEHARP = "是竖琴吗？Musha从来没见过。",
		STATUEMAXWELL = "他把我困在这...Musha讨厌他。",
		STEELWOOL = "Musha要做套衫吗？什么？开玩笑的！",
		STINGER = "小蜜蜂的刺。",
		STRAWHAT = "用草做的，不过让Musha干爽。",
		SUNKBOAT = "发生什么了？",
		SWEATERVEST = "时尚的背心！",
		TAFFY = "给Musha更多糖果！",
		TALLBIRD = "真是高的黑鸟。有时候很坏！",
		TALLBIRDEGG = "一只很大的蓝色蛋。",
		TALLBIRDEGG_COOKED = "一个人吃的话太大了，不过Musha可以，因为Musha非常饿。",
		TALLBIRDEGG_CRACKED =
		{
			COLD = "这蛋需要更暖一点！",
			GENERIC = "它和Yamche一样！",
			HOT = "太热了无法孵化！",
			LONG = "这需要多久？",
			SHORT = "Musha听到它好像要孵化了！",
		},
		TALLBIRDNEST =
		{
			GENERIC = "你看见了吗？很大的蛋！",
			PICKED = "愤怒的鸟蛋不见了。",
		},
		TEENBIRD =
		{
			GENERIC = "那鸟看着想要什么...",
			HUNGRY = "那鸟一直很饿。",
			STARVING = "不要啄Musha！\n Musha给你食物！",
		},
		TELEPORTATO_BASE =
		{
			ACTIVE = "Musha只想跟你在屏幕里相遇。",
			GENERIC = "这是传送门？",
			LOCKED = "还需要一些东西Musha才能使用它。",
			PARTIAL = "到另一个世界！",
		},
		TELEPORTATO_BOX = "惊喜！",
		TELEPORTATO_CRANK = "要去哪？",
		TELEPORTATO_POTATO = "就一块金属。",
		TELEPORTATO_RING = "一些大圈子。",
		TENTACLE = "看着像乌贼的腿。",
		TENTACLESPOTS = "这里有东西！Musha要拿走吗？",
		TENTACLESPIKE = "噢，上面有刺。真漂亮！",
		TENTACLE_PILLAR = "那还活着！",
		TENTACLE_PILLAR_ARM = "不要碰Musha！",
		TENTACLE_GARDEN = "Musha听到什么声音在挖洞。",
		TOPHAT = "优雅的帽子。",
		TORCH = "没有黑暗，什么都不怕！",
		TRAP = "给兔子，青蛙和蜘蛛用的。",
		TRAP_TEETH = "用来杀猎犬，企鹅和鹅的。",
		TRAP_TEETH_MAXWELL = "那是什么？地雷？\n 那对Musha危险吗？",
		TRINKET_1 = "这不会给怪物造成太多伤害。\n 有人感兴趣吗？",-- Melty Marbles
		TRINKET_10 = "牙齿？不能用来咬。",-- Second-hand Dentures
		TRINKET_11 = "玩具！",-- Lying Robot
		TRINKET_12 = "那个触手太硬了，吃不动。",--Dessicated Tentacle
		TRINKET_13 = "有人喜欢这个，不过Musha不喜欢。",
		TRINKET_2 = "风笛...什么？Musha不会吹",--Fake Kazoo
		TRINKET_3 = "很难解开那个结，剪掉吧。",--Gord's Knot
		TRINKET_4 = "格罗姆 格罗姆 格罗姆~ 小小格罗姆~",--Gnome
		TRINKET_5 = "侦测到核弹发射？什么意思？", --starcraft
		TRINKET_6 = "暗杀？用线？这些线？\n Musha没兴趣。",--Frazzled Wires
		TRINKET_7 = "试试抓一下杯子里的球！",-- Ball and Cup
		TRINKET_8 = "Musha知道这是什么...额，它是小枷锁的部件。",-- Hardened Rubber Bung
		TRINKET_9 = "Musha会用这些纽扣装饰雕像！",--Mismatched Buttons
	--adds 3 start
		TRINKET_10 = "它们很快就成了维斯最喜欢的道具.", --Dentures
		TRINKET_11 = "对Musha来说这是个美丽的谎言.", --Lying Robot
		TRINKET_12 = "这是用来做实验的.", --Dessicated Tentacle
		TRINKET_13 = "它一定是某种宗教神器.", --Gnomette
		TRINKET_14 = "现在Musha只想要喝点茶...", --Leaky Teacup
		TRINKET_15 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_16 = "...Maxwell left his stuff out again.", --Pawn
		TRINKET_17 = "A horrifying utensil fusion. Maybe science *can* go too far.", --Bent Spork
		TRINKET_18 = "Musha wonders what it's hiding?", --Trojan Horse
		TRINKET_19 = "It doesn't spin very well.", --Unbalanced Top
		TRINKET_20 = "Wigfrid keeps jumping out and hitting Musha with it?!", --Backscratcher
		TRINKET_21 = "This egg beater is all bent out of shape.", --Egg Beater
		TRINKET_22 = "Musha has a few theories about this string.", --Frayed Yarn
		TRINKET_23 = "Musha can put Musha's shoes on without help, thanks.", --Shoehorn
		TRINKET_24 = "Musha thinks Wickerbottom had a cat.", --Lucky Cat Jar
		TRINKET_25 = "It smells kind of stale.", --Air Unfreshener
		TRINKET_26 = "Food and a cup! The ultimate survival container.", --Potato Cup
		TRINKET_27 = "If you unwound it you could poke someone from really far away.", --Coat Hanger
		TRINKET_28 = "How Machiavellian.", --Rook
        TRINKET_29 = "How Machiavellian.", --Rook
        TRINKET_30 = "Honestly, he just leaves them out wherever.", --Knight
        TRINKET_31 = "Honestly, he just leaves them out wherever.", --Knight
        TRINKET_32 = "Musha knows someone who'd have a ball with this!", --Cubic Zirconia Ball
        TRINKET_33 = "Musha hopes this doesn't attract spiders.", --Spider Ring
        TRINKET_34 = "Let's make a wish. For science.", --Monkey Paw
        TRINKET_35 = "Hard to find a good flask around here.", --Empty Elixir
        TRINKET_36 = "Musha might need these after all that candy.", --Faux fangs
        TRINKET_37 = "Musha doesn't believe in the supernatural.", --Broken Stake
        TRINKET_38 = "Musha thinks it came from another world. One with grifts.", -- Binoculars Griftlands trinket
        TRINKET_39 = "Musha wonders where the other one is?", -- Lone Glove Griftlands trinket
        TRINKET_40 = "Holding it makes me feel like bartering.", -- Snail Scale Griftlands trinket
        TRINKET_41 = "It's a little warm to the touch.", -- Goop Canister Hot Lava trinket
        TRINKET_42 = "It's full of someone's childhood memories.", -- Toy Cobra Hot Lava trinket
        TRINKET_43= "It's not very good at jumping.", -- Crocodile Toy Hot Lava trinket
        TRINKET_44 = "It's some sort of plant specimen.", -- Broken Terrarium ONI trinket
        TRINKET_45 = "It's picking up frequencies from another world.", -- Odd Radio ONI trinket
        TRINKET_46 = "Maybe a tool for testing aerodynamics?", -- Hairdryer ONI trinket
		
		HALLOWEENCANDY_1 = "The cavities are probably worth it, right?",
        HALLOWEENCANDY_2 = "What corruption of science grew these?",
        HALLOWEENCANDY_3 = "It's... corn.",
        HALLOWEENCANDY_4 = "They wriggle on the way down.",
        HALLOWEENCANDY_5 = "Musha's teeth are going to have something to say about this tomorrow.",
        HALLOWEENCANDY_6 = "Musha... doesn't think Musha will be eating those.",
        HALLOWEENCANDY_7 = "Everyone'll be raisin' a fuss over these.",
        HALLOWEENCANDY_8 = "Only a sucker wouldn't love this.",
        HALLOWEENCANDY_9 = "Sticks to Musha's teeth.",
        HALLOWEENCANDY_10 = "Only a sucker wouldn't love this.",
        HALLOWEENCANDY_11 = "Much better tasting than the real thing.",
        HALLOWEENCANDY_12 = "Did that candy just move?", --ONI meal lice candy
        HALLOWEENCANDY_13 = "Oh, Musha's poor jaw.", --Griftlands themed candy
        HALLOWEENCANDY_14 = "Musha doesn't do well with spice.", --Hot Lava pepper candy
        CANDYBAG = "It's some sort of delicious pocket dimension for sugary treats.",

        DRAGONHEADHAT = "So who gets to be the head?",
        DRAGONBODYHAT = "Musha is middling on this middle piece.",
        DRAGONTAILHAT = "Someone has to bring up the rear.",
        PERDSHRINE =
        {
            GENERIC = "Musha feels like it wants something.",
            EMPTY = "Musha needs to plant something there.",
            BURNT = "That won't do at all.",
        },
        REDLANTERN = "这盏灯笼感觉比其他的更独特.",
        LUCKY_GOLDNUGGET = "多么幸运的发现!",
        FIRECRACKERS = "科学方式来引爆它!",
        PERDFAN = "It's inordinately large.",
        REDPOUCH = "里面有什么东西吗?",
        WARGSHRINE = 
        {
            GENERIC = "Musha应该做点快乐的事情~",
            EMPTY = "Musha需要放一个火把进去.",
            BURNT = "它被烧毁了.",
        },
        CLAYWARG = 
        {
        	GENERIC = "一个恐怖的兵马俑!",
        	STATUE = "它刚才动了吗?",
        },
        CLAYHOUND = 
        {
        	GENERIC = "它会被释放!",
        	STATUE = "它看上去很逼真！",
        },
        HOUNDWHISTLE = "它们能让狗进不来.",
        CHESSPIECE_CLAYHOUND = "那件事是我最担心的.",
        CHESSPIECE_CLAYWARG = "And Musha didn't even get eaten!",

		BISHOP_CHARGE_HIT = "哇!",
	--adds 3 end
		TRUNKVEST_SUMMER = "真是温暖的防水背心！",
		TRUNKVEST_WINTER = "有人说背心的材料很难弄到，\n 但是Musha拿到了。",
		TRUNK_COOKED = "你要吃这个吗？为什么？",
		TRUNK_SUMMER = "一个长鼻子！",
		TRUNK_WINTER = "一个长鼻子！",
		UMBRELLA = "Musha喜欢这颜色！",
		WAFFLES = "嗨，华夫饼！是时候吃你了！",
		WALL_HAY_ITEM = "唔。我在担心它很容易烧起来。",
		WALL_STONE = "这就安全了..",--0
		WALL_STONE_ITEM = "看着很重，不过Musha不在乎。",
		WALL_RUINS = "石墙！",--0
		WALL_RUINS_ITEM = "看着很重，不过Musha不在乎。",
		WALL_WOOD_ITEM = "木墙。比草要好点。",
		WALRUS = "靠近点！它只有吹箭！",
		WALRUSHAT = "完美。",
		WALRUS_CAMP =
		{
			EMPTY = "有人住在这里。",
			GENERIC = "Musha想要住在这样的房子里！",
		},
		WALRUS_TUSK = "又大又时尚。",
		WARG = "带上你的兄弟。",
		WASPHIVE = "看着非常危险。",
		WETGOOP = "Musha没有做错。",
		WINTERHAT = "冬天的基本装备。",
		WORMHOLE =
		{
			GENERIC = "这是尾巴还是头？",
			OPEN = "Musha不确定那个东西是否安全。",
		},
		ACCOMPLISHMENT_SHRINE = "Musha讨厌它！",
	},
	DESCRIBE_TOODARK = "光尘呢？\n Musha现在需要更多的光！",
	DESCRIBE_SMOLDERING = "噢噢噢噢！",
	EAT_FOOD =
	{
		TALLBIRDEGG_CRACKED = "这很好吃，不过肉比这更好吃。",
	},
}