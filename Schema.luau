local Schema = {}

local UniqueStatus = require(script.UniqueStatus)

Schema.Types = {
	Burn = {
		TickInterval = 0.5,
		Duration = 5.1,
		UniqueStatusData = {
			Damage = 5,
		},
	},
}

function Schema.OnApplied(entityId, uniqueStatusData)
	print("Applied")
end

function Schema.OnRemoved(entityId, uniqueStatusData)
	print("Removed")
end

function Schema.OnTick(entityId, uniqueStatusData)
	for i, v in pairs(uniqueStatusData) do
		if UniqueStatus[i] then
			UniqueStatus[i](entityId, v)
		end
	end
end

return Schema
