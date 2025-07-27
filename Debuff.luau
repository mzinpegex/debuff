local Debuff = {}
Debuff.__index = Debuff

local RunService = game:GetService("RunService")

local Schema = require(script.Schema)

function Debuff.new(EntityId, DebuffType:string)
	if not EntityId then warn("An error unexpected ocurred while trying to get ID") return end
	if not Schema.Types[DebuffType] then warn("The debuff :"..DebuffType.." doesn't exist.") return end
	
	local self = setmetatable({}, Debuff)
	
	self.CurrentDebuff = Schema.Types[DebuffType]
	self.EntityID = EntityId
	self.EndTime = os.clock() + self.CurrentDebuff["Duration"]
	self.NextTick = os.clock() + self.CurrentDebuff["TickInterval"]
	self.Destroyed = false
	
	self._connection = RunService.Heartbeat:Connect(function()
		self:OnHeartbeat()
	end)
	
	if Schema.OnApplied then
		print(self.CurrentDebuff["UniqueStatusData"])
		Schema.OnApplied(self.EntityID, self.CurrentDebuff["UniqueStatusData"])
	end
	
	return self
end

function Debuff:OnHeartbeat()
	if self.Destroyed then return end
	
	local Now = os.clock()
	
	if Now >= self.NextTick then
		if Schema.OnTick then
			Schema.OnTick(self.EntityID, self.CurrentDebuff["UniqueStatusData"])
		end
		
		self.NextTick = Now + self.CurrentDebuff.TickInterval
	end
	
	if Now >= self.EndTime then
		self:Destroy()
	end
end

function Debuff:Destroy()
	if self.Destroyed then return end
	self.Destroyed = true
	
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end
	
	if Schema.OnRemoved then
		Schema.OnRemoved(self.EntityID, self.CurrentDebuff["UniqueStatusData"]	)
	end
end

return Debuff
