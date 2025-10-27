-- === ШАГ 1: Первый скрипт ===
loadstring(game:HttpGet("https://raw.githubusercontent.com/vertix-hub/Script-Hub/refs/heads/main/Menu"))()

-- === ШАГ 2: Загрузочный экран ===
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local loadTime = 90 -- сколько секунд идёт загрузка

local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScreen"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.DisplayOrder = 999999
gui.Parent = playerGui

-- Окно (не на весь экран)
local window = Instance.new("Frame", gui)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.Position = UDim2.new(0.5, 0, 0.5, 0)
window.Size = UDim2.new(0, 550, 0, 300)
window.BackgroundColor3 = Color3.fromRGB(25, 10, 35)
window.BorderSizePixel = 0

local wCorner = Instance.new("UICorner", window)
wCorner.CornerRadius = UDim.new(0, 18)

-- Градиент на фоне
local gradient = Instance.new("UIGradient", window)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(110, 20, 160)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 120, 50))
}
gradient.Rotation = 45

-- Текст
local title = Instance.new("TextLabel", window)
title.AnchorPoint = Vector2.new(0.5, 0)
title.Position = UDim2.new(0.5, 0, 0.25, 0)
title.Size = UDim2.new(0.8, 0, 0, 60)
title.BackgroundTransparency = 1
title.Text = "Loading..."
title.TextColor3 = Color3.fromRGB(255, 220, 180)
title.Font = Enum.Font.GothamBold
title.TextSize = 36
title.TextStrokeTransparency = 0.7

-- Полоса загрузки
local barHolder = Instance.new("Frame", window)
barHolder.AnchorPoint = Vector2.new(0.5, 0)
barHolder.Position = UDim2.new(0.5, 0, 0.65, 0)
barHolder.Size = UDim2.new(0.8, 0, 0, 26)
barHolder.BackgroundColor3 = Color3.fromRGB(40, 15, 10)
barHolder.BorderSizePixel = 0
local hCorner = Instance.new("UICorner", barHolder)
hCorner.CornerRadius = UDim.new(0, 13)

local bar = Instance.new("Frame", barHolder)
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(255, 120, 40)
bar.BorderSizePixel = 0
local bCorner = Instance.new("UICorner", bar)
bCorner.CornerRadius = UDim.new(0, 13)

local barGrad = Instance.new("UIGradient", bar)
barGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 140, 50)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 80)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 30))
}

-- Анимация текста (точки)
task.spawn(function()
    local dots = 0
    while gui.Parent do
        dots = (dots + 1) % 4
        title.Text = "Loading" .. string.rep(".", dots)
        task.wait(0.5)
    end
end)

-- Анимация полосы загрузки
local startTime = tick()
while tick() - startTime < loadTime do
    local progress = math.clamp((tick() - startTime) / loadTime, 0, 1)
    bar.Size = UDim2.new(progress, 0, 1, 0)
    task.wait(0.05)
end

-- Убираем экран
gui:Destroy()

-- === ШАГ 3: Твой скрипт (добавишь сюда позже) ===
task.spawn(function()
    -- пример:
    -- loadstring(game:HttpGet('https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader'))()
end)
