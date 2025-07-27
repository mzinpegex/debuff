local module = {}

function module.Damage(target:Player, value:number)
	local c = target.Character or target.CharacterAdded:Wait()
	local h = c:FindFirstChildOfClass("Humanoid")
	h:TakeDamage(value)
end

return module
