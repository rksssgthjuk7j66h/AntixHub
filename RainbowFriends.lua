local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window = OrionLib:MakeWindow({Name = "Antix Hub", IntroText = "Antix Hub", HidePremium = true, SaveConfig = false})

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998"
})

MainTab:AddSection({
	Name = "Items"
})

MainTab:AddButton({
	Name = "PickUp All Items",
	Callback = function()
		for _,v in pairs(workspace:GetChildren()) do
			if v:FindFirstChild("TouchTrigger") then
				v.TouchTrigger:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			end
		end
  	end
})

MainTab:AddButton({
	Name = "Place All Items",
	Callback = function()
		local Trigger = workspace.GroupBuildStructures:FindFirstChild("Trigger", true)
		if Trigger then
			local oldPos = Trigger.CFrame
			Trigger:PivotTo(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			wait(0.2)
			Trigger.CFrame = oldPos
		end
  	end
})

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998"
})

PlayerTab:AddSection({
	Name = "Character"
})

PlayerTab:AddToggle({
	Name = "Fake Box",
	Flag = "FakeBox",
	Default = false,
	Callback = function()end
})

PlayerTab:AddSection({
	Name = "Humanoid"
})

PlayerTab:AddToggle({
	Name = "Toggle WalkSpeed",
	Flag = "WalkSpeed",
	Default = false,
	Callback = function(a)
		if a then return end
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
	end
})

PlayerTab:AddSlider({
	Name = "WalkSpeed Value",
	ValueName = "%",
	Flag = "WalkSpeedValue",
	Min = 16,
	Max = 100,
	Default = 16,
	Increment = 1,
	Callback = function()end    
})

local VisualsTab = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://4483345998"
})

VisualsTab:AddSection({
	Name = "Monsters"
})

VisualsTab:AddToggle({
	Name = "Monster Highlight",
	Flag = "Monster",
	Default = false,
	Callback = function()end
})

local MonsterColor = Color3.fromRGB(255, 0, 0)
VisualsTab:AddColorpicker({
	Name = "Monster Highlight Color",
	Default = Color3.fromRGB(255, 0, 0),
	Callback = function(a)
		MColor = a
		for _,v in pairs(workspace.Monsters:GetChildren()) do
			if v:FindFirstChild("Highlight") then
				v.Highlight.FillColor = a
			end
		end
	end
})

VisualsTab:AddSection({
	Name = "Items"
})

VisualsTab:AddToggle({
	Name = "Item Highlight",
	Flag = "Item",
	Default = false,
	Callback = function()end
})

local ItemColor = Color3.fromRGB(0, 255, 0)
VisualsTab:AddColorpicker({
	Name = "Item Highlight Color",
	Default = Color3.fromRGB(0, 255, 0),
	Callback = function(a)
		ItemColor = a
		for _,v in pairs(workspace:GetChildren()) do
			if v:FindFirstChild("TouchTrigger") and v:FindFirstChild("Highlight") then
				v.Highlight.FillColor = a
			end
		end
	end
})

while wait(0.2) do
	if OrionLib.Flags["Monster"].Value then
		for _,v in pairs(workspace.Monsters:GetChildren()) do
			if not v:FindFirstChild("Highlight") then
				local highlight = Instance.new("Highlight", v)
				highlight.FillColor = MonsterColor
			end
		end
	else
		for _,v in pairs(workspace.Monsters:GetChildren()) do
			if v:FindFirstChild("Highlight") then
				v.Highlight:Destroy()
			end
		end
	end
	if OrionLib.Flags["Item"].Value then
		for _,v in pairs(workspace:GetChildren()) do
			if v:FindFirstChild("TouchTrigger") and not v:FindFirstChild("Highlight") then
				local highlight = Instance.new("Highlight", v)
				highlight.FillColor = ItemColor
			end
		end
	else
		for _,v in pairs(workspace:GetChildren()) do
			if v:FindFirstChild("TouchTrigger") and v:FindFirstChild("Highlight") then
				v.Highlight:Destroy()
			end
		end
	end
	if OrionLib.Flags["FakeBox"].Value then
		game.ReplicatedStorage.communication.boxes.cl.BoxUpdated:FireServer("Equip")
		game.ReplicatedStorage.communication.boxes.cl.BoxEquipped:Fire()
		game.ReplicatedStorage.communication.walkspeed.ReplicateFlag:FireServer({
			["IgnoreModifiers"] = false,
			["Amount"] = 4,
			["Name"] = "BoxHiding",
			["Active"] = false
		})
	end
	if OrionLib.Flags["WalkSpeed"].Value then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OrionLib.Flags["WalkSpeedValue"].Value
	end
end
