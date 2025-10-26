-- LocalScript: RedHub GUI (bigger, fixed layout, copy Discord + clickable icon)
-- Помести в StarterPlayerScripts или StarterGui (LocalScript)

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- === Настройки ===
local DISCORD_URL = "https://discord.gg/your-invite" -- <- поставь свою ссылку
-- Если хочешь использовать картинку-иконку Discord, укажи asset id (rbxassetid://...) или оставь nil для fallback-эмодзи
local DISCORD_ICON = nil -- e.g. "rbxassetid://1234567890"

local WINDOW_NAME = "RedHub"
local PLACEHOLDER_KEY = "Key"

-- === Создаём ScreenGui ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RedHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- === Основная панель (широкая и побольше) ===
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0.88, 0, 0.16, 0)       -- шире и выше
frame.Position = UDim2.new(0.06, 0, 0.06, 0)   -- чуть отступ слева/сверху
frame.AnchorPoint = Vector2.new(0, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = frame

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(70,70,70)
outline.Thickness = 1
outline.Parent = frame

-- === Заголовок слева ===
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = WINDOW_NAME
title.Size = UDim2.new(0.22, 0, 1, 0)
title.Position = UDim2.new(0.02, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame

-- === Блок ввода ключа (по центру) ===
local keyIcon = Instance.new("TextLabel")
keyIcon.Name = "KeyIcon"
keyIcon.Size = UDim2.new(0, 36, 0, 36)
keyIcon.Position = UDim2.new(0.26, 6, 0.18, 0)
keyIcon.BackgroundTransparency = 1
keyIcon.Text = "🔑"
keyIcon.Font = Enum.Font.SourceSans
keyIcon.TextSize = 26
keyIcon.Parent = frame

local keyBox = Instance.new("TextBox")
keyBox.Name = "KeyBox"
keyBox.Size = UDim2.new(0.40, 0, 0.5, 0)
keyBox.Position = UDim2.new(0.31, 10, 0.18, 0)
keyBox.PlaceholderText = PLACEHOLDER_KEY
keyBox.Text = ""
keyBox.ClearTextOnFocus = false
keyBox.BackgroundTransparency = 0.12
keyBox.BackgroundColor3 = Color3.fromRGB(36,36,36)
keyBox.TextColor3 = Color3.fromRGB(235,235,235)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 18
keyBox.TextXAlignment = Enum.TextXAlignment.Left
keyBox.Parent = frame

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 8)
keyCorner.Parent = keyBox

-- === Кнопка Enter справа от поля ключа ===
local submitBtn = Instance.new("TextButton")
submitBtn.Name = "SubmitBtn"
submitBtn.Size = UDim2.new(0.13, 0, 0.6, 0)
submitBtn.Position = UDim2.new(0.73, -6, 0.18, 0)
submitBtn.BackgroundColor3 = Color3.fromRGB(64,160,255)
submitBtn.Text = "Enter"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 18
submitBtn.Parent = frame

local submitCorner = Instance.new("UICorner")
submitCorner.CornerRadius = UDim.new(0, 10)
submitCorner.Parent = submitBtn

-- === Правая колонка: Copy Discord + ссылка с иконкой ===
-- Контейнер для правого блока
local rightContainer = Instance.new("Frame")
rightContainer.Name = "RightContainer"
rightContainer.Size = UDim2.new(0.28, 0, 1, 0)
rightContainer.Position = UDim2.new(0.72, 0, 0, 0)
rightContainer.BackgroundTransparency = 1
rightContainer.Parent = frame

-- "Копировать Discord" (большая кнопка)
local copyBtn = Instance.new("TextButton")
copyBtn.Name = "CopyDiscord"
copyBtn.Size = UDim2.new(0.9, 0, 0.42, 0)
copyBtn.Position = UDim2.new(0.05, 0, 0.08, 0)
copyBtn.BackgroundColor3 = Color3.fromRGB(54,57,63)
copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 16
copyBtn.Text = "Копировать Discord"
copyBtn.AutoButtonColor = true
copyBtn.Parent = rightContainer

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 10)
copyCorner.Parent = copyBtn

-- Ниже: строка с иконкой + видимой ссылкой
local linkFrame = Instance.new("Frame")
linkFrame.Name = "LinkFrame"
linkFrame.Size = UDim2.new(0.9, 0, 0.36, 0)
linkFrame.Position = UDim2.new(0.05, 0, 0.56, 0)
linkFrame.BackgroundTransparency = 1
linkFrame.Parent = rightContainer

-- Icon (ImageButton если указан asset, иначе TextButton с эмодзи)
local iconButton
if DISCORD_ICON and typeof(DISCORD_ICON) == "string" then
    iconButton = Instance.new("ImageButton")
    iconButton.Image = DISCORD_ICON
else
    iconButton = Instance.new("TextButton")
    iconButton.Text = "� Discord"
    iconButton.Font = Enum.Font.GothamBold
    iconButton.TextSize = 16
end
iconButton.Name = "DiscordIcon"
iconButton.Size = UDim2.new(0, 36, 0, 36)
iconButton.Position = UDim2.new(0, 0, 0.16, 0)
iconButton.BackgroundTransparency = 0.12
iconButton.Parent = linkFrame

local iconCorner = Instance.new("UICorner")
iconCorner.CornerRadius = UDim.new(0, 8)
iconCorner.Parent = iconButton

-- Label с видимой ссылкой (можно выделить/скопировать вручную)
local linkLabel = Instance.new("TextLabel")
linkLabel.Name = "LinkLabel"
linkLabel.Size = UDim2.new(1, -46, 1, 0)
linkLabel.Position = UDim2.new(0, 46, 0, 0)
linkLabel.BackgroundTransparency = 0.12
linkLabel.BackgroundColor3 = Color3.fromRGB(36,36,36)
linkLabel.Text = DISCORD_URL
linkLabel.TextColor3 = Color3.fromRGB(220,220,220)
linkLabel.Font = Enum.Font.Gotham
linkLabel.TextSize = 14
linkLabel.TextXAlignment = Enum.TextXAlignment.Left
linkLabel.TextWrapped = true
linkLabel.Parent = linkFrame

local linkCorner = Instance.new("UICorner")
linkCorner.CornerRadius = UDim.new(0, 8)
linkCorner.Parent = linkLabel

-- === Вспомогательные функции: копирование и уведомления ===
local function tryCopyToClipboard(text)
    local ok = false
    pcall(function()
        if setclipboard then
            setclipboard(text)
            ok = true
            return
        end
        if syn and syn.set_clipboard then
            syn.set_clipboard(text)
            ok = true
            return
        end
        -- другие окружения можно добавить при необходимости
    end)
    return ok
end

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

-- Попытка автокопирования при запуске (необязательно)
spawn(function()
    wait(0.4)
    local ok = tryCopyToClipboard(DISCORD_URL)
    if ok then
        notify("RedHub", "Discord link copied to clipboard ✅")
    else
        notify("RedHub", "Auto-copy unavailable — use the 'Копировать Discord' button or click the icon")
    end
end)

-- Обработчики кликов:
copyBtn.MouseButton1Click:Connect(function()
    local ok = tryCopyToClipboard(DISCORD_URL)
    if ok then
        notify("RedHub", "Discord link copied ✅")
    else
        notify("RedHub", "Cannot auto-copy — opened link instead.")
    end
    -- Попытка открыть ссылку в браузере (если поддерживается)
    pcall(function()
        GuiService:OpenBrowserWindow(DISCORD_URL)
    end)
end)

-- Иконка тоже кликабельна: копирует и открывает
iconButton.MouseButton1Click:Connect(function()
    local ok = tryCopyToClipboard(DISCORD_URL)
    if ok then
        notify("RedHub", "Discord link copied ✅")
    else
        notify("RedHub", "Auto-copy unavailable — opening link.")
    end
    pcall(function()
        GuiService:OpenBrowserWindow(DISCORD_URL)
    end)
end)

-- Нажатие на сам текст ссылки тоже откроет и попытается скопировать
linkLabel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local ok = tryCopyToClipboard(DISCORD_URL)
        if ok then
            notify("RedHub", "Discord link copied ✅")
        else
            notify("RedHub", "Opening Discord link.")
        end
        pcall(function()
            GuiService:OpenBrowserWindow(DISCORD_URL)
        end)
    end
end)

-- Submit обработчик для ключа
submitBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then
        notify("RedHub", "Please enter a key")
        return
    end
    notify("RedHub", "Key entered: "..tostring(key))
    -- Здесь можно добавить валидацию ключа через HttpService и т.д.
end)

-- Анимация появления
frame.Position = UDim2.new(0.06, 0, -0.2, 0)
frame:TweenPosition(UDim2.new(0.06, 0, 0.06, 0), "Out", "Quad", 0.5, true)
