local function onmax(self, max)
	self.inst._spellpowermax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentspellpowerperc:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local Spellpower = Class(function(self, inst)
	self.inst = inst
	self.max = 100
	self.current = 50

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(5, function() self:Spelllevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function Spellpower:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function Spellpower:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function Spellpower:LongUpdate(dt)
	self:DoRegen(dt)
end

function Spellpower:GetPercent()
    return self.current / self.max
end

function Spellpower:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function Spellpower:SetMax(amount)
	self.inst._spellpowermax:set(amount)
    self.max = amount
    self.current = amount
end

function Spellpower:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("spellpowerdelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function Spellpower:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("spellpowerdelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end


local function Sleeping(inst)
	return inst:HasTag("sleeping") or inst.sleep_on or inst.tiny_sleep
end
local function Valkyrie(inst)
	return inst.active_valkyrie
end

local function Mana_regen_veasy(inst)
	return inst.dmana_veasy
end
local function Mana_regen_easy(inst)
	return inst.dmana_easy
end
local function Mana_regen_normal(inst)
	return inst.dmana_normal
end
local function Mana_regen_hard(inst)
	return inst.dmana_hard
end
local function Mana_regen_hardcore(inst)
	return inst.dmana_hardcore
end

function Spellpower:DoRegen(dt)
    local old = self.current
	
	local regen = 0.05
if self.current < 100 then 
	if Sleeping(self.inst) then
			if Mana_regen_veasy(self.inst) then
			regen = 2
			elseif Mana_regen_easy(self.inst) then
			regen = 1
			elseif Mana_regen_normal(self.inst) then
			regen = 0.5
			elseif Mana_regen_hard(self.inst) then
			regen = 0.25
			elseif Mana_regen_hardcore(self.inst) then
			regen = 0.1
			end
	else
		if Valkyrie(self.inst) then
			if Mana_regen_veasy(self.inst) then
			regen = 0.4
			elseif Mana_regen_easy(self.inst) then
			regen = 0.2
			elseif Mana_regen_normal(self.inst) then
			regen = 0.1
			elseif Mana_regen_hard(self.inst) then
			regen = 0.05
			elseif Mana_regen_hardcore(self.inst) then
			regen = 0.025
			end
		else
			if Mana_regen_veasy(self.inst) then
			regen = 0.2
			elseif Mana_regen_easy(self.inst) then
			regen = 0.1
			elseif Mana_regen_normal(self.inst) then
			regen = 0.05
			elseif Mana_regen_hard(self.inst) then
			regen = 0.025
			elseif Mana_regen_hardcore(self.inst) then
			regen = 0.01
			end
		end
	end
end	
	self:DoDelta((dt * regen), true)

end


function Spellpower:Spelllevels()

		
			if self.current < 15 then
			self.inst.vlow_spell = true
			else
			self.inst.vlow_spell = false
			end
	
			if self.current >= 15 and self.current < 42 then 
			self.inst.low_spell = true
			else
			self.inst.low_spell = false
			end
			
			if self.current >= 42 and self.current < 73 then 
			self.inst.med_spell = true
			else
			self.inst.med_spell = false
			end
			
			if self.current >= 73 then 
			self.inst.high_spell = true
			else
			self.inst.high_spell = false
			end
		
	
end

return Spellpower