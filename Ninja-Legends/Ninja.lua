-- ═══════════════════════════════════════════════════════
--     ARCHITECT 04 - NINJA LEGENDS V2 (FIXED)
--     COIN + CHI INJECTOR (AUTO DETECT)
--     © XyrooXellz
-- ═══════════════════════════════════════════════════════

local player = game.Players.LocalPlayer

-- AUTO DETECT STAT NAMES
local function findStat(statNames)
    local ls = player:findFirstChild("leaderstats")
    if not ls then return nil end
    for _, name in pairs(statNames) do
        local stat = ls:findFirstChild(name)
        if stat then return stat, name end
    end
    return nil
end

-- LIST KEMUNGKINAN NAMA STAT
local coinNames = {"Coins", "Coin", "Money", "Gold", "Tokens", "Gems", "Cash", "Points"}
local chiNames = {"Chi", "Energy", "Chakra", "Power", "Spirit", "Mana", "Stamina"}

-- CREATE UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Architect04_Fixed"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 240)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -120)
mainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
mainFrame.BorderColor3 = Color3.new(0, 1, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- JUDUL
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
title.BorderColor3 = Color3.new(0, 1, 0)
title.BorderSizePixel = 1
title.Text = "  ARCHITECT 04 - NINJA LEGENDS V2"
title.TextColor3 = Color3.new(0, 1, 0)
title.TextSize = 13
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- CLOSE
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0, 3)
closeBtn.BackgroundColor3 = Color3.new(0.15, 0, 0)
closeBtn.BorderColor3 = Color3.new(1, 0, 0)
closeBtn.BorderSizePixel = 1
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Parent = mainFrame
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- DETECTED STAT DISPLAY
local detectedFrame = Instance.new("Frame")
detectedFrame.Size = UDim2.new(1, -20, 0, 25)
detectedFrame.Position = UDim2.new(0, 10, 0, 35)
detectedFrame.BackgroundColor3 = Color3.new(0.02, 0.02, 0.02)
detectedFrame.BorderColor3 = Color3.new(0, 1, 0)
detectedFrame.BorderSizePixel = 1
detectedFrame.Parent = mainFrame

local detectedText = Instance.new("TextLabel")
detectedText.Size = UDim2.new(1, -10, 1, 0)
detectedText.Position = UDim2.new(0, 5, 0, 0)
detectedText.BackgroundTransparency = 1
detectedText.Text = "🔍 SCANNING STATS..."
detectedText.TextColor3 = Color3.new(0, 1, 0)
detectedText.TextSize = 10
detectedText.Font = Enum.Font.SourceSans
detectedText.TextXAlignment = Enum.TextXAlignment.Left
detectedText.Parent = detectedFrame

-- COIN
local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.new(1, -20, 0, 25)
coinLabel.Position = UDim2.new(0, 10, 0, 70)
coinLabel.BackgroundTransparency = 1
coinLabel.Text = "🪙 COIN"
coinLabel.TextColor3 = Color3.new(0, 1, 0)
coinLabel.TextSize = 12
coinLabel.Font = Enum.Font.SourceSansBold
coinLabel.TextXAlignment = Enum.TextXAlignment.Left
coinLabel.Parent = mainFrame

local coinInput = Instance.new("TextBox")
coinInput.Size = UDim2.new(0, 200, 0, 32)
coinInput.Position = UDim2.new(0, 10, 0, 95)
coinInput.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
coinInput.BorderColor3 = Color3.new(0, 1, 0)
coinInput.BorderSizePixel = 1
coinInput.Text = ""
coinInput.PlaceholderText = "jumlah (contoh: 9999 / inf)"
coinInput.PlaceholderColor3 = Color3.new(0.3, 0.3, 0.3)
coinInput.TextColor3 = Color3.new(0, 1, 0)
coinInput.TextSize = 12
coinInput.Font = Enum.Font.SourceSans
coinInput.Parent = mainFrame

local coinBtn = Instance.new("TextButton")
coinBtn.Size = UDim2.new(0, 120, 0, 32)
coinBtn.Position = UDim2.new(0, 225, 0, 95)
coinBtn.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
coinBtn.BorderColor3 = Color3.new(0, 1, 0)
coinBtn.BorderSizePixel = 1
coinBtn.Text = "INJECT"
coinBtn.TextColor3 = Color3.new(0, 1, 0)
coinBtn.TextSize = 12
coinBtn.Font = Enum.Font.SourceSansBold
coinBtn.Parent = mainFrame

-- CHI
local chiLabel = Instance.new("TextLabel")
chiLabel.Size = UDim2.new(1, -20, 0, 25)
chiLabel.Position = UDim2.new(0, 10, 0, 140)
chiLabel.BackgroundTransparency = 1
chiLabel.Text = "⚡ CHI / ENERGY"
chiLabel.TextColor3 = Color3.new(0, 1, 0)
chiLabel.TextSize = 12
chiLabel.Font = Enum.Font.SourceSansBold
chiLabel.TextXAlignment = Enum.TextXAlignment.Left
chiLabel.Parent = mainFrame

local chiInput = Instance.new("TextBox")
chiInput.Size = UDim2.new(0, 200, 0, 32)
chiInput.Position = UDim2.new(0, 10, 0, 165)
chiInput.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
chiInput.BorderColor3 = Color3.new(0, 1, 0)
chiInput.BorderSizePixel = 1
chiInput.Text = ""
chiInput.PlaceholderText = "jumlah (contoh: 9999 / inf)"
chiInput.PlaceholderColor3 = Color3.new(0.3, 0.3, 0.3)
chiInput.TextColor3 = Color3.new(0, 1, 0)
chiInput.TextSize = 12
chiInput.Font = Enum.Font.SourceSans
chiInput.Parent = mainFrame

local chiBtn = Instance.new("TextButton")
chiBtn.Size = UDim2.new(0, 120, 0, 32)
chiBtn.Position = UDim2.new(0, 225, 0, 165)
chiBtn.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
chiBtn.BorderColor3 = Color3.new(0, 1, 0)
chiBtn.BorderSizePixel = 1
chiBtn.Text = "INJECT"
chiBtn.TextColor3 = Color3.new(0, 1, 0)
chiBtn.TextSize = 12
chiBtn.Font = Enum.Font.SourceSansBold
chiBtn.Parent = mainFrame

-- STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 20)
status.Position = UDim2.new(0, 10, 0, 210)
status.BackgroundTransparency = 1
status.Text = "READY"
status.TextColor3 = Color3.new(0, 1, 0)
status.TextSize = 10
status.Font = Enum.Font.SourceSans
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = mainFrame

-- FUNGSI
local function updateStatus(msg, isErr)
    status.Text = msg
    status.TextColor3 = isErr and Color3.new(1, 0, 0) or Color3.new(0, 1, 0)
    task.wait(2)
    status.Text = "READY"
    status.TextColor3 = Color3.new(0, 1, 0)
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

-- SCAN STATS ON LOAD
local coinStat, coinName = findStat(coinNames)
local chiStat, chiName = findStat(chiNames)

task.wait(0.5)

if coinStat then
    detectedText.Text = "✅ DETECTED: COIN = '" .. coinName .. "' | CHI = '" .. (chiName or "NOT FOUND") .. "'"
    detectedText.TextColor3 = Color3.new(0, 1, 0)
else
    detectedText.Text = "⚠️ WARNING: COIN STAT NOT FOUND! Coba cek nama stat di leaderstats"
    detectedText.TextColor3 = Color3.new(1, 0.5, 0)
end

if chiStat then
    chiLabel.Text = "⚡ " .. chiName:upper()
else
    chiLabel.Text = "⚡ CHI / ENERGY (NOT FOUND)"
end

local function injectCoin(amount)
    local ls = player:findFirstChild("leaderstats")
    if not ls then updateStatus("leaderstats NOT FOUND!", true) return false end
    
    -- REFRESH DETECTION
    local stat, foundName = findStat(coinNames)
    if not stat then 
        updateStatus("COIN STAT NOT FOUND! Nama: " .. foundName, true) 
        return false 
    end
    
    local old = stat.Value
    if amount == math.huge then
        stat.Value = 9.999999999999999e+23
        updateStatus("🪙 " .. foundName .. ": INFINITE! (OLD: " .. old .. ")")
    else
        stat.Value = old + amount
        updateStatus("🪙 " .. foundName .. ": +" .. amount .. " (NOW: " .. stat.Value .. ")")
    end
    return true
end

local function injectChi(amount)
    local ls = player:findFirstChild("leaderstats")
    if not ls then updateStatus("leaderstats NOT FOUND!", true) return false end
    
    local stat, foundName = findStat(chiNames)
    if not stat then 
        updateStatus("CHI/ENERGY STAT NOT FOUND!", true) 
        return false 
    end
    
    local old = stat.Value
    if amount == math.huge then
        stat.Value = 9.999999999999999e+23
        updateStatus("⚡ " .. foundName .. ": INFINITE! (OLD: " .. old .. ")")
    else
        stat.Value = old + amount
        updateStatus("⚡ " .. foundName .. ": +" .. amount .. " (NOW: " .. stat.Value .. ")")
    end
    return true
end

coinBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(coinInput.Text)
    if not amt then updateStatus("INVALID AMOUNT!", true) coinInput.Text = "" return end
    injectCoin(amt)
    coinInput.Text = ""
end)

chiBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(chiInput.Text)
    if not amt then updateStatus("INVALID AMOUNT!", true) chiInput.Text = "" return end
    injectChi(amt)
    chiInput.Text = ""
end)

print("═══════════════════════════════════════")
print("ARCHITECT 04 - NINJA LEGENDS V2 FIXED")
print("COIN DETECTED: " .. tostring(coinName or "NOT FOUND"))
print("CHI DETECTED: " .. tostring(chiName or "NOT FOUND"))
print("═══════════════════════════════════════")
