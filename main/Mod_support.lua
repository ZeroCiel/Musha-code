local DLC2 = 0 
for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Tropical Experience | The Volcano Biome" or GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Island Adventures" then
		DLC2 = 1
   end end 

local DLC2_fly = 0 
for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
    if GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Island Adventures" then
		DLC2_fly = 1
   end end   
--function
function SW_DLC2_fly(inst)
	inst.DLC2_fly = true
end

function SW_DLC2(inst)
	inst.DLC2 = true
end
--setting
local list_fuel = {
	"mushasword_base","mushasword","mushasword_frost","armor_mushaa","armor_mushab","pirateback","musha","musha_small","musha_teen","musha_teenr1","musha_teenr2","musha_teenr3","musha_teenr4","musha_teenice","musha_tall","musha_tallr1","musha_tallr2","musha_tallr3","musha_tallr4","musha_tallrice","musha_tall2","musha_tallrr1","musha_tallrr2","musha_tallrr3","musha_tallrr4","musha_tallrr5","musha_tallrrice","musha_tall3","musha_tallrrr1","musha_tallrrr2","musha_tallrrr3","musha_tallrrr4","musha_tallrrr5","musha_tallrrrice","musha_tall4","musha_tallrrrr1","musha_tallrrrr2","musha_tallrrrr3","musha_tallrrrr4","musha_tallrrrr5","musha_tallrrrr6","musha_tallrrrrice","musha_tall5","musha_tallrrrrr1","musha_tallrrrrr2","musha_tallrrrrr3","musha_tallrrrrr4","musha_tallrrrrr5","musha_tallrrrrr6","musha_tallrrrrrice","musha_rp1","musha_rp2","musha_rp3","musha_rp4","musha_rp5","musha_rp6","musha_rp7","musha_rpice"
}

if DLC2 == 1 then   
for k, v in pairs(list_fuel) do
	AddPrefabPostInit(v, SW_DLC2)
end

function hack_tool(inst)
inst:AddComponent("tool")
inst.components.tool:SetAction(ACTIONS.HACK)
end
AddPrefabPostInit("mushasword", hack_tool)
AddPrefabPostInit("mushasword_frost", hack_tool)
end

if DLC2_fly == 1 then   
modimport "main/IA_support.lua"

for k, v in pairs(list_fuel) do
	AddPrefabPostInit(v, SW_DLC2_fly)
end
end

--patch 如果玩家拥有五格，那就把它改成背包，否则就是护甲。
for _, moddir in ipairs(GLOBAL.KnownModIndex:GetModsToLoad()) do
	if not (GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Extra Equip Slots" or
			GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Extra Equip Slots API Edition" or
			GLOBAL.KnownModIndex:GetModInfo(moddir).name == "Slots Tweak & UI optimizer - RoT Hotfix")
	then
	local function cold(inst)
	inst:AddTag("fridge")
	end
	AddPrefabPostInit("pirateback", cold)
	end
end