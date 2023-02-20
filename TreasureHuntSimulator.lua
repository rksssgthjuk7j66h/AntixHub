local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window = OrionLib:MakeWindow({Name = "Antix Hub", IntroText = "Antix Hub", HidePremium = true, SaveConfig = false})

function GetClosestChest()
    local maxDist = math.huge
    local target = nil
    for _,v in pairs(workspace.SandBlocks:GetChildren()) do
        if v:FindFirstChild("Chest") then
            local magnitude = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
            if magnitude < maxDist then
                maxDist = magnitude
                target = v
            end
        end
    end
    return target
end

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998"
})

local AutoFarmSection = MainTab:AddSection({
	Name = "Autofarm"
})

MainTab:AddToggle({
	Name = "Auto Miner",
	Default = false,
    Flag = "AutoDig",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Auto Rebirth",
	Default = false,
    Flag = "AutoRebirth",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Auto Sell",
	Default = false,
    Flag = "AutoSell",
	Callback = function()end
})

local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998"
})

local HumanoidSection = MiscTab:AddSection({
	Name = "Humanoid"
})

MiscTab:AddToggle({
	Name = "Toggle WalkSpeed",
	Default = false,
    Flag = "WalkSpeed",
	Callback = function(v)
		if v or not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then return end
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
})

MiscTab:AddSlider({
	Name = "WalkSpeed Value",
	Min = 16,
	Max = 250,
	Default = 16,
	Flag = "WalkSpeedValue",
	Increment = 1,
	ValueName = "%",
	Callback = function()end
})

local OtherSection = MiscTab:AddSection({
	Name = "Other"
})

MiscTab:AddButton({
	Name = "Lag Server",
	Callback = function()
      	game.RunService.RenderStepped:Connect(function()
            game.ReplicatedStorage.Events.UpdateLeaderstats:FireServer()
            game.ReplicatedStorage.Events.GetServerSongsPlaying:InvokeServer()
            game.ReplicatedStorage.Events.GetStats:InvokeServer()
            game.ReplicatedStorage.Events.CheckIfOwned:InvokeServer("Medium Shovel")
        end)
  	end
})

game:GetService("RunService").RenderStepped:Connect(function()
    if OrionLib.Flags["WalkSpeed"].Value then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OrionLib.Flags["WalkSpeedValue"].Value
    end
end)

local d = false
while wait(.4) do
    if OrionLib.Flags["AutoDig"].Value and not d then
        local Event = game.Players.LocalPlayer.Character:FindFirstChild("RemoteClick", true)
        if Event then
            local nearest = GetClosestChest()
            if nearest and nearest.Health.Value >= 1 and nearest.Health.Value < 100000 then
                nearest.CanCollide = true
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = nearest.CFrame
                nearest.CanCollide = false
                Event:FireServer(nearest)
            end
        end
    end
    if OrionLib.Flags["AutoRebirth"].Value then
        game.ReplicatedStorage.Events.Rebirth:FireServer()
    end
    if OrionLib.Flags["AutoSell"].Value then
        if game.Players.LocalPlayer.PlayerGui.Gui.Popups.BackpackFull.Visible then
            local oldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(4, 10, -160))
            game.ReplicatedStorage.Events.AreaSell:FireServer()
		d = true
            wait(.6)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldPos
			d = false
        end
    end
end
