local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local Backpack = player:WaitForChild("Backpack")

-- Fade out existing DupeMenu if it exists
local existingGui = player:FindFirstChild("PlayerGui"):FindFirstChild("DupeMenu")
if existingGui then
    for _, guiObject in pairs(existingGui:GetDescendants()) do
        if guiObject:IsA("Frame") or guiObject:IsA("TextButton") or guiObject:IsA("ImageButton") or guiObject:IsA("ImageLabel") then
            local tweenProperties = {}
            if guiObject:IsA("TextButton") or guiObject:IsA("TextLabel") then
                tweenProperties.TextTransparency = 1
            end
            if guiObject:IsA("ImageLabel") or guiObject:IsA("ImageButton") then
                tweenProperties.ImageTransparency = 1
            end
            tweenProperties.BackgroundTransparency = 1

            local tween = TweenService:Create(guiObject, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), tweenProperties)
            tween:Play()
        end
    end
    task.wait(0.5)
    existingGui:Destroy()
end

-- === Your previous code continues here ===

local TextColor = Color3.fromRGB(255, 255, 255)
local BackgroundColor = Color3.fromRGB(0, 0, 0)               
local ElementBackgroundColor = Color3.fromRGB(255, 255, 255)  
local ElementBackgroundHoverColor = Color3.fromRGB(230, 230, 230) 
local ElementStrokeColor = Color3.fromRGB(255, 57, 57)        
local GlowColor = Color3.fromRGB(255, 255, 255)

local function makeDraggable(guiElement)
    local dragging = false
    local dragStart, startPos

    guiElement.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiElement.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            guiElement.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- === The rest of your code (ScreenGui creation, buttons, dupe logic, etc.) continues unchanged ===


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DupeMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 120, 0, 50)  
toggleButton.Position = UDim2.new(0, 10, 0, 50)
toggleButton.Image = "rbxassetid://132219788588936"
toggleButton.BackgroundColor3 = BackgroundColor
toggleButton.BackgroundTransparency = 1
toggleButton.ScaleType = Enum.ScaleType.Stretch  
Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 8)


local toggleStroke = Instance.new("UIStroke", toggleButton)
toggleStroke.Color = GlowColor
toggleStroke.Thickness = 3
toggleStroke.Transparency = 0.3
toggleStroke.LineJoinMode = Enum.LineJoinMode.Round

toggleButton.Parent = screenGui
makeDraggable(toggleButton)


local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 180, 0, 180) 
frame.Position = UDim2.new(0.5, -175, 0.5, -110)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = BackgroundColor  
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)


local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = GlowColor
frameStroke.Thickness = 3
frameStroke.Transparency = 0.3
frameStroke.LineJoinMode = Enum.LineJoinMode.Round

frame.Parent = screenGui
frame.Visible = false
makeDraggable(frame)


local titleImage = Instance.new("ImageLabel")
titleImage.Image = "rbxassetid://132219788588936"
titleImage.BackgroundTransparency = 1
titleImage.Size = UDim2.new(1, 0, 0.40, 0)
titleImage.Position = UDim2.new(0, 0, 0, 0)
titleImage.ScaleType = Enum.ScaleType.Stretch
titleImage.Parent = frame
local titleUICorner = Instance.new("UICorner", titleImage)
titleUICorner.CornerRadius = UDim.new(0, 12)


local dupeButton = Instance.new("TextButton")
dupeButton.Size = UDim2.new(0.6, 0, 0.18, 0)
dupeButton.Position = UDim2.new(0.2, 0, 0.45, 0) -- moved down
dupeButton.Text = "Dupe: OFF"
dupeButton.Font = Enum.Font.GothamBold
dupeButton.TextColor3 = Color3.new(1, 1, 1)  -- Keep text white for visibility
dupeButton.TextSize = 18
dupeButton.BackgroundColor3 = Color3.new(0, 0, 0)  -- Black button
local dupeUICorner = Instance.new("UICorner", dupeButton)
dupeUICorner.CornerRadius = UDim.new(0, 8)


local dupeStroke = Instance.new("UIStroke", dupeButton)
dupeStroke.Color = ElementStrokeColor
dupeStroke.Thickness = 0
dupeStroke.Transparency = 0
dupeStroke.LineJoinMode = Enum.LineJoinMode.Round

dupeButton.Parent = frame


local helpButton = Instance.new("TextButton")
helpButton.Size = UDim2.new(0.6, 0, 0.16, 0)
helpButton.Position = UDim2.new(0.2, 0, 0.75, 0) -- moved down
helpButton.Text = "How To Dupe"
helpButton.Font = Enum.Font.GothamBold
helpButton.TextColor3 = Color3.new(1, 1, 1)  -- White text for visibility
helpButton.TextSize = 16
helpButton.BackgroundColor3 = Color3.new(0, 0, 0)  -- Black button
local helpUICorner = Instance.new("UICorner", helpButton)
helpUICorner.CornerRadius = UDim.new(0, 8)



local helpStroke = Instance.new("UIStroke", helpButton)
helpStroke.Color = ElementStrokeColor
helpStroke.Thickness = 0
helpStroke.Transparency = 0
helpStroke.LineJoinMode = Enum.LineJoinMode.Round

helpButton.Parent = frame


toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)





local tweenInfo = TweenInfo.new(
    1,                   
    Enum.EasingStyle.Sine,
    Enum.EasingDirection.InOut,
    -1,                  
    true                 
)

local goal = {Transparency = 0.8}

local heartbeatTweenFrame = TweenService:Create(frameStroke, tweenInfo, goal)
heartbeatTweenFrame:Play()

local heartbeatTweenToggle = TweenService:Create(toggleStroke, tweenInfo, goal)
heartbeatTweenToggle:Play()


local autoDupe = false
local dupeCoroutine

local RunService = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local Players = cloneref(game:GetService("Players"))
local Backpack = player:WaitForChild("Backpack")

local storedToolName = nil


local function getPing()
    local Player = Players.LocalPlayer

    if typeof(Player.GetNetworkPing) == "function" then
        local success, result = pcall(function()
            return tonumber(string.match(Player:GetNetworkPing(), "%d+"))
        end)
        if success and result then
            return result
        end
    end

    local t0 = tick()
    local temp = Instance.new("BoolValue", ReplicatedStorage)
    temp.Name = "PingTest_" .. tostring(math.random(10000,99999))
    task.wait(0.1)
    local t1 = tick()
    temp:Destroy()

    return math.clamp((t1 - t0) * 1000, 50, 300)
end


local function dupeOnce()
    local Player = Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Backpack = Player:WaitForChild("Backpack")


    local tool = Backpack:FindFirstChild(storedToolName)
    if tool then
        local humanoid = Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:EquipTool(tool)
            task.wait(0.4)
        end
    end

    local Tool = Character:FindFirstChildOfClass("Tool")
    if not Tool then
        warn("No tool equipped.")
        return
    end

    Tool.Parent = Backpack
    task.wait(0.5)

    local ToolName = storedToolName
    local ToolId = nil

    local ping = getPing()
    local delay = 0.25 + ((math.clamp(ping, 0, 300) / 300) * 0.03)

    local marketconnection = ReplicatedStorage.MarketItems.ChildAdded:Connect(function(item)
        if item.Name == ToolName then
            local owner = item:WaitForChild("owner", 2)
            if owner and owner.Value == Player.Name then
                ToolId = item:GetAttribute("SpecialId")
            end
        end
    end)


    task.spawn(function()
        ReplicatedStorage.ListWeaponRemote:FireServer(ToolName, 99999)
    end)


    task.wait(delay)


    task.spawn(function()
        ReplicatedStorage.BackpackRemote:InvokeServer("Store", ToolName)
    end)

    task.wait(3)


    if ToolId then
        task.spawn(function()
            ReplicatedStorage.BuyItemRemote:FireServer(ToolName, "Remove", ToolId)
        end)
    end

    task.spawn(function()
        ReplicatedStorage.BackpackRemote:InvokeServer("Grab", ToolName)
    end)

    marketconnection:Disconnect()
    task.wait(1)
end


dupeButton.MouseButton1Click:Connect(function()
    autoDupe = not autoDupe
    dupeButton.Text = autoDupe and "Dupe: ON" or "Dupe: OFF"

    if autoDupe then

        local character = player.Character or player.CharacterAdded:Wait()
        local equipped = character:FindFirstChildOfClass("Tool")
        if equipped then
            storedToolName = equipped.Name
            print("Stored tool name:", storedToolName)
        else
            warn("Equip a tool first before enabling dupe.")
            autoDupe = false
            dupeButton.Text = "Dupe: OFF"
            return
        end


        if dupeCoroutine == nil or coroutine.status(dupeCoroutine) == "dead" then
            dupeCoroutine = coroutine.create(function()
                while autoDupe do
                    dupeOnce()
                    task.wait(0.3)
                end
            end)
            coroutine.resume(dupeCoroutine)
        end
    end
end)


helpButton.MouseButton1Click:Connect(function()
    local TweenService = game:GetService("TweenService")

    local howToDupeUI = Instance.new("ScreenGui")
    howToDupeUI.Name = "HowToDupeUI"
    howToDupeUI.Parent = player:WaitForChild("PlayerGui")  

    local f = Instance.new("Frame")
    f.Size = UDim2.new(0, 300, 0, 180)
    f.Position = UDim2.new(0, 10, 1, -258)
    f.BackgroundColor3 = BackgroundColor 
    f.AnchorPoint = Vector2.new(0, 0)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 12)
    f.Parent = howToDupeUI

    local fStroke = Instance.new("UIStroke", f)
    fStroke.Color = GlowColor
    fStroke.Thickness = 3
    fStroke.Transparency = 0.3
    fStroke.LineJoinMode = Enum.LineJoinMode.Round

    local tweenInfo = TweenInfo.new(
        1,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut,
        -1,
        true
    )
    local goal = {Transparency = 0.8}
    local heartbeatTweenFrame = TweenService:Create(fStroke, tweenInfo, goal)
    heartbeatTweenFrame:Play()

    local tb = Instance.new("Frame")
    tb.Size = UDim2.new(1, 0, 0, 30)
    tb.BackgroundColor3 = BackgroundColor
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 12)
    tb.Parent = f

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -50, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "How To Dupe (Note: Buggy)"
    title.Font = Enum.Font.GothamBold
    title.TextColor3 = TextColor
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = tb

    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0.5, -10)
    closeButton.Text = "X"
    closeButton.Font = Enum.Font.GothamBold
    closeButton.TextColor3 = TextColor
    closeButton.TextSize = 14
    closeButton.BackgroundColor3 = ElementBackgroundHoverColor
    local closeUICorner = Instance.new("UICorner", closeButton)
    closeUICorner.CornerRadius = UDim.new(0, 8)
    closeButton.Parent = tb

    local closeStroke = Instance.new("UIStroke", closeButton)
    closeStroke.Color = ElementStrokeColor
    closeStroke.Thickness = 2
    closeStroke.Transparency = 0.2
    closeStroke.LineJoinMode = Enum.LineJoinMode.Round

    local heartbeatTweenClose = TweenService:Create(closeStroke, tweenInfo, goal)
    heartbeatTweenClose:Play()

    local b = Instance.new("TextLabel")
    b.Size = UDim2.new(1, -20, 1, -55)
    b.Position = UDim2.new(0, 10, 0, 40)
    b.BackgroundTransparency = 1
    b.Text = [[
This dupe tool is a bit buggy:
Equip whatever tool or item you want to duplicate and toggle it on.
]]
    b.TextWrapped = true
    b.Font = Enum.Font.Gotham
    b.TextColor3 = TextColor
    b.TextSize = 14
    b.Parent = f

    closeButton.MouseButton1Click:Connect(function()
        howToDupeUI:Destroy()
    end)
end)

