GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end}) 

--old Code
local Widget = require("widgets/widget")
local Text = require("widgets/text")
local PlayerBadge = require("widgets/playerbadge")
-----------Load game start-----------
--prefab/注册名
modimport "main/Musha_Assets.lua"
--recipes/配方
modimport "main/Musha_Recipes.lua"
--Any containers setting/所有musha有关的物品容器设定
modimport "main/Musha_Containers.lua"
--重写musha的生命值和精神值，它应该被重写，和musha本体有关。
modimport "main/Musha_Setting.lua" 
--Musha Skill
modimport "main/Musha_Skill.lua"
--API Setting/API设置
local Components_Api = GetModConfigData("Components_Api")
if Components_Api then
modimport("scripts/apis/Components_API.lua")--这是Musha的游戏组件，和凤凰有关。
end
--Add Arrmor fuel/增加装备燃料
modimport "main/Fuel.lua" 
--需要重写装备文件
-- modimport "scripts/apis/CommonAPIs.lua" 
--Mod 设置
modimport "main/Game_setting.lua"--优化了也就那样
--Yamache、bird、phoenix‘s dst Compatibility code(And patch)
modimport "main/Yamache.lua"
--add states
modimport "scripts/musha_states.lua"
--mod support 对其他mod的额外支持请看这里。
modimport "main/Mod_support.lua"

--语言设定
local Musha_language = GetModConfigData("modlanguage")
if Modlanguage == "_en" then
local KnownModIndex = GLOBAL.KnownModIndex
	for _, moddir in ipairs(KnownModIndex:GetModsToLoad()) do
		local language = KnownModIndex:GetModInfo(moddir).name
		if language == "한글 모드 서버 버전" or language == "한글 모드 클라이언트 버전" or language == "Korean Language Pack Ver.Server" then
			Musha_language = "_ko"
		elseif language == "Chinese Language Pack" or language == "Chinese Plus" or language == "[DST]雪儿的外置汉化模组" or language == "中文语言包" then
			Musha_language = "_cn"
		elseif language == "Russian Language Pack" or language == "Russification Pack for DST" or language == "Rus To Latin (Client)" then
			Musha_language = "_ru"
		end
	end
elseif Musha_language == "chinese" or Musha_language == "english" or Musha_language == "russian" or Musha_language == "korean"
	then
		Musha_language = "_en"
end
STRINGS.CHARACTERS.MUSHA = require("speech_musha" .. Musha_language)
modimport("scripts/strings_musha" .. Musha_language .. ".lua")

--不明意义的文件
modimport("libs/env.lua")
modimport("scripts/mypower_musha_1.lua")
modimport("scripts/widgets/spellpower_statusdisplays.lua")
modimport("scripts/widgets/fatigue_sleep_statusdisplays.lua")
modimport("scripts/widgets/stamina_sleep_statusdisplays.lua")
modimport("scripts/difficulty_monster_dst.lua")

AddModCharacter("musha", "FEMALE")
AddReplicableComponent("characterspecific")

--active lightning strike
function on_hitLightnings_9(inst, data)
	local other = data.target
	if not other:HasTag("smashable") and not other:HasTag("shadowminion") and not other:HasTag("alignwall") then
		inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
		inst.lightning_spell_cost = false
		if other and other.components.health and inst.level <= 430 then
			if inst.loud_1 or inst.loud_2 or inst.loud_3 then
				SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end
			SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())

			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			local fx = SpawnPrefab("firering_fx")
			fx.Transform:SetScale(0.6, 0.6, 0.6)
			fx.Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-40)
			--inst.components.sanity:DoDelta(-5)
			inst.components.combat:SetRange(2)
			other.burn = false
			inst.AnimState:SetBloomEffectHandle("")
			if inst.in_shadow then
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
				inst.in_shadow = false
			end
			inst.switch = false
			inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
			if inst.frost and other.components.freezable then
				other.components.freezable:AddColdness(1.5)
				other.components.health:DoDelta(-5)
			elseif inst.fire and other.components.burnable then
				other.components.burnable:Ignite()
				other.components.health:DoDelta(-15)
			end
		elseif other and other.components.health and inst.level > 430 and inst.level <= 1880 then
			if inst.loud_1 or inst.loud_2 or inst.loud_3 then
				SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end
			SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			local fx = SpawnPrefab("firering_fx")
			fx.Transform:SetScale(0.6, 0.6, 0.6)
			fx.Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-60)
			--inst.components.sanity:DoDelta(-5)
			inst.components.combat:SetRange(2)
			other.burn = false
			inst.AnimState:SetBloomEffectHandle("")
			if inst.in_shadow then
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
				inst.in_shadow = false
			end
			inst.switch = false
			inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
			if inst.frost and other.components.freezable then
				other.components.freezable:AddColdness(2)
				other.components.health:DoDelta(-10)
			elseif inst.fire and other.components.burnable then
				other.components.burnable:Ignite()
				other.components.health:DoDelta(-30)
			end
		elseif other and other.components.health and inst.level > 1880 and inst.level <= 6999 then
			if inst.loud_1 or inst.loud_2 or inst.loud_3 then
				SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end
			SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			local fx = SpawnPrefab("firering_fx")
			fx.Transform:SetScale(0.6, 0.6, 0.6)
			fx.Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-80)
			--inst.components.sanity:DoDelta(-5)
			inst.components.combat:SetRange(2)
			other.burn = false
			inst.AnimState:SetBloomEffectHandle("")
			if inst.in_shadow then
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
				inst.in_shadow = false
			end
			inst.switch = false
			inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
			if inst.frost and other.components.freezable then
				other.components.freezable:AddColdness(2.5)
				other.components.health:DoDelta(-15)
			elseif inst.fire and other.components.burnable then
				other.components.burnable:Ignite()
				other.components.health:DoDelta(-45)
			end
		elseif other and other.components.health and inst.level >= 7000 then
			if inst.loud_1 or inst.loud_2 or inst.loud_3 then
				SpawnPrefab("lightning").Transform:SetPosition(other:GetPosition():Get())
			end
			SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
			SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
			local fx = SpawnPrefab("firering_fx")
			fx.Transform:SetScale(0.6, 0.6, 0.6)
			fx.Transform:SetPosition(other:GetPosition():Get())
			other.components.health:DoDelta(-100)
			--inst.components.sanity:DoDelta(-5)
			inst.components.combat:SetRange(2)
			other.burn = false
			inst.AnimState:SetBloomEffectHandle("")
			if inst.in_shadow then
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
				inst.in_shadow = false
			end
			inst.switch = false
			inst:RemoveEventCallback("onhitother", on_hitLightnings_9)
			if inst.frost and other.components.freezable then
				other.components.freezable:AddColdness(3)
				other.components.health:DoDelta(-20)
			elseif inst.fire and other.components.burnable then
				other.components.burnable:Ignite()
				other.components.health:DoDelta(-60)
			end
		end

		--debuff with power lightning

		if other:HasTag("burn") then
			other:DoTaskInTime(
				0.3,
				function()
					SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
					SpawnPrefab("lightning2").Transform:SetPosition(other:GetPosition():Get())
					other:DoTaskInTime(
						0.4,
						function()
							SpawnPrefab("shock_fx").Transform:SetPosition(other:GetPosition():Get())
							local fx_3 = SpawnPrefab("groundpoundring_fx")
							fx_3.Transform:SetScale(0.3, 0.3, 0.3)
							fx_3.Transform:SetPosition(other:GetPosition():Get())
						end
					)

					other.slow = true
					if not other:HasTag("slow") then
						other:AddTag("slow")
					end

					other.burn = false
					other.bloom = false
					other:RemoveTag("burn")
					if not other:HasTag("lightninggoat") then
						other.AnimState:SetBloomEffectHandle("")
						other.bloom = false
					end

					if other:HasTag("slow") then
						local shocking = SpawnPrefab("musha_spin_fx")
						shocking.Transform:SetPosition(other:GetPosition():Get())
						if shocking then
							local follower = shocking.entity:AddFollower()
							follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, 0, 0.5)
						end

						if not other.shocked then
							other.components.health:DoDelta(-25)
						elseif other.shocked then
							SpawnPrefab("explode_small").Transform:SetPosition(other:GetPosition():Get())
							other.components.health:DoDelta(-50)
							other.shocked = false
						end

						local debuff = SpawnPrefab("debuff_short")
						debuff.Transform:SetPosition(other:GetPosition():Get())
						if debuff and other:HasTag("slow") then
							local follower = debuff.entity:AddFollower()
							if not other:HasTag("cavedweller") then
								follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, -50, 0.5)
							else
								follower:FollowSymbol(other.GUID, "body", 0, -50, 0.5)
							end
							TheWorld:DoPeriodicTask(
								2,
								function()
									if other:HasTag("slow") and not other.components.health:IsDead() then
										other.components.health:DoDelta(-8)
									--other.components.combat:GetAttacked(inst, 8)
									end
								end
							)
						end
						TheWorld:DoTaskInTime(
							15,
							function()
								if other.components.locomotor then
									other.components.locomotor.groundspeedmultiplier = 1
									other.slow = false
									other:RemoveTag("slow")
									debuff:Remove()
								end
							end
						)
					end
				end
			)
		end

		if other:HasTag("lightninggoat") and not other:HasTag("charged") then
		--other.charged = true
		--other:AddTag("charged")
		end
		--if other:HasTag("lightninggoat") then
		--	other.sg:GoToState("shocked")
		--end
		--[[if other.components.freezable and other.components.freezable:IsFrozen() and other:HasTag("dragonfly") then
      inst:DoTaskInTime( 1.5, function()  other.components.freezable:Unfreeze() end)
end]]
		if other.components.burnable and other.components.burnable:IsBurning() then
			other.components.burnable:Extinguish()
		end

		local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if weapon and weapon.components.weapon and weapon:HasTag("musha_items") then
			weapon.components.weapon.stimuli = nil
		end
		--[[local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 2, {"musha_items"})
for k,v in pairs(ents) do
if v.components.weapon then
v.components.weapon.stimuli = nil end
end]]
		if inst.switch and inst.frosthammer2 then
			inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
			inst.AnimState:Show("ARM_carry")
			inst.AnimState:Hide("ARM_normal")
		elseif not inst.switch and inst.frosthammer2 then
			inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
			inst.AnimState:Show("ARM_carry")
			inst.AnimState:Hide("ARM_normal")
		end
	end
end

function InShadow(inst, data)
	if inst.sneaka then
		if inst.active_valkyrie or inst.switch then
			inst.components.combat:SetRange(2)
			inst.switch = false
		end
		local player = GLOBAL.ThePlayer
		local x, y, z = inst.Transform:GetWorldPosition()
		local ents = TheSim:FindEntities(x, y, z, 12)
		for k, v in pairs(ents) do
			if
				v.components.health and not v.components.health:IsDead() and v.components.combat and
					v.components.combat.target == inst and
					not (v:HasTag("berrythief") or v:HasTag("prey") or v:HasTag("bird") or v:HasTag("butterfly"))
			 then
				v.components.combat.target = nil
			end
		end
	end
end
--old book skill

function Call_lightining_on(inst, data)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 12)
	for k, v in pairs(ents) do
		if
			v:IsValid() and v.entity:IsVisible() and v.components.health and not v.components.health:IsDead() and
				not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and
				not v:HasTag("groundspike") and
				not v:HasTag("player") and
				not v:HasTag("stalkerminion") and
				not v:HasTag("yamache") and
				not v:HasTag("companion") and
				not inst.components.rider ~= nil and
				not inst.components.rider:IsRiding() and
				not inst.sg:HasStateTag("moving") and
				not inst.sg:HasStateTag("attack") and
				not v:HasTag("structure") and
				v.components.combat and
				(v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn") or v:HasTag("werepig") or
					v:HasTag("frog"))
		 then
			inst.components.locomotor:Stop()
			if --[[inst.switch and inst.active_valkyrie and]] not inst.casting then
				----------------------------------------------------
				--[[local fx_1 = SpawnPrefab("stalker_shield_musha")
	  fx_1.Transform:SetScale(0.5, 0.5, 0.5)
  	  fx_1.Transform:SetPosition(inst:GetPosition():Get())]]
				if not inst.casting then
					inst.casting = true
					if inst.components.spellpower then
						inst.components.spellpower:DoDelta(-10)
					end
					inst.sg:GoToState("book2")
				end

				if inst.level < 430 then
					inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
					if inst.loud_2 or inst.loud_3 then
						SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
					else
						SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
					end

					if v.components.locomotor and not v:HasTag("ghost") then
						v.components.locomotor:StopMoving()
						if v:HasTag("spider") and not v:HasTag("spiderqueen") then
							v.sg:GoToState("hit_stunlock")
						else
							v.sg:GoToState("hit")
						end
					end
					local fx_2 = SpawnPrefab("groundpoundring_fx")
					fx_2.Transform:SetScale(0.4, 0.4, 0.4)
					fx_2.Transform:SetPosition(inst:GetPosition():Get())

					v:DoTaskInTime(
						0.3,
						function()
							SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
							SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
							v:DoTaskInTime(
								0.4,
								function()
									SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
									local fx_3 = SpawnPrefab("groundpoundring_fx")
									fx_3.Transform:SetScale(0.3, 0.3, 0.3)
									fx_3.Transform:SetPosition(v:GetPosition():Get())
								end
							)
							if v:HasTag("burn") then
								v.slow = true
								if not v:HasTag("slow") then
									v:AddTag("slow")
								end
							else
								--v.components.combat:GetAttacked(inst, 10)
								v.components.health:DoDelta(-10)
							end
							if v.components.combat and not v:HasTag("companion") then
								v.components.combat:SuggestTarget(inst)
							end
							v.burn = false
							v.bloom = false
							v:RemoveTag("burn")
							if not v:HasTag("lightninggoat") then
								v.AnimState:SetBloomEffectHandle("")
								v.bloom = false
							end

							if v:HasTag("slow") then
								--[[local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	]]
								if not v.shocked then
									--v.components.combat:GetAttacked(inst, 20)
									v.components.health:DoDelta(-25)
								elseif v.shocked then
									SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
									v.components.health:DoDelta(-40)
									--v.components.combat:GetAttacked(inst, 40)

									local shocking = SpawnPrefab("musha_spin_fx")
									shocking.Transform:SetPosition(v:GetPosition():Get())
									if shocking then
										local follower = shocking.entity:AddFollower()
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
									end

									v.shocked = false
								end

								local debuff = SpawnPrefab("debuff_short")
								debuff.Transform:SetPosition(v:GetPosition():Get())
								if debuff and v:HasTag("slow") then
									local follower = debuff.entity:AddFollower()
									if not v:HasTag("cavedweller") then
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5)
									else
										follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5)
									end
									TheWorld:DoPeriodicTask(
										2,
										function()
											if v:HasTag("slow") and not v.components.health:IsDead() then
												v.components.health:DoDelta(-2)
											--
											end
										end
									)
								end
								TheWorld:DoTaskInTime(
									15,
									function()
										if v.components.locomotor then
											v.components.locomotor.groundspeedmultiplier = 1
											v.slow = false
											v:RemoveTag("slow")
											debuff:Remove()
										end
									end
								)
							elseif not v:HasTag("slow") then
								v:AddTag("burn")
							end
						end
					)
				elseif inst.level >= 430 and inst.level < 1880 then
					inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
					if inst.loud_2 or inst.loud_3 then
						SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
					else
						SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
					end

					if v.components.locomotor and not v:HasTag("ghost") then
						v.components.locomotor:StopMoving()
						if v:HasTag("spider") and not v:HasTag("spiderqueen") then
							v.sg:GoToState("hit_stunlock")
						else
							v.sg:GoToState("hit")
						end
					end
					local fx_2 = SpawnPrefab("groundpoundring_fx")
					fx_2.Transform:SetScale(0.4, 0.4, 0.4)
					fx_2.Transform:SetPosition(inst:GetPosition():Get())

					v:DoTaskInTime(
						0.3,
						function()
							SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
							SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
							v:DoTaskInTime(
								0.4,
								function()
									SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
									local fx_3 = SpawnPrefab("groundpoundring_fx")
									fx_3.Transform:SetScale(0.3, 0.3, 0.3)
									fx_3.Transform:SetPosition(v:GetPosition():Get())
								end
							)
							if v:HasTag("burn") then
								v.slow = true
								if not v:HasTag("slow") then
									v:AddTag("slow")
								end
							else
								--v.components.combat:GetAttacked(inst, 15)
								v.components.health:DoDelta(-15)
							end
							if v.components.combat and not v:HasTag("companion") then
								v.components.combat:SuggestTarget(inst)
							end
							v.burn = false
							v.bloom = false
							v:RemoveTag("burn")
							if not v:HasTag("lightninggoat") then
								v.AnimState:SetBloomEffectHandle("")
								v.bloom = false
							end

							if v:HasTag("slow") then
								if not v.shocked then
									--v.components.combat:GetAttacked(inst, 30)
									v.components.health:DoDelta(-30)
								elseif v.shocked then
									SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
									v.components.health:DoDelta(-50)
									--v.components.combat:GetAttacked(inst, 50)

									local shocking = SpawnPrefab("musha_spin_fx")
									shocking.Transform:SetPosition(v:GetPosition():Get())
									if shocking then
										local follower = shocking.entity:AddFollower()
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
									end

									v.shocked = false
								end

								local debuff = SpawnPrefab("debuff_short")
								debuff.Transform:SetPosition(v:GetPosition():Get())
								if debuff and v:HasTag("slow") then
									local follower = debuff.entity:AddFollower()
									if not v:HasTag("cavedweller") then
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5)
									else
										follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5)
									end
									TheWorld:DoPeriodicTask(
										2,
										function()
											if v:HasTag("slow") and not v.components.health:IsDead() then
												v.components.health:DoDelta(-4)
											--
											end
										end
									)
								end
								TheWorld:DoTaskInTime(
									15,
									function()
										if v.components.locomotor then
											v.components.locomotor.groundspeedmultiplier = 1
											v.slow = false
											v:RemoveTag("slow")
											debuff:Remove()
										end
									end
								)
							elseif not v:HasTag("slow") then
								v:AddTag("burn")
							end
						end
					)
				elseif inst.level >= 1880 and inst.level < 7000 then
					inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
					if inst.loud_2 or inst.loud_3 then
						SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
					else
						SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
					end

					if v.components.locomotor and not v:HasTag("ghost") then
						v.components.locomotor:StopMoving()
						if v:HasTag("spider") and not v:HasTag("spiderqueen") then
							v.sg:GoToState("hit_stunlock")
						else
							v.sg:GoToState("hit")
						end
					end
					local fx_2 = SpawnPrefab("groundpoundring_fx")
					fx_2.Transform:SetScale(0.4, 0.4, 0.4)
					fx_2.Transform:SetPosition(inst:GetPosition():Get())

					v:DoTaskInTime(
						0.3,
						function()
							SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
							SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
							v:DoTaskInTime(
								0.4,
								function()
									SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
									local fx_3 = SpawnPrefab("groundpoundring_fx")
									fx_3.Transform:SetScale(0.3, 0.3, 0.3)
									fx_3.Transform:SetPosition(v:GetPosition():Get())
								end
							)
							if v:HasTag("burn") then
								v.slow = true
								if not v:HasTag("slow") then
									v:AddTag("slow")
								end
							else
								--v.components.combat:GetAttacked(inst, 20)
								v.components.health:DoDelta(-20)
							end
							if v.components.combat and not v:HasTag("companion") then
								v.components.combat:SuggestTarget(inst)
							end
							v.burn = false
							v.bloom = false
							v:RemoveTag("burn")
							if not v:HasTag("lightninggoat") then
								v.AnimState:SetBloomEffectHandle("")
								v.bloom = false
							end

							if v:HasTag("slow") then
								if not v.shocked then
									--v.components.combat:GetAttacked(inst, 35)
									v.components.health:DoDelta(-35)
								elseif v.shocked then
									SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
									v.components.health:DoDelta(-60)
									--v.components.combat:GetAttacked(inst, 60)

									local shocking = SpawnPrefab("musha_spin_fx")
									shocking.Transform:SetPosition(v:GetPosition():Get())
									if shocking then
										local follower = shocking.entity:AddFollower()
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
									end

									v.shocked = false
								end

								local debuff = SpawnPrefab("debuff_short")
								debuff.Transform:SetPosition(v:GetPosition():Get())
								if debuff and v:HasTag("slow") then
									local follower = debuff.entity:AddFollower()
									if not v:HasTag("cavedweller") then
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5)
									else
										follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5)
									end
									TheWorld:DoPeriodicTask(
										2,
										function()
											if v:HasTag("slow") and not v.components.health:IsDead() then
												v.components.health:DoDelta(-6)
											--
											end
										end
									)
								end
								TheWorld:DoTaskInTime(
									15,
									function()
										if v.components.locomotor then
											v.components.locomotor.groundspeedmultiplier = 1
											v.slow = false
											v:RemoveTag("slow")
											debuff:Remove()
										end
									end
								)
							elseif not v:HasTag("slow") then
								v:AddTag("burn")
							end
						end
					)
				elseif inst.level >= 7000 then
					inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")
					if inst.loud_2 or inst.loud_3 then
						SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
					else
						SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
					end

					if v.components.locomotor and not v:HasTag("ghost") then
						v.components.locomotor:StopMoving()
						if v:HasTag("spider") and not v:HasTag("spiderqueen") then
							v.sg:GoToState("hit_stunlock")
						else
							v.sg:GoToState("hit")
						end
					end
					local fx_2 = SpawnPrefab("groundpoundring_fx")
					fx_2.Transform:SetScale(0.4, 0.4, 0.4)
					fx_2.Transform:SetPosition(inst:GetPosition():Get())

					v:DoTaskInTime(
						0.3,
						function()
							SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
							SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
							v:DoTaskInTime(
								0.4,
								function()
									SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
									local fx_3 = SpawnPrefab("groundpoundring_fx")
									fx_3.Transform:SetScale(0.3, 0.3, 0.3)
									fx_3.Transform:SetPosition(v:GetPosition():Get())
								end
							)
							if v:HasTag("burn") then
								v.slow = true
								if not v:HasTag("slow") then
									v:AddTag("slow")
								end
							else
								--v.components.combat:GetAttacked(inst, 25)
								v.components.health:DoDelta(-25)
							end
							if v.components.combat and not v:HasTag("companion") then
								v.components.combat:SuggestTarget(inst)
							end
							v.burn = false
							v.bloom = false
							v:RemoveTag("burn")
							if not v:HasTag("lightninggoat") then
								v.AnimState:SetBloomEffectHandle("")
								v.bloom = false
							end

							if v:HasTag("slow") then
								if not v.shocked then
									--v.components.combat:GetAttacked(inst, 40)
									v.components.health:DoDelta(-40)
								elseif v.shocked then
									SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
									v.components.health:DoDelta(-70)
									--v.components.combat:GetAttacked(inst, 70)

									local shocking = SpawnPrefab("musha_spin_fx")
									shocking.Transform:SetPosition(v:GetPosition():Get())
									if shocking then
										local follower = shocking.entity:AddFollower()
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
									end

									v.shocked = false
								end

								local debuff = SpawnPrefab("debuff_short")
								debuff.Transform:SetPosition(v:GetPosition():Get())
								if debuff and v:HasTag("slow") then
									local follower = debuff.entity:AddFollower()
									if not v:HasTag("cavedweller") then
										follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5)
									else
										follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5)
									end
									TheWorld:DoPeriodicTask(
										2,
										function()
											if v:HasTag("slow") and not v.components.health:IsDead() then
												v.components.health:DoDelta(-8)
											--
											end
										end
									)
								end
								TheWorld:DoTaskInTime(
									15,
									function()
										if v.components.locomotor then
											v.components.locomotor.groundspeedmultiplier = 1
											v.slow = false
											v:RemoveTag("slow")
											debuff:Remove()
										end
									end
								)
							elseif not v:HasTag("slow") then
								v:AddTag("burn")
							end
						end
					)
				end
			end
			if v.components.combat and not v:HasTag("companion") then
				v.components.combat:SuggestTarget(inst)
			end
		end
	end
end
--power lightning

function Lightning_a(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if inst.sneaka then
		--inst.components.talker:Say("Be quiet..")
		if not inst.poison_sneaka then
			if inst.components.sanity.current > 10 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_READY_POISON)
				inst.components.sanity:DoDelta(-25)
				inst.poison_sneaka = true
				local poison_sneaka = SpawnPrefab("shadowbomb_r")
				if poison_sneaka then
					poison_sneaka.entity:SetParent(inst.entity)
					poison_sneaka.Follower:FollowSymbol(inst.GUID, "headbase", -5, -225, 0.5)
				end
			elseif inst.components.sanity.current <= 25 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
			end
		elseif inst.poison_sneaka then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_CANCEL_POISON)
			inst.poison_sneaka = false
			inst.components.sanity:DoDelta(25)
		end
	else
		if not inst.writing and inst.berserk then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GRRR)
			local fx = SpawnPrefab("stalker_shield_musha")
			fx.Transform:SetScale(0.5, 0.5, 0.5)
			fx.Transform:SetPosition(inst:GetPosition():Get())
			local shocking = SpawnPrefab("musha_spin_fx")
			shocking.Transform:SetPosition(inst:GetPosition():Get())
			if shocking then
				local follower = shocking.entity:AddFollower()
				--inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
				follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5)
			end
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = TheSim:FindEntities(x, y, z, 10)
			for k, v in pairs(ents) do
				if
					inst.components.spellpower.current > 1 and v:IsValid() and v.entity:IsVisible() and v.components.health and
						not v.components.health:IsDead() and
						not v.components.health:IsDead() and
						not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and
						not v:HasTag("groundspike") and
						not v:HasTag("player") and
						not v:HasTag("stalkerminion") and
						not v:HasTag("structure") and
						not v:HasTag("groundspike") and
						not v:HasTag("stalkerminion") and
						v.components.locomotor and
						not v.ghost_spark and
						v.components.combat and
						(v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn") or v:HasTag("werepig") or
							v:HasTag("frog"))
				 then
					--cost
					inst.components.spellpower:DoDelta(-1)

					v.ghost_spark = true
					if inst.loud_1 or inst.loud_2 then
						SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
					else
						SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
					end
					inst:DoTaskInTime(
						0.6,
						function()
							SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
						end
					)

					-- lightning skill cost
					--inst.components.sanity:DoDelta(-3)
					if v:HasTag("burn") and v.components.combat ~= nil then
						SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
						if not v:HasTag("slow") then
							v:AddTag("slow")
						end
						if v:HasTag("slow") then
							--[[local shocking = SpawnPrefab("musha_spin_fx")
		shocking.Transform:SetPosition(v:GetPosition():Get())
		if shocking then
		local follower = shocking.entity:AddFollower()
		follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
		end	]]
							if not v.shocked then
								--v.components.combat:GetAttacked(inst, 40)
								v.components.health:DoDelta(-30)
							elseif v.shocked then
								SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get())
								v.components.health:DoDelta(-45)
								--v.components.combat:GetAttacked(inst, 65)

								local shocking = SpawnPrefab("musha_spin_fx")
								shocking.Transform:SetPosition(v:GetPosition():Get())
								if shocking then
									local follower = shocking.entity:AddFollower()
									--inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
									follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
								end

								v.shocked = false
							end

							local debuff = SpawnPrefab("debuff_short")
							debuff.Transform:SetPosition(v:GetPosition():Get())
							if debuff and v:HasTag("slow") then
								local follower = debuff.entity:AddFollower()
								if not v:HasTag("cavedweller") then
									follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5)
								else
									follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5)
								end
								TheWorld:DoPeriodicTask(
									2,
									function()
										if v:HasTag("slow") and not v.components.health:IsDead() then
											v.components.health:DoDelta(-2)
										--
										end
									end
								)
							end
							TheWorld:DoTaskInTime(
								15,
								function()
									if v.components.locomotor then
										v.components.locomotor.groundspeedmultiplier = 1
										v.slow = false
										v:RemoveTag("slow")
										debuff:Remove()
									end
								end
							)
						end
					else
						--v.components.combat:GetAttacked(inst, 30)
						v.components.health:DoDelta(-25)
					end
					--[[if v.ghost_spark and v:HasTag("spider") then
					v.sg:GoToState("hit_stunlock")
				else
					v.sg:GoToState("hit")
				end]]
					if v.components.locomotor and not v:HasTag("ghost") then
						v.components.locomotor:StopMoving()
						if v:HasTag("spider") and not v:HasTag("spiderqueen") then
							v.sg:GoToState("hit_stunlock")
						else
							v.sg:GoToState("hit")
						end
					end

					if v.components.combat and not v:HasTag("companion") then
						v.components.combat:SuggestTarget(inst)
					end
					v:DoTaskInTime(
						3,
						function()
							v.ghost_spark = false
						end
					)
				end
			end
		elseif not inst.writing and not inst.berserk then
			if
				inst.components.stamina_sleep.current >= 20 and inst.components.sanity.current >= 0 and
					not inst.components.health:IsDead() and
					not inst.active_valkyrie and
					not inst.switch and
					inst.valkyrie_on
			 then
				--inst:DoTaskInTime( 60, function() inst.active_valkyrie = false SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get()) end)
				inst.active_valkyrie = true
			elseif
				(inst.components.stamina_sleep.current < 20 or inst.components.sanity.current <= 0) and not inst.active_valkyrie and
					inst.valkyrie_on
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_GRRR)
				if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
					inst.sg:GoToState("repelled")
				else
					inst.sg:GoToState("mindcontrolled")
				end
				inst.components.combat:SetRange(2)
				inst.AnimState:SetBloomEffectHandle("")
				if inst.in_shadow then
					inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
					inst.in_shadow = false
				end
				inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
				inst.switch = false
				inst.active_valkyrie = false
			elseif inst.components.sanity.current <= 0 and inst.active_valkyrie and inst.valkyrie_on then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
				if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
					inst.sg:GoToState("repelled")
				else
					inst.sg:GoToState("mindcontrolled")
				end
				inst.components.combat:SetRange(2)
				inst:RemoveEventCallback("onhitother", on_hitLightnings_9)

				inst.AnimState:SetBloomEffectHandle("")
				if inst.in_shadow then
					inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
					inst.in_shadow = false
				end
				inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
				SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
				inst.switch = false
				inst.active_valkyrie = false
			--inst.components.sanity:DoDelta(4)
			end
			if
				inst.components.stamina_sleep.current >= 20 and not inst.switch and inst.components.sanity.current > 0 and
					inst.level < 430 and
					not inst.components.health:IsDead() and
					not inst:HasTag("playerghost") and
					not (inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and
					inst.valkyrie_on
			 then
				--Call_lightining_on(inst)
				--inst.components.sanity:DoDelta(-2)
				if inst.components.spellpower.current >= 9 then
					inst.components.spellpower:DoDelta(-9)
					inst.lightning_spell_cost = true
					inst.components.combat:SetRange(10, 12)
					inst:ListenForEvent("onhitother", on_hitLightnings_9)

					inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
					SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
					local fx = SpawnPrefab("groundpoundring_fx")
					fx.Transform:SetScale(0.3, 0.3, 0.3)
					fx.Transform:SetPosition(inst:GetPosition():Get())
					if not inst.sneak_pang then
						inst:DoTaskInTime(
							2,
							function()
								if inst.switch then
									inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
								end
							end
						)
					end
				end
				inst.switch = true

				local shocking = SpawnPrefab("musha_spin_fx")
				shocking.Transform:SetPosition(inst:GetPosition():Get())
				if shocking then
					local follower = shocking.entity:AddFollower()
					follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5)
				end
			elseif
				inst.components.stamina_sleep.current >= 20 and not inst.switch and inst.components.sanity.current > 0 and
					inst.level >= 430 and
					inst.level < 1880 and
					not inst.components.health:IsDead() and
					not inst:HasTag("playerghost") and
					not (inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and
					inst.valkyrie_on
			 then
				if inst.components.spellpower.current >= 9 then
					inst.components.spellpower:DoDelta(-9)
					inst.lightning_spell_cost = true
					inst.components.combat:SetRange(10, 12)
					inst:ListenForEvent("onhitother", on_hitLightnings_9)

					inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
					SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
					local fx = SpawnPrefab("groundpoundring_fx")
					fx.Transform:SetScale(0.3, 0.3, 0.3)
					fx.Transform:SetPosition(inst:GetPosition():Get())
					if not inst.sneak_pang then
						inst:DoTaskInTime(
							2,
							function()
								if inst.switch then
									inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
								end
							end
						)
					end
				end
				inst.switch = true

				local shocking = SpawnPrefab("musha_spin_fx")
				shocking.Transform:SetPosition(inst:GetPosition():Get())
				if shocking then
					local follower = shocking.entity:AddFollower()
					follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5)
				end
				--Call_lightining_on(inst)
				--inst.components.sanity:DoDelta(-2)
				if not inst.berserk then
				--inst.components.talker:Say("Valkyrie!")
				end
			elseif
				inst.components.stamina_sleep.current >= 20 and not inst.switch and inst.components.sanity.current > 0 and
					inst.level >= 1880 and
					inst.level < 7000 and
					not inst.components.health:IsDead() and
					not inst:HasTag("playerghost") and
					not (inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and
					inst.valkyrie_on
			 then
				if inst.components.spellpower.current >= 9 then
					inst.components.spellpower:DoDelta(-9)
					inst.lightning_spell_cost = true
					inst.components.combat:SetRange(10, 12)
					inst:ListenForEvent("onhitother", on_hitLightnings_9)

					inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
					SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
					local fx = SpawnPrefab("groundpoundring_fx")
					fx.Transform:SetScale(0.3, 0.3, 0.3)
					fx.Transform:SetPosition(inst:GetPosition():Get())
					if not inst.sneak_pang then
						inst:DoTaskInTime(
							2,
							function()
								if inst.switch then
									inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
								end
							end
						)
					end
				end
				inst.switch = true

				local shocking = SpawnPrefab("musha_spin_fx")
				shocking.Transform:SetPosition(inst:GetPosition():Get())
				if shocking then
					local follower = shocking.entity:AddFollower()
					follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5)
				end
				--Call_lightining_on(inst)
				--inst.components.sanity:DoDelta(-2)
				if not inst.berserk then
				--inst.components.talker:Say("Valkyrie!")
				end
			elseif
				inst.components.stamina_sleep.current >= 20 and not inst.switch and inst.components.sanity.current > 0 and
					inst.level >= 7000 and
					not inst.components.health:IsDead() and
					not inst:HasTag("playerghost") and
					not (inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and
					inst.valkyrie_on
			 then
				--Call_lightining_on(inst)
				--inst.components.sanity:DoDelta(-2)
				if inst.components.spellpower.current >= 9 then
					inst.components.spellpower:DoDelta(-9)
					inst.lightning_spell_cost = true
					inst.components.combat:SetRange(10, 12)
					inst:ListenForEvent("onhitother", on_hitLightnings_9)

					inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
					SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
					local fx = SpawnPrefab("groundpoundring_fx")
					fx.Transform:SetScale(0.3, 0.3, 0.3)
					fx.Transform:SetPosition(inst:GetPosition():Get())
					if not inst.sneak_pang then
						inst:DoTaskInTime(
							2,
							function()
								if inst.switch then
									inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
								end
							end
						)
					end
				end
				inst.switch = true

				local shocking = SpawnPrefab("musha_spin_fx")
				shocking.Transform:SetPosition(inst:GetPosition():Get())
				if shocking then
					local follower = shocking.entity:AddFollower()
					follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5)
				end
			elseif
				not inst.switch and not inst.components.health:IsDead() and
					(inst.vl1 or inst.vl2 or inst.vl3 or inst.vl4 or inst.vl5 or inst.vl6 or inst.vl7 or inst.vl8) and
					inst.valkyrie_on
			 then
				inst.components.combat:SetRange(2)
				inst:RemoveEventCallback("onhitother", on_hitLightnings_9)

				inst.AnimState:SetBloomEffectHandle("")
				if inst.in_shadow then
					inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
					inst.in_shadow = false
				end
				inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
				SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
				inst.switch = false
				inst.active_valkyrie = false
				--inst.components.sanity:DoDelta(6)
				if inst.lightning_spell_cost then
					inst.components.spellpower:DoDelta(6)
				end
			elseif inst.switch and not inst.components.health:IsDead() and inst.valkyrie_on then
				inst.components.combat:SetRange(2)
				inst:RemoveEventCallback("onhitother", on_hitLightnings_9)

				inst.AnimState:SetBloomEffectHandle("")
				if inst.in_shadow then
					inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
					inst.in_shadow = false
				end
				inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
				SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
				inst.switch = false
				inst.active_valkyrie = false
				--inst.components.sanity:DoDelta(1)
				if inst.lightning_spell_cost then
					inst.components.spellpower:DoDelta(6)
				end
			elseif
				not inst.switch and inst.components.sanity.current <= 0 and not inst.components.health:IsDead() and
					not inst:HasTag("playerghost") and
					inst.valkyrie_on
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
			elseif inst:HasTag("playerghost") then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_REVENGE)

				local x, y, z = inst.Transform:GetWorldPosition()
				local ents = TheSim:FindEntities(x, y, z, 10)
				for k, v in pairs(ents) do
					if
						v:IsValid() and v.entity:IsVisible() and v.components.health and not v.components.health:IsDead() and
							not v.ghost_spark and
							not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and
							not v:HasTag("groundspike") and
							not v:HasTag("player") and
							not v:HasTag("stalkerminion") and
							not inst.components.rider ~= nil and
							not inst.components.rider:IsRiding() and
							not inst.sg:HasStateTag("moving") and
							not inst.sg:HasStateTag("attack") and
							not v:HasTag("structure") and
							v.components.combat and
							(v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn") or v:HasTag("werepig") or
								v:HasTag("frog")) and
							not target:HasTag("follower")
					 then
						if not target == nil then
							v.ghost_spark = true
							SpawnPrefab("lightning2").Transform:SetPosition(v:GetPosition():Get())
							if v.ghost_spark then
								local shocking = SpawnPrefab("musha_spin_fx")
								shocking.Transform:SetPosition(v:GetPosition():Get())
								if shocking then
									local follower = shocking.entity:AddFollower()
									inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_appear")
									follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
								end
							end
							v.components.health:DoDelta(-10)
							if v.ghost_spark and v:HasTag("spider") and not v:HasTag("spiderqueen") then
								v.sg:GoToState("hit_stunlock")
							elseif v.ghost_spark and v:HasTag("hound") then
								v.sg:GoToState("hit")
							end
							v:DoTaskInTime(
								3,
								function()
									v.ghost_spark = false
								end
							)
						end
					end
				end
			end
			--inst:ListenForEvent("killed", onkilll)
			if not inst.valkyrie_on and not inst:HasTag("playerghost") then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_EXP .. "\n[REQUIRE]: level 3")
			end
			local x, y, z = inst.Transform:GetWorldPosition()
			local ents = TheSim:FindEntities(x, y, z, 40, {"yamcheb"})
			for k, v in pairs(ents) do
				if inst.components.leader:IsFollower(v) and not inst.switch then
					v.yamche_lightning = false
				elseif inst.components.leader:IsFollower(v) and inst.switch then
					v.yamche_lightning = true
				end
			end

			local weapon = inst.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS)
			if inst.switch and weapon and weapon.components.weapon then
				weapon.components.weapon.stimuli = "electric"
			elseif not inst.switch and weapon and weapon.components.weapon and not weapon:HasTag("electric_weapon") then
				weapon.components.weapon.stimuli = nil
			end

		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
		end
	end
	if inst.switch and inst.frosthammer2 then
		inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer2", "frosthammer")
		inst.AnimState:Show("ARM_carry")
		inst.AnimState:Hide("ARM_normal")
	elseif not inst.switch and inst.frosthammer2 then
		inst.AnimState:OverrideSymbol("swap_object", "swap_frosthammer", "frosthammer")
		inst.AnimState:Show("ARM_carry")
		inst.AnimState:Hide("ARM_normal")
	end
end
AddModRPCHandler("musha", "Lightning_a", Lightning_a)

--shield
--active shield
function shield_go(inst, attacked, data)
	if not inst.components.health:IsDead() and inst.level < 430 and not inst.activec0 and inst.shield_level1 then
		--inst.components.talker:Say("Shield on!!")
		inst.components.health:SetAbsorptionAmount(1)
		local fx = SpawnPrefab("forcefieldfxx")
		inst.on_sparkshield = true

		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		fx.entity:SetParent(inst.entity)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
			fx.Transform:SetScale(2, 2, 2)
		else
			fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
		fx.Transform:SetPosition(0, 0.2, 0)
		local fx_hitanim = function()
			fx.AnimState:PlayAnimation("hit")
			fx.AnimState:PushAnimation("idle_loop")
		end
		fx:ListenForEvent("blocked", fx_hitanim, inst)
		inst.activec0 = true
		inst.timec1 = true
		inst:DoTaskInTime --[[Duration]](
			12,
			function()
				fx:RemoveEventCallback("blocked", fx_hitanim, inst)

				if inst:IsValid() then
					fx.kill_fx(fx)
					--inst.components.health:SetAbsorptionAmount(0)
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_90)
					inst.on_sparkshield = false

					inst:DoTaskInTime --[[Cooldown]](
						90,
						function()
							inst.activec0 = false
							inst.timec1 = false
							inst.casting = false
						end
					)
				end
			end
		)
	end
	if
		not inst.components.health:IsDead() and inst.level >= 430 and inst.level < 1880 and not inst.activec0 and
			inst.shield_level2
	 then
		--inst.components.talker:Say("Shield on!!")
		inst.components.health:SetAbsorptionAmount(1)
		local fx = SpawnPrefab("forcefieldfxx")
		inst.on_sparkshield = true

		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		fx.entity:SetParent(inst.entity)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
			fx.Transform:SetScale(2, 2, 2)
		else
			fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
		fx.Transform:SetPosition(0, 0.2, 0)
		local fx_hitanim = function()
			fx.AnimState:PlayAnimation("hit")
			fx.AnimState:PushAnimation("idle_loop")
		end
		fx:ListenForEvent("blocked", fx_hitanim, inst)
		inst.activec0 = true
		inst.timec2 = true
		inst:DoTaskInTime --[[Duration]](
			12,
			function()
				fx:RemoveEventCallback("blocked", fx_hitanim, inst)
				if inst:IsValid() then
					fx.kill_fx(fx)
					--inst.components.health:SetAbsorptionAmount(0)
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_80)
					inst.on_sparkshield = false
					inst:DoTaskInTime --[[Cooldown]](
						80,
						function()
							inst.activec0 = false
							inst.timec2 = false
						end
					)
				end
			end
		)
	end
	if
		not inst.components.health:IsDead() and inst.level >= 1880 and inst.level < 7000 and not inst.activec0 and
			inst.shield_level3
	 then
		--inst.components.talker:Say("Shield on!!")
		inst.components.health:SetAbsorptionAmount(1)
		local fx = SpawnPrefab("forcefieldfxx")
		inst.on_sparkshield = true

		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		fx.entity:SetParent(inst.entity)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
			fx.Transform:SetScale(2, 2, 2)
		else
			fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
		fx.Transform:SetPosition(0, 0.2, 0)
		local fx_hitanim = function()
			fx.AnimState:PlayAnimation("hit")
			fx.AnimState:PushAnimation("idle_loop")
		end
		fx:ListenForEvent("blocked", fx_hitanim, inst)
		inst.activec0 = true
		inst.timec3 = true
		inst:DoTaskInTime --[[Duration]](
			12,
			function()
				fx:RemoveEventCallback("blocked", fx_hitanim, inst)
				if inst:IsValid() then
					fx.kill_fx(fx)
					--inst.components.health:SetAbsorptionAmount(0)
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_70)
					inst.on_sparkshield = false
					inst:DoTaskInTime --[[Cooldown]](
						70,
						function()
							inst.activec0 = false
							inst.timec3 = false
						end
					)
				end
			end
		)
	end
	if not inst.components.health:IsDead() and inst.level >= 7000 and not inst.activec0 and inst.shield_level4 then
		--inst.components.talker:Say("Shield on!!")
		inst.components.health:SetAbsorptionAmount(1)
		local fx = SpawnPrefab("forcefieldfxx")
		inst.on_sparkshield = true

		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
		inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
		fx.entity:SetParent(inst.entity)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
			fx.Transform:SetScale(2, 2, 2)
		else
			fx.Transform:SetScale(0.8, 0.8, 0.8)
		end
		fx.Transform:SetPosition(0, 0.2, 0)
		local fx_hitanim = function()
			fx.AnimState:PlayAnimation("hit")
			fx.AnimState:PushAnimation("idle_loop")
		end
		fx:ListenForEvent("blocked", fx_hitanim, inst)
		inst.activec0 = true
		inst.timec4 = true
		inst:DoTaskInTime --[[Duration]](
			12,
			function()
				fx:RemoveEventCallback("blocked", fx_hitanim, inst)
				if inst:IsValid() then
					fx.kill_fx(fx)
					--inst.components.health:SetAbsorptionAmount(0)
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_COOL_60)
					inst.on_sparkshield = false
					if inst.berserk and inst.berserk_armor_1 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.15)
					elseif inst.berserk and inst.berserk_armor_2 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.3)
					elseif inst.berserk and inst.berserk_armor_3 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.45)
					elseif
						inst.valkyrie and
							not (inst.valkyrie_armor_1 or inst.valkyrie_armor_2 or inst.valkyrie_armor_3 or inst.valkyrie_armor_4) and
							not inst.music_armor
					 then
						inst.components.health:SetAbsorptionAmount(0.1)
					elseif inst.valkyrie and inst.valkyrie_armor_1 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.1)
					elseif inst.valkyrie and inst.valkyrie_armor_2 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.2)
					elseif inst.valkyrie and inst.valkyrie_armor_3 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.25)
					elseif inst.valkyrie and inst.valkyrie_armor_4 and not inst.music_armor then
						inst.components.health:SetAbsorptionAmount(0.3)
					else
						inst.components.health:SetAbsorptionAmount(0)
					end
					inst:DoTaskInTime --[[Cooldown]](
						60,
						function()
							inst.activec0 = false
							inst.timec4 = false
						end
					)
				end
			end
		)
	end
	----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end

---
function shieldgo(inst)
	if not inst.activec0 and not inst.timec1 and inst.level < 430 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
		inst.timec1 = true
	elseif not inst.activec0 and not inst.timec2 and inst.level >= 430 and inst.level < 1880 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
		inst.timec2 = true
	elseif not inst.activec0 and not inst.timec3 and inst.level >= 1880 and inst.level < 7000 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
		inst.timec3 = true
	elseif not inst.activec0 and not inst.timec4 and inst.level >= 7000 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SHIELD_FULL)
		SpawnPrefab("sparks").Transform:SetPosition(inst:GetPosition():Get())
		inst.timec4 = true
	end
	----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
end
function on_shield_act(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		if inst.components.health ~= nil and not inst.components.health:IsDead() and not inst:HasTag("playerghost") then
			----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
			inst:ListenForEvent("hungerdelta", shieldgo)
			--inst:ListenForEvent("attacked", Sparkshield_1)
			if inst.level < 430 then
				inst.shield_level1 = true
			elseif inst.level >= 430 and inst.level < 1880 then
				inst.shield_level2 = true
				inst.shield_level1 = false
			elseif inst.level >= 1880 and inst.level < 7000 then
				inst.shield_level3 = true
				inst.shield_level2 = false
				inst.shield_level1 = false
			elseif inst.level >= 7000 then
				inst.shield_level4 = true
				inst.shield_level3 = false
				inst.shield_level2 = false
				inst.shield_level1 = false
			end

			if not inst.activec0 and inst.components.spellpower.current >= 30 then
				--[[local fx_1 = SpawnPrefab("stalker_shield_musha")
	  fx_1.Transform:SetScale(0.4, 0.4, 0.4)
  	  fx_1.Transform:SetPosition(inst:GetPosition():Get())]]
				inst.components.locomotor:Stop()
				if
					not inst.casting and not inst.components.rider:IsRiding() and not inst.sg:HasStateTag("moving") and
						not inst.sg:HasStateTag("attack")
				 then
					inst.casting = true
					inst.sg:GoToState("book2")
					inst.on_sparkshield = true
				end

				local shocking_self = SpawnPrefab("musha_spin_fx")
				shocking_self.Transform:SetPosition(inst:GetPosition():Get())
				if shocking_self then
					local follower = shocking_self.entity:AddFollower()
					follower:FollowSymbol(inst.GUID, inst.components.combat.hiteffectsymbol, 0, 0, 0.5)
				end

				local x, y, z = inst.Transform:GetWorldPosition()
				local ents = TheSim:FindEntities(x, y, z, 10)
				for k, v in pairs(ents) do
					if
						inst.components.sanity and v:IsValid() and v.entity:IsVisible() and v.components.health and
							not v.components.health:IsDead() and
							not (v:HasTag("berrythief") or v:HasTag("bird") or v:HasTag("butterfly")) and
							not v:HasTag("groundspike") and
							not v:HasTag("player") and
							not v:HasTag("companion") and
							not v:HasTag("stalkerminion") and
							not v:HasTag("structure") and
							v.components.combat ~= nil and
							(v.components.combat.target == inst or v:HasTag("monster") or v:HasTag("burn"))
					 then
						SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
						--SpawnPrefab("shock_fx").Transform:SetPosition(v:GetPosition():Get())
						local shocking = SpawnPrefab("musha_spin_fx")
						shocking.Transform:SetPosition(v:GetPosition():Get())
						if shocking then
							local follower = shocking.entity:AddFollower()
							follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5)
						end

						if v.components.locomotor and not v:HasTag("ghost") then
							v.components.locomotor:StopMoving()
							if v:HasTag("spider") and not v:HasTag("spiderqueen") then
								v.sg:GoToState("hit_stunlock")
							else
								v.sg:GoToState("hit")
							end
						end
						v.components.health:DoDelta(-20)
						--v.components.combat:GetAttacked(inst, 10)

						if v.components.combat and not v:HasTag("companion") then
							v.components.combat:SuggestTarget(inst)
						end
					end
				end
			elseif inst.activec0 or inst.components.spellpower.current < 30 then
				if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
					inst.sg:GoToState("repelled")
				else
					inst.sg:GoToState("mindcontrolled")
				end
			end

			if inst.level < 430 and not inst.activec0 and inst.components.spellpower.current >= 30 then
				--inst.components.talker:Say("Shield on!!")
				shield_go(inst)
				if inst.components.spellpower then
					inst.components.spellpower:DoDelta(-30)
				end
			elseif inst.level >= 430 and inst.level < 1880 and not inst.activec0 and inst.components.spellpower.current >= 30 then
				--inst.components.talker:Say("Shield on!!")
				shield_go(inst)
				if inst.components.spellpower then
					inst.components.spellpower:DoDelta(-30)
				end
			elseif inst.level >= 1880 and inst.level < 7000 and not inst.activec0 and inst.components.spellpower.current >= 30 then
				--inst.components.talker:Say("Shield on!!")
				shield_go(inst)
				if inst.components.spellpower then
					inst.components.spellpower:DoDelta(-30)
				end
			elseif inst.level >= 7000 and not inst.activec0 and inst.components.spellpower.current >= 30 then
				--inst.components.talker:Say("Shield on!!")
				shield_go(inst)
				if inst.components.spellpower then
					inst.components.spellpower:DoDelta(-30)
				end
			elseif inst.components.spellpower.current < 30 then
				--inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEPY)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SPELLPOWER .. "\n(30)")
			elseif inst.activec0 then
				inst.shield_level1 = false
				inst.shield_level2 = false
				inst.shield_level3 = false
				inst.shield_level4 = false
			end
		elseif inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
		end
	end
end

AddModRPCHandler("musha", "on_shield_act", on_shield_act)

--treasure hunt

function musha_egghunt(inst, data)
	if not inst.yamche_egg_hunted then
		local pos1 = inst:GetPosition()
		local offset1 = FindWalkableOffset(pos1, math.random() * 2 * math.pi, math.random(5, 10), 10)
		if offset1 then --fixd compatibility
			local spawn_pos1 = pos1 + offset1
			local hidden_egg = SpawnPrefab("musha_hidden_egg")
			hidden_egg.Transform:SetPosition(spawn_pos1:Get())
			local puff = SpawnPrefab("small_puff")
			puff.Transform:SetPosition(spawn_pos1:Get())
			local shovel = SpawnPrefab("shovel")
			shovel.Transform:SetPosition(spawn_pos1:Get())
			hidden_egg:SetTreasureHunt()
			inst.yamche_egg_hunted = true
			inst:DoTaskInTime(
				0.5,
				function()
					inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FIRST)
					inst:DoTaskInTime(
						2,
						function()
							inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_YAMCHE)
						end
					)
				end
			)
		elseif not offset1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FAILED)
			inst.treasure = inst.treasure + 99
		end
	end
end

function musha_treasurehunt(inst, isload)
	if not inst.yamche_egg_hunted then
		musha_egghunt(inst)
	elseif inst.yamche_egg_hunted then
		local pos1 = inst:GetPosition()
		local offset1 = FindWalkableOffset(pos1, math.random() * 800 * math.pi, math.random(900, 1000), 500)
		local offset2 = FindWalkableOffset(pos1, math.random() * 200 * math.pi, math.random(250, 300), 180)
		local offset3 = FindWalkableOffset(pos1, math.random() * 3 * math.pi, math.random(25, 30), 18)
		local guard1 = FindWalkableOffset(pos1, math.random() * 1 * math.pi, math.random(1, 3), 1)
		local guard2 = FindWalkableOffset(pos1, math.random() * 1 * math.pi, math.random(1, 2), 2)
		local guard3 = FindWalkableOffset(pos1, math.random() * 1 * math.pi, math.random(1, 1), 3)
		--test
		--[[
if offset3 then
inst.treasure3 = true
inst:DoTaskInTime(0.5, function() inst.components.talker:Say("It is near !!") end)
local spawn_pos3 = pos1 + offset3
local treasure3 = SpawnPrefab("musha_treasure2")
treasure3.Transform:SetPosition(spawn_pos3:Get())
treasure3:SetTreasureHunt()
SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos3:Get())
treasure3:AddTag("treasure")
inst.treasure = inst.treasure + 100 end
]]
		if math.random() < 0.5 and offset1 then
			inst.treasure1 = true
			inst:DoTaskInTime(
				1,
				function()
					inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FAR)
				end
			)
			local spawn_pos1 = pos1 + offset1
			local treasure1 = SpawnPrefab("musha_treasure2")
			treasure1.Transform:SetPosition(spawn_pos1:Get())
			treasure1:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos1:Get())
			--treasure1:AddTag("treasure")
			-- green worm
			if math.random() < 0.5 and guard1 then
				local spawn_pos1_gw = pos1 + offset1 + guard1
				local gworm = SpawnPrefab("greenworm")
				gworm.Transform:SetPosition(spawn_pos1_gw:Get())
				gworm.sg:GoToState("lure_enter")
			end
			-- green fruit
			if math.random() < 0.5 and guard2 then
				local spawn_pos1_gw = pos1 + offset1 + guard2
				local gworm = SpawnPrefab("green_apple_plant")
				gworm.Transform:SetPosition(spawn_pos1_gw:Get())
			end
			if math.random() < 0.25 and guard3 then
				local spawn_pos1_gw = pos1 + offset1 + guard3
				local gworm = SpawnPrefab("green_apple_plant")
				gworm.Transform:SetPosition(spawn_pos1_gw:Get())
			end
		elseif math.random() < 0.6 and not inst.treasure1 and offset2 then
			inst.treasure2 = true
			inst:DoTaskInTime(
				1,
				function()
					inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_MED)
				end
			)
			local spawn_pos2 = pos1 + offset2
			local treasure2 = SpawnPrefab("musha_treasure2")
			treasure2.Transform:SetPosition(spawn_pos2:Get())
			treasure2:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos2:Get())
			--treasure2:AddTag("treasure")
			-- green worm
			if math.random() < 0.55 and guard1 then
				local spawn_pos2_gw = pos1 + offset2 + guard1
				local gworm = SpawnPrefab("greenworm")
				gworm.Transform:SetPosition(spawn_pos2_gw:Get())
				gworm.sg:GoToState("lure_enter")
			end
			-- green fruit
			if math.random() < 0.5 and guard2 then
				local spawn_pos2_gw = pos1 + offset2 + guard2
				local gworm = SpawnPrefab("green_apple_plant")
				gworm.Transform:SetPosition(spawn_pos2_gw:Get())
			end
			-- green fruit
			if math.random() < 0.25 and guard3 then
				local spawn_pos2_gw = pos1 + offset2 + guard3
				local gworm = SpawnPrefab("green_apple_plant")
				gworm.Transform:SetPosition(spawn_pos2_gw:Get())
			end
		elseif not inst.treasure1 and not inst.treasure2 and offset3 then
			inst.treasure3 = true
			inst:DoTaskInTime(
				0.5,
				function()
					inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_NEAR)
				end
			)
			local spawn_pos3 = pos1 + offset3
			local treasure3 = SpawnPrefab("musha_treasure2")
			treasure3.Transform:SetPosition(spawn_pos3:Get())
			treasure3:SetTreasureHunt()
			SpawnPrefab("musha_spore").Transform:SetPosition(spawn_pos3:Get())
			--treasure3.near_treasure = true
			-- green worm
			if math.random() < 0.5 and guard1 then
				local spawn_pos3_gw = pos1 + offset3 + guard1
				local gworm = SpawnPrefab("greenworm")
				gworm.Transform:SetPosition(spawn_pos3_gw:Get())
				gworm.sg:GoToState("lure_enter")
			end
			-- green fruit
			if math.random() < 0.5 and guard2 then
				local spawn_pos3_gw = pos1 + offset3 + guard2
				local gworm = SpawnPrefab("green_apple_plant")
				gworm.Transform:SetPosition(spawn_pos3_gw:Get())
			end
			if math.random() < 0.25 and guard3 then
				local spawn_pos3_gw = pos1 + offset3 + guard3
				local gworm = SpawnPrefab("green_apple_plant")
				gworm.Transform:SetPosition(spawn_pos3_gw:Get())
			end
		elseif not inst.treasure1 and not inst.treasure2 and not inst.treasure3 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FAILED)
			inst.treasure = inst.treasure + 90
		end
		if inst.treasure1 or inst.treasure2 or inst.treasure3 then
			inst.treasure1 = false
			inst.treasure2 = false
			inst.treasure3 = false
		end
	end
end

function on_treasure_hunt(inst)
	if inst.components.playercontroller then
		inst.components.playercontroller:Enable(false)

		--[[	if TheSim:FindFirstEntityWithTag("musha_treasure") then
	local treasures = TheSim:FindFirstEntityWithTag("musha_treasure")
	local x, y, z = treasures.Transform:GetWorldPosition()
	local minimap = TheWorld.minimap.MiniMap
	minimap:ShowArea(x, y, z, 20)
			end]]
		inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_SNIFF)
		local item = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if item then
			inst.sg:GoToState("talk")
			inst.components.inventory:Unequip(EQUIPSLOTS.HANDS, true)
			inst.components.inventory:GiveItem(item)
		end
		inst:DoTaskInTime(
			1.5,
			function()
				inst.components.playercontroller:Enable(false)
				inst.sg:GoToState("peertelescope2")
				inst.components.talker.colour = Vector3(1, 0.85, 0.7, 1)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_FOUND)
				inst:DoTaskInTime(
					3,
					function()
						inst.components.playercontroller:Enable(false)
						inst.sg:GoToState("map")
						inst.components.talker.colour = Vector3(1, 0.85, 0.7, 1)
						inst.components.talker:Say(STRINGS.MUSHA_TALK_TREASURE_MARK)
						inst:DoTaskInTime(
							3.5,
							function()
								inst.components.playercontroller:Enable(true)
								inst.components.talker.colour = Vector3(1, 1, 1, 1)
								musha_treasurehunt(inst)
							end
						)
					end
				)
			end
		)
	end
end

function on_music_act1(inst)
	if inst.components.playercontroller then
		local lightorb = SpawnPrefab("musha_spore2")
		local hounds = SpawnPrefab("ghosthound")
		inst.components.playercontroller:Enable(false)
		inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
		inst.sg:GoToState("play_flute2")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
		inst.entity:AddLight()
		inst.Light:SetRadius(0.5)
		inst.Light:SetFalloff(.75)
		inst.Light:SetIntensity(.1)
		inst.Light:SetColour(90 / 255, 90 / 255, 90 / 255)
		inst.components.health:SetAbsorptionAmount(1)
		inst.music_armor = true
		inst.nsleep = true
		inst.start_music = false
		inst.components.health:SetInvincible(true)
		inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE * 5)
		inst:DoTaskInTime(
			3,
			function()
				inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
				inst.sg:GoToState("play_flute2")
				inst:DoTaskInTime(
					3,
					function()
						inst.sg:GoToState("enter_onemanband")
						inst:DoTaskInTime(
							3,
							function()
								inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
								inst.sg:GoToState("play_flute2")
								inst:DoTaskInTime(
									3,
									function()
										inst.components.playercontroller:Enable(true)
										inst.AnimState:SetBloomEffectHandle("")
										inst.Light:Enable(true) --[[inst.components.talker:Say("[Light Aura] -ON     \n- Sanity Regen UP    \n- Sleep/Tired Regen UP")]]
										lightorb.Transform:SetPosition(inst:GetPosition():Get())
										lightorb.components.follower:SetLeader(inst)
										inst.small_light = true
										inst.lightaura = true
										inst.moondrake_on = true
										inst.sg:GoToState("play_horn2")
										inst.nsleep = false
										SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
										hounds.Transform:SetPosition(inst:GetPosition():Get())
										hounds.Transform:SetPosition(inst:GetPosition():Get())
										hounds.followdog = true --[[hounds.components.follower:SetLeader(inst)]]
										inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE)
										inst.components.sanity:DoDelta(10)
										inst.music_armor = false
										inst.components.health:SetInvincible(false)
										inst:DoTaskInTime(
											180,
											function()
												--[[inst.components.talker:Say("[Light Aura] -OFF")]] inst.small_light = false
												inst.lightaura = false
												inst.moondrake_on = false
												inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
												SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
												inst.components.sanityaura.aura = 0
												inst.Light:SetRadius(0.5)
												inst:DoTaskInTime(
													5,
													function()
														inst.Light:Enable(false)
														inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
													end
												)
											end
										)
									end
								)
							end
						)
					end
				)
			end
		)
	end
end

function on_music_act2(inst)
	if inst.components.playercontroller then
		local lightorb = SpawnPrefab("musha_spore2")
		local shadows = SpawnPrefab("shadowmusha")
		inst.components.playercontroller:Enable(false)
		inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
		inst.sg:GoToState("play_flute2")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
		inst.entity:AddLight()
		inst.Light:SetRadius(0.5)
		inst.Light:SetFalloff(.75)
		inst.Light:SetIntensity(.1)
		inst.Light:SetColour(90 / 255, 90 / 255, 90 / 255)
		inst.components.health:SetAbsorptionAmount(1)
		inst.music_armor = true
		inst.nsleep = true
		inst.start_music = false
		inst.components.health:SetInvincible(true)
		inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE * 5)
		inst:DoTaskInTime(
			3,
			function()
				inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
				inst.sg:GoToState("play_flute2")
				inst:DoTaskInTime(
					3,
					function()
						inst.sg:GoToState("enter_onemanband")
						inst:DoTaskInTime(
							3,
							function()
								inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
								inst.sg:GoToState("play_flute2")
								inst:DoTaskInTime(
									3,
									function()
										inst.sg:GoToState("enter_onemanband")
										inst:DoTaskInTime(
											3,
											function()
												inst.components.playercontroller:Enable(true)
												inst.AnimState:SetBloomEffectHandle("")
												inst.Light:Enable(true) --[[inst.components.talker:Say("[Light Aura] -ON     \n- Sanity Regen UP    \n- Sleep/Tired Regen UP")]]
												lightorb.Transform:SetPosition(inst:GetPosition():Get())
												lightorb.components.follower:SetLeader(inst)
												inst.small_light = true
												inst.lightaura = true
												inst.moondrake_on = true
												inst.sg:GoToState("play_horn2")
												inst.nsleep = false
												SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
												shadows.Transform:SetPosition(inst:GetPosition():Get())
												shadows.followdog = true
												inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE)
												inst.components.sanity:DoDelta(10)
												inst.music_armor = false
												inst.components.health:SetInvincible(false)
												inst:DoTaskInTime(
													180,
													function()
														--[[inst.components.talker:Say("[Light Aura] -OFF")]] inst.small_light = false
														inst.lightaura = false
														inst.moondrake_on = false
														inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
														SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
														inst.components.sanityaura.aura = 0
														inst.Light:SetRadius(0.5)
														inst:DoTaskInTime(
															5,
															function()
																inst.Light:Enable(false)
																inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
															end
														)
													end
												)
											end
										)
									end
								)
							end
						)
					end
				)
			end
		)
	end
end

function on_music_act3(inst)
	if inst.components.playercontroller then
		local lightorb = SpawnPrefab("musha_spore2")
		inst.components.playercontroller:Enable(false)
		inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
		inst.sg:GoToState("play_flute2")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
		inst.entity:AddLight()
		inst.Light:SetRadius(0.5)
		inst.Light:SetFalloff(.75)
		inst.Light:SetIntensity(.1)
		inst.Light:SetColour(90 / 255, 90 / 255, 90 / 255)
		inst.components.health:SetAbsorptionAmount(1)
		inst.music_armor = true
		inst.nsleep = true
		inst.start_music = false
		inst.components.health:SetInvincible(true)
		inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE * 5)
		inst:DoTaskInTime(
			3,
			function()
				inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
				inst.sg:GoToState("play_flute2")
				inst:DoTaskInTime(
					3,
					function()
						inst.sg:GoToState("enter_onemanband")
						inst:DoTaskInTime(
							3,
							function()
								inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
								inst.sg:GoToState("play_flute2")
								inst:DoTaskInTime(
									3,
									function()
										inst.sg:GoToState("enter_onemanband")
										inst:DoTaskInTime(
											3,
											function()
												inst.components.playercontroller:Enable(true)
												inst.AnimState:SetBloomEffectHandle("")
												inst.Light:Enable(true) --[[inst.components.talker:Say("[Light Aura] -ON     \n- Sanity Regen UP    \n- Sleep/Tired Regen UP")]]
												lightorb.Transform:SetPosition(inst:GetPosition():Get())
												lightorb.components.follower:SetLeader(inst)
												inst.small_light = true
												inst.lightaura = true
												inst.moondrake_on = true
												inst.sg:GoToState("play_horn2")
												inst.nsleep = false
												local drakeangle = math.random(1, 360)
												local tentacle_frost0 = SpawnPrefab("tentacle_frost")
												local tentacle_frost1 = SpawnPrefab("tentacle_frost")
												local tentacle_frost2 = SpawnPrefab("tentacle_frost")
												local tentacle_frost3 = SpawnPrefab("tentacle_frost")
												local tentacle_frost4 = SpawnPrefab("tentacle_frost")
												local tentacle_frost5 = SpawnPrefab("tentacle_frost")
												local offset0 =
													FindWalkableOffset(inst:GetPosition(), drakeangle * DEGREES, math.random(2, 8), 30, false, false)
												local offset1 =
													FindWalkableOffset(inst:GetPosition(), drakeangle * DEGREES, math.random(2, 8), 30, false, false)
												local offset2 =
													FindWalkableOffset(inst:GetPosition(), drakeangle * DEGREES, math.random(2, 8), 30, false, false)
												local offset3 =
													FindWalkableOffset(inst:GetPosition(), drakeangle * DEGREES, math.random(2, 8), 30, false, false)
												local offset4 =
													FindWalkableOffset(inst:GetPosition(), drakeangle * DEGREES, math.random(2, 8), 30, false, false)
												local offset5 =
													FindWalkableOffset(inst:GetPosition(), drakeangle * DEGREES, math.random(2, 8), 30, false, false)
												local x, y, z = inst.Transform:GetWorldPosition()
												tentacle_frost0.Transform:SetPosition(x + offset0.x, y + offset0.y, z + offset0.z)
												SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost0:GetPosition():Get())
												inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
												inst:DoTaskInTime(
													3,
													function()
														tentacle_frost1.Transform:SetPosition(x + offset1.x, y + offset1.y, z + offset1.z)
														SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost1:GetPosition():Get())
														tentacle_frost1.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
													end
												)
												inst:DoTaskInTime(
													6,
													function()
														tentacle_frost2.Transform:SetPosition(x + offset2.x, y + offset2.y, z + offset2.z)
														SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost2:GetPosition():Get())
														tentacle_frost2.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
													end
												)
												inst:DoTaskInTime(
													9,
													function()
														tentacle_frost3.Transform:SetPosition(x + offset3.x, y + offset3.y, z + offset3.z)
														SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost3:GetPosition():Get())
														tentacle_frost3.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
													end
												)
												inst:DoTaskInTime(
													12,
													function()
														tentacle_frost4.Transform:SetPosition(x + offset4.x, y + offset4.y, z + offset4.z)
														SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost4:GetPosition():Get())
														tentacle_frost4.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
													end
												)
												inst:DoTaskInTime(
													15,
													function()
														tentacle_frost5.Transform:SetPosition(x + offset5.x, y + offset5.y, z + offset5.z)
														SpawnPrefab("statue_transition").Transform:SetPosition(tentacle_frost5:GetPosition():Get())
														tentacle_frost5.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
													end
												)
												inst.components.sanityaura.aura = (TUNING.SANITYAURA_HUGE)
												inst.components.sanity:DoDelta(10)
												inst.music_armor = false
												inst.components.health:SetInvincible(false)
												inst:DoTaskInTime(
													180,
													function()
														--[[inst.components.talker:Say("[Light Aura] -OFF")]] inst.small_light = false
														inst.lightaura = false
														inst.moondrake_on = false
														inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
														SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
														inst.components.sanityaura.aura = 0
														inst.Light:SetRadius(0.5)
														inst:DoTaskInTime(
															5,
															function()
																inst.Light:Enable(false)
																inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
															end
														)
													end
												)
											end
										)
									end
								)
							end
						)
					end
				)
			end
		)
	end
end

function on_sleep(inst)
	if inst.fberserk or inst.berserks and not inst:HasTag("playerghost") then
		inst.berserks = false
		inst.fberserk = false
		SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
		SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
		if not inst:HasTag("playerghost") then
			if inst.components.hunger.current >= 160 then
				inst.strength = "full"
				if inst.visual_cos then
					inst.AnimState:SetBuild("musha")
				elseif not inst.visual_cos and not inst.change_visual then
					if
						not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and
							not inst.visual_hold4
					 then
						inst.AnimState:SetBuild("musha")
					elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
						inst.AnimState:SetBuild("musha")
					elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
						inst.AnimState:SetBuild("musha_full_k")
					elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
						inst.AnimState:SetBuild("musha_old")
					elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
						inst.AnimState:SetBuild("musha_full_sw2")
					end
				end
			elseif inst.components.hunger.current < 160 then
				inst.strength = "normal"
				if inst.visual_cos then
					inst.AnimState:SetBuild("musha_normal")
				elseif not inst.visual_cos and not inst.change_visual then
					if
						not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and
							not inst.visual_hold4
					 then
						inst.AnimState:SetBuild("musha_normal")
					elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
						inst.AnimState:SetBuild("musha_normal")
					elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
						inst.AnimState:SetBuild("musha_normal_k")
					elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
						inst.AnimState:SetBuild("musha_normal_old")
					elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
						inst.AnimState:SetBuild("musha_normal_sw2")
					end
				end
			end
		end
	end

	inst:RemoveTag("notarget")
	if inst.sneaka or inst.sneak_pang then
		inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
	end
	inst.sneaka = false
	inst.poison_sneaka = false
	inst.sneak_pang = false
	inst.AnimState:SetBloomEffectHandle("")
	inst.switch = false
	inst.active_valkyrie = false

	local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
	if weapon and weapon.components.weapon and weapon:HasTag("musha_items") then
		weapon.components.weapon.stimuli = nil
	end
	inst.components.locomotor:Stop()
	--local bedroll = inst.sg:GoToState("bedroll2")
	--inst.sg:AddStateTag("sleeping")
	inst.sg:AddStateTag("busy")
	--inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw")

	if inst.components.temperature:GetCurrent() < 10 then
		inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_furry", "bedroll_furry")
	else
		inst.AnimState:OverrideSymbol("swap_bedroll", "swap_bedroll_straw", "bedroll_straw")
	end
	if inst.components.health and not inst.components.health:IsDead() then
		--inst.AnimState:PlayAnimation("bedroll")
		inst.sg:GoToState("bedroll2")
		inst:DoTaskInTime(
			2,
			function()
				inst.sleep_on = true
			end
		)
	--inst.sleepheal = inst:DoPeriodicTask(5, function() onsleepheal(inst) end)
	end
end

function on_tiny_sleep(inst)
	if inst.components.health and not inst.components.health:IsDead() then
		if inst.fberserk or inst.berserks and not inst:HasTag("playerghost") then
			inst.berserks = false
			inst.fberserk = false
			SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
			SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
			if not inst:HasTag("playerghost") then
				if inst.components.hunger.current >= 160 then
					inst.strength = "full"
					if inst.visual_cos then
						inst.AnimState:SetBuild("musha")
					elseif not inst.visual_cos and not inst.change_visual then
						if
							not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and
								not inst.visual_hold4
						 then
							inst.AnimState:SetBuild("musha")
						elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
							inst.AnimState:SetBuild("musha")
						elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
							inst.AnimState:SetBuild("musha_full_k")
						elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
							inst.AnimState:SetBuild("musha_old")
						elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
							inst.AnimState:SetBuild("musha_full_sw2")
						end
					end
				elseif inst.components.hunger.current < 160 then
					inst.strength = "normal"
					if inst.visual_cos then
						inst.AnimState:SetBuild("musha_normal")
					elseif not inst.visual_cos and not inst.change_visual then
						if
							not inst.set_on and not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and
								not inst.visual_hold4
						 then
							inst.AnimState:SetBuild("musha_normal")
						elseif inst.set_on and inst.visual_hold and not (inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4) then
							inst.AnimState:SetBuild("musha_normal")
						elseif inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
							inst.AnimState:SetBuild("musha_normal_k")
						elseif inst.set_on and inst.visual_hold3 and not (inst.visual_hold and inst.visual_hold2 and inst.visual_hold4) then
							inst.AnimState:SetBuild("musha_normal_old")
						elseif inst.set_on and inst.visual_hold4 and inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 then
							inst.AnimState:SetBuild("musha_normal_sw2")
						end
					end
				end
			end
		end

		inst:RemoveTag("notarget")
		if inst.sneaka or inst.sneak_pang then
			inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
		end
		inst.sneaka = false
		inst.poison_sneaka = false
		inst.sneak_pang = false
		inst.AnimState:SetBloomEffectHandle("")
		inst.switch = false
		inst.active_valkyrie = false
		inst.berserks = false
		inst.fberserk = false
		local weapon = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
		if weapon and weapon.components.weapon and weapon:HasTag("musha_items") then
			weapon.components.weapon.stimuli = nil
		end
		if not inst:HasTag("playerghost") then
			inst.sg:GoToState("knockout")
			inst.tiny_sleep = true
		elseif inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_SLEEP)
		end
	end
end

function on_wakeup(inst)
	if not inst.music_check and inst.sleep_on then
		inst.sleep_on = false
		inst.sg:GoToState("wakeup")
		inst.entity:AddLight()
		inst.Light:SetRadius(1)
		inst.Light:SetFalloff(.8)
		inst.Light:SetIntensity(.8)
		inst.Light:SetColour(150 / 255, 150 / 255, 150 / 255)
		inst.components.health:SetAbsorptionAmount(1)
		inst.music_armor = true
		inst.Light:Enable(true)
		inst:DoTaskInTime(
			1.5,
			function()
				inst.Light:Enable(false)
				inst.music_armor = false
				inst.musha_press = false
				if inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
					if math.random() < 0.3 then
						inst.AnimState:PushAnimation("mime1", false)
					elseif math.random() < 0.3 then
						inst.AnimState:PushAnimation("mime4", false)
					else
						inst.AnimState:PushAnimation("mime3", false)
					end
				else
					if inst.components.stamina_sleep.current < 99 then
						inst.AnimState:PlayAnimation("yawn")
					elseif inst.components.stamina_sleep.current >= 99 then
						if math.random() < 0.3 then
							inst.AnimState:PlayAnimation("yawn")
						elseif math.random() < 0.3 then
							inst.AnimState:PushAnimation("mime1", false)
						elseif math.random() < 0.3 then
							inst.AnimState:PushAnimation("mime4", false)
						else
							inst.AnimState:PushAnimation("mime3", false)
						end
					end
				end
			end
		)
	elseif not inst.music_check and inst.tiny_sleep then
		--if inst.sleepheal then inst.sleepheal:Cancel() inst.sleepheal = nil end
		inst.tiny_sleep = false
		inst.sg:GoToState("wakeup")
		inst.entity:AddLight()
		inst.Light:SetRadius(1)
		inst.Light:SetFalloff(.8)
		inst.Light:SetIntensity(.8)
		inst.Light:SetColour(150 / 255, 150 / 255, 150 / 255)
		inst.components.health:SetAbsorptionAmount(1)
		inst.music_armor = true
		inst.Light:Enable(true)
		inst:DoTaskInTime(
			3.1,
			function()
				inst.Light:Enable(false)
				inst.music_armor = false
				--inst.sg:GoToState("yawn")
				inst.musha_press = false

				if inst.set_on and inst.visual_hold2 and not (inst.visual_hold and inst.visual_hold3 and inst.visual_hold4) then
					if math.random() < 0.3 then
						inst.AnimState:PushAnimation("mime1", false)
					elseif math.random() < 0.3 then
						inst.AnimState:PushAnimation("mime4", false)
					else
						inst.AnimState:PushAnimation("mime3", false)
					end
				else
					inst.AnimState:PlayAnimation("yawn")
				end

				--inst.AnimState:PlayAnimation("yawn")
			end
		)
	elseif inst.music_check then
		inst.components.playercontroller:Enable(false)
		inst.sleep_on = false
		inst.tiny_sleep = false
		--inst.sg.statemem.iswaking = true
		inst.sg:GoToState("wakeup")
		inst.entity:AddLight()
		inst.Light:SetRadius(1)
		inst.Light:SetFalloff(.8)
		inst.Light:SetIntensity(.8)
		inst.Light:SetColour(150 / 255, 150 / 255, 150 / 255)
		inst.components.health:SetAbsorptionAmount(1)
		--inst.music_armor = true
		inst.Light:Enable(true)
		inst.AnimState:SetBloomEffectHandle("")
		inst.music_check = false
		inst.switlight = true
		inst:DoTaskInTime(
			2,
			function()
				inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_READY)
				inst.sg:GoToState("play_flute2")
				inst.Light:Enable(false)
				inst.music_armor = false
				inst.music_check = false
				inst.AnimState:SetBloomEffectHandle("")
				inst.SoundEmitter:PlaySound("dontstarve/wilson/onemanband")
				inst.musha_press = false
				inst.components.playercontroller:Enable(true)
			end
		)
	end
end

function on_buff_act(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		local performance0 = 1
		local performance1 = 0.25
		local performance2 = 0.3
		local performance3 = 0.1
		local performance4 = 0.15
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_RIDE)
		else
			inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_RIDE)
			if inst.treasure_sniffs then
				on_treasure_hunt(inst)
				inst.treasure = inst.treasure * 0
				inst.treasure_sniffs = false
			elseif not inst.treasure_sniffs then
				if
					inst.switlight and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and
						not inst.start_music
				 then
					inst.start_music = true
					inst.music = inst.music * 0
					inst.switlight = false
					if math.random() < 0.5 then
						inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE .. "1")
						on_music_act1(inst)
					elseif math.random() < 0.3 then
						inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE .. "2")
						on_music_act2(inst)
					elseif math.random() < 0.15 then
						inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE .. "3")
						on_music_act3(inst)
					else
						inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_TYPE .. "4")
						on_music_act1(inst)
					end
				elseif
					not inst.switlight and not inst.sleep_on and not inst.components.health:IsDead() and not inst:HasTag("playerghost")
				 then
					if inst.music < 100 then
						inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEP)
					elseif inst.music >= 100 then
						inst.components.talker:Say(STRINGS.MUSHA_TALK_MUSIC_READY)
						inst.switlight = true
					end
				elseif inst.components.health:IsDead() or inst:HasTag("playerghost") then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_MUSIC)
				end
			----inst.components.talker.colour = Vector3(1, 0.85, 0.75, 1)
			end
		end
	end
end
AddModRPCHandler("musha", "buff", on_buff_act)

function on_sleeping(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if
		not inst.writing and not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and
			not inst:HasTag("playerghost") and
			not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and
			inst.components.stamina_sleep.current >= 90
	 then
		if TheWorld.state.isday and not inst.tiny_sleep then
			if math.random() < 0.2 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_1)
			elseif math.random() < 0.2 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_2)
			elseif math.random() < 0.2 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_3)
			elseif math.random() < 0.2 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_4)
			else
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_5)
			end
		elseif TheWorld.state.isday and inst.tiny_sleep and not inst.musha_press then
			inst.musha_press = true
			on_wakeup(inst)
		end
	elseif
		not inst.writing and not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and
			not inst:HasTag("playerghost") and
			not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and
			inst.components.stamina_sleep.current < 90
	 then
		if TheWorld.state.isday and not inst.tiny_sleep then
			if (inst.warm_on or inst.warm_tent) then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NO_3)
			end
			if inst.components.stamina_sleep.current >= 40 and not (inst.warm_on or inst.warm_tent) then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_1)
			elseif
				inst.components.stamina_sleep.current < 40 and inst.components.stamina_sleep.current >= 25 and
					not (inst.warm_on or inst.warm_tent)
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_2)
			elseif
				inst.components.stamina_sleep.current < 25 and inst.components.stamina_sleep.current >= 5 and
					not (inst.warm_on or inst.warm_tent)
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_3)
			elseif inst.components.stamina_sleep.current < 5 and not (inst.warm_on or inst.warm_tent) then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_4)
			end
			inst:DoTaskInTime(
				1,
				function()
					on_tiny_sleep(inst)
				end
			)
			inst.sg:AddStateTag("busy")
		elseif TheWorld.state.isday and inst.tiny_sleep and not inst.musha_press then
			inst.musha_press = true
			on_wakeup(inst)
		end
	end
	if
		not inst.writing and not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and
			not inst:HasTag("playerghost") and
			not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and
			not TheWorld.state.isday and
			not inst.sleep_on and
			not inst.tiny_sleep and
			not inst.nsleep and
			not (inst.warm_on or inst.warm_tent)
	 then
		if not TheWorld.state.isnight then
			if inst.components.stamina_sleep.current >= 40 and not (inst.warm_on or inst.warm_tent) then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_1)
			elseif
				inst.components.stamina_sleep.current < 40 and inst.components.stamina_sleep.current >= 25 and
					not (inst.warm_on or inst.warm_tent)
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_2)
			elseif
				inst.components.stamina_sleep.current < 25 and inst.components.stamina_sleep.current >= 5 and
					not (inst.warm_on or inst.warm_tent)
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_3)
			elseif inst.components.stamina_sleep.current < 5 and not (inst.warm_on or inst.warm_tent) then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_4)
			end
			inst:DoTaskInTime(
				1,
				function()
					on_tiny_sleep(inst)
				end
			)
			inst.sg:AddStateTag("busy")
		elseif TheWorld.state.isnight then
			local random1 = 0.2
			local last = 1
			if not inst.LightWatcher:IsInLight() then
				if math.random() < random1 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_1)
				elseif math.random() < random1 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_2)
				elseif math.random() < random1 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_3)
				elseif math.random() < random1 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_4)
				elseif math.random() <= last then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_NEED_LIGHT_5)
				end
			elseif inst.LightWatcher:IsInLight() then
				if inst.components.stamina_sleep.current >= 40 and not (inst.warm_on or inst.warm_tent) then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_1)
				elseif
					inst.components.stamina_sleep.current < 40 and inst.components.stamina_sleep.current >= 25 and
						not (inst.warm_on or inst.warm_tent)
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_2)
				elseif
					inst.components.stamina_sleep.current < 25 and inst.components.stamina_sleep.current >= 5 and
						not (inst.warm_on or inst.warm_tent)
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_3)
				elseif inst.components.stamina_sleep.current < 5 and not (inst.warm_on or inst.warm_tent) then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DIZZY_4)
				end
				inst:DoTaskInTime(
					1,
					function()
						on_tiny_sleep(inst)
					end
				)
			end
		end
	elseif
		not inst.components.health:IsDead() and not inst.sleep_on and not inst.components.health:IsDead() and
			not inst:HasTag("playerghost") and
			not (inst.sg:HasStateTag("moving") or inst.sg:HasStateTag("attack")) and
			not TheWorld.state.isday and
			not inst.sleep_on and
			not inst.tiny_sleep and
			not inst.nsleep and
			(inst.warm_on or inst.warm_tent) and
			not inst.sleep_no
	 then
		local random1 = 0.2
		if math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_1)
		elseif math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_2)
		elseif math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_3)
		elseif math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD_4)
		else
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_GOOD)
		end
		on_sleep(inst)
	elseif
		not TheWorld.state.isday and not inst.sleep_on and not inst.tiny_sleep and not inst.nsleep and
			(inst.warm_on or inst.warm_tent) and
			inst.sleep_no
	 then
		local random1 = 0.2
		if math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_1)
		elseif math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_2)
		elseif math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_3)
		elseif math.random() < random1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_4)
		elseif math.random() <= 1 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SLEEP_DANGER_5)
		end
	elseif
		not inst.components.health:IsDead() and (inst.sleep_on or inst.tiny_sleep) and not inst.nsleep and
			not inst:HasTag("playerghost") and
			not inst.musha_press
	 then
		inst.musha_press = true
		on_wakeup(inst)
	elseif inst.components.health:IsDead() or inst:HasTag("playerghost") then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
	end
	----inst.components.talker.colour = Vector3(1, 0.85, 0.75, 1)
end
--end
AddModRPCHandler("musha", "sleeping", on_sleeping)

---------------------moon tree

function dall_update(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 25, {"dall"})
	for k, v in pairs(ents) do
		if
			inst.follow_dall and v.components.follower and not v.components.follower.leader and
				not inst.components.leader:IsFollower(v) and
				inst.components.leader:CountFollowers("dall") == 0
		 then
			if not v.onsleep then
				--			if emote ~= nil then
				--				MushaCommands.RunTextUserCommand(emote, inst, false)
				--			end
				inst.components.leader:AddFollower(v)
				v.yamche = true
				v.sleep_on = false
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_FOLLOW)
				local emote = "happy"
			elseif v.onsleep then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_SLEEPY)
			end
		elseif
			not inst.follow_dall and v.components.follower and v.components.follower.leader and
				inst.components.leader:IsFollower(v) and
				inst.components.leader:CountFollowers("dall") == 1
		 then
			if not v.onsleep then
				v.yamche = true
				v.sleep_on = true
				inst.components.leader:RemoveFollowersByTag("dall")
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_STAY)
			elseif v.onsleep then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_SLEEPY)
			end
		end
	end
end

function order_dall(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		if
			inst.dall_follow and not inst.follow_dall and not inst.components.health:IsDead() and not inst:HasTag("playerghost")
		 then
			inst.follow_dall = true
			dall_update(inst)
		elseif
			inst.dall_follow and inst.follow_dall and not inst.components.health:IsDead() and not inst:HasTag("playerghost")
		 then
			inst.follow_dall = false
			inst.dall_follow = false
			dall_update(inst)
		elseif not inst.dall_follow and not inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_DALL_LOST)
		elseif inst.dall_follow and not inst.follow_dall and inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_FOLLOW)
			inst.follow_dall = true
			dall_update(inst)
		elseif inst.dall_follow and inst.follow_dall and inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STAY)
			inst.follow_dall = false
			inst.dall_follow = false
			dall_update(inst)
		elseif not inst.dall_follow and inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
		end
	end
end

AddModRPCHandler("musha", "dall", order_dall)
-----pet

---------------------arong

function arong_update(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 25, {"Arongb"})
	for k, v in pairs(ents) do
		if
			inst.follow_arong and v.components.follower and not v.components.follower.leader and
				not inst.components.leader:IsFollower(v) and
				inst.components.leader:CountFollowers("Arongb") == 0
		 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_FOLLOW)
			local emote = "happy"
			--			if emote ~= nil then
			--				MushaCommands.RunTextUserCommand(emote, inst, false)
			--			end
			inst.components.leader:AddFollower(v)
			v.yamche = true
			v.mount = true
			v.sleep_on = false
			v.follow = true
		elseif
			not inst.follow_arong and v.components.follower and v.components.follower.leader and
				inst.components.leader:IsFollower(v) and
				inst.components.leader:CountFollowers("Arongb") == 1
		 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_STAY)

			v.yamche = true
			v.active_hunt = false
			v.mount = false
			v.sleep_on = true
			v.follow = false
			inst.components.leader:RemoveFollowersByTag("Arongb")
		end
	end
end

function order_arong(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		if
			inst.arong_follow and not inst.follow_arong and not inst.components.health:IsDead() and
				not inst:HasTag("playerghost")
		 then
			inst.follow_arong = true
			arong_update(inst)
		elseif
			inst.arong_follow and inst.follow_arong and not inst.components.health:IsDead() and not inst:HasTag("playerghost")
		 then
			inst.follow_arong = false
			inst.arong_follow = false
			arong_update(inst)
		elseif not inst.arong_follow and not inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_LOST)
		elseif inst.arong_follow and not inst.follow_arong and inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_FOLLOW)
			inst.follow_arong = true
			arong_update(inst)
		elseif inst.arong_follow and inst.follow_arong and inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STAY)
			inst.follow_arong = false
			inst.arong_follow = false
			arong_update(inst)
		elseif not inst.arong_follow and inst:HasTag("playerghost") then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOH)
		end
	end
end

AddModRPCHandler("musha", "arong", order_arong)

-----------------------------

--sneak attack --hide in shadow

function on_Sneak_pang(inst, data)
	local other = data.target
	if not other:HasTag("smashable") and not other:HasTag("shadowminion") and not other:HasTag("alignwall") then
		if not inst.sneaka and inst.sneak_pang then
			inst.components.sanity:DoDelta(50)
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_UNHIDE)
			inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)

			inst:RemoveTag("notarget")
			inst.sneaka = false
			if inst.poison_sneaka then
				inst.poison_sneaka = false
				inst.components.sanity:DoDelta(10)
			end
			inst.sneak_pang = false
		elseif
			inst.sneaka and inst.sneak_pang and
				(other:HasTag("no_target") or other:HasTag("structure") or other:HasTag("wall") or other:HasTag("pillarretracting") or
					other:HasTag("tentacle_pillar") or
					other:HasTag("arm") or
					other:HasTag("shadow")) and
				not other.components.locomotor
		 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_NO_TARGET)
			inst.components.sanity:DoDelta(50)
			--inst.components.talker:Say("Unhide !")
			inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)

			inst:RemoveTag("notarget")
			inst.sneaka = false
			if inst.poison_sneaka then
				inst.poison_sneaka = false
				inst.components.sanity:DoDelta(10)
			end
			inst.sneak_pang = false
		elseif
			inst.sneaka and inst.sneak_pang and
				not (other:HasTag("no_target") or other:HasTag("structure") or other:HasTag("wall") or
					other:HasTag("pillarretracting") or
					other:HasTag("tentacle_pillar") or
					other:HasTag("arm") or
					other:HasTag("shadow")) and
				other.components.locomotor
		 then
			if
				not other.sg:HasStateTag("attack") and not other.sg:HasStateTag("shield") and not other.sg:HasStateTag("moving") and
					not other.sg:HasStateTag("frozen")
			 then
				inst.components.sanity:DoDelta(50)
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)

				if inst.level >= 50 and inst.level < 429 then --5
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\nLV(1)")
					other.components.health:DoDelta(-300)
				elseif inst.level >= 430 and inst.level < 1029 then --10
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\nLV(2)")
					other.components.health:DoDelta(-400)
				elseif inst.level >= 1030 and inst.level < 1879 then --15
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\nLV(3)")
					other.components.health:DoDelta(-500)
				elseif inst.level >= 1880 and inst.level < 3199 then --20
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\nLV(4)")
					other.components.health:DoDelta(-600)
				elseif inst.level >= 3200 and inst.level < 6999 then --25
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\nLV(5)")
					other.components.health:DoDelta(-700)
				elseif inst.level >= 7000 then --30
					inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\nLV(6)")
					other.components.health:DoDelta(-800)
				end

				inst.switch = false
				inst.components.combat:SetRange(2)

				local dark1 = SpawnPrefab("statue_transition")
				local pos = Vector3(other.Transform:GetWorldPosition())
				dark1.Transform:SetPosition(pos:Get())
				dark1.Transform:SetScale(0.5, 4, 0.5)
				local fx = SpawnPrefab("explode_small")
				local pos = Vector3(other.Transform:GetWorldPosition())
				fx.Transform:SetPosition(pos:Get())
				inst:RemoveTag("notarget")
				inst.sneak_pang = false
				inst.sneaka = false
				inst:RemoveEventCallback("onhitother", on_Sneak_pang)
			elseif other.sg:HasStateTag("frozen") then
				inst.components.sanity:DoDelta(50)
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SUCCESS .. "\n" .. STRINGS.MUSHA_TALK_SNEAK_FROZEN)
				if inst.level >= 50 and inst.level < 429 then --5
					other.components.health:DoDelta(-150)
				elseif inst.level >= 430 and inst.level < 1029 then --10
					other.components.health:DoDelta(-200)
				elseif inst.level >= 1030 and inst.level < 1879 then --15
					other.components.health:DoDelta(-250)
				elseif inst.level >= 1880 and inst.level < 3199 then --20
					other.components.health:DoDelta(-300)
				elseif inst.level >= 3200 and inst.level < 6999 then --25
					other.components.health:DoDelta(-350)
				elseif inst.level >= 7000 then --30
					other.components.health:DoDelta(-400)
				end
				local dark1 = SpawnPrefab("statue_transition")
				local pos = Vector3(other.Transform:GetWorldPosition())
				dark1.Transform:SetPosition(pos:Get())
				dark1.Transform:SetScale(0.5, 4, 0.5)
				local fx = SpawnPrefab("explode_small")
				local pos = Vector3(other.Transform:GetWorldPosition())
				fx.Transform:SetPosition(pos:Get())
				inst:RemoveTag("notarget")
				inst.sneak_pang = false
				inst.sneaka = false
				inst:RemoveEventCallback("onhitother", on_Sneak_pang)
			elseif
				other.sg:HasStateTag("attack") or other.sg:HasStateTag("shield") or
					other.sg:HasStateTag("moving") and not other.sg:HasStateTag("frozen")
			 then
				inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_FAILED)
				local fx = SpawnPrefab("splash")
				local pos = Vector3(other.Transform:GetWorldPosition())
				fx.Transform:SetPosition(pos:Get())
				inst:RemoveTag("notarget")
				inst.sneak_pang = false
				inst.sneaka = false
				inst:RemoveEventCallback("onhitother", on_Sneak_pang)
			--inst:DoTaskInTime(0.5, function() on_tiny_sleep(inst) end)
			end
			if inst.poison_sneaka then
				inst.poison_sneaka = false
				if other.components.health and not other.components.health:IsDead() and other.components.combat then
					local shadowbomb = SpawnPrefab("shadowbomb")
					if shadowbomb then
						shadowbomb.entity:SetParent(other.entity)
						local follower = shadowbomb.entity:AddFollower()
						if not other:HasTag("cavedweller") then
							follower:FollowSymbol(other.GUID, other.components.combat.hiteffectsymbol, 0, -200, 0.5)
						else
							follower:FollowSymbol(other.GUID, "body", 0, -200, 0.5)
						end
					end
				else
					local cloud = SpawnPrefab("sporecloud2")
					cloud.Transform:SetPosition(other:GetPosition():Get())
					cloud:FadeInImmediately()
				end
			end
		end
	end
end

function hide_discorved(inst, data)
	if inst.sneak_pang then
		inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
		inst.sneak_pang = false
		inst.sneaka = false
		inst.poison_sneaka = false
		inst:RemoveTag("notarget")
		local fx = SpawnPrefab("statue_transition_2")
		fx.entity:SetParent(inst.entity)
		fx.Transform:SetScale(1.2, 1.2, 1.2)
		fx.Transform:SetPosition(0, 0, 0.5)
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_ATTACKED)
		inst:RemoveEventCallback("onhitother", on_Sneak_pang)
		inst:RemoveEventCallback("attacked", hide_discorved)
	end
end

function HideIn(inst)
	if inst.level < 50 then
		inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_NEED_EXP)
		if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
			inst.sg:GoToState("repelled")
		else
			inst.sg:GoToState("mindcontrolled")
		end
	elseif inst.level >= 50 then
		if not inst.sneak_pang and inst.components.sanity.current >= 50 and inst.components.stamina_sleep.current >= 30 then
			if inst.level >= 50 and inst.level < 429 then --5
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE .. "(LV1)")
			elseif inst.level >= 430 and inst.level < 1029 then --10
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE .. "(LV2)")
			elseif inst.level >= 1030 and inst.level < 1879 then --15
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE .. "(LV3)")
			elseif inst.level >= 1880 and inst.level < 3199 then --20
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE .. "(LV4)")
			elseif inst.level >= 3200 and inst.level < 6999 then --25
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE .. "(LV5)")
			elseif inst.level >= 7000 then --30
				inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_HIDE .. "(LV6)")
			end
			inst.components.sanity:DoDelta(-50)
			inst.sneak_pang = true
			inst.components.colourtweener:StartTween({0.3, 0.3, 0.3, 1}, 0)
			local fx = SpawnPrefab("statue_transition_2")
			fx.entity:SetParent(inst.entity)
			fx.Transform:SetScale(1.2, 1.2, 1.2)
			fx.Transform:SetPosition(0, 0, 0.5)

			inst:DoTaskInTime(
				4,
				function()
					if inst.sneak_pang then
						inst.sneaka = true
						inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_SHADOW)
						local fx = SpawnPrefab("stalker_shield_musha")
						fx.Transform:SetScale(0.5, 0.5, 0.5)
						fx.Transform:SetPosition(inst:GetPosition():Get())
						if not inst:HasTag("notarget") then
							inst:AddTag("notarget")
						end
						SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
						inst.components.colourtweener:StartTween({0.1, 0.1, 0.1, 1}, 0)
						inst.in_shadow = true
						InShadow(inst)
					end
				end
			)

			inst:ListenForEvent("onhitother", on_Sneak_pang)
			inst:ListenForEvent("attacked", hide_discorved)
		elseif not inst.sneak_pang and inst.components.sanity.current < 50 and inst.components.stamina_sleep.current >= 30 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SANITY)
			if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
				inst.sg:GoToState("repelled")
			else
				inst.sg:GoToState("mindcontrolled")
			end
		elseif not inst.sneak_pang and inst.components.sanity.current > 50 and inst.components.stamina_sleep.current < 30 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEPY)
			if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
				inst.sg:GoToState("repelled")
			else
				inst.sg:GoToState("mindcontrolled")
			end
		elseif not inst.sneak_pang and inst.components.sanity.current < 50 and inst.components.stamina_sleep.current < 30 then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_NEED_SLEEP)
			if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
				inst.sg:GoToState("repelled")
			else
				inst.sg:GoToState("mindcontrolled")
			end
		elseif inst.sneak_pang then
			inst.components.talker:Say(STRINGS.MUSHA_TALK_SNEAK_UNHIDE)
			inst.components.colourtweener:StartTween({1, 1, 1, 1}, 0)
			local fx = SpawnPrefab("statue_transition_2")
			fx.entity:SetParent(inst.entity)
			fx.Transform:SetScale(1.2, 1.2, 1.2)
			fx.Transform:SetPosition(0, 0, 0.5)
			inst.components.sanity:DoDelta(50)
			inst.sneak_pang = false
			inst.sneaka = false
			inst.poison_sneaka = false
			inst:RemoveTag("notarget")
			inst:RemoveEventCallback("onhitother", on_Sneak_pang)
			inst:RemoveEventCallback("attacked", hide_discorved)
		end
	end
end
AddModRPCHandler("musha", "shadows", HideIn)

--specific
--[[
local function BabyPostInit(inst)
	if not inst.components.characterspecific then
		inst:AddComponent("characterspecific")	end
	inst.components.characterspecific:SetOwner("musha")
	inst.components.characterspecific:SetStorable(false)
	inst.components.characterspecific:SetComment("Phoenix seems difficult to tame..")

	return inst
end
AddPrefabPostInit("musha_small", BabyPostInit) 
]]
-----------------------------------------------
-----------------------------------------------
local function visual_cos(inst)
	----------------------------------------------
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing and not inst.visual_cos then
		inst.musha_full = false
		inst.musha_normal = false
		inst.musha_battle = false
		inst.musha_hunger = false

		inst.visual_cos = true
		inst.components.talker:Say(STRINGS.MUSHA_VISUAL_BASE)
		inst.soundsname = "willow"
		inst.set_on = false
		inst.visual_hold = false

		inst.visual_hold2 = false
		inst.visual_hold3 = false
		inst.visual_hold4 = false
		inst.full_hold = false
		inst.normal_hold = false
		inst.valkyrie_hold = false
		inst.berserk_hold = false
		inst.hold_old1 = false
		inst.hold_old2 = false
		inst.hold_old3 = false
		inst.hold_old4 = false
		inst.hold_old5 = false
		inst.hold_old6 = false
		inst.hold_old7 = false
		inst.hold_old8 = false
		inst.full_k_hold = false
		inst.normal_k_hold = false
		inst.valkyrie_k_hold = false
		inst.berserk_k_hold = false
		inst.willow = false
		inst.wigfred = false
		inst.change_visual = false
	end

	inst.visual_cos = false
end

AddModRPCHandler("musha", "visual_cos", visual_cos)

AddModRPCHandler("musha", "visual_human", visual_human)

-----------------------------------------------
local function visual_hold(inst)
	----------------------------------------------
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing and not inst:HasTag("playerghost") then
		if not inst.visual_cos then
			inst.musha_full = false
			inst.musha_normal = false
			inst.musha_battle = false
			inst.musha_hunger = false
			if not inst.willow and not inst.wigfred then
				inst.change_visual = true
				inst.willow = true
				inst.components.talker:Say("[Visual] : Willow \nCancel(O)key")
				inst.AnimState:SetBuild("Willow")
				inst.wigfred = false
			elseif inst.willow and not inst.wigfred then
				inst.change_visual = true
				inst.willow = true
				inst.components.talker:Say("[Visual] : Wigfred \nCancel(O)key")
				inst.AnimState:SetBuild("wathgrithr")
				inst.wigfred = true
			elseif inst.willow and inst.wigfred then
				inst.change_visual = false
				if
					not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						not inst.full_hold and
						not inst.normal_hold and
						not inst.berserk_hold and
						not inst.valkyrie_hold and
						not inst.hold_old1 and
						not inst.hold_old2 and
						not inst.hold_old3 and
						not inst.hold_old4 and
						not inst.hold_old5 and
						not inst.hold_old6 and
						not inst.hold_old7 and
						not inst.hold_old8 and
						not inst.full_k_hold and
						not inst.normal_k_hold and
						not inst.valkyrie_k_hold and
						not inst.berserk_k_hold
				 then
					--inst.AnimState:SetBuild("musha")
					inst.components.talker:Say("Change Appearance\nCancel(O)key\nVisual:[Auto] SET 1")
					inst.set_on = true
					inst.visual_hold = true
					inst.visual_hold2 = false
					inst.visual_hold3 = false
					inst.visual_hold4 = false
					inst.full_hold = false
					inst.normal_hold = false
					inst.valkyrie_hold = false
					inst.berserk_hold = false
					inst.hold_old1 = false
					inst.hold_old2 = false
					inst.hold_old3 = false
					inst.hold_old4 = false
					inst.hold_old5 = false
					inst.hold_old6 = false
					inst.hold_old7 = false
					inst.hold_old8 = false
					inst.full_k_hold = false
					inst.normal_k_hold = false
					inst.valkyrie_k_hold = false
					inst.berserk_k_hold = false
				elseif
					inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						not inst.full_hold and
						not inst.normal_hold and
						not inst.berserk_hold and
						not inst.valkyrie_hold and
						not inst.hold_old1 and
						not inst.hold_old2 and
						not inst.hold_old3 and
						not inst.hold_old4 and
						not inst.hold_old5 and
						not inst.hold_old6 and
						not inst.hold_old7 and
						not inst.hold_old8 and
						not inst.full_k_hold and
						not inst.normal_k_hold and
						not inst.valkyrie_k_hold and
						not inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 2")
					inst.set_on = true
					inst.visual_hold = false
					inst.visual_hold2 = true
					inst.visual_hold3 = false
					inst.visual_hold4 = false
					inst.full_hold = false
					inst.normal_hold = false
					inst.valkyrie_hold = false
					inst.berserk_hold = false
					inst.hold_old1 = false
					inst.hold_old2 = false
					inst.hold_old3 = false
					inst.hold_old4 = false
					inst.hold_old5 = false
					inst.hold_old6 = false
					inst.hold_old7 = false
					inst.hold_old8 = false
					inst.full_k_hold = false
					inst.normal_k_hold = false
					inst.valkyrie_k_hold = false
					inst.berserk_k_hold = false
				elseif
					not inst.visual_hold and inst.visual_hold2 and not inst.visual_hold3 and not inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						not inst.full_hold and
						not inst.normal_hold and
						not inst.berserk_hold and
						not inst.valkyrie_hold and
						not inst.hold_old1 and
						not inst.hold_old2 and
						not inst.hold_old3 and
						not inst.hold_old4 and
						not inst.hold_old5 and
						not inst.hold_old6 and
						not inst.hold_old7 and
						not inst.hold_old8 and
						not inst.full_k_hold and
						not inst.normal_k_hold and
						not inst.valkyrie_k_hold and
						not inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 3")
					inst.set_on = true
					inst.visual_hold = false
					inst.visual_hold2 = false
					inst.visual_hold3 = true
					inst.visual_hold4 = false
					inst.full_hold = false
					inst.normal_hold = false
					inst.valkyrie_hold = false
					inst.berserk_hold = false
					inst.hold_old1 = false
					inst.hold_old2 = false
					inst.hold_old3 = false
					inst.hold_old4 = false
					inst.hold_old5 = false
					inst.hold_old6 = false
					inst.hold_old7 = false
					inst.hold_old8 = false
					inst.full_k_hold = false
					inst.normal_k_hold = false
					inst.valkyrie_k_hold = false
					inst.berserk_k_hold = false
				elseif
					not inst.visual_hold and not inst.visual_hold2 and inst.visual_hold3 and not inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						not inst.full_hold and
						not inst.normal_hold and
						not inst.berserk_hold and
						not inst.valkyrie_hold and
						not inst.hold_old1 and
						not inst.hold_old2 and
						not inst.hold_old3 and
						not inst.hold_old4 and
						not inst.hold_old5 and
						not inst.hold_old6 and
						not inst.hold_old7 and
						not inst.hold_old8 and
						not inst.full_k_hold and
						not inst.normal_k_hold and
						not inst.valkyrie_k_hold and
						not inst.berserk_k_hold
				 then
					--[[
elseif not inst.visual_hold and not inst.visual_hold2 and not inst.visual_hold3 and inst.visual_hold4 and not inst.components.health:IsDead() and not inst:HasTag("playerghost") and not inst.full_hold and not inst.normal_hold and not inst.berserk_hold and not inst.valkyrie_hold and not inst.hold_old1 and not inst.hold_old2 and not inst.hold_old3 and not inst.hold_old4 and not inst.hold_old5 and not inst.hold_old6 and not inst.hold_old7 and not inst.hold_old8 and not inst.full_k_hold and not inst.normal_k_hold and not inst.valkyrie_k_hold and not inst.berserk_k_hold then
inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 5")
inst.visual_hold = true
inst.visual_hold2 = true
inst.visual_hold3 = true
inst.visual_hold4 = true
inst.full_hold = false
inst.normal_hold = false
inst.valkyrie_hold = false
inst.berserk_hold = false
inst.hold_old1 = false
inst.hold_old2 = false
inst.hold_old3 = false
inst.hold_old4 = false
inst.hold_old5 = false
inst.hold_old6 = false
inst.hold_old7 = false
inst.hold_old8 = false
inst.full_k_hold = false
inst.normal_k_hold = false
inst.valkyrie_k_hold = false
inst.berserk_k_hold = false
]]
					----------------------------------------------
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Auto] SET 4")
					inst.set_on = true
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = false
					inst.normal_hold = false
					inst.valkyrie_hold = false
					inst.berserk_hold = false
					inst.hold_old1 = false
					inst.hold_old2 = false
					inst.hold_old3 = false
					inst.hold_old4 = false
					inst.hold_old5 = false
					inst.hold_old6 = false
					inst.hold_old7 = false
					inst.hold_old8 = false
					inst.full_k_hold = false
					inst.normal_k_hold = false
					inst.valkyrie_k_hold = false
					inst.berserk_k_hold = false
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						not inst.full_hold and
						not inst.normal_hold and
						not inst.berserk_hold and
						not inst.valkyrie_hold and
						not inst.hold_old1 and
						not inst.hold_old2 and
						not inst.hold_old3 and
						not inst.hold_old4 and
						not inst.hold_old5 and
						not inst.hold_old6 and
						not inst.hold_old7 and
						not inst.hold_old8 and
						not inst.full_k_hold and
						not inst.normal_k_hold and
						not inst.valkyrie_k_hold and
						not inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Full]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = false
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						not inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Normal]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = false
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_normal")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						not inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Valkyrie]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = false
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true

					inst.AnimState:SetBuild("musha_battle")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						not inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Berserk]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = false
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_hunger")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						not inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 1]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = false
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_old")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						not inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 2]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = false
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_normal_old")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						not inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 3]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = false
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_battle_old")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						not inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 4]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = false
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_hunger_old")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						not inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 5]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = false
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_full_sw2")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						not inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 6]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = false
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_normal_sw2")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						not inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 7]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = false
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true
					inst.AnimState:SetBuild("musha_battle_sw2")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						not inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 8]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = false
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true

					inst.AnimState:SetBuild("musha_hunger_sw2")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						not inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 9]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = false
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true

					inst.AnimState:SetBuild("musha_full_k")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						not inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 10]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = false
					inst.berserk_k_hold = true

					inst.AnimState:SetBuild("musha_normal_k")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						not inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 11]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = false

					inst.AnimState:SetBuild("musha_battle_k")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						not inst.berserk_k_hold
				 then
					inst.components.talker:Say("Change Appearance\nCancel(O)key \nVisual:[Change Appearance 12]")
					inst.set_on = false
					inst.visual_hold = true
					inst.visual_hold2 = true
					inst.visual_hold3 = true
					inst.visual_hold4 = true
					inst.full_hold = true
					inst.normal_hold = true
					inst.valkyrie_hold = true
					inst.berserk_hold = true
					inst.hold_old1 = true
					inst.hold_old2 = true
					inst.hold_old3 = true
					inst.hold_old4 = true
					inst.hold_old5 = true
					inst.hold_old6 = true
					inst.hold_old7 = true
					inst.hold_old8 = true
					inst.full_k_hold = true
					inst.normal_k_hold = true
					inst.valkyrie_k_hold = true
					inst.berserk_k_hold = true

					inst.AnimState:SetBuild("musha_hunger_k")
				elseif
					inst.visual_hold and inst.visual_hold2 and inst.visual_hold3 and inst.visual_hold4 and
						not inst.components.health:IsDead() and
						not inst:HasTag("playerghost") and
						inst.full_hold and
						inst.normal_hold and
						inst.valkyrie_hold and
						inst.berserk_hold and
						inst.hold_old1 and
						inst.hold_old2 and
						inst.hold_old3 and
						inst.hold_old4 and
						inst.hold_old5 and
						inst.hold_old6 and
						inst.hold_old7 and
						inst.hold_old8 and
						inst.full_k_hold and
						inst.normal_k_hold and
						inst.valkyrie_k_hold and
						inst.berserk_k_hold
				 then
					inst.components.talker:Say("[Visual Hold - Off] \nVisual:[Auto]")
					inst.set_on = false
					inst.visual_hold = false
					inst.visual_hold = false
					inst.visual_hold2 = false
					inst.visual_hold3 = false
					inst.visual_hold4 = false
					inst.full_hold = false
					inst.normal_hold = false
					inst.valkyrie_hold = false
					inst.berserk_hold = false
					inst.hold_old1 = false
					inst.hold_old2 = false
					inst.hold_old3 = false
					inst.hold_old4 = false
					inst.hold_old5 = false
					inst.hold_old6 = false
					inst.hold_old7 = false
					inst.hold_old8 = false
					inst.full_k_hold = false
					inst.normal_k_hold = false
					inst.valkyrie_k_hold = false
					inst.berserk_k_hold = false
					inst.willow = false
					inst.wigfred = false
					inst.change_visual = false
				end
			end
		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
		end
	end
end
AddModRPCHandler("musha", "visual_hold", visual_hold)

local function yamche2(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		--hunt --defense --avoid
		local x, y, z = inst.Transform:GetWorldPosition()
		local ents = TheSim:FindEntities(x, y, z, 25, {"yamche"})
		for k, v in pairs(ents) do
			if
				not inst.components.leader:IsFollower(v) and v:HasTag("yamcheb") and not inst:HasTag("playerghost") and
					inst.components.leader:CountFollowers("yamcheb") == 0
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_ARONG_SLEEPY)
			elseif
				v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.peace and
					not v.active_hunt and
					not v.defense and
					not inst:HasTag("playerghost") and
					not inst.berserks and
					not inst.fberserk
			 then
				v.yamche = true
				if v:HasTag("yamcheb") then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNT)
					--v.components.talker:Say("[Aggressive]\nArmor:40")
					v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_OFFENSE)
					v.peace = false
					v.active_hunt = true
					v.defense = false
					v.crazyness = false
				end
			elseif
				v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.peace and
					v.active_hunt and
					not v.defense and
					inst.components.leader:IsFollower(v) and
					not inst:HasTag("playerghost") and
					not inst.berserks and
					not inst.fberserk
			 then
				v.yamche = true
				if v:HasTag("yamcheb") then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_RETREAT)
					--v.components.talker:Say("[Avoidance]\nArmor:95")
					v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID)
					v.peace = true
					v.active_hunt = false
					v.defense = true
					v.crazyness = true
				end
			elseif
				v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and v.peace and
					not v.active_hunt and
					v.defense and
					inst.components.leader:IsFollower(v) and
					not inst:HasTag("playerghost") and
					not inst.berserks and
					not inst.fberserk
			 then
				v.yamche = true
				if v:HasTag("yamcheb") then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_PROTECT)
					--v.components.talker:Say("[Defensive]\nArmor:60")
					v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DEFFENSE)
					v.peace = false
					v.active_hunt = false
					v.defense = false
					v.crazyness = false
				end
			elseif
				v.components.follower and v.components.follower.leader and v.peace and inst.components.leader:IsFollower(v) and
					not inst:HasTag("playerghost") and
					(inst.berserks or inst.fberserk)
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_BERSERK)
				v.yamche = true
				if v:HasTag("yamcheb") then
					v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID)
					v.peace = true
					v.active_hunt = false
					v.defense = true
					v.crazyness = true
				end
			elseif
				v.components.follower and v.components.follower.leader and not v.peace and inst.components.leader:IsFollower(v) and
					inst:HasTag("playerghost") and
					not inst.berserks and
					not inst.fberserk
			 then
				v.yamche = true
				if v:HasTag("yamcheb") then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GHOST)
					v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_AVOID)
					v.peace = true
					v.active_hunt = false
					v.defense = true
					v.crazyness = false
				end
			elseif
				v.components.follower and v.components.follower.leader and v.peace and inst.components.leader:IsFollower(v) and
					inst:HasTag("playerghost") and
					not inst.berserks and
					not inst.fberserk
			 then
				inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_OOOOHHHH)
				v.yamche = true
				if v:HasTag("yamcheb") then
					v.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_DEFFENSE)
					v.peace = false
					v.active_hunt = false
					v.defense = false
					v.crazyness = false
				end
			----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
			end
		end
	end
end
AddModRPCHandler("musha", "yamche2", yamche2)

local function yamche3(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		local x, y, z = inst.Transform:GetWorldPosition()
		local ents = TheSim:FindEntities(x, y, z, 25, {"yamcheb"})
		for k, v in pairs(ents) do
			if not v.removinv then
				if
					v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and
						not inst:HasTag("playerghost") and
						v.level1
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_LEVEL1)
					v.yamche = true
				elseif
					not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and
						not inst:HasTag("playerghost") and
						v.components.container and
						v.item_max_full
				 then
					v.working_food = false
					v.pick1 = false
					v.drop = true
					v.item_1 = false
					v.item_ready_drop = false
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_SHOWME)
					v.yamche = true

					SpawnPrefab("dr_warm_loop_2").Transform:SetPosition(v:GetPosition():Get())
					if not v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x1)"
						)
					elseif v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x8)"
						)
					end
				elseif
					not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and
						not v.pick1 and
						not inst:HasTag("playerghost") and
						not v.item_max_full
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER)
					local emote = "cheer"
					if emote ~= nil then
						MushaCommands.RunTextUserCommand(emote, inst, false)
					end
					v.working_food = true
					v.pick1 = true
					v.drop = false
					v.yamche = true

					if not v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x6)"
						)
					elseif v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT ..
								"+" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x14)"
						)
					end
				elseif
					not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and
						v.pick1 and
						not inst:HasTag("playerghost") and
						not v.item_max_full
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_GATHER_STOP)
					v.working_food = false
					v.pick1 = false
					v.drop = true
					v.yamche = true
					if not v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x1)"
						)
					elseif v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x8)"
						)
					end
				elseif
					not v.level1 and not inst.components.leader:IsFollower(v) and not inst:HasTag("playerghost") and
						inst.components.leader:CountFollowers("yamcheb") == 0
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_ORDER_YAMCHE_EGG)
				elseif
					v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and not v.pick1 and
						inst:HasTag("playerghost")
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_GATHER)
					v.working_food = true
					v.pick1 = true
					v.drop = false
					v.yamche = true

					if not v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x6)"
						)
					elseif v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT ..
								"+" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_STUFF .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x14)"
						)
					end
				elseif
					not v.level1 and v.components.follower and v.components.follower.leader and inst.components.leader:IsFollower(v) and
						v.pick1 and
						inst:HasTag("playerghost")
				 then
					inst.components.talker:Say(STRINGS.MUSHA_TALK_GHOST_STOP)
					v.working_food = false
					v.pick1 = false
					v.drop = true
					if not v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_REST .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x1)"
						)
					elseif v.light_on then
						v.components.talker:Say(
							STRINGS.MUSHA_TALK_ORDER_YAMCHE_LIGHT .. "\n" .. STRINGS.MUSHA_TALK_ORDER_YAMCHE_HUNGRY .. "(x8)"
						)
					end
				end
			----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
			end
		end
		--
		local x, y, z = inst.Transform:GetWorldPosition()
		local critter = TheSim:FindEntities(x, y, z, 25, {"critter"})
		for k, v in pairs(critter) do
			if
				v.components.follower.leader and inst.components.leader:IsFollower(v) and v.components.container ~= nil and
					v.critter_musha and
					inst.components.leader:CountFollowers("yamcheb") == 0
			 then
				--v.pet_mood_check = true
				if v.components.container:IsFull() then
					if v.components.locomotor ~= nil then
						v.components.locomotor:StopMoving()
					end
					local emote = "annoyed"
					if emote ~= nil then
						MushaCommands.RunTextUserCommand(emote, inst, false)
					end
					v.AnimState:PlayAnimation("distress")
					v.components.machine:TurnOff()
					v.working_on = false
					v.item_ready_drop = false
					v.working_food = false
					v.pick1 = false
					v.collect_off = true
				else
					if not v.pick1 and not v.working_food then
						if v.components.container ~= nil then
							v.components.container:Close()
							v.collect_work = true
						end

						inst.components.talker:Say(STRINGS.CRITTER_GATHERING)
						local emote = "cheer"
						if emote ~= nil then
							MushaCommands.RunTextUserCommand(emote, inst, false)
						end
						v.components.machine:TurnOn()
						v.working_on = true
						v.item_ready_drop = true
						if v.components.locomotor ~= nil then
							v.components.locomotor:StopMoving()
						end
						local random_ani = math.random(1, 2)
						if random_ani == 1 then
							v.sg:GoToState("playful")
						else
							v.AnimState:PlayAnimation("emote_nuzzle")
						end

						v.item_ready_drop = true
						v.working_food = true
						v.pick1 = true
					elseif v.pick1 or v.working_food then
						if v.components.container ~= nil then
							v.collect_work = false
						end

						inst.components.talker:Say(STRINGS.CRITTER_STOP_GATHER)
						v.components.machine:TurnOff()
						v.working_on = false

						if v.components.locomotor ~= nil then
							v.components.locomotor:StopMoving()
						end
						if v.prefab == "critter_lamb" then
							v.AnimState:PlayAnimation("distress")
							v.SoundEmitter:PlaySound("dontstarve/creatures/together/sheepington/yell")
						else
							v.sg:GoToState("emote_cute")
						end

						v.item_ready_drop = false
						v.working_food = false
						v.pick1 = false
					end
				end
			elseif
				v.components.follower.leader and inst.components.leader:IsFollower(v) and v.components.container ~= nil and
					v.critter_musha and
					inst.components.leader:CountFollowers("yamcheb") >= 1
			 then
				v.follow_yamche = true
			end
		end
	end
end

AddModRPCHandler("musha", "yamche3", yamche3)

local function ydebug(inst)
	inst.writing = false
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, 1, {"_writeable"})
	for k, v in pairs(ents) do
		inst.writing = true
	end
	if not inst.writing then
		if not inst.sleepbadge_off then
			inst.sleepbadge_off = true
			inst.components.talker:Say(STRINGS.MUSHA_BADGE_SLEEP .. "\nOFF")
		elseif inst.sleepbadge_off then
			inst.sleepbadge_off = false
			inst.components.talker:Say(STRINGS.MUSHA_BADGE_SLEEP .. "\nON")
			inst.sleep_debuff_reset = true
			inst.sleep_debuff_90 = false
			inst.sleep_debuff_70 = false
			inst.sleep_debuff_50 = false
			inst.sleep_debuff_30 = false
		end
	end
end

AddModRPCHandler("musha", "ydebug", ydebug)
--------------------------------
AddPrefabPostInitAny(
	function(inst)
		if inst.components.healthinfo_copy == nil and inst:HasTag("yamache") then
			if not inst.components.healthinfo_copy then
				inst:AddComponent("healthinfo_copy")
			end
			if not inst.components.healthinfo_copy then
				inst:AddComponent("hungerinfo")
			end
			Updateyamche =
				inst:DoPeriodicTask(
				0.2,
				function()
					if inst.components.health and inst.components.hunger then
						str = ""
						local h = inst.components.health
						local mx = math.floor(h.maxhealth - h.minhealth)
						local cur = math.floor(h.currenthealth - h.minhealth)
						local h2 = inst.components.hunger
						local mx2 = math.floor(h2.max - h2.hungerrate)
						local cur2 = math.floor(h2.current - h2.hungerrate)
						str = "[" .. math.floor(cur * 100 / mx) .. "%/" .. math.floor(cur2 * 100 / mx2) .. "%]"
						--str = "\nHealth: "..math.floor(cur*100/mx).."%\nHunger: "..math.floor(cur2*100/mx2).."%"
						inst.components.healthinfo_copy:SetText(str)
					end
				end
			)
		end
	end
)

AddPrefabPostInitAny(
	function(inst)
		if inst.components.healthinfo_copy == nil and inst:HasTag("arongbaby") then
			if not inst.components.healthinfo_copy then
				inst:AddComponent("healthinfo_copy")
			end
			if inst.components.health then
				str = ""
				local h = inst.components.health
				local mx = math.floor(h.maxhealth - h.minhealth)
				local cur = math.floor(h.currenthealth - h.minhealth)

				str = "[" .. math.floor(cur * 100 / mx) .. "%]"
				--str = "\nHealth: "..math.floor(cur*100/mx).."%\nHunger: "..math.floor(cur2*100/mx2).."%"
				inst.components.healthinfo_copy:SetText(str)
			end
		end
	end
)