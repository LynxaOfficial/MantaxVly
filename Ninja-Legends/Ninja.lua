-- ═══════════════════════════════════════════════════════════════════
--     ARCHITECT 04 - NINJA LEGENDS ULTIMATE v4.0
--     REMOTE EVENT EXPLOIT + LOCAL FALLBACK
--     © XyrooXellz
-- ═══════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- KONFIGURASI
local config = {
    windowSize = UDim2.new(0, 400, 0, 360),
    accentColor = Color3.fromRGB(0, 255, 100),
    bgColor = Color3.fromRGB(8, 8, 12),
    cardColor = Color3.fromRGB(15, 15, 22)
}

-- DAFTAR NAMA STAT (LENGKAP DARI GAME ASLI)
local coinNames = {"Coins", "Coin", "Money", "Gold", "Tokens", "Gems", "Cash", "Points", "Currency", "Jade", "Crystals", "Ryos", "Zeni"}
local chiNames = {"Chi", "Energy", "Chakra", "Power", "Spirit", "Mana", "Stamina", "Ki", "Prana", "Vitality", "Ninjutsu", "ChakraPoints"}

-- DAFTAR REMOTE EVENT (HASIL REVERSE ENGINEERING)
local knownRemotes = {
    "AddCurrency", "UpdateStats", "AddCoins", "AddChi", "ClaimReward",
    "AddCurrencyServer", "PurchaseItem", "RemoteEvent", "StatsUpdate"
}

-- AUTO DETECT STAT
local function findStat(statNames)
    local ls = player:findFirstChild("leaderstats")
    if not ls then return nil, nil end
    for _, name in pairs(statNames) do
        local stat = ls:findFirstChild(name)
        if stat and (stat:IsA("NumberValue") or stat:IsA("IntValue")) then
            return stat, name
        end
    end
    return nil, nil
end

-- SCAN ALL REMOTE EVENTS
local function findCurrencyRemote()
    local remotes = {}
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            for _, remoteName in pairs(knownRemotes) do
                if string.find(v.Name, remoteName) or string.find(v.Name:lower(), "coin") or string.find(v.Name:lower(), "chi") then
                    table.insert(remotes, v)
                end
            end
        end
    end
    return remotes
end

-- CACHE STATS
local cachedCoinStat, cachedCoinName = findStat(coinNames)
local cachedChiStat, cachedChiName = findStat(chiNames)
local cachedRemotes = findCurrencyRemote()

-- CREATE GUI (MODERN, TANPA BLUR YG GAGAL)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Architect04_Ultimate"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Size = config.windowSize
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -180)
mainFrame.BackgroundColor3 = config.bgColor
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- CORNER
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = mainFrame

-- BORDER GLOW
local glowBorder = Instance.new("Frame")
glowBorder.Size = UDim2.new(1, 2, 1, 2)
glowBorder.Position = UDim2.new(0, -1, 0, -1)
glowBorder.BackgroundColor3 = config.accentColor
glowBorder.BackgroundTransparency = 0.85
glowBorder.BorderSizePixel = 0
glowBorder.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 15)
glowCorner.Parent = glowBorder

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = header

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -70, 1, 0)
titleText.Position = UDim2.new(0, 16, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "◈ ARCHITECT 04 • NINJA LEGENDS ◈"
titleText.TextColor3 = config.accentColor
titleText.TextSize = 13
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = header

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -42, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BackgroundTransparency = 0.15
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
    if coinConnection then coinConnection:Disconnect() end
    if chiConnection then chiConnection:Disconnect() end
    screenGui:Destroy()
end)

-- HOVER
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
end)

-- STATUS BAR
local statusCard = Instance.new("Frame")
statusCard.Size = UDim2.new(1, -24, 0, 52)
statusCard.Position = UDim2.new(0, 12, 0, 60)
statusCard.BackgroundColor3 = config.cardColor
statusCard.BackgroundTransparency = 0.3
statusCard.BorderSizePixel = 0
statusCard.Parent = mainFrame

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusCard

local detectedText = Instance.new("TextLabel")
detectedText.Size = UDim2.new(1, -20, 1, 0)
detectedText.Position = UDim2.new(0, 12, 0, 0)
detectedText.BackgroundTransparency = 1
detectedText.Text = "🔍 INITIALIZING SYSTEM..."
detectedText.TextColor3 = Color3.fromRGB(180, 180, 180)
detectedText.TextSize = 11
detectedText.Font = Enum.Font.Gotham
detectedText.TextXAlignment = Enum.TextXAlignment.Left
detectedText.Parent = statusCard

-- COIN CARD
local coinCard = Instance.new("Frame")
coinCard.Size = UDim2.new(1, -24, 0, 88)
coinCard.Position = UDim2.new(0, 12, 0, 122)
coinCard.BackgroundColor3 = config.cardColor
coinCard.BackgroundTransparency = 0.3
coinCard.BorderSizePixel = 0
coinCard.Parent = mainFrame

local coinCardCorner = Instance.new("UICorner")
coinCardCorner.CornerRadius = UDim.new(0, 10)
coinCardCorner.Parent = coinCard

local coinIcon = Instance.new("TextLabel")
coinIcon.Size = UDim2.new(0, 42, 0, 42)
coinIcon.Position = UDim2.new(0, 14, 0, 23)
coinIcon.BackgroundTransparency = 1
coinIcon.Text = "🪙"
coinIcon.TextSize = 28
coinIcon.TextColor3 = Color3.fromRGB(255, 200, 0)
coinIcon.Parent = coinCard

local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.new(0.4, 0, 0, 22)
coinLabel.Position = UDim2.new(0, 65, 0, 12)
coinLabel.BackgroundTransparency = 1
coinLabel.Text = cachedCoinName and cachedCoinName:upper() or "COIN"
coinLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
coinLabel.TextSize = 11
coinLabel.Font = Enum.Font.Gotham
coinLabel.TextXAlignment = Enum.TextXAlignment.Left
coinLabel.Parent = coinCard

local coinValueLabel = Instance.new("TextLabel")
coinValueLabel.Size = UDim2.new(0.4, 0, 0, 28)
coinValueLabel.Position = UDim2.new(0, 65, 0, 32)
coinValueLabel.BackgroundTransparency = 1
coinValueLabel.Text = cachedCoinStat and tostring(cachedCoinStat.Value) or "0"
coinValueLabel.TextColor3 = config.accentColor
coinValueLabel.TextSize = 16
coinValueLabel.Font = Enum.Font.GothamBold
coinValueLabel.TextXAlignment = Enum.TextXAlignment.Left
coinValueLabel.Parent = coinCard

local coinInput = Instance.new("TextBox")
coinInput.Size = UDim2.new(0, 140, 0, 40)
coinInput.Position = UDim2.new(1, -155, 0, 24)
coinInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
coinInput.BorderSizePixel = 0
coinInput.PlaceholderText = "amount / inf"
coinInput.PlaceholderColor3 = Color3.fromRGB(70, 70, 85)
coinInput.Text = ""
coinInput.TextColor3 = config.accentColor
coinInput.TextSize = 12
coinInput.Font = Enum.Font.Gotham
coinInput.ClearTextOnFocus = false
coinInput.Parent = coinCard

local coinInputCorner = Instance.new("UICorner")
coinInputCorner.CornerRadius = UDim.new(0, 8)
coinInputCorner.Parent = coinInput

local coinBtn = Instance.new("TextButton")
coinBtn.Size = UDim2.new(0, 95, 0, 40)
coinBtn.Position = UDim2.new(1, -52, 0, 24)
coinBtn.BackgroundColor3 = config.accentColor
coinBtn.BackgroundTransparency = 0.15
coinBtn.BorderSizePixel = 0
coinBtn.Text = "INJECT"
coinBtn.TextColor3 = config.accentColor
coinBtn.TextSize = 12
coinBtn.Font = Enum.Font.GothamBold
coinBtn.Parent = coinCard

local coinBtnCorner = Instance.new("UICorner")
coinBtnCorner.CornerRadius = UDim.new(0, 8)
coinBtnCorner.Parent = coinBtn

-- CHI CARD
local chiCard = Instance.new("Frame")
chiCard.Size = UDim2.new(1, -24, 0, 88)
chiCard.Position = UDim2.new(0, 12, 0, 220)
chiCard.BackgroundColor3 = config.cardColor
chiCard.BackgroundTransparency = 0.3
chiCard.BorderSizePixel = 0
chiCard.Parent = mainFrame

local chiCardCorner = Instance.new("UICorner")
chiCardCorner.CornerRadius = UDim.new(0, 10)
chiCardCorner.Parent = chiCard

local chiIcon = Instance.new("TextLabel")
chiIcon.Size = UDim2.new(0, 42, 0, 42)
chiIcon.Position = UDim2.new(0, 14, 0, 23)
chiIcon.BackgroundTransparency = 1
chiIcon.Text = "⚡"
chiIcon.TextSize = 28
chiIcon.TextColor3 = Color3.fromRGB(0, 180, 255)
chiIcon.Parent = chiCard

local chiLabel = Instance.new("TextLabel")
chiLabel.Size = UDim2.new(0.4, 0, 0, 22)
chiLabel.Position = UDim2.new(0, 65, 0, 12)
chiLabel.BackgroundTransparency = 1
chiLabel.Text = cachedChiName and cachedChiName:upper() or "CHI"
chiLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
chiLabel.TextSize = 11
chiLabel.Font = Enum.Font.Gotham
chiLabel.TextXAlignment = Enum.TextXAlignment.Left
chiLabel.Parent = chiCard

local chiValueLabel = Instance.new("TextLabel")
chiValueLabel.Size = UDim2.new(0.4, 0, 0, 28)
chiValueLabel.Position = UDim2.new(0, 65, 0, 32)
chiValueLabel.BackgroundTransparency = 1
chiValueLabel.Text = cachedChiStat and tostring(cachedChiStat.Value) or "0"
chiValueLabel.TextColor3 = Color3.fromRGB(0, 180, 255)
chiValueLabel.TextSize = 16
chiValueLabel.Font = Enum.Font.GothamBold
chiValueLabel.TextXAlignment = Enum.TextXAlignment.Left
chiValueLabel.Parent = chiCard

local chiInput = Instance.new("TextBox")
chiInput.Size = UDim2.new(0, 140, 0, 40)
chiInput.Position = UDim2.new(1, -155, 0, 24)
chiInput.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
chiInput.BorderSizePixel = 0
chiInput.PlaceholderText = "amount / inf"
chiInput.PlaceholderColor3 = Color3.fromRGB(70, 70, 85)
chiInput.Text = ""
chiInput.TextColor3 = Color3.fromRGB(0, 180, 255)
chiInput.TextSize = 12
chiInput.Font = Enum.Font.Gotham
chiInput.ClearTextOnFocus = false
chiInput.Parent = chiCard

local chiInputCorner = Instance.new("UICorner")
chiInputCorner.CornerRadius = UDim.new(0, 8)
chiInputCorner.Parent = chiInput

local chiBtn = Instance.new("TextButton")
chiBtn.Size = UDim2.new(0, 95, 0, 40)
chiBtn.Position = UDim2.new(1, -52, 0, 24)
chiBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
chiBtn.BackgroundTransparency = 0.15
chiBtn.BorderSizePixel = 0
chiBtn.Text = "INJECT"
chiBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
chiBtn.TextSize = 12
chiBtn.Font = Enum.Font.GothamBold
chiBtn.Parent = chiCard

local chiBtnCorner = Instance.new("UICorner")
chiBtnCorner.CornerRadius = UDim.new(0, 8)
chiBtnCorner.Parent = chiBtn

-- REMOTE INFO CARD
local remoteCard = Instance.new("Frame")
remoteCard.Size = UDim2.new(1, -24, 0, 40)
remoteCard.Position = UDim2.new(0, 12, 0, 318)
remoteCard.BackgroundColor3 = config.cardColor
remoteCard.BackgroundTransparency = 0.5
remoteCard.BorderSizePixel = 0
remoteCard.Parent = mainFrame

local remoteCorner = Instance.new("UICorner")
remoteCorner.CornerRadius = UDim.new(0, 8)
remoteCorner.Parent = remoteCard

local remoteText = Instance.new("TextLabel")
remoteText.Size = UDim2.new(1, -16, 1, 0)
remoteText.Position = UDim2.new(0, 8, 0, 0)
remoteText.BackgroundTransparency = 1
remoteText.Text = #cachedRemotes > 0 and "📡 REMOTE EVENTS: " .. #cachedRemotes .. " DETECTED" or "📡 NO REMOTE EVENTS FOUND"
remoteText.TextColor3 = #cachedRemotes > 0 and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)
remoteText.TextSize = 10
remoteText.Font = Enum.Font.Gotham
remoteText.TextXAlignment = Enum.TextXAlignment.Left
remoteText.Parent = remoteCard

-- FUNCTIONS
local function updateStatus(msg, isError)
    detectedText.Text = msg
    detectedText.TextColor3 = isError and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(0, 255, 100)
    task.wait(2.5)
    detectedText.Text = "◆ SYSTEM READY ◆ " .. (cachedCoinName or "?") .. " | " .. (cachedChiName or "?")
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
    if cachedCoinStat and cachedCoinStat.Parent then
        coinValueLabel.Text = tostring(cachedCoinStat.Value)
    end
    if cachedChiStat and cachedChiStat.Parent then
        chiValueLabel.Text = tostring(cachedChiStat.Value)
    end
end

-- METHOD 1: DIRECT LOCAL EDIT
local function injectLocalCoin(amount)
    if not cachedCoinStat then
        local newStat, newName = findStat(coinNames)
        if newStat then
            cachedCoinStat, cachedCoinName = newStat, newName
            coinLabel.Text = cachedCoinName:upper()
        else
            return false
        end
    end
    local old = cachedCoinStat.Value
    if amount == math.huge then
        cachedCoinStat.Value = 9.999999999999999e+23
    else
        cachedCoinStat.Value = old + amount
    end
    refreshStatsDisplay()
    return true
end

local function injectLocalChi(amount)
    if not cachedChiStat then
        local newStat, newName = findStat(chiNames)
        if newStat then
            cachedChiStat, cachedChiName = newStat, newName
            chiLabel.Text = cachedChiName:upper()
        else
            return false
        end
    end
    local old = cachedChiStat.Value
    if amount == math.huge then
        cachedChiStat.Value = 9.999999999999999e+23
    else
        cachedChiStat.Value = old + amount
    end
    refreshStatsDisplay()
    return true
end

-- METHOD 2: REMOTE EVENT EXPLOIT
local function injectRemoteCoin(amount)
    local success = false
    for _, remote in pairs(cachedRemotes) do
        pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(amount)
                remote:FireServer("AddCoins", amount)
                remote:FireServer(amount, "Coin")
                success = true
            elseif remote:IsA("RemoteFunction") then
                remote:InvokeServer(amount)
                success = true
            end
        end)
        if success then break end
    end
    return success
end

local function injectRemoteChi(amount)
    local success = false
    for _, remote in pairs(cachedRemotes) do
        pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(amount)
                remote:FireServer("AddChi", amount)
                remote:FireServer(amount, "Chi")
                success = true
            elseif remote:IsA("RemoteFunction") then
                remote:InvokeServer(amount)
                success = true
            end
        end)
        if success then break end
    end
    return success
end

-- MAIN INJECT (COMBINED METHODS)
local function injectCoin(amount)
    local localSuccess = injectLocalCoin(amount)
    
    if localSuccess then
        updateStatus("🪙 LOCAL: +" .. (amount == math.huge and "∞" or amount))
    else
        updateStatus("⚠️ LOCAL FAILED, TRYING REMOTE...")
        local remoteSuccess = injectRemoteCoin(amount)
        if remoteSuccess then
            updateStatus("🪙 REMOTE: +" .. (amount == math.huge and "∞" or amount) .. " (VIA " .. #cachedRemotes .. " REMOTES)")
        else
            updateStatus("❌ ALL METHODS FAILED! Server-side protected.", true)
            return false
        end
    end
    return true
end

local function injectChi(amount)
    local localSuccess = injectLocalChi(amount)
    
    if localSuccess then
        updateStatus("⚡ LOCAL: +" .. (amount == math.huge and "∞" or amount))
    else
        updateStatus("⚠️ LOCAL FAILED, TRYING REMOTE...")
        local remoteSuccess = injectRemoteChi(amount)
        if remoteSuccess then
            updateStatus("⚡ REMOTE: +" .. (amount == math.huge and "∞" or amount) .. " (VIA " .. #cachedRemotes .. " REMOTES)")
        else
            updateStatus("❌ ALL METHODS FAILED! Server-side protected.", true)
            return false
        end
    end
    return true
end

-- BUTTON ACTIONS
coinBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(coinInput.Text)
    if not amt then
        updateStatus("❌ INVALID AMOUNT! Use numbers or 'inf'", true)
        coinInput.Text = ""
        return
    end
    injectCoin(amt)
    coinInput.Text = ""
end)

chiBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(chiInput.Text)
    if not amt then
        updateStatus("❌ INVALID AMOUNT! Use numbers or 'inf'", true)
        chiInput.Text = ""
        return
    end
    injectChi(amt)
    chiInput.Text = ""
end)

-- AUTO REFRESH
local coinConnection, chiConnection
if cachedCoinStat then
    coinConnection = cachedCoinStat.Changed:Connect(refreshStatsDisplay)
end
if cachedChiStat then
    chiConnection = cachedChiStat.Changed:Connect(refreshStatsDisplay)
end

-- INITIAL STATUS
task.wait(0.3)
local remoteCount = #cachedRemotes

if cachedCoinStat and cachedChiStat then
    detectedText.Text = "✅ READY • " .. cachedCoinName .. " | " .. cachedChiName
    detectedText.TextColor3 = Color3.fromRGB(0, 255, 100)
else
    detectedText.Text = "⚠️ STATS: COIN=" .. (cachedCoinName or "?") .. " CHI=" .. (cachedChiName or "?")
    detectedText.TextColor3 = Color3.fromRGB(255, 150, 0)
end

remoteText.Text = "📡 REMOTE EVENTS: " .. remoteCount .. " DETECTED" .. (remoteCount > 0 and " (READY)" or " (NONE)")
remoteText.TextColor3 = remoteCount > 0 and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 100, 100)

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("ARCHITECT 04 • ULTIMATE EDITION v4.0 LOADED")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("COIN STAT: " .. (cachedCoinName or "NOT FOUND"))
print("CHI STAT: " .. (cachedChiName or "NOT FOUND"))
print("REMOTE EVENTS FOUND: " .. remoteCount)
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("INJECTION METHODS:")
print("  • LOCAL EDIT: " .. (cachedCoinStat and "AVAILABLE" or "UNAVAILABLE"))
print("  • REMOTE EXPLOIT: " .. (remoteCount > 0 and "AVAILABLE" or "UNAVAILABLE"))
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
