-- Trade Freeze GUI with minimize + notifications
if game.CoreGui:FindFirstChild("TradeFreezeUI") then
    game.CoreGui:FindFirstChild("TradeFreezeUI"):Destroy()
end

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TradeFreezeUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 150)
Frame.Position = UDim2.new(0.5, -110, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Corner rounding
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Frame
local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Trade Freeze"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 1, 0)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundTransparency = 1
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

-- Buttons
local function createButton(text, yPos, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.8, 0, 0, 35)
    btn.Position = UDim2.new(0.1, 0, 0, yPos)
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.Parent = Frame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local FreezeBtn = createButton("Freeze Trade", 40, Color3.fromRGB(200, 50, 50))
local ForceBtn = createButton("Force Accept", 90, Color3.fromRGB(50, 200, 50))

-- Notification system
local function showNotification(message)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 180, 0, 40)
    notif.Position = UDim2.new(1, 200, 0.8, 0)
    notif.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextSize = 14
    textLabel.Font = Enum.Font.Gotham
    textLabel.Parent = notif

    -- Slide in
    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, -190, 0.8, 0)}):Play()

    -- Stay, then slide out
    task.delay(2, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, 200, 0.8, 0)}):Play()
        task.delay(0.4, function() notif:Destroy() end)
    end)
end

-- Button events
FreezeBtn.MouseButton1Click:Connect(function()
    showNotification("Trade Frozen!")
    -- Actual freeze trade logic goes here
end)

ForceBtn.MouseButton1Click:Connect(function()
    showNotification("Trade Forced!")
    -- Actual force accept logic goes here
end)

-- Minimized icon
local MinimizedBtn = Instance.new("TextButton")
MinimizedBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizedBtn.Position = UDim2.new(0, 20, 0, 200)
MinimizedBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MinimizedBtn.Text = "TF"
MinimizedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedBtn.TextSize = 14
MinimizedBtn.Font = Enum.Font.GothamBold
MinimizedBtn.Visible = false
MinimizedBtn.Active = true
MinimizedBtn.Draggable = true
Instance.new("UICorner", MinimizedBtn).CornerRadius = UDim.new(0, 8)
MinimizedBtn.Parent = ScreenGui

CloseBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    MinimizedBtn.Visible = true
end)

MinimizedBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    MinimizedBtn.Visible = false
end)
