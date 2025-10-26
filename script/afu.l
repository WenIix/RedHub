-- LocalScript: RedHub GUI (centered, fixed layout, English text, working Discord copy)
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === CONFIG ===
local DISCORD_URL = "https://discord.gg/your-invite" -- replace with your invite link
local WINDOW_NAME = "RedHub"

-- === Create ScreenGui ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- === Main Frame ===
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0.6, 0, 0.3, 0) -- bigger panel
frame.Position = UDim2.new(0.2, 0, 0.35, 0)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(70, 70, 70)
outline.Thickness = 1
outline.Parent = frame

-- === Title ===
local title = Instance.new("TextLabel")
title.Text = WINDOW_NAME
title.Size = UDim2.new(1, 0, 0.25, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.Parent = frame

-- === Key Box ===
local keyBox = Instance.new("TextBox")
keyBox.PlaceholderText = "Enter Key"
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.Size = UDim2.new(0.6, 0, 0.18, 0)
keyBox.Position = UDim2.new(0.2, 0, 0.35, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.fromRGB(235, 235, 235)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.Parent = frame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

-- === Enter Button ===
local enterButton = Instance.new("TextButton")
enterButton.Text = "Enter"
enterButton.Size = UDim2.new(0.3, 0, 0.18, 0)
enterButton.Position = UDim2.new(0.35, 0, 0.56, 0)
enterButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
enterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
enterButton.Font = Enum.Font.GothamBold
enterButton.TextSize = 20
enterButton.Parent = frame

local enterCorner = Instance.new("UICorner")
enterCorner.CornerRadius = UDim.new(0, 10)
enterCorner.Parent = enterButton

-- === Copy Discord Button (above Enter) ===
local copyButton = Instance.new("TextButton")
copyButton.Text = "Copy Discord"
copyButton.Size = UDim2.new(0.3, 0, 0.18, 0)
copyButton.Position = UDim2.new(0.35, 0, 0.16, 0)
copyButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 20
copyButton.Parent = frame

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 10)
copyCorner.Parent = copyButton

-- === Discord Icon (centered under Enter) ===
local discordIcon = Instance.new("TextButton")
discordIcon.Text = "💬"
discordIcon.Size = UDim2.new(0.12, 0, 0.25, 0)
discordIcon.Position = UDim2.new(0.44, 0, 0.76, 0)
discordIcon.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
discordIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
discordIcon.Font = Enum.Font.GothamBold
discordIcon.TextSize = 24
discordIcon.Parent = frame

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 12)
iconCorner.Parent = discordIcon

-- === Helper functions ===
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
			Duration = 4
		})
	end)
end

-- === Button Events ===
copyButton.MouseButton1Click:Connect(function()
	local ok = tryCopyToClipboard(DISCORD_URL)
	if ok then
		notify("Discord link copied to clipboard!")
	else
		notify("Copy not supported, opening link.")
	end
	pcall(function()
		GuiService:OpenBrowserWindow(DISCORD_URL)
	end)
end)

discordIcon.MouseButton1Click:Connect(function()
	local ok = tryCopyToClipboard(DISCORD_URL)
	if ok then
		notify("Discord link copied!")
	else
		notify("Opening Discord link.")
	end
	pcall(function()
		GuiService:OpenBrowserWindow(DISCORD_URL)
	end)
end)

enterButton.MouseButton1Click:Connect(function()
	local key = keyBox.Text
	if key == "" then
		notify("Please enter a key!")
	else
		notify("Key entered: " .. key)
	end
end)

-- === Animation ===
frame.Position = UDim2.new(0.2, 0, 1, 0)
frame:TweenPosition(UDim2.new(0.2, 0, 0.35, 0), "Out", "Quad", 0.5, true)
