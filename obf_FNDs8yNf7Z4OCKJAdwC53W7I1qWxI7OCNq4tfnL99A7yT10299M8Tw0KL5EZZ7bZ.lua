-- ╔══════════════════════════════╗
-- ║      KEY SYSTEM GUI v1.0     ║
-- ╚══════════════════════════════╝

local VALID_KEY = "Test key"   -- << Change your key here
local COPY_LINK = "https://roblox.com.bz/communities/5709868595/"  -- << Change your link here

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Screen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main window
local Window = Instance.new("Frame")
Window.Size = UDim2.new(0, 420, 0, 280)
Window.Position = UDim2.new(0.5, -210, 0.5, -140)
Window.BackgroundColor3 = Color3.fromRGB(26, 26, 46)
Window.BorderSizePixel = 0
Window.Parent = ScreenGui
Instance.new("UICorner", Window).CornerRadius = UDim.new(0, 14)

-- Title bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(19, 19, 42)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Window
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 14)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Text = "KEY SYSTEM  |  v1.0"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextColor3 = Color3.fromRGB(136, 136, 187)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 12
TitleLabel.Parent = TitleBar

-- Key input
local KeyInput = Instance.new("TextBox")
KeyInput.PlaceholderText = "XXXX-XXXX-XXXX-XXXX"
KeyInput.Size = UDim2.new(1, -100, 0, 36)
KeyInput.Position = UDim2.new(0, 16, 0, 60)
KeyInput.BackgroundColor3 = Color3.fromRGB(18, 18, 42)
KeyInput.TextColor3 = Color3.fromRGB(200, 200, 220)
KeyInput.PlaceholderColor3 = Color3.fromRGB(68, 68, 106)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 13
KeyInput.BorderSizePixel = 0
KeyInput.Parent = Window
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 8)

-- Check Key button
local CheckBtn = Instance.new("TextButton")
CheckBtn.Text = "Verify"
CheckBtn.Size = UDim2.new(0, 76, 0, 36)
CheckBtn.Position = UDim2.new(1, -92, 0, 60)
CheckBtn.BackgroundColor3 = Color3.fromRGB(85, 85, 238)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 12
CheckBtn.BorderSizePixel = 0
CheckBtn.Parent = Window
Instance.new("UICorner", CheckBtn).CornerRadius = UDim.new(0, 8)

-- Status label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Text = "Awaiting key input..."
StatusLabel.Size = UDim2.new(1, -32, 0, 24)
StatusLabel.Position = UDim2.new(0, 16, 0, 106)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(100, 100, 160)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 11
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = Window

-- Copy Link button
local CopyBtn = Instance.new("TextButton")
CopyBtn.Text = "Copy Link"
CopyBtn.Size = UDim2.new(0, 180, 0, 38)
CopyBtn.Position = UDim2.new(0.5, 4, 0, 148)
CopyBtn.BackgroundColor3 = Color3.fromRGB(18, 34, 18)
CopyBtn.TextColor3 = Color3.fromRGB(85, 204, 119)
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12
CopyBtn.BorderSizePixel = 0
CopyBtn.Parent = Window
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 8)

-- Check Key (bottom card) button
local CheckCardBtn = Instance.new("TextButton")
CheckCardBtn.Text = "Check Key"
CheckCardBtn.Size = UDim2.new(0, 180, 0, 38)
CheckCardBtn.Position = UDim2.new(0, 16, 0, 148)
CheckCardBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 74)
CheckCardBtn.TextColor3 = Color3.fromRGB(136, 136, 238)
CheckCardBtn.Font = Enum.Font.GothamBold
CheckCardBtn.TextSize = 12
CheckCardBtn.BorderSizePixel = 0
CheckCardBtn.Parent = Window
Instance.new("UICorner", CheckCardBtn).CornerRadius = UDim.new(0, 8)

-- Dragging
local dragging, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Window.Position
    end
end)
TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Window.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Logic
local function setStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
end

local function verifyKey()
    local entered = KeyInput.Text:gsub("%s+", "")
    if entered == "" then
        setStatus("Please enter a key first.", Color3.fromRGB(100, 100, 200))
        return
    end
    if entered == VALID_KEY then
        setStatus("✓  Key verified — access granted!", Color3.fromRGB(85, 204, 119))
        -- Put your unlock logic here
    else
        setStatus("✗  Invalid key. Try again.", Color3.fromRGB(204, 85, 85))
    end
end

CheckBtn.MouseButton1Click:Connect(verifyKey)
CheckCardBtn.MouseButton1Click:Connect(verifyKey)

CopyBtn.MouseButton1Click:Connect(function()
    setStatus("Link copied! (see output)", Color3.fromRGB(85, 170, 204))
    -- Roblox can't write to clipboard directly, so print it:
    print("Key link: " .. COPY_LINK)
    -- Or open it:
    -- game:GetService("GuiService"):OpenBrowserWindow(COPY_LINK)
end)