-- ═══════════════════════════════════════════════════════
--     ARCHITECT 04 - NINJA LEGENDS
--     COIN + CHI INJECTOR (MINIMALIST)
--     © XyrooXellz
-- ═══════════════════════════════════════════════════════

local player = game.Players.LocalPlayer

-- CREATE UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Architect04"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 200)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -100)
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
title.Text = "  ARCHITECT 04 - NINJA LEGENDS"
title.TextColor3 = Color3.new(0, 1, 0)
title.TextSize = 13
title.Font = Enum.Font.SourceSansBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- CLOSE (TAPI GAUSAH /MENU, LANGSUNG KLOSE AJA)
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

-- COIN
local coinLabel = Instance.new("TextLabel")
coinLabel.Size = UDim2.new(1, -20, 0, 25)
coinLabel.Position = UDim2.new(0, 10, 0, 40)
coinLabel.BackgroundTransparency = 1
coinLabel.Text = "🪙 COIN"
coinLabel.TextColor3 = Color3.new(0, 1, 0)
coinLabel.TextSize = 12
coinLabel.Font = Enum.Font.SourceSansBold
coinLabel.TextXAlignment = Enum.TextXAlignment.Left
coinLabel.Parent = mainFrame

local coinInput = Instance.new("TextBox")
coinInput.Size = UDim2.new(0, 180, 0, 32)
coinInput.Position = UDim2.new(0, 10, 0, 65)
coinInput.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
coinInput.BorderColor3 = Color3.new(0, 1, 0)
coinInput.BorderSizePixel = 1
coinInput.Text = ""
coinInput.PlaceholderText = "jumlah coin"
coinInput.PlaceholderColor3 = Color3.new(0.3, 0.3, 0.3)
coinInput.TextColor3 = Color3.new(0, 1, 0)
coinInput.TextSize = 12
coinInput.Font = Enum.Font.SourceSans
coinInput.Parent = mainFrame

local coinBtn = Instance.new("TextButton")
coinBtn.Size = UDim2.new(0, 120, 0, 32)
coinBtn.Position = UDim2.new(0, 200, 0, 65)
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
chiLabel.Position = UDim2.new(0, 10, 0, 110)
chiLabel.BackgroundTransparency = 1
chiLabel.Text = "⚡ CHI"
chiLabel.TextColor3 = Color3.new(0, 1, 0)
chiLabel.TextSize = 12
chiLabel.Font = Enum.Font.SourceSansBold
chiLabel.TextXAlignment = Enum.TextXAlignment.Left
chiLabel.Parent = mainFrame

local chiInput = Instance.new("TextBox")
chiInput.Size = UDim2.new(0, 180, 0, 32)
chiInput.Position = UDim2.new(0, 10, 0, 135)
chiInput.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
chiInput.BorderColor3 = Color3.new(0, 1, 0)
chiInput.BorderSizePixel = 1
chiInput.Text = ""
chiInput.PlaceholderText = "jumlah chi"
chiInput.PlaceholderColor3 = Color3.new(0.3, 0.3, 0.3)
chiInput.TextColor3 = Color3.new(0, 1, 0)
chiInput.TextSize = 12
chiInput.Font = Enum.Font.SourceSans
chiInput.Parent = mainFrame

local chiBtn = Instance.new("TextButton")
chiBtn.Size = UDim2.new(0, 120, 0, 32)
chiBtn.Position = UDim2.new(0, 200, 0, 135)
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
status.Position = UDim2.new(0, 10, 0, 175)
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

local function injectCoin(amount)
    local ls = player:findFirstChild("leaderstats")
    if not ls then updateStatus("leaderstats NOT FOUND", true) return false end
    local stat = ls:findFirstChild("Coins")
    if not stat then updateStatus("COIN NOT FOUND", true) return false end
    local old = stat.Value
    if amount == math.huge then
        stat.Value = 9.999999999999999e+23
        updateStatus("COIN: INFINITE!")
    else
        stat.Value = old + amount
        updateStatus("COIN: +" .. amount .. " (NOW: " .. stat.Value .. ")")
    end
    return true
end

local function injectChi(amount)
    local ls = player:findFirstChild("leaderstats")
    if not ls then updateStatus("leaderstats NOT FOUND", true) return false end
    local stat = ls:findFirstChild("Chi") or ls:findFirstChild("Energy")
    if not stat then updateStatus("CHI/ENERGY NOT FOUND", true) return false end
    local old = stat.Value
    if amount == math.huge then
        stat.Value = 9.999999999999999e+23
        updateStatus("CHI: INFINITE!")
    else
        stat.Value = old + amount
        updateStatus("CHI: +" .. amount .. " (NOW: " .. stat.Value .. ")")
    end
    return true
end

coinBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(coinInput.Text)
    if not amt then updateStatus("INVALID AMOUNT", true) coinInput.Text = "" return end
    injectCoin(amt)
    coinInput.Text = ""
end)

chiBtn.MouseButton1Click:Connect(function()
    local amt = parseAmount(chiInput.Text)
    if not amt then updateStatus("INVALID AMOUNT", true) chiInput.Text = "" return end
    injectChi(amt)
    chiInput.Text = ""
end)

print("Architect 04 - Ninja Legends LOADED, BANGSAT!")
