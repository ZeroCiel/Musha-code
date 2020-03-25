--The file need fix,But I can't write this,Can you tell me how to do?
--when the yamche follow for the the musha,Then will be lost the image on the maprevealer
--And I think we need the Shared vision,That will help players find lost birds.
--i do this,fix finish.but something time be happen the problem，maybe need to check yamache's code.

--funciton
function follower(inst)
    inst.components.locomotor:SetAllowPlatformHopping(true)
    inst:AddComponent("embarker")
end 

function yamche_blue(inst)
if IsServer then
inst:AddTag("icecream")
end 
end
AddPrefabPostInit("icecream", yamche_blue)

function musha_wildness(inst)
if inst:HasTag("musha") then
if not inst.ghostenabled then
	inst.yamche_egg_hunted = true
end 
end
end
AddPrefabPostInit("musha",musha_wildness)

local function init(inst)
    if inst.icon == nil and not inst:HasTag("burnt") then
        inst.icon = SpawnPrefab("globalmapicon")
        inst.icon.MiniMapEntity:SetIsFogRevealer(true)
        inst.icon:TrackEntity(inst)
    end
end

local function aaa(inst)
    if inst.prefab ~= nil then 
    end 
    inst:AddTag("compassbearer")
	inst:AddTag("maprevealer")
    inst:AddComponent("maprevealer")	 
	if inst.components.maprevealable ~= nil then
       inst.components.maprevealable:AddRevealSource(inst, "compassbearer")
    end
	    if not TheWorld.ismastersim then
        return inst
    end
	inst:DoTaskInTime(0, init)
end

function yamche_update(inst)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 25, {"yamcheb"})
for k,v in pairs(ents) do
if not v.house and not v.hat then
if inst.follow and v.components.follower and not v.components.follower.leader and not inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("yamcheb") == 0 then
inst.components.leader:AddFollower(v)
--on_yamche(inst)
v.yamche = true
v.sleepn = false 
v.fightn = false
v.slave = true
 inst:DoTaskInTime(0, init)
 inst.MiniMapEntity:SetDrawOverFogOfWar(true)
elseif not inst.follow and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and inst.components.leader:CountFollowers("yamcheb") == 1 then
v.sleepn = true
v.yamche = true 
v.fightn = true
v.slave = false
v.active_hunt = false
inst.components.leader:RemoveFollowersByTag("yamcheb")
 inst:DoTaskInTime(0, init)
 inst.MiniMapEntity:SetDrawOverFogOfWar(true)
if v.pick1 then
v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER_STOP)
v.pick1 = false
v.working_food = false
end
end 
end 
end
end
 
function order_yamche(inst)
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing and not inst.hat and not inst.house then
if inst.yamche_follow and not inst.follow and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_FOLLOW)
inst.follow = true
--master_yamche(inst)
yamche_update(inst)
elseif inst.yamche_follow and inst.follow and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_STAY)
inst.follow = false
inst.yamche_follow = false
--master_yamche(inst)
yamche_update(inst)
elseif not inst.yamche_follow and not inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LOST)

elseif inst.yamche_follow and not inst.follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_FOLLOW)
inst.follow = true
yamche_update(inst)
elseif inst.yamche_follow and inst.follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STAY)
inst.follow = false
inst.yamche_follow = false
yamche_update(inst)
elseif not inst.yamche_follow and inst:HasTag("playerghost") then
inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
end
end
end 

AddModRPCHandler("musha","yamche", order_yamche)

AddPrefabPostInit( "musha_small", aaa)
AddPrefabPostInit( "musha_teen", aaa)
AddPrefabPostInit( "musha_teenr1", aaa)
AddPrefabPostInit( "musha_teenr2", aaa)
AddPrefabPostInit( "musha_teenr3", aaa)
AddPrefabPostInit( "musha_teenr4", aaa)
AddPrefabPostInit( "musha_teenice", aaa)
AddPrefabPostInit( "musha_tall", aaa)
AddPrefabPostInit( "musha_tallr1", aaa)
AddPrefabPostInit( "musha_tallr2", aaa)
AddPrefabPostInit( "musha_tallr3", aaa)
AddPrefabPostInit( "musha_tallr4", aaa)
AddPrefabPostInit( "musha_tallrice", aaa)
AddPrefabPostInit( "musha_tall2", aaa)
AddPrefabPostInit( "musha_tallrr1", aaa)
AddPrefabPostInit( "musha_tallrr2", aaa)
AddPrefabPostInit( "musha_tallrr3", aaa)
AddPrefabPostInit( "musha_tallrr4", aaa)
AddPrefabPostInit( "musha_tallrr5", aaa)
AddPrefabPostInit( "musha_tallrrice", aaa)
AddPrefabPostInit( "musha_tall3", aaa)
AddPrefabPostInit( "musha_tallrrr1", aaa)
AddPrefabPostInit( "musha_tallrrr2", aaa)
AddPrefabPostInit( "musha_tallrrr3", aaa)
AddPrefabPostInit( "musha_tallrrr4", aaa)
AddPrefabPostInit( "musha_tallrrr5", aaa)
AddPrefabPostInit( "musha_tallrrrice", aaa)
AddPrefabPostInit( "musha_tall4", aaa)
AddPrefabPostInit( "musha_tallrrrr1", aaa)
AddPrefabPostInit( "musha_tallrrrr2", aaa)
AddPrefabPostInit( "musha_tallrrrr3", aaa)
AddPrefabPostInit( "musha_tallrrrr4", aaa)
AddPrefabPostInit( "musha_tallrrrr5", aaa)
AddPrefabPostInit( "musha_tallrrrr6", aaa)
AddPrefabPostInit( "musha_tallrrrrice", aaa)
AddPrefabPostInit( "musha_tall5", aaa)
AddPrefabPostInit( "musha_tallrrrrr1", aaa)
AddPrefabPostInit( "musha_tallrrrrr2", aaa)
AddPrefabPostInit( "musha_tallrrrrr3", aaa)
AddPrefabPostInit( "musha_tallrrrrr4", aaa)
AddPrefabPostInit( "musha_tallrrrrr5", aaa)
AddPrefabPostInit( "musha_tallrrrrr6", aaa)
AddPrefabPostInit( "musha_tallrrrrrice", aaa)
AddPrefabPostInit( "musha_rp1", aaa)
AddPrefabPostInit( "musha_rp2", aaa)
AddPrefabPostInit( "musha_rp3", aaa)
AddPrefabPostInit( "musha_rp4", aaa)
AddPrefabPostInit( "musha_rp5", aaa)
AddPrefabPostInit( "musha_rp6", aaa)
AddPrefabPostInit( "musha_rp7", aaa)
AddPrefabPostInit( "musha_rpice", aaa)
--AddPrefabPostInit( "arong", aaa)
--AddPrefabPostInit( "arom", aaa)


function electric_weapon(inst)
if IsServer then
        inst:AddTag("electric_weapon")
end end
AddPrefabPostInit("nightstick", electric_weapon)
function no_target(inst)
if IsServer then
        inst:AddTag("no_target")
end end
AddPrefabPostInit("slurtlehole", no_target)

function arms(inst)
if IsServer then
        inst:AddTag("arm")
end end
AddPrefabPostInit("tentacle_pillar_arm", arms)

function green_mush(inst)
if IsServer then
	 inst:AddComponent("follower")
	 inst:AddTag("mushrooms")
end end
function veggie(inst)
if IsServer then
	 inst:AddComponent("follower")
	 inst:AddTag("carrot")
end end
AddPrefabPostInit("carrot_planted", veggie)
AddPrefabPostInit("green_mushroom", green_mush)

