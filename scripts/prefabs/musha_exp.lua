local assets=
{
	Asset("ANIM", "anim/musha_exp.zip"),
  Asset("ATLAS", "images/inventoryimages/musha_exp.xml"),
  Asset("IMAGE", "images/inventoryimages/musha_exp.tex"),
}

local function item_oneaten(inst, eater)
if eater.components.spellpower then
eater.components.spellpower:SetPercent(1)
end
if eater.components.stamina_sleep then
eater.components.fatigue_sleep:SetPercent(0)
eater.components.stamina_sleep:SetPercent(1)
--eater.stamina = 100
eater.level = eater.level + 50
eater.music = 100
--eater.fatigue =0
--eater.count_w = eater.count_w + 35
eater.treasure = 100
SpawnPrefab("musha_spore").Transform:SetPosition(eater:GetPosition():Get())
end 
if eater:HasTag("yamcheb") and eater.level then
eater.level = eater.level + 50
end
if eater:HasTag("critter") and eater.level then
eater.level = eater.level + 50
end
end

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    MakeInventoryPhysics(inst)
 	inst.entity:AddNetwork()

    inst.entity:AddSoundEmitter()
    
    inst.AnimState:SetBank("bulb")
    inst.AnimState:SetBuild("exp")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetMultColour(1, 1, 1, 0.3)

    local light = inst.entity:AddLight()
    light:SetFalloff(0.3)
    light:SetIntensity(.3)
    light:SetRadius(0.3)
    light:SetColour(120/255, 120/255, 150/255)
    light:Enable(true)
    inst.AnimState:SetBloomEffectHandle( "shaders/anim.ksh" )
	inst.Transform:SetScale(0.5, 0.5, 0.5)
	  --     inst.entity:AddMiniMapEntity()
	--inst.MiniMapEntity:SetIcon( "exp.tex" )
	
	inst.entity:SetPristine() 
          	if not TheWorld.ismastersim then
   return inst
end	

    inst:AddComponent("tradable")
	
	    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.SEEDS
    inst.components.edible.healthvalue = 100
    inst.components.edible.hungervalue = 150
    inst.components.edible.sanityvalue = 100
    inst.components.edible:SetOnEatenFn(item_oneaten)


    inst:AddComponent("stackable")
	inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = 40000000
    inst.components.fuel.fueltype = "CHEMICAL"

    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
inst.components.inventoryitem.atlasname = "images/inventoryimages/musha_exp.xml"
 

    return inst
end

return Prefab( "common/inventory/musha_exp", fn, assets) 

