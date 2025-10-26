-- LocalScript: RedHub GUI (English version)
-- Place this inside StarterPlayerScripts or StarterGui (LocalScript)

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Settings
local DISCORD_URL = "https://discord.gg/your-invite" -- <--- replace with your Discord link
local WINDOW_NAME = "RedHub"
local PLACEHOLDER_KEY = "Key"

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main frame (wide top bar)
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0.6, 0, 0.12, 0)
frame.Position = UDim2.new(0.2, 0, 0.08, 0)
frame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

-- Rounded corners and outline
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(60, 60, 60)
uiStroke.Thickness = 1
uiStroke.Parent = frame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = WINDOW_NAME
title.Size = UDim2.new(0.3, -10, 1, 0)
title.Position = UDim2.new(0, 12, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- Key icon
local keyIcon = Instance.new("TextLabel")
keyIcon.Name = "KeyIcon"
keyIcon.Size = UDim2.new(0, 32, 0, 32)
keyIcon.Position = UDim2.new(0.31, 8, 0.2, 0)
keyIcon.BackgroundTransparency = 1
keyIcon.Text = "🔑"
keyIcon.Font = Enum.Font.SourceSans
keyIcon.TextSize = 24
keyIcon.Parent = frame

-- Key input box
local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyBox"
keyBox.Size = UDim2.new(0.45, 0, 0.5, 0)
keyBox.Position = UDim2.new(0.38, 8, 0.15, 0)
keyBox.PlaceholderText = PLACEHOLDER_KEY
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.BackgroundTransparency = 0.15
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.fromRGB(230, 230, 230)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.TextXAlignment = Enum.TextXAlignment.Left
keyBox.Parent = frame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

-- Discord button (clickable)
local discordButton = Instance.new("TextButton")
discordButton.Name = "DiscordButton"
discordButton.Size = UDim2.new(0.25, 0, 0.45, 0)
discordButton.Position = UDim2.new(0.68, -8, 0.5, -8)
discordButton.BackgroundTransparency = 0.12
discordButton.BackgroundColor3 = Color3.fromRGB(54, 57, 63)
discordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
discordButton.Font = Enum.Font.Gotham
discordButton.TextSize = 15
discordButton.Text = "Discord: Click to open\n(and copy link)"
discordButton.TextWrapped = true
discordButton.AutoButtonColor = true
discordButton.Parent = frame

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 8)
discordCorner.Parent = discordButton

-- Hint text below
local hint = Instance.new("TextLabel")
hint.Name = "Hint"
hint.Size = UDim2.new(0.45, 0, 0.2, 0)
hint.Position = UDim2.new(0.38, 0, 0.68, 0)
hint.BackgroundTransparency = 1
hint.TextColor3 = Color3.fromRGB(180, 180, 180)
hint.Font = Enum.Font.Gotham
hint.TextSize = 13
hint.Text = "Enter your key here"
hint.TextXAlignment = Enum.TextXAlignment.Left
hint.Parent = frame

-- Clipboard helper
local function tryCopyToClipboard(text)
	local ok, err = pcall(function()
		if setclipboard then
			setclipboard(text)
			return
		end
		if syn and syn.set_clipboard then
			syn.set_clipboard(text)
			return
		end
		error("clipboard unavailable")
	end)
	return ok, err
end

-- Notification helper
local function notify(titleText, bodyText)
	local success, _ = pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = titleText;
			Text = bodyText;
			Duration = 4;
		})
	end)
	if not success then
		local tmp = Instance.new("TextLabel")
		tmp.Size = UDim2.new(0.3, 0, 0.06, 0)
		tmp.Position = UDim2.new(0.35, 0, 0.02, 0)
		tmp.BackgroundTransparency = 0.2
		tmp.BackgroundColor3 = Color3.fromRGB(30,30,30)
		tmp.TextColor3 = Color3.fromRGB(255,255,255)
		tmp.Font = Enum.Font.Gotham
		tmp.TextSize = 16
		tmp.Text = titleText .. " - " .. bodyText
		tmp.Parent = screenGui
		game:GetService("Debris"):AddItem(tmp, 4)
	end
end

-- Try to auto-copy Discord link on startup
spawn(function()
	wait(0.4)
	local ok = tryCopyToClipboard(DISCORD_URL)
	if ok then
		notify("RedHub", "Discord link copied to clipboard ✅")
	else
		notify("RedHub", "Auto-copy unavailable — click the link to open/copy")
	end
end)

-- Click handler for Discord button
discordButton.MouseButton1Click:Connect(function()
	pcall(function()
		GuiService:OpenBrowserWindow(DISCORD_URL)
	end)
	local ok = tryCopyToClipboard(DISCORD_URL)
	if ok then
		notify("RedHub", "Discord link copied ✅")
	else
		notify("RedHub", "Opened Discord link — copy manually if needed.")
	end
end)

-- Submit button (optional)
local submitBtn = Instance.new("TextButton")
submitBtn.Name = "SubmitBtn"
submitBtn.Size = UDim2.new(0.15, 0, 0.45, 0)
submitBtn.Position = UDim2.new(0.86, -10, 0.15, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
submitBtn.Text = "Enter"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 16
submitBtn.Parent = frame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 8)
submitCorner.Parent = submitBtn

submitBtn.MouseButton1Click:Connect(function()
	local key = keyBox.Text
	if key == "" then
		notify("RedHub", "Please enter a key")
		return
	end
	notify("RedHub", "Key entered: " .. tostring(key))
end)

-- Smooth intro animation
frame.Position = UDim2.new(0.2, 0, -0.2, 0)
frame:TweenPosition(UDim2.new(0.2, 0, 0.08, 0), "Out", "Quad", 0.45, true)
