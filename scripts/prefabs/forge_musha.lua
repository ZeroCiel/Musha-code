require "prefabutil"

local tent_assets = {
	Asset("ANIM", "anim/forge_musha.zip"),
	Asset("ANIM", "anim/forge_musha_on.zip"),
	Asset("ANIM", "anim/forge_musha_broken.zip")
}

local function ShowFuel(inst)
	local Fuel_tips = inst.components.fueled.currentfuel < 4 and STRINGS.MUSHA_NOTFUEL .. "\n" or ""

	if inst.components.machine.ison then
		inst.components.talker:Say(
			Fuel_tips .. STRINGS.MUSHA_TALK_FORGE_ON .. "\n" .. math.ceil(inst.components.fueled:GetPercent() * 100) .. "%"
		)
	else
		inst.components.talker:Say(
			Fuel_tips .. STRINGS.MUSHA_TALK_FORGE_OFF .. "\n" .. math.ceil(inst.components.fueled:GetPercent() * 100) .. "%"
		)
	end
end

local function OnOpen(inst)
	inst.is_On = true
	inst.SoundEmitter:PlaySound("dontstarve/common/minerhatAddFuel")
	if not inst.components.fueled:IsEmpty() then
		inst.Light:Enable(true)
	end
	inst.components.fueled:StartConsuming()
	ShowFuel(inst)
end

local function OnClose(inst)
	inst.is_On = false
	inst.SoundEmitter:PlaySound("dontstarve/common/minerhatOut")
	inst.Light:Enable(false)
	inst.components.fueled:StopConsuming()
	ShowFuel(inst)
end

local function AutoUpgrade(inst)
	if not inst.components.fueled:IsEmpty() then
		local container = inst.components.container
		for i = 1, container:GetNumSlots() do
			local item = container:GetItemInSlot(i)
			if item and inst.components.machine.ison and item:HasTag("musha_items") and item.level and item.level < 4000 then
				item.level = item.level + 1
				inst.AnimState:PlayAnimation("hit")
				SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
				inst.components.fueled:DoDelta(-0.25)
				if not inst.components.fueled:IsEmpty() then
					return
				end
			end
		end
	end
end

local function OnBroken(inst)
	ShowFuel(inst)
	inst.Light:Enable(false)
	inst.components.fueled:StopConsuming()
	--inst.components.container:DropEverything()
	--inst.components.container:Close()
	inst.AnimState:PlayAnimation("destroy")
	inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_pre")
	inst:DoTaskInTime(
		16 * FRAMES,
		function()
			inst.SoundEmitter:PlaySound("dontstarve/common/tent_dis_twirl")
		end
	)
	scheduler:ExecuteInTime(
		2,
		function()
			SpawnPrefab("collapse_big").Transform:SetPosition(inst:GetPosition():Get())
			inst.AnimState:SetBuild("forge_musha_broken")
			inst.AnimState:PlayAnimation("place")
			inst.AnimState:PushAnimation("idle", true)
		end
	)
end

local function OnLoad(inst, data)
	if data and data.is_On then
		inst.is_On = data.is_On
		if not inst.components.fueled:IsEmpty() then
			inst.components.machine:TurnOn()
		end
	end
end

local function OnSave(inst, data)
	data.is_On = inst.is_On
end

local function OnBuilt(inst)
	inst.AnimState:PlayAnimation("place")
	inst.AnimState:PushAnimation("idle", true)
end

local function OnHammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	local fx = SpawnPrefab("collapse_big")
	fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
	fx:SetMaterial("wood")
	inst:Remove()
end

local function OnDestoryed(inst, worker)
	if not inst:HasTag("burnt") then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("idle", true)
	end
end

local function TakeItem(inst, item, data)
	if inst.components.fueled:IsEmpty() then
		inst.AnimState:SetBuild("forge_musha")
		inst.AnimState:PlayAnimation("place")
		inst.AnimState:PushAnimation("idle", true)
	end

	SpawnPrefab("small_puff").Transform:SetPosition(inst:GetPosition():Get())
	SpawnPrefab("green_leaves").Transform:SetPosition(inst:GetPosition():Get())
	inst.components.fueled:DoDelta(20)
	if inst.is_On then
		inst.components.machine:TurnOn()
	end
end

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddNetwork()

	MakeObstaclePhysics(inst, 1)

	inst:AddTag("forge_musha")
	inst:AddTag("structure")
	inst:AddTag("fridge")

	inst.AnimState:SetBank("tent")
	inst.AnimState:SetBuild("forge_musha")
	--   inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:PlayAnimation("hit")
	inst.MiniMapEntity:SetIcon("forge_musha.tex")

	MakeSnowCoveredPristine(inst)

	inst.entity:AddLight()
	inst.Light:SetRadius(5)
	inst.Light:SetFalloff(.8)
	inst.Light:SetIntensity(.8)
	inst.Light:SetColour(180 / 255, 180 / 255, 180 / 255)
	inst.Light:Enable(false)
	inst.is_On = false

	inst:AddComponent("machine")
	inst.components.machine.turnonfn = OnOpen
	inst.components.machine.turnofffn = OnClose
	inst.components.machine.cooldowntime = 0

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 21
	inst.components.talker.font = TALKINGFONT
	inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	inst.components.talker.offset = Vector3(0, -780, 0)
	inst.components.talker.symbol = "swap_object"

	inst:AddComponent("fueled")
	inst.components.fueled.fueltype = "BURNABLE"
	inst.components.fueled:InitializeFuelLevel(100)
	inst.components.fueled.rate = 0.004
	inst.components.fueled.bonusmult = 0
	inst.components.fueled:SetDepletedFn(OnBroken)
	inst.components.fueled:SetTakeFuelFn(TakeItem)
	inst.components.fueled.accepting = true
	inst.components.fueled:StopConsuming()

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		inst:DoTaskInTime(
			0,
			function()
				inst.replica.container:WidgetSetup("chest_yamche5")
			end
		)
		return inst
	end

	inst:AddComponent("container")
	inst.components.container:WidgetSetup("chest_yamche5")
	inst.components.container.onopenfn = function()
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	end

	inst.components.container.onclosefn = function()
		inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	end

	inst._activecount = 0
	inst._activetask = nil
	inst:AddComponent("inspectable")

	inst:AddComponent("lootdropper")
	inst:AddComponent("workable")
	inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
	inst.components.workable:SetWorkLeft(5)
	inst.components.workable:SetOnFinishCallback(OnHammered)
	inst.components.workable:SetOnWorkCallback(OnDestoryed)

	inst:DoPeriodicTask(10, AutoUpgrade)
	inst:DoPeriodicTask(1, ShowFuel)

	--  MakeSnowCovered(inst)
	inst:ListenForEvent("onbuilt", OnBuilt)

	inst.OnSave = OnSave
	inst.OnLoad = OnLoad
	inst.Player_Upgrade = function()
		inst.components.fueled:DoDelta(-4)
		ShowFuel(inst)
	end

	MakeHauntableWork(inst)

	return inst
end

return Prefab("common/objects/forge_musha", fn, tent_assets), MakePlacer(
	"common/forge_musha_placer",
	"tent",
	"forge_musha",
	"idle"
)
