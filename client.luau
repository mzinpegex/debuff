local uis = game:GetService("UserInputService")
--Testezinho de boa para ver se o codigo ta funcionando
local DebuffFolder = game.ReplicatedStorage.Debuff
local Debuff = require(DebuffFolder.Constructor)

uis.InputBegan:Connect(function(input, gameProcessedEvent)
	if input.KeyCode == Enum.KeyCode.E and not gameProcessedEvent then
		local plr = game.Players.LocalPlayer
		Debuff.new(plr, "Burn")
	end
end)
