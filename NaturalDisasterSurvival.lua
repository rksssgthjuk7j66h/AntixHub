local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window = OrionLib:MakeWindow({Name = "Aero Hub", IntroText = "Aero Hub", HidePremium = true, SaveConfig = false})

function Notify(text, title)
    OrionLib:MakeNotification({
        Name = text,
        Content = title,
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998"
})

local TrollingSection = MainTab:AddSection({
	Name = "Survival"
})

MainTab:AddToggle({
	Name = "No FallDamage",
	Default = false,
    Flag = "FallDamage",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Predict Disasters",
	Default = false,
    Flag = "Predict",
	Callback = function(v)
		if v then return end
		if game.Players.LocalPlayer.Character:FindFirstChild("SurvivalTag") and game.Players.LocalPlayer.Character.SurvivalTag:FindFirstChild("Notif") then
			game.Players.LocalPlayer.Character.SurvivalTag.Notif:Destroy()
		end
	end
})

MainTab:AddToggle({
	Name = "Map Vote",
	Default = false,
    Flag = "Vote",
	Callback = function(v)
		game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = v
	end
})

local TrollingSection = MainTab:AddSection({
	Name = "Trolling"
})

MainTab:AddToggle({
	Name = "Spam Sounds",
	Default = false,
    Flag = "SoundSpam",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Mute Sounds",
	Default = false,
    Flag = "SoundMute",
	Callback = function()end
})

local DisasterTab = Window:MakeTab({
	Name = "Disasters",
	Icon = "rbxassetid://4483345998"
})

local DisastersSection = DisasterTab:AddSection({
	Name = "Disasters"
})

DisasterTab:AddToggle({
	Name = "Bypass Acid Rain",
	Default = false,
    Flag = "AcidRain",
	Callback = function()end
})

DisasterTab:AddToggle({
	Name = "Bypass Meteors",
	Default = false,
    Flag = "Meteors",
	Callback = function()end
})

DisasterTab:AddToggle({
	Name = "Bypass Virus",
	Default = false,
    Flag = "Virus",
	Callback = function(v)
		if not v then return end
		for _,v in pairs(workspace.Structure:GetDescendants()) do
			if v.Name == "Virus" then
				v:Destroy()
			end
		end
	end
})

DisasterTab:AddToggle({
	Name = "Bypass Lava",
	Default = false,
    Flag = "Lava",
	Callback = function(v)
		if not v then return end
		for _,v in pairs(workspace.Structure:GetDescendants()) do
			if v.Name == "Lava" then
				v:Destroy()
			end
		end
	end
})

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998"
})

local HumanoidSection = PlayerTab:AddSection({
	Name = "Humanoid"
})

PlayerTab:AddToggle({
	Name = "Infinite Jump",
	Default = false,
    Flag = "InfJump",
	Callback = function()end
})

PlayerTab:AddToggle({
	Name = "Toggle WalkSpeed",
	Default = false,
    Flag = "WalkSpeed",
	Callback = function(v)
		if v or not game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then return end
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
})

PlayerTab:AddSlider({
	Name = "WalkSpeed Value",
	Min = 16,
	Max = 250,
	Default = 16,
	Flag = "WalkSpeedValue",
	Increment = 1,
	ValueName = "%",
	Callback = function()end    
})

local CharacterSection = PlayerTab:AddSection({
	Name = "Character"
})

PlayerTab:AddToggle({
	Name = "Noclip",
	Default = false,
    Flag = "Noclip",
	Callback = function(v)
		if v then
			NoclipLoop = game.RunService.Stepped:Connect(function()
				if game.Players.LocalPlayer.Character then
					for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
						if v:IsA("BasePart") and v.CanCollide then
							v.CanCollide = false
						end
					end
				end
			end)
		else
			if NoclipLoop then
				NoclipLoop:Disconnect()
				for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
					if v:IsA("BasePart") and not v.CanCollide then
						v.CanCollide = true
					end
				end
			end
		end
	end
})

local MiscTab = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://4483345998"
})

local TeleportsSection = MiscTab:AddSection({
	Name = "Teleports"
})

MiscTab:AddButton({
	Name = "Tower",
	Callback = function()
		pcall(function()
      		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-269, 181, 383))
		end)
  	end
})

MiscTab:AddButton({
	Name = "Island",
	Callback = function()
		pcall(function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-122, 48, 18))
		end)
  	end
})

local OtherSection = MiscTab:AddSection({
	Name = "Other"
})

MiscTab:AddButton({
	Name = "Get Balloon",
	Callback = function()
		for _,v in pairs(game.Players:GetPlayers()) do
			if v.Backpack:FindFirstChild("GreenBalloon") or v.Character:FindFirstChild("GreenBalloon") then
				local balloon = v.Backpack:FindFirstChild("GreenBalloon") or v.Character:FindFirstChild("GreenBalloon")
				local clone = balloon:Clone()
				clone.Parent = game.Players.LocalPlayer.Backpack
				break
			end
		end
		if not game.Players.LocalPlayer.Backpack:FindFirstChild("GreenBalloon") then
			Notify("Get Balloon", "Something went wrong. Try Later!")
		end
  	end
})

MiscTab:AddButton({
	Name = "Walk On Water",
	Callback = function()
		workspace.WaterLevel.CanCollide = true
		workspace.WaterLevel.Mesh.Parent = nil
		workspace.WaterLevel.Size = Vector3.new(9e9, .1, 9e9)
		workspace.WaterLevel.Color = Color3.fromRGB(13, 105, 172)
		Instance.new("MeshPart", workspace.WaterLevel).Name = "Mesh"
  	end
})

local EspSection = MiscTab:AddSection({
	Name = "Esp"
})

MiscTab:AddToggle({
	Name = "Highlight Esp",
	Default = false,
    Flag = "Highlights",
	Callback = function(v)
		if v then return end
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Highlight") then
				coroutine.wrap(function()
					v.Character.Highlight:Destroy()
				end)()
			end
		end
	end
})

MiscTab:AddColorpicker({
	Name = "Highlight Esp Color",
	Default = Color3.fromRGB(233, 246, 233),
	Flag = "HighlightsColor",
	Callback = function(c)
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Highlight") then
				v.Character.Highlight.FillColor = c
			end
		end
	end
})

game:GetService("Workspace").Structure.DescendantAdded:Connect(function(v)
	if v.Name == "Virus" and OrionLib.Flags["Virus"].Value then
		game.RunService.RenderStepped:Wait()
        v:Destroy()
	end
    if v.Name == "MeteorTemplate" and OrionLib.Flags["Meteors"].Value then
		game.RunService.RenderStepped:Wait()
        v:Destroy()
	end
	if v.Name == "Lava" and OrionLib.Flags["Lava"].Value then
		game.RunService.RenderStepped:Wait()
        v:Destroy()
	end
    if v.Name == "AcidRain" and OrionLib.Flags["AcidRain"].Value then
		game.RunService.RenderStepped:Wait()
        v:Destroy()
	end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if OrionLib.Flags["InfJump"].Value then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
    end
end)

while wait(.4) do
    if OrionLib.Flags["FallDamage"].Value then
        if game.Players.LocalPlayer.Character:FindFirstChild("FallDamageScript") then
			game.Players.LocalPlayer.Character.FallDamageScript:Destroy()
		end
    end
    if OrionLib.Flags["Predict"].Value then
        if game.Players.LocalPlayer.Character:FindFirstChild("SurvivalTag") and not game.Players.LocalPlayer.Character.SurvivalTag:FindFirstChild("Notif") then
            Notify("Disaster Prediction", "Current disaster is " .. game.Players.LocalPlayer.Character.SurvivalTag.Value)
			Instance.new("BoolValue", game.Players.LocalPlayer.Character.SurvivalTag).Name = "Notif"
        end
    end
    if OrionLib.Flags["SoundSpam"].Value and not OrionLib.Flags["SoundMute"].Value then
        for _,v in pairs(workspace.ContentModel.Sounds:GetChildren()) do
			if v.ClassName == "Sound" then
				v:Play()
			end
		end
    end
	if OrionLib.Flags["SoundMute"].Value then
        for _,v in pairs(workspace.ContentModel.Sounds:GetChildren()) do
			if v.ClassName == "Sound" and v.IsPlaying then
				v:Stop()
			end
		end
    end
	if OrionLib.Flags["Highlights"].Value then
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer and v.Character and not v.Character:FindFirstChild("Highlight") then
				local highlight = Instance.new("Highlight", v.Character)
				highlight.FillColor = OrionLib.Flags["HighlightsColor"].Value
			end
		end
	end
	if OrionLib.Flags["WalkSpeed"].Value then
		if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
			game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OrionLib.Flags["WalkSpeedValue"].Value
		end
	end
	if OrionLib.Flags["Vote"].Value then
		game.Players.LocalPlayer.PlayerGui.MainGui.MapVotePage.Visible = true
	end
end
