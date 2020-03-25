local SpawnPrefab = GLOBAL.SpawnPrefab
local GetTime = GLOBAL.GetTime

local require = GLOBAL.require
local Crop = require "components/crop"
local Harvestable = require "components/harvestable"
local Pickable = require "components/pickable"
local Stewer = require "components/stewer"
local inventory = require "components/inventory"
local cooking = require "cooking"

-- AddComponentPostInit("Cookable", function(self)
    -- local GetProduct = Cookable.GetProduct
	-- Cookable.GetProduct = function(self, ...)
    -- local prefab = nil 
    -- if self.product then 
        -- prefab = self.product
        -- if type(self.product) == "function" then
            -- prefab = self.product(self.inst)
        -- end
    -- end 
    -- return prefab
	-- end
	-- GetProduct(self)
-- end)

AddComponentPostInit("harvestable", function(self)
    local oldHarvest = self.Harvest --获取原来的
	self.Harvest = function(self, picker, ...) --重新定义
		if picker and picker:HasTag("yamcheb") then  --如果是小凤凰 那么执行自己的部分
			----这里开始是自己的部分
			if self:CanBeHarvested() then
				local produce = self.produce
				self.produce = 0

				local pos = self.inst:GetPosition()

				if self.onharvestfn ~= nil then
					self.onharvestfn(self.inst, picker, produce)
				end

				if self.product ~= nil then
					if picker ~= nil and picker.components.container ~= nil then
						picker:PushEvent("harvestsomething", { object = self.inst })
					end

					for i = 1, produce, 1 do
						local loot = SpawnPrefab(self.product)
						if loot ~= nil then
							if loot.components.inventoryitem ~= nil then
								loot.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
							end
							if picker ~= nil and picker.components.container ~= nil then
								picker.components.container:GiveItem(loot)
							else
								LaunchAt(loot, self.inst, nil, 1, 1)
							end
						end
					end
				end
				self:StartGrowing()
				return true
			end		
		else
			return oldHarvest(self, picker, ...) 
		end
	end
end)
		

function QWQ(self)
	local oldHarvest=self.Harvest
	self.Harvest=function(self,harvester,...)
		if harvester and harvester:HasTag("yamcheb") then
			if self.matured or self.inst:HasTag("withered") then
				local product = nil
				if self.grower ~= nil and
					(self.grower.components.burnable ~= nil and self.grower.components.burnable:IsBurning()) or
					(self.inst.components.burnable ~= nil and self.inst.components.burnable:IsBurning()) then
					local temp = SpawnPrefab(self.product_prefab)
					product = SpawnPrefab(temp.components.cookable ~= nil and temp.components.cookable.product or "seeds_cooked")
					temp:Remove()
				else
					product = SpawnPrefab(self.product_prefab)
				end

				if self.onharvest ~= nil then
					self.onharvest(self.inst, product, harvester)
				end

				if product ~= nil then
					if product.components.inventoryitem ~= nil then
						product.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
					end
					if harvester ~= nil and harvester.components.container ~= nil then
						harvester.components.container:GiveItem(product, nil, self.inst:GetPosition())
					else
						product.Transform:SetPosition(self.inst.Transform:GetWorldPosition())
					end
					ProfileStatsAdd("grown_"..product.prefab)
				end

				self.matured = false
				self.growthpercent = 0
				self.product_prefab = nil

				if self.grower ~= nil and self.grower:IsValid() and self.grower.components.grower ~= nil then
					self.grower.components.grower:RemoveCrop(self.inst)
					self.grower = nil
				else
					self.inst:Remove()
				end

				return true, product
			end		
		else
			return oldHarvest(self,harvester,...)
		end
	end
end
AddComponentPostInit("crop",QWQ)

function QVQ(self)
	local oldStewerHarvest=self.Harvest
	self.Harvest=function(self,harvester,...)
 		if harvester and harvester:HasTag("yamcheb") then	   
			if self.done then
				if self.onharvest ~= nil then
					self.onharvest(self.inst)
				end
				if self.product ~= nil then
					local loot = SpawnPrefab(self.product)
					if loot ~= nil then
						local recipe = cooking.GetRecipe(self.inst.prefab, self.product)
						local stacksize = recipe and recipe.stacksize or 1
						if stacksize > 1 then
							loot.components.stackable:SetStackSize(stacksize)
						end
            
						if self.spoiltime ~= nil and loot.components.perishable ~= nil then
							local spoilpercent = self:GetTimeToSpoil() / self.spoiltime
							loot.components.perishable:SetPercent(self.product_spoilage * spoilpercent)
							loot.components.perishable:StartPerishing()
						end
						if harvester ~= nil and harvester.components.container ~= nil then
							harvester.components.container:GiveItem(loot)
						else
							LaunchAt(loot, self.inst, nil, 1, 1)
						end
					end
					self.product = nil
				end

			if self.task ~= nil then
					self.task:Cancel()
					self.task = nil
				end
				self.targettime = nil
				self.done = nil
				self.spoiltime = nil
				self.product_spoilage = nil

				if self.inst.components.container ~= nil then      
					self.inst.components.container.canbeopened = true
				end

				return true
			end
		else
			return oldStewerHarvest(self,harvester,...)
		end
	end	
end
AddComponentPostInit("stewer",QVQ)

AddComponentPostInit("pickable", function(self)
    local oldPick = self.Pickable --获取原来的
	self.Pickable = function(self, picker, ...) --重新定义
	if picker and picker:HasTag("yamcheb") then  --如果是小凤凰 那么执行自己的部分
    if self.canbepicked and self.caninteractwith then
        if self.transplanted and self.cycles_left ~= nil then
            self.cycles_left = math.max(0, self.cycles_left - 1)
        end

        if self.protected_cycles ~= nil then
            self.protected_cycles = self.protected_cycles - 1
            if self.protected_cycles < 0 then
                self.protected_cycles = nil
                if self.inst.components.witherable ~= nil then
                    self.inst.components.witherable:Enable(true)
                end
            end
        end

        local loot = nil
        if picker ~= nil and (picker:HasTag("yamcheb") or picker:HasTag("critter")) and picker.components.container ~= nil and self.product ~= nil then
            if self.droppicked and self.inst.components.lootdropper ~= nil then
                local num = self.numtoharvest or 1
                local pt = self.inst:GetPosition()
                pt.y = pt.y + (self.dropheight or 0)
                for i = 1, num do
                    self.inst.components.lootdropper:SpawnLootPrefab(self.product, pt)
                end
            else
                loot = SpawnPrefab(self.product)
                if loot ~= nil then
                    if loot.components.inventoryitem ~= nil then
                        loot.components.inventoryitem:InheritMoisture(TheWorld.state.wetness, TheWorld.state.iswet)
                    end
                    if self.numtoharvest > 1 and loot.components.stackable ~= nil then
                        loot.components.stackable:SetStackSize(self.numtoharvest)
                    end
                    picker:PushEvent("picksomething", { object = self.inst, loot = loot })
                    picker.components.container:GiveItem(loot, nil, self.inst:GetPosition())
                end
            end
        end

        if self.onpickedfn ~= nil then
            self.onpickedfn(self.inst, picker, loot)
        end

        self.canbepicked = false

        if self.baseregentime ~= nil and not (self.paused or self:IsBarren() or self.inst:HasTag("withered")) then
            if TheWorld.state.isspring then
                self.regentime = self.baseregentime * TUNING.SPRING_GROWTH_MODIFIER
            end

            if self.task ~= nil then
                self.task:Cancel()
            end
            self.task = self.inst:DoTaskInTime(self.regentime, OnRegen)
            self.targettime = GetTime() + self.regentime
        end

        self.inst:PushEvent("picked", { picker = picker, loot = loot, plant = self.inst })
    end
		else
			return self.Pickable(self,picker,...)
		end
		end
end)

ACTIONS.PICKUP.fn = function(act)
if not act.doer:HasTag("yamcheb") then
    if act.doer.components.inventory ~= nil and
        act.target ~= nil and
        act.target.components.inventoryitem ~= nil and
        (act.target.components.inventoryitem.canbepickedup or
        (act.target.components.inventoryitem.canbepickedupalive and not act.doer:HasTag("player"))) and
        not (act.target:IsInLimbo() or
            (act.target.components.burnable ~= nil and act.target.components.burnable:IsBurning()) or
            (act.target.components.projectile ~= nil and act.target.components.projectile:IsThrown())) then

        if act.doer.components.itemtyperestrictions ~= nil and not act.doer.components.itemtyperestrictions:IsAllowed(act.target) then
            return false, "restriction"
        elseif act.target.components.container ~= nil and act.target.components.container:IsOpen() and not act.target.components.container:IsOpenedBy(act.doer) then
            return false, "inuse"
        end

        act.doer:PushEvent("onpickupitem", { item = act.target })

        if act.target.components.equippable ~= nil and not act.target.components.equippable:IsRestricted(act.doer) then
            local equip = act.doer.components.inventory:GetEquippedItem(act.target.components.equippable.equipslot)
            if equip ~= nil and not act.target.components.inventoryitem.cangoincontainer then
                --special case for trying to carry two backpacks
                if equip.components.inventoryitem ~= nil and equip.components.inventoryitem.cangoincontainer then
                    --act.doer.components.inventory:SelectActiveItemFromEquipSlot(act.target.components.equippable.equipslot)
                    act.doer.components.inventory:GiveItem(act.doer.components.inventory:Unequip(act.target.components.equippable.equipslot))
                else
                    act.doer.components.inventory:DropItem(equip)
                end
                act.doer.components.inventory:Equip(act.target)
                return true
            elseif act.doer:HasTag("player") then
                if equip == nil or act.doer.components.inventory:GetNumSlots() <= 0 then
                    act.doer.components.inventory:Equip(act.target)
                    return true
                elseif GetGameModeProperty("non_item_equips") then
                    act.doer.components.inventory:DropItem(equip)
                    act.doer.components.inventory:Equip(act.target)
                    return true
                end
            end
        end

        act.doer.components.inventory:GiveItem(act.target, nil, act.target:GetPosition())
        return true
    end
elseif act.doer:HasTag("yamcheb") then	
	if act.doer.components.container ~= nil and
        act.target ~= nil and
        act.target.components.inventoryitem ~= nil and
        (act.target.components.inventoryitem.canbepickedup or
        (act.target.components.inventoryitem.canbepickedupalive and not act.doer:HasTag("player"))) and
        not (act.target:IsInLimbo() or
            (act.target.components.burnable ~= nil and act.target.components.burnable:IsBurning()) or
            (act.target.components.projectile ~= nil and act.target.components.projectile:IsThrown())) then

        if act.doer.components.itemtyperestrictions ~= nil and not act.doer.components.itemtyperestrictions:IsAllowed(act.target) then
            return false, "restriction"
        elseif act.target.components.container ~= nil and act.target.components.container:IsOpen() and not act.target.components.container:IsOpenedBy(act.doer) then
            return false, "inuse"
        end

        act.doer:PushEvent("onpickupitem", { item = act.target })

        act.doer.components.container:GiveItem(act.target, nil, act.target:GetPosition())
		--picker.components.container:GiveItem(loot, nil, self.inst:GetPosition())
        
        return true

end
end
end
		