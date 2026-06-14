-- ═══════════════════════════════════════════════════════════════════
--     ARCHITECT 04 - NINJA LEGENDS MODERN EDITION
--     COIN + CHI INJECTOR v3.0 | OPTIMIZED
--     © XyrooXellz
-- ═══════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- LIST KEMUNGKINAN NAMA STAT (EXPANDED)
local coinNames = {"Coins", "Coin", "Money", "Gold", "Tokens", "Gems", "Cash", "Points", "Currency", "Jade", "Crystals"}
local chiNames = {"Chi", "Energy", "Chakra", "Power", "Spirit", "Mana", "Stamina", "Ki", "Prana", "Vitality"}

-- AUTO DETECT STAT NAMES (IMPROVED)
local function findStat(statNames)
    local ls = player:findFirstChild("leaderstats")
    if not ls then return nil, nil end
    for _, name in pairs(statNames) do
        local stat = ls:findFirstChild(name)
        if stat and stat:IsA("NumberValue") then
            return stat, name
        end
    end
    return nil, nil
end

-- CACHE STATS
local cachedCoinStat, cachedCoinName = findStat(coinNames)
local cachedChiStat, cachedChiName = findStat(chiNames)

-- CREATE GUI (MODERN ROUNDED)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Architect04_Modern"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 320)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BackgroundTransparency = 0.95
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- BLUR EFFECT
local blur = Instance.new("BlurEffect")
blur.Size = 8
blur.Parent = mainFrame

-- CORNER RADIUS
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- GLOW BORDER
local border = Instance.new("Frame")
border.Size = UDim2.new(1, 0, 1, 0)
border.Position = UDim2.new(0, 0, 0, 0)
border.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
border.BackgroundTransparency = 0.85
border.BorderSizePixel = 0
border.Parent = mainFrame

-- HEADER MODERN
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- TITLE
local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ARCHITECT 04 • NINJA LEGENDS"
titleText.TextColor3 = Color3.fromRGB(0, 255, 100)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = header

-- CLOSE BUTTON (MODERN)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -40, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.BackgroundTransparency = 0.2
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 16
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- HOVER EFFECT CLOSE
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
end)

-- STATUS CARD
local statusCard = Instance.new("Frame")
statusCard.Size = UDim2.new(1, -30, 0, 50)
statusCard.Position = UDim2.new(0, 15, 0, 60)
statusCard.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
statusCard.BorderSizePixel = 0
statusCard.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusCard

local detectedText = Instance.new("TextLabel")
detectedText.Size = UDim2.new(1, -20, 1, 0)
detectedText.Position = UDim2.new(0, 10, 0, 0)
detectedText.BackgroundTransparency = 1
detectedText.Text = "🔍 Scanning stats..."
detectedText.TextColor3 = Color3.fromRGB(150, 150, 150)
detectedText.TextSize = 11
detectedText.Font = Enum.Font.Gotham
detectedText.TextXAlignment = Enum.TextXAlignment.Left
detectedText.Parent = statusCard

-- COIN SECTION (MODERN)
local coinCard = Instance.new("Frame")
coinCard.Size = UDim2.new(1, -30, 0, 80)
coinCard.Position = UDim2.new(0, 15, 0, 125)
coinCard.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
coinCard.BorderSizePixel = 0
coinCard.Parent = mainFrame

local coinCorner = Instance.new("UICorner")
coinCorner.CornerRadius = UDim.new(0, 8)
coinCorner.Parent = coinCard

local coinIcon = Instance.new("TextLabel")
coinIcon.Size = UDim2.new(0, 35, 0, 35)
coinIcon.Position = UDim2.new(0, 12, 0, 12)
coinIcon.BackgroundTransparency = 1
coinIcon.Text = "🪙"
coinIcon.TextSize = 24
coinIcon.TextColor3 = Color3.fromRGB(255, 215, 0)
coinIcon.Parent = coinCard

local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.new(0.5, 0, 0, 20)
coinLabel.Position = UDim2.new(0, 55, 0, 10)
coinLabel.BackgroundTransparency = 1
coinLabel.Text = "COIN"
coinLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
coinLabel.TextSize = 11
coinLabel.Font = Enum.Font.GothamBold
coinLabel.TextXAlignment = Enum.TextXAlignment.Left
coinLabel.Parent = coinCard

local coinValueLabel = Instance.new("TextLabel")
coinValueLabel.Size = UDim2.new(0.5, 0, 0, 20)
coinValueLabel.Position = UDim2.new(0, 55, 0, 28)
coinValueLabel.BackgroundTransparency = 1
coinValueLabel.Text = cachedCoinStat and tostring(cachedCoinStat.Value) or "0"
coinValueLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
coinValueLabel.TextSize = 14
coinValueLabel.Font = Enum.Font.GothamBold
coinValueLabel.TextXAlignment = Enum.TextXAlignment.Left
coinValueLabel.Parent = coinCard

local coinInput = Instance.new("TextBox")
coinInput.Size = UDim2.new(0, 130, 0, 38)
coinInput.Position = UDim2.new(1, -145, 0, 20)
coinInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
coinInput.BorderSizePixel = 0
coinInput.PlaceholderText = "amount / inf"
coinInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 90)
coinInput.Text = ""
coinInput.TextColor3 = Color3.fromRGB(0, 255, 100)
coinInput.TextSize = 12
coinInput.Font = Enum.Font.Gotham
coinInput.ClearTextOnFocus = false
coinInput.Parent = coinCard

local coinInputCorner = Instance.new("UICorner")
coinInputCorner.CornerRadius = UDim.new(0, 6)
coinInputCorner.Parent = coinInput

local coinBtn = Instance.new("TextButton")
coinBtn.Size = UDim2.new(0, 90, 0, 38)
coinBtn.Position = UDim2.new(1, -50, 0, 20)
coinBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
coinBtn.BackgroundTransparency = 0.15
coinBtn.BorderSizePixel = 0
coinBtn.Text = "INJECT"
coinBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
coinBtn.TextSize = 12
coinBtn.Font = Enum.Font.GothamBold
coinBtn.Parent = coinCard

local coinBtnCorner = Instance.new("UICorner")
coinBtnCorner.CornerRadius = UDim.new(0, 6)
coinBtnCorner.Parent = coinBtn

-- CHI SECTION
local chiCard = Instance.new("Frame")
chiCard.Size = UDim2.new(1, -30, 0, 80)
chiCard.Position = UDim2.new(0, 15, 0, 215)
chiCard.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
chiCard.BorderSizePixel = 0
chiCard.Parent = mainFrame

local chiCorner = Instance.new("UICorner")
chiCorner.CornerRadius = UDim.new(0, 8)
chiCorner.Parent = chiCard

local chiIcon = Instance.new("TextLabel")
chiIcon.Size = UDim2.new(0, 35, 0, 35)
chiIcon.Position = UDim2.new(0, 12, 0, 12)
chiIcon.BackgroundTransparency = 1
chiIcon.Text = "⚡"
chiIcon.TextSize = 24
chiIcon.TextColor3 = Color3.fromRGB(0, 200, 255)
chiIcon.Parent = chiCard

local chiLabel = Instance.new("TextLabel")
chiLabel.Size = UDim2.new(0.5, 0, 0, 20)
chiLabel.Position = UDim2.new(0, 55, 0, 10)
chiLabel.BackgroundTransparency = 1
chiLabel.Text = cachedChiName and cachedChiName:upper() or "CHI"
chiLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
chiLabel.TextSize = 11
chiLabel.Font = Enum.Font.GothamBold
chiLabel.TextXAlignment = Enum.TextXAlignment.Left
chiLabel.Parent = chiCard

local chiValueLabel = Instance.new("TextLabel")
chiValueLabel.Size = UDim2.new(0.5, 0, 0, 20)
chiValueLabel.Position = UDim2.new(0, 55, 0, 28)
chiValueLabel.BackgroundTransparency = 1
chiValueLabel.Text = cachedChiStat and tostring(cachedChiStat.Value) or "0"
chiValueLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
chiValueLabel.TextSize = 14
chiValueLabel.Font = Enum.Font.GothamBold
chiValueLabel.TextXAlignment = Enum.TextXAlignment.Left
chiValueLabel.Parent = chiCard

local chiInput = Instance.new("TextBox")
chiInput.Size = UDim2.new(0, 130, 0, 38)
chiInput.Position = UDim2.new(1, -145, 0, 20)
chiInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
chiInput.BorderSizePixel = 0
chiInput.PlaceholderText = "amount / inf"
chiInput.PlaceholderColor3 = Color3.fromRGB(80, 80, 90)
chiInput.Text = ""
chiInput.TextColor3 = Color3.fromRGB(0, 200, 255)
chiInput.TextSize = 12
chiInput.Font = Enum.Font.Gotham
chiInput.ClearTextOnFocus = false
chiInput.Parent = chiCard

local chiInputCorner = Instance.new("UICorner")
chiInputCorner.CornerRadius = UDim.new(0, 6)
chiInputCorner.Parent = chiInput

local chiBtn = Instance.new("TextButton")
chiBtn.Size = UDim2.new(0, 90, 0, 38)
chiBtn.Position = UDim2.new(1, -50, 0, 20)
chiBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
chiBtn.BackgroundTransparency = 0.15
chiBtn.BorderSizePixel = 0
chiBtn.Text = "INJECT"
chiBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
chiBtn.TextSize = 12
chiBtn.Font = Enum.Font.GothamBold
chiBtn.Parent = chiCard

local chiBtnCorner = Instance.new("UICorner")
chiBtnCorner.CornerRadius = UDim.new(0, 6)
chiBtnCorner.Parent = chiBtn

-- FUNCTIONS
local function updateStatus(msg, isError)
    detectedText.Text = msg
    detectedText.TextColor3 = isError and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(0, 255, 100)
    task.wait(2.5)
    detectedText.Text = "✅ System ready • " .. (cachedCoinName or "?") .. " | " .. (cachedChiName or "?")
    detectedText.TextColor3 = Color3.fromRGB(0, 255, 100)
end

local function parseAmount(input)
    if input:lower() == "inf" or input:lower() == "infinite" or input == "∞" then
        return math.huge
    end
    local num = tonumber(input)
    if num and num > 0 then
        return num
    end
    return nil
end

local function refreshStatsDisplay()
    if cachedCoinStat then
        coinValueLabel.Text = tostring(cachedCoinStat.Value)
    end
    if cachedChiStat then
        chiValueLabel.Text = tostring(cachedChiStat.Value)
    end
end

local function injectCoin(amount)
    if not cachedCoinStat then
        local newStat, newName = findStat(coinNames)
        if newStat then
            cachedCoinStat, cachedCoinName = newStat, newName
        else
            updateStatus("❌ Coin stat not found!", true)
            return false
        end
    end
    
    local old = cachedCoinStat.Value
    if amount == math.huge then
        cachedCoinStat.Value = 9.999999999999999e+23
        updateStatus("🪙 " .. cachedCoinName .. ": INFINITE! (was " .. old .. ")")
    else
        cachedCoinStat.Value = old + amount
        updateStatus("🪙 " .. cachedCoinName .. ": +" .. amount .. " → " .. cachedCoinStat.Value)
    end
    refreshStatsDisplay()
    return true
end

local function injectChi(amount)
    if not cachedChiStat then
        local newStat, newName = findStat(chiNames)
        if newStat then
            cachedChiStat, cachedChiName = newStat, newName
            chiLabel.Text = cachedChiName:upper()
        else
            updateStatus("❌ Chi/Energy stat not found!", true)
            return false
        end
    end
    
    local old = cachedChiStat.Value
    if amount == math.huge then
        cachedChiStat.Value = 9.999999999999999e+23
        updateStatus("⚡ " .. cachedChiName .. ": INFINITE! (was " .. old .. ")")
    else
        cachedChiStat.Value = old + amount
        updateStatus("⚡ " .. cachedChiName .. ": +" .. amount .. " → " .. cachedChiStat.Value)
    end
    refreshStatsDisplay()
    return true
end

-- BUTTON ACTIONS
coinBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(coinInput.Text)
    if not amt then
        updateStatus("❌ Invalid amount!", true)
        coinInput.Text = ""
        return
    end
    injectCoin(amt)
    coinInput.Text = ""
end)

chiBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(chiInput.Text)
    if not amt then
        updateStatus("❌ Invalid amount!", true)
        chiInput.Text = ""
        return
    end
    injectChi(amt)
    chiInput.Text = ""
end)

-- AUTO REFRESH ON STAT CHANGE
local coinConnection, chiConnection
if cachedCoinStat then
    coinConnection = cachedCoinStat.Changed:Connect(refreshStatsDisplay)
end
if cachedChiStat then
    chiConnection = cachedChiStat.Changed:Connect(refreshStatsDisplay)
end

-- INITIAL STATUS
task.wait(0.2)
if cachedCoinStat and cachedChiStat then
    detectedText.Text = "✅ System ready • " .. cachedCoinName .. " | " .. cachedChiName
    detectedText.TextColor3 = Color3.fromRGB(0, 255, 100)
else
    detectedText.Text = "⚠️ Some stats not detected • check game mode"
    detectedText.TextColor3 = Color3.fromRGB(255, 150, 0)
end

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("ARCHITECT 04 • MODERN EDITION LOADED")
print("COIN: " .. (cachedCoinName or "NOT FOUND"))
print("CHI: " .. (cachedChiName or "NOT FOUND"))
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
