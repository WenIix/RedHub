-- LocalScript: RedHub GUI (injector version) + safe external-run helper
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- CONFIG
local DISCORD_URL = "https://discord.gg/9a3eaGvTYp"
local WINDOW_NAME = "RedHub"

-- EXTERNAL runstring (the one you asked about)
local EXTERNAL_RAW = "https://raw.githubusercontent.com/discoworkr-web/RedHub/refs/heads/main/script/ark.lua"
local EXTERNAL_RUN_CMD = ("loadstring(game:HttpGet(%q))()"):format(EXTERNAL_RAW)

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.45, 0, 0.36, 0)
frame.Position = UDim2.new(0.275, 0, 0.32, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 1
frame.BorderColor3 = Color3.fromRGB(60, 60, 60)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 14)
frameCorner.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Text = WINDOW_NAME
title.Size = UDim2.new(0.4, 0, 0.16, 0)
title.Position = UDim2.new(0.04, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSans
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Copy Discord Link Button
local copyButton = Instance.new("TextButton")
copyButton.Text = "🔗  Copy Discord Link"
copyButton.Size = UDim2.new(0.65, 0, 0.12, 0)
copyButton.Position = UDim2.new(0.175, 0, 0.14, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(88,101,242)
copyButton.TextColor3 = Color3.fromRGB(255,255,255)
copyButton.Font = Enum.Font.SourceSans
copyButton.TextSize = 18
copyButton.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0,10)
copyCorner.Parent = copyButton

-- External Menu copy button (safe helper)
local extButton = Instance.new("TextButton")
extButton.Text = "Copy External Run Command"
extButton.Size = UDim2.new(0.65, 0, 0.11, 0)
extButton.Position = UDim2.new(0.175, 0, 0.28, 0)
extButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
extButton.TextColor3 = Color3.fromRGB(255,255,255)
extButton.Font = Enum.Font.SourceSans
extButton.TextSize = 16
extButton.Parent = frame

local extCorner = Instance.new("UICorner")
extCorner.CornerRadius = UDim.new(0,8)
extCorner.Parent = extButton

-- small helper label under extButton to show instruction (initially hidden)
local extHint = Instance.new("TextLabel")
extHint.Text = "Run command copied — inspect before executing in your executor."
extHint.Size = UDim2.new(0.65, 0, 0.08, 0)
extHint.Position = UDim2.new(0.175, 0, 0.395, 0)
extHint.BackgroundTransparency = 1
extHint.TextColor3 = Color3.fromRGB(200,200,200)
extHint.Font = Enum.Font.SourceSans
extHint.TextSize = 14
extHint.TextWrapped = true
extHint.TextXAlignment = Enum.TextXAlignment.Left
extHint.Visible = false
extHint.Parent = frame

-- Key Box
local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "Enter the key... (key in Discord server)"
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.Size = UDim2.new(0.65, 0, 0.12, 0)
keyBox.Position = UDim2.new(0.175, 0, 0.505, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
keyBox.TextColor3 = Color3.fromRGB(235,235,235)
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 16
keyBox.Parent = frame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0,8)
keyCorner.Parent = keyBox

-- Enter Key Button (под текстовым полем)
local enterButton = Instance.new("TextButton")
enterButton.Text = "Enter Key"
enterButton.Size = UDim2.new(0.65, 0, 0.12, 0)
enterButton.Position = UDim2.new(0.175, 0, 0.645, 0)
enterButton.BackgroundColor3 = Color3.fromRGB(88,101,242)
enterButton.TextColor3 = Color3.fromRGB(255,255,255)
enterButton.Font = Enum.Font.SourceSans
enterButton.TextSize = 18
enterButton.Parent = frame

local enterCorner = Instance.new("UICorner")
enterCorner.CornerRadius = UDim.new(0,10)
enterCorner.Parent = enterButton

-- small info under enter button
local enterHint = Instance.new("TextLabel")
enterHint.Text = "(key in Discord server)"
enterHint.Size = UDim2.new(0.65,0,0.07,0)
enterHint.Position = UDim2.new(0.175,0,0.785,0)
enterHint.BackgroundTransparency = 1
enterHint.TextColor3 = Color3.fromRGB(200,200,200)
enterHint.Font = Enum.Font.SourceSans
enterHint.TextSize = 14
enterHint.TextXAlignment = Enum.TextXAlignment.Left
enterHint.Parent = frame

-- Helper Functions
local function tryCopyToClipboard(text)
    local ok = false
    pcall(function()
        if setclipboard then
            setclipboard(text)
            ok = true
        elseif syn and syn.set_clipboard then
            syn.set_clipboard(text)
            ok = true
        end
    end)
    return ok
end

local function notify(msg)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "RedHub",
            Text = msg,
            Duration = 3
        })
    end)
end

local function flashButtonText(button, newText, delaySec)
    local orig = button.Text
    button.Text = newText
    task.delay(delaySec or 3, function()
        if button and button.Parent then
            button.Text = orig
        end
    end)
end

-- Button Events
copyButton.MouseButton1Click:Connect(function()
    local ok = tryCopyToClipboard(DISCORD_URL)
    if ok then
        flashButtonText(copyButton, "Copied!", 3)
    else
        flashButtonText(copyButton, "Copied!", 3)
        notify("Copy not supported.")
    end
end)

enterButton.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then
        notify("Please enter a key!")
    else
        notify("Key entered: " .. key)
    end
end)

extButton.MouseButton1Click:Connect(function()
    local ok = tryCopyToClipboard(EXTERNAL_RUN_CMD)
    if ok then
        extHint.Visible = true
        notify("External run command copied to clipboard. Inspect before executing.")
        task.delay(6, function()
            if extHint and extHint.Parent then
                extHint.Visible = false
            end
        end)
    else
        notify("Cannot copy external command to clipboard.")
    end
end)

-- Auto-copy Discord on
