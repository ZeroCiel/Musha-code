--give sunnyyyyholic,
--You must to know, It's not good to write too much code.Because you have to optimize it, it's just too bad.
--Separating this code can help we deal with bugs.

--musha setting
--There is no need to indicate difficulty
--That gives me a headache
local IsServer = GLOBAL.TheNet:GetIsServer()

local bodyguard_wilson = GetModConfigData("bodyguardwilson")
local share_item = GetModConfigData("shareitems")
local musha_in_container = GetModConfigData("musha_incontainer")
--Game effect
local Loud_Lightning = GetModConfigData("loudlightning")
local avisual_Mushaa = GetModConfigData("avisual_musha")
local avisual_Mushab = GetModConfigData("avisual_princess")
local avisual_Pirate = GetModConfigData("avisual_pirate")
local avisual_Pirate_Armor = GetModConfigData("avisual_pirate_armor")
local musha_moon_tree_stop = GetModConfigData("stop_spawning")
local frostblade3rd = GetModConfigData("frostblade3rd")
--------------------------------------------------other setting---------------------------------------
--bodyguard wilson
if IsServer then
local function bodyguardwilson(inst)
	if bodyguard_wilson == 1 then
		inst.no_bodyguard = true
	end
end
AddPrefabPostInit("musha", bodyguardwilson)

local function musha_incontainer(inst)
	if musha_in_container == 0 then
		if inst.components.inventoryitem then
		inst.components.inventoryitem.cangoincontainer = false
		end
	elseif musha_in_container == 1 then
		if inst.components.inventoryitem then
		inst.components.inventoryitem.cangoincontainer = true
		end
	end
end
local list_incontainer = {"armor_mushaa","armor_mushab","broken_frosthammer","pirateback"}

for k, v in pairs(list_incontainer) do
	AddPrefabPostInit(v, musha_incontainer)
end

local function share_items(inst)
	if share_item == 0 then
		inst:AddComponent("characterspecific_musha")
		inst.components.characterspecific_musha:SetOwner("musha")
		inst.components.characterspecific_musha:SetStorable(false)
	end
	if share_item == 1 then
		inst.share_item = true
	end
end

local list_item = {
	"mushasword_base","mushasword","mushasword_frost","mushasword4","phoenixspear","bowm","frosthammer","hat_mbunny","hat_mbunnya","hat_mphoenix","hat_mphoenix","hat_mprincess","hat_mwildcat","broken_frosthammer","armor_mushaa","armor_mushab","pirateback"
}

for k, v in pairs(list_item) do
	AddPrefabPostInit(v, share_items)
end

local function loud_Lightning_effect(inst)
	if Loud_Lightning == "loud1" then
		loud_1 = true
	elseif Loud_Lightning == "loud2" then
		loud_2 = true
	elseif Loud_Lightning == "loud3" then
		loud_3 = true
	end
	end

AddPrefabPostInit("musha", loud_Lightning_effect)

local function back_mushaa_visual(inst)
	inst.visual = avisual_Mushaa
end
AddPrefabPostInit("armor_mushaa", back_mushaa_visual)

local function back_mushab_visual(inst)
	inst.visual = avisual_Mushab
end
AddPrefabPostInit("armor_mushab", back_mushab_visual)

local function armor_pirateback_visual(inst)
	inst.armor_visual = avisual_Pirate_Armor
end
AddPrefabPostInit("pirateback", armor_pirateback_visual)

local function back_pirateback_visual(inst)
	inst.back_visual = avisual_Pirate
end
AddPrefabPostInit("pirateback", back_pirateback_visual)

local function frostarmor_shield(inst)
	inst.enable_butterfly_shield = butterfly_shield == 1
end
AddPrefabPostInit("broken_frosthammer", frostarmor_shield)

local function musha_moon_tree_spawn(inst)
	if musha_moon_tree_stop == 2 then
		inst.radius_spawning = true
	end
	if musha_moon_tree_stop == 3 then
		inst.stop_spawning = true
	end
end
AddPrefabPostInit("musha_moon_tree", musha_moon_tree_spawn)
end
-------------------------------------------------------------other function
local function frostblade_3rdbooster(inst)
	if frostblade3rd == 2 then
		inst.frostblade3rd_spear = true
	elseif frostblade3rd == 3 then
		inst.frostblade3rd_spear = true
		inst.frostblade3rd_spear_range = true
	end
end

if not frostblade3rd == 1 then
AddPrefabPostInit("mushasword_frost", frostblade_3rdbooster)
end

local function musha_font(inst)
	inst.components.talker.fontsize = 26
	inst.components.talker.colour = Vector3(0.75, 0.9, 1, 1)
end
AddPrefabPostInit("musha", musha_font)

