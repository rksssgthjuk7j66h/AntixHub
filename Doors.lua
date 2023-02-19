getgenv().gethui = function() return game.CoreGui end

local OrionLib = loadstring(game:HttpGet(("https://raw.githubusercontent.com/shlexware/Orion/main/source")))()
local Window = OrionLib:MakeWindow({Name = "Antix Hub", IntroText = "Antix Hub", HidePremium = true, SaveConfig = false})

local Entities = {"RushMoving", "AmbushMoving", "Eyes", "Snare", "A60", "A120"}
local LatestRoom = game.ReplicatedStorage.GameData.LatestRoom

local MainTab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998"
})

MainTab:AddSection({
	Name = "Entities"
})

MainTab:AddToggle({
	Name = "Warnings",
	Default = false,
    Flag = "Warnings",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Bypass Seek",
	Default = false,
    Flag = "BypassSeek",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Harmless Screech",
	Default = false,
    Flag = "BypassScreech",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "Harmless Eyes",
	Default = false,
    Flag = "BypassEyes",
	Callback = function()end
})

MainTab:AddSection({
	Name = "Other"
})

MainTab:AddToggle({
	Name = "Always Win Heartbeat",
	Default = false,
    Flag = "Heartbeat",
	Callback = function()end
})

MainTab:AddToggle({
	Name = "No E Wait",
	Default = false,
    Flag = "NoEWait",
	Callback = function()end
})

local VisualsTab = Window:MakeTab({
	Name = "Visuals",
	Icon = "rbxassetid://4483345998"
})

VisualsTab:AddSection({
	Name = "Esp"
})

VisualsTab:AddToggle({
	Name = "Entity Esp",
	Default = false,
    Flag = "EntityEsp",
	Callback = function()end
})

VisualsTab:AddToggle({
	Name = "Door Esp",
	Default = false,
    Flag = "DoorEsp",
	Callback = function()end
})

VisualsTab:AddToggle({
	Name = "Objective Esp",
	Default = false,
    Flag = "ObjectiveEsp",
	Callback = function()end
})

VisualsTab:AddSection({
	Name = "Misc"
})

VisualsTab:AddToggle({
	Name = "Full Bright",
	Default = false,
    Flag = "FullBright",
	Callback = function(v)
        if v then
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
            game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
            return
        end
        game:GetService("Lighting").Ambient = Color3.new(0.262745, 0.2, 0.219608)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Top = Color3.new(0.823529, 0.854902, 1)
    end
})

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998"
})

PlayerTab:AddSection({
	Name = "Humanoid"
})

PlayerTab:AddToggle({
	Name = "Toggle WalkSpeed",
	Default = false,
    Flag = "WalkSpeed",
	Callback = function()end
})

PlayerTab:AddSlider({
	Name = "WalkSpeed Value",
	Min = 15,
	Max = 24,
	Default = 15,
	Flag = "WalkSpeedValue",
	Increment = 1,
	ValueName = "%",
	Callback = function(v)
        if OrionLib.Flags["WalkSpeed"].Value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
    end
})

PlayerTab:AddSection({
	Name = "Character"
})

PlayerTab:AddToggle({
	Name = "Semi Noclip",
    Flag = "Noclip",
	Default = false,
	Callback = function(a)
        if not a then
            for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                if v:IsA("BasePart") and not v.CanCollide then
                    v.CanCollide = true
                end
            end
            return
        end
        for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") and v.CanCollide then
               v.CanCollide = false
            end
        end
    end
})

game:GetService("Players").LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if OrionLib.Flags["WalkSpeed"].Value then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = OrionLib.Flags["WalkSpeedValue"].Value
    end
end)

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(v)
    if OrionLib.Flags["NoEWait"].Value then
        pcall(function()
            v.HoldDuration = 0
            fireproximityprompt(v)
        end)
    end
end)

game:GetService("Lighting").Changed:Connect(function()
    if OrionLib.Flags["FullBright"].Value then
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
        game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
    else
        game:GetService("Lighting").Ambient = Color3.new(0.262745, 0.2, 0.219608)
        game:GetService("Lighting").ColorShift_Bottom = Color3.new(0, 0, 0)
        game:GetService("Lighting").ColorShift_Top = Color3.new(0.823529, 0.854902, 1)
    end
end)

game:GetService("Workspace").CurrentRooms.ChildAdded:Connect(function(v)
    if OrionLib.Flags["BypassSeek"].Value then
        local seek_trigger = v:WaitForChild("TriggerEventCollision", 10)
        if seek_trigger then
            seek_trigger:Destroy()
        end
    end
end)

game:GetService("Workspace").ChildAdded:Connect(function(v)
    if table.find(Entities, v.Name) and (OrionLib.Flags["Warnings"].Value or OrionLib.Flags["EntityEsp"].Value) then
        repeat wait(0.1) until not workspace:FindFirstChild(v.Name) or game.Players.LocalPlayer:DistanceFromCharacter(v:GetPivot().Position) < 1500
        if workspace:FindFirstChild(v.Name) then
            if OrionLib.Flags["Warnings"].Value then
                OrionLib:MakeNotification({
                    Name = "Warning!",
                    Content = v.Name:gsub("Moving", "") .. " has spawned!",
                    Image = "rbxassetid://4483345998",
                    Time = 5
                })
            end
            if OrionLib.Flags["EntityEsp"].Value then
                local Tracer = Drawing.new("Line")
                Tracer.Visible = false
                Tracer.Thickness = 1
                Tracer.Transparency = 1

                local Text = Drawing.new("Text")
                Text.Visible = false
                Text.Center = true
                Text.Outline = true
                Text.Text = v.Name:gsub("Moving", "")
                Text.Size = 17

                local RushEsp = game.RunService.RenderStepped:Connect(function()
                    local Vector, onScreen = workspace.CurrentCamera:worldToViewportPoint(v.PrimaryPart.Position)
                    if onScreen then
                        if OrionLib.Flags["EntityEsp"].Value then
                            Text.Visible = true
                            Text.Color = Color3.fromRGB(241, 196, 15)
                            Text.Position = Vector2.new(Vector.X, Vector.Y - 30)
                            Tracer.Visible = true
                            Tracer.Color = Color3.fromRGB(241, 196, 15)
                            Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                            Tracer.To = Vector2.new(Vector.X, Vector.Y)
                        else
                            Tracer.Visible = false
                            Text.Visible = false
                        end
                    else
                        Tracer.Visible = false
                        Text.Visible = false
                    end
                end)
                
                v.Destroying:Wait()
                RushEsp:Disconnect()
                Tracer:Remove()
                Text:Remove()
            end
        end
    end
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    local method = getnamecallmethod()

    if tostring(self) == "Screech" and tostring(method) == "FireServer" and OrionLib.Flags["BypassScreech"].Value then
        args[1] = true
        return oldNamecall(self, unpack(args))
    end
    if tostring(self) == "ClutchHeartbeat" and tostring(method) == "FireServer" and OrionLib.Flags["Heartbeat"].Value then
        args[2] = true
        return oldNamecall(self, unpack(args))
    end
    if tostring(self) == "MotorReplication" and tostring(method) == "FireServer" and OrionLib.Flags["BypassEyes"].Value then
        args[2] = 90
        return oldNamecall(self, unpack(args))
    end

    return oldNamecall(self, ...)
end))

while wait(0.8) do
    if OrionLib.Flags["DoorEsp"].Value then
        if LatestRoom.Value ~= 49 and LatestRoom.Value ~= 50 then
            for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
                if LatestRoom.Value == tonumber(v.Name) then
                    if v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") and not v.Door.Door:FindFirstChild("Highlight") then
                        if v.Door:FindFirstChild("Lock") then
                            Instance.new("Highlight", v.Door.Door).FillColor = Color3.fromRGB(136, 78, 160)
                        else
                            Instance.new("Highlight", v.Door.Door).FillColor = Color3.fromRGB(241, 196, 15)
                        end
                    end
                    if v:FindFirstChild("Closet") and v.Closet:FindFirstChild("DoorNormal") and not v.Closet.DoorNormal:FindFirstChild("Highlight") then
                        Instance.new("Highlight", v.Closet.DoorNormal).FillColor = Color3.fromRGB(136, 78, 160)
                    end
                else
                    if v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") and v.Door.Door:FindFirstChild("Highlight") then
                        v.Door.Door.Highlight:Destroy()
                    end
                    if v:FindFirstChild("Closet") and v.Closet:FindFirstChild("DoorNormal") and v.Closet.DoorNormal:FindFirstChild("Highlight") then
                        v.Closet.DoorNormal.Highlight:Destroy()
                    end
                end
            end
        end
    else
        for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
            if v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") and v.Door.Door:FindFirstChild("Highlight") then
                v.Door.Door.Highlight:Destroy()
            end
            if v:FindFirstChild("Closet") and v.Closet:FindFirstChild("DoorNormal") and v.Closet.DoorNormal:FindFirstChild("Highlight") then
                v.Closet.DoorNormal.Highlight:Destroy()
            end
        end
    end
    if OrionLib.Flags["ObjectiveEsp"].Value then
        for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
            if LatestRoom.Value == tonumber(v.Name) then
                if v:FindFirstChild("Assets") then
                    local key = v.Assets:FindFirstChild("KeyObtain", true)
                    if key and not key:FindFirstChild("Highlight") then
                        Instance.new("Highlight", key).FillColor = Color3.fromRGB(241, 196, 15)
                    end
                    local lever = v.Assets:FindFirstChild("LeverForGate", true)
                    if lever and not lever:FindFirstChild("Highlight") then
                        Instance.new("Highlight", lever).FillColor = Color3.fromRGB(241, 196, 15)
                    end
                    if LatestRoom.Value == 50 then
                        for _,v in pairs(v.Assets:GetDescendants()) do
                            if v.Name == "LiveHintBook" and not v:FindFirstChild("Highlight") then
                                Instance.new("Highlight", v).FillColor = Color3.fromRGB(241, 196, 15)
                            end
                        end
                    end
                    if LatestRoom.Value == 100 then
                        for _,v in pairs(v.Assets:GetDescendants()) do
                            if v.Name == "LiveBreakerPolePickup" and not v:FindFirstChild("Highlight") then
                                Instance.new("Highlight", v).FillColor = Color3.fromRGB(241, 196, 15)
                            end
                        end
                    end
                end
            else
                if v:FindFirstChild("Assets") then
                    local key = v.Assets:FindFirstChild("KeyObtain", true)
                    if key and key:FindFirstChild("Highlight") then
                        key.Highlight:Destroy()
                    end
                    local lever = v.Assets:FindFirstChild("LeverForGate", true)
                    if lever and lever:FindFirstChild("Highlight") then
                        lever.Highlight:Destroy()
                    end
                    if LatestRoom.Value == 50 then
                        for _,v in pairs(v.Assets:GetDescendants()) do
                            if v.Name == "LiveHintBook" and v:FindFirstChild("Highlight") then
                                v.Highlight:Destroy()
                            end
                        end
                    end
                    if LatestRoom.Value == 100 then
                        for _,v in pairs(v.Assets:GetDescendants()) do
                            if v.Name == "LiveBreakerPolePickup" and v:FindFirstChild("Highlight") then
                                v.Highlight:Destroy()
                            end
                        end
                    end
                end
            end
        end
    else
        for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
            if v:FindFirstChild("Assets") then
                local key = v.Assets:FindFirstChild("KeyObtain", true)
                if key and key:FindFirstChild("Highlight") then
                    key.Highlight:Destroy()
                end
                local lever = v.Assets:FindFirstChild("LeverForGate", true)
                if lever and lever:FindFirstChild("Highlight") then
                    lever.Highlight:Destroy()
                end
                if LatestRoom.Value == 50 then
                    for _,v in pairs(v.Assets:GetDescendants()) do
                        if v.Name == "LiveHintBook" and v:FindFirstChild("Highlight") then
                            v.Highlight:Destroy()
                        end
                    end
                end
                if LatestRoom.Value == 100 then
                    for _,v in pairs(v.Assets:GetDescendants()) do
                        if v.Name == "LiveBreakerPolePickup" and v:FindFirstChild("Highlight") then
                            v.Highlight:Destroy()
                        end
                    end
                end
            end
        end
    end
    if OrionLib.Flags["EntityEsp"].Value then
        if LatestRoom.Value == 50 or LatestRoom.Value == 100 then
            for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
                if v:FindFirstChild("FigureSetup") and v.FigureSetup:FindFirstChild("FigureRagdoll") and not v.FigureSetup.FigureRagdoll:FindFirstChild("Highlight") then
                    Instance.new("Highlight", v.FigureSetup.FigureRagdoll).FillColor = Color3.fromRGB(241, 196, 15)
                end
            end
        end
    else
        for _,v in pairs(workspace.CurrentRooms:GetChildren()) do
            if v:FindFirstChild("FigureSetup") and v.FigureSetup:FindFirstChild("FigureRagdoll") and v.FigureSetup.FigureRagdoll:FindFirstChild("Highlight") then
                v.FigureSetup.FigureRagdoll.Highlight:Destroy()
            end
        end
    end
    if OrionLib.Flags["Noclip"].Value then
        for _,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("BasePart") and v.CanCollide then
               v.CanCollide = false
            end
        end
    end
end
