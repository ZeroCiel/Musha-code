modimport("libs/use.lua")
-- Import the mod environment as our environment.
--use "libs/mod_env"(env)There's a BUG I don't know how to fix
-- Imports to keep the keyhandler from working while typing in chat.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"

local MushaCommands = GLOBAL.require("usercommands")

GLOBAL.TUNING.MUSHA = {}
GLOBAL.TUNING.MUSHA.KEY = GetModConfigData("key") or 108  --L
GLOBAL.TUNING.MUSHA.KEY2 = GetModConfigData("key2") or 114  --R
GLOBAL.TUNING.MUSHA.KEY3 = GetModConfigData("key3") or 99  --C
GLOBAL.TUNING.MUSHA.KEY4 = GetModConfigData("key4") or 120  --X  
GLOBAL.TUNING.MUSHA.KEY5 = GetModConfigData("key5") or 107  --K
GLOBAL.TUNING.MUSHA.KEY6 = GetModConfigData("key6") or 122  --Z
GLOBAL.TUNING.MUSHA.KEY7 = GetModConfigData("key7") or 112  --P
GLOBAL.TUNING.MUSHA.KEY15 = GetModConfigData("key15") or 111  --O
GLOBAL.TUNING.MUSHA.KEY8 = GetModConfigData("key8") or 118  --V
GLOBAL.TUNING.MUSHA.KEY9 = GetModConfigData("key9") or 98  --B
GLOBAL.TUNING.MUSHA.KEY10 = GetModConfigData("key10") or 110  --N
GLOBAL.TUNING.MUSHA.KEY11 = GetModConfigData("key11") or 103  --G
GLOBAL.TUNING.MUSHA.KEY12 = GetModConfigData("key12") or 116  --T
GLOBAL.TUNING.MUSHA.KEY13 = GetModConfigData("key13") or 282  --F1
GLOBAL.TUNING.MUSHA.KEY14 = GetModConfigData("key14") or 283  --F2

--Skill
function on_yamcheinfo(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 25, {"yamche"})
	for k, v in pairs(ents) do
		if inst.components.leader:IsFollower(v) and v.components.follower.leader then
			v.yamcheinfo = true
		end
	end
end

function on_critterinfo(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 25, {"critter"})
	for k, v in pairs(ents) do
		if inst.components.leader:IsFollower(v) and v.components.follower.leader then
			v.yamcheinfo = true
		end
	end
end

--告诉玩家每一级升级所需的经验算法
local function CountLevel(value)
if value <= 10 then
local result = math.ceil(value/5)*5
return result
elseif value <= 50 then
local result = math.ceil((value-10)/10)*10+10
return result
elseif value <= 130 then
local result = math.ceil((value-50)/20)*20+50
return result
elseif value <= 380 then
local result = math.ceil((value-130)/50)*50+130
return result
elseif value <= 880 then
local result = math.ceil((value-380)/100)*100+380
return result
elseif value <= 2130 then
local result = math.ceil((value-880)/250)*250+880
return result
elseif value <= 4030 then
local result = math.ceil((value-2130)/475)*475+2130
return result
elseif value <= 5000 then
local result = math.ceil((value-4030)/970)*970+4030
return result
end
end

function INFO(inst) --Key ?/Level Info
inst.writing = false
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
for k,v in pairs(ents) do
inst.writing = true
end 
if not inst.writing then
local TheInput = TheInput
local max_exp = 7000
local level = math.min(inst.level, max_exp)
	local max_stamina = 100
	local min_stamina = 0
	local max_fatigue = 100
	local min_fatigue = 0	
	local max_music = 100
	local min_music = 0	
	local max_treasure = 100
	local min_treasure = 0	
	local stamina_sleep = inst.components.stamina_sleep.current
	local fatigue_sleep = inst.components.fatigue_sleep.current
			local mx=math.floor(max_stamina-min_stamina)
			local cur=math.floor(stamina_sleep-min_stamina)
			local mx2=math.floor(max_fatigue-min_fatigue)
			local cur2=math.floor(fatigue_sleep-min_fatigue)
			local mxx=math.floor(max_music-min_music)
			local curr=math.floor(inst.music-min_music)
			local mxt=math.floor(max_treasure-min_treasure)
			local curt=math.floor(inst.treasure-min_treasure)
			local level_exp = math.floor(CountLevel(inst.level))
		
			sleep = ""..math.floor(cur*100/mx).."%"
			sleepy = ""..math.floor(cur2*100/mx2).."%"
			musics = ""..math.floor(curr*100/mxx).."%"
			treasures = ""..math.floor(curt*100/mxt).."%"
inst.keep_check = false			
if not inst.keep_check then		
inst.keep_check = true	
inst.components.talker:Say("["..STRINGS.MUSHA_LEVEL_NEXT_LEVEL_UP.."] "..STRINGS.MUSHA_LEVEL_EXP..":" .. (inst.level) .."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
on_yamcheinfo(inst)
on_critterinfo(inst)

if inst.level <7000 then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "1 "..STRINGS.MUSHA_LEVEL_EXP..": ".. (inst.level) .."/".. (level_exp) .."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))
elseif inst.level >=7000  then
inst.components.talker:Say(STRINGS.MUSHA_LEVEL_LEVEL.. "30 \n[MAX]\n Extra EXP ".. (inst.level -7000).."\n["..STRINGS.MUSHA_LEVEL_SLEEP.."]: "..(sleep).."   ["..STRINGS.MUSHA_LEVEL_TIRED.."]: "..(sleepy).."\n["..STRINGS.MUSHA_LEVEL_MUSIC.."]: "..(musics).."   ["..STRINGS.MUSHA_LEVEL_SNIFF.."]: "..(treasures))	
end
elseif inst.keep_check then		
inst.keep_check = false	
end
inst:DoTaskInTime( 0.5, function()
if inst.keep_check then
inst.keep_check = false
end end)
end 
end
AddModRPCHandler("musha", "INFO", INFO)

function INFO2(inst) --KEY K/Skill INFO
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		local TheInput = TheInput
		local max_exp = 999997000
		local level = math.min(inst.level, max_exp)
		inst.keep_check = false
		if not inst.keep_check then
			inst.keep_check = true
			--inst.sg:AddStateTag("notalking")
			if inst.level >= 0 and inst.level <= 4 then --level[1]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[0/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[0/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[0/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[0/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[0/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[0/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level > 4 and inst.level < 10 then --level[2]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[0/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[0/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[0/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[0/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[1/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[0/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level > 10 and inst.level < 30 then --level[3]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[0/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[1/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[0/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[1/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[0/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 30 and inst.level < 50 then --level[4]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[0/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[1/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[0/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[1/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 50 and inst.level < 80 then --level[5]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[1/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[2/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[0/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[1/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 80 and inst.level < 124 then --level[6]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[1/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[2/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[0/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[2/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 125 and inst.level < 200 then --level[7]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[1/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[2/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[2/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 200 and inst.level < 340 then --level[8]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[1/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[3/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[2/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 340 and inst.level < 430 then --level[9]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[1/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[1/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[1/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[4/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[2/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 430 and inst.level < 530 then --level[10]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[2/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[4/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[3/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[1/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 530 and inst.level < 640 then --level[11]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[2/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[4/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[3/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[2/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 640 and inst.level < 760 then --level[12]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[2/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[4/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[3/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[3/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 760 and inst.level < 890 then --level[13]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[2/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[5/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[3/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[3/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 890 and inst.level < 1030 then --level[14]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[2/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[6/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[3/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[3/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 1030 and inst.level < 1180 then --level[15]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[3/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[6/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[4/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[3/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 1180 and inst.level < 1340 then --level[16]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[3/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[6/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[4/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[4/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 1340 and inst.level < 1510 then --level[17]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[3/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[7/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[4/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[4/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 1510 and inst.level < 1690 then --level[18]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[3/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[8/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[1/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[4/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[4/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 1690 and inst.level < 1880 then --level[19]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[2/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[2/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[3/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[8/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[2/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[4/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[4/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 1880 and inst.level < 2080 then --level[20]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[4/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[8/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[2/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[4/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[5/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 2080 and inst.level < 2290 then --level[21]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[4/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[8/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[2/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[5/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 2290 and inst.level < 2500 then --level[22]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[4/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[9/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[2/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[5/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 2500 and inst.level < 2850 then --level[23]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[4/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[10/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[2/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[5/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 2850 and inst.level < 3200 then --level[24]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[4/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[10/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[5/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 3200 and inst.level < 3700 then --level[25]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[5/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[10/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[6/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 3700 and inst.level < 4200 then --level[26]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[5/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[11/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[6/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 4200 and inst.level < 4700 then --level[27]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[5/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[11/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[7/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 4700 and inst.level < 5500 then --level[28]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[5/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[12/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[7/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 5500 and inst.level < 7000 then --level[29]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[3/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[3/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[5/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[13/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[7/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[0/1]"
				)
			elseif inst.level >= 7000 then --level[30]
				inst.components.talker:Say(
					STRINGS.MUSHA_SKILL_ACTIVE ..
						"\n[*]" ..
							STRINGS.MUSHA_SKILL_SLEEP ..
								"[1/1]-(T)\n[*]" ..
									STRINGS.MUSHA_SKILL_POWER ..
										"[4/4]-(R)\n[*]" ..
											STRINGS.MUSHA_SKILL_SHIELD ..
												"[4/4]-(C)\n[*]" ..
													STRINGS.MUSHA_SKILL_MUSIC ..
														"[1/1]-(X)\n[*]" ..
															STRINGS.MUSHA_SKILL_SHADOW ..
																"[6/6]-(G)\n" ..
																	STRINGS.MUSHA_SKILL_PASSIVE ..
																		"\n[*]" ..
																			STRINGS.MUSHA_SKILL_VALKYR ..
																				"[14/14] \n[*]" ..
																					STRINGS.MUSHA_SKILL_BERSERK ..
																						"[3/3] \n[*]" ..
																							STRINGS.MUSHA_SKILL_ELECTRA ..
																								"[5/5] \n[*]" ..
																									STRINGS.MUSHA_SKILL_CRITIC .. "[7/7] \n[*]" .. STRINGS.MUSHA_SKILL_DOUBLE .. "[1/1]"
				)
			end
		elseif inst.keep_check then
			inst.keep_check = false
		--inst.components.talker:ShutUp()
		--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime(
			0.5,
			function()
				if inst.keep_check then
					inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking")
				end
			end
		)
	----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	end
end
AddModRPCHandler("musha", "INFO2", INFO2)