--All item upgrade parameters, it is unified.
--First is the Item infomartion.
--here is the Level Info.

local function AcceptTest_b(inst)
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL
	inst.components.fuel.fueltype = "CHEMICAL"
	inst:AddTag("elements")
end
AddPrefabPostInit("goldnugget", AcceptTest_b)
AddPrefabPostInit("thulecite", AcceptTest_b)

--fuel
local function AddFuelType(inst)
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = TUNING.MED_LARGE_FUEL
	inst.components.fuel.fueltype = "CHEMICAL"
	inst:AddTag("elements")
end

local list_fuel = {
	"rocks","flint","marble","moonrocknugget","thulecite_pieces","boneshard","stinger","spidergland","houndstooth","snakeskin","slurtle_shellpieces","silk"
}

for k, v in pairs(list_fuel) do
	AddPrefabPostInit(v, AddFuelType)
end
