repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════════════
-- 🌟 MATRIX GLOW LOADING SCREEN
-- ═══════════════════════════════════════════════════════════════════════

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "MatrixLoading"
loadingGui.Parent = game:GetService("CoreGui")
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0
bg.Parent = loadingGui

local glowCircle = Instance.new("Frame")
glowCircle.Size = UDim2.new(0, 180, 0, 180)
glowCircle.Position = UDim2.new(0.5, -90, 0.5, -120)
glowCircle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
glowCircle.BackgroundTransparency = 0.85
glowCircle.BorderSizePixel = 0
glowCircle.Parent = loadingGui

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(1, 0)
glowCorner.Parent = glowCircle

local innerGlow = Instance.new("Frame")
innerGlow.Size = UDim2.new(0, 100, 0, 100)
innerGlow.Position = UDim2.new(0.5, -50, 0.5, -170)
innerGlow.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
innerGlow.BackgroundTransparency = 0.9
innerGlow.BorderSizePixel = 0
innerGlow.Parent = loadingGui

local innerCorner = Instance.new("UICorner")
innerCorner.CornerRadius = UDim.new(1, 0)
innerCorner.Parent = innerGlow

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, 0, 0, 50)
titleText.Position = UDim2.new(0, 0, 0.5, -80)
titleText.BackgroundTransparency = 1
titleText.Text = "MANTAXRACE"
titleText.TextColor3 = Color3.fromRGB(0, 255, 0)
titleText.TextSize = 38
titleText.Font = Enum.Font.GothamBold
titleText.TextScaled = true
titleText.Parent = loadingGui

local subText = Instance.new("TextLabel")
subText.Size = UDim2.new(1, 0, 0, 25)
subText.Position = UDim2.new(0, 0, 0.5, -35)
subText.BackgroundTransparency = 1
subText.Text = "MATRIX GLOW EDITION"
subText.TextColor3 = Color3.fromRGB(0, 200, 0)
subText.TextSize = 13
subText.Font = Enum.Font.Gotham
subText.Parent = loadingGui

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0.5, 0, 0, 3)
progressBar.Position = UDim2.new(0.25, 0, 0.5, 20)
progressBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
progressBar.BorderSizePixel = 0
progressBar.Parent = loadingGui

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBar

local percentText = Instance.new("TextLabel")
percentText.Size = UDim2.new(1, 0, 0, 30)
percentText.Position = UDim2.new(0, 0, 0.5, 40)
percentText.BackgroundTransparency = 1
percentText.Text = "0%"
percentText.TextColor3 = Color3.fromRGB(0, 255, 0)
percentText.TextSize = 13
percentText.Font = Enum.Font.GothamBold
percentText.Parent = loadingGui

local loadingSteps = {
    "INITIALIZING MATRIX...",
    "LOADING CORE MODULES...",
    "CONNECTING TO SERVER...",
    "VALIDATING CREDENTIALS...",
    "STARTING QUANTUM ENGINE..."
}

local stepText = Instance.new("TextLabel")
stepText.Size = UDim2.new(1, 0, 0, 20)
stepText.Position = UDim2.new(0, 0, 0.5, 70)
stepText.BackgroundTransparency = 1
stepText.Text = loadingSteps[1]
stepText.TextColor3 = Color3.fromRGB(100, 100, 100)
stepText.TextSize = 10
stepText.Font = Enum.Font.Gotham
stepText.Parent = loadingGui

for i = 0, 1, 0.02 do
    progressFill.Size = UDim2.new(i, 0, 1, 0)
    percentText.Text = math.floor(i * 100) .. "%"
    glowCircle.BackgroundTransparency = 0.85 - (i * 0.3)
    innerGlow.BackgroundTransparency = 0.9 - (i * 0.3)
    titleText.TextColor3 = Color3.fromRGB(0, 255 * math.min(i * 1.5, 1), 0)
    
    local stepIndex = math.floor(i * #loadingSteps) + 1
    if stepIndex <= #loadingSteps then
        stepText.Text = loadingSteps[stepIndex]
    end
    task.wait(0.015)
end

task.wait(0.3)
loadingGui:Destroy()

-- ═══════════════════════════════════════════════════════════════════════
-- 🔐 KEY SYSTEM (FETCH FROM GITHUB)
-- ═══════════════════════════════════════════════════════════════════════

local function notify(title, text, dur)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = text, Duration = dur or 3})
    end)
end

local correctKey = "Mantax" -- fallback

-- Fetch key dari GitHub
local success, fetchedKey = pcall(function()
    return game:HttpGet("https://raw.githubusercontent.com/LynxaOfficial/LynxaUserData/main/key.txt")
end)

if success and fetchedKey then
    correctKey = fetchedKey:gsub("\n", ""):gsub("\r", "")
    notify("🔐 KEY SYSTEM", "Key loaded from server!", 2)
else
    notify("⚠️ KEY SYSTEM", "Using fallback key. Server unreachable.", 3)
end

local keyVerified = false

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.Parent = game:GetService("CoreGui")

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 380, 0, 250)
keyFrame.Position = UDim2.new(0.5, -190, 0.5, -125)
keyFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
keyFrame.BackgroundTransparency = 0.05
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 20)
keyCorner.Parent = keyFrame

local glowBorder = Instance.new("Frame")
glowBorder.Size = UDim2.new(1, 0, 1, 0)
glowBorder.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
glowBorder.BackgroundTransparency = 0.9
glowBorder.BorderSizePixel = 0
glowBorder.Parent = keyFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 20)
borderCorner.Parent = glowBorder

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 50)
keyTitle.Position = UDim2.new(0, 0, 0, 15)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "⚡ MANTAXRACE"
keyTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
keyTitle.TextSize = 26
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Parent = keyFrame

local keySub = Instance.new("TextLabel")
keySub.Size = UDim2.new(1, 0, 0, 25)
keySub.Position = UDim2.new(0, 0, 0, 65)
keySub.BackgroundTransparency = 1
keySub.Text = "ENTER ACTIVATION KEY"
keySub.TextColor3 = Color3.fromRGB(150, 150, 180)
keySub.TextSize = 11
keySub.Font = Enum.Font.Gotham
keySub.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.7, 0, 0, 45)
keyBox.Position = UDim2.new(0.15, 0, 0, 100)
keyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(0, 255, 0)
keyBox.TextSize = 18
keyBox.Font = Enum.Font.GothamBold
keyBox.PlaceholderText = "Enter KEY"
keyBox.Parent = keyFrame

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 10)
keyBoxCorner.Parent = keyBox

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.5, 0, 0, 45)
keyBtn.Position = UDim2.new(0.25, 0, 0, 160)
keyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
keyBtn.Text = "ACTIVATE"
keyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
keyBtn.TextSize = 16
keyBtn.Font = Enum.Font.GothamBold
keyBtn.Parent = keyFrame

local keyBtnCorner = Instance.new("UICorner")
keyBtnCorner.CornerRadius = UDim.new(0, 10)
keyBtnCorner.Parent = keyBtn

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 20)
statusText.Position = UDim2.new(0, 0, 0, 215)
statusText.BackgroundTransparency = 1
statusText.Text = ""
statusText.TextColor3 = Color3.fromRGB(255, 0, 0)
statusText.TextSize = 10
statusText.Font = Enum.Font.Gotham
statusText.Parent = keyFrame

local attemptCount = 0

keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == correctKey then
        keyVerified = true
        statusText.Text = "✅ VALID! LOADING SCRIPT..."
        statusText.TextColor3 = Color3.fromRGB(0, 255, 0)
        task.wait(1)
        keyGui:Destroy()
        notify("✅ ACCESS GRANTED", "Welcome to MantaxRace! Enjoy unlimited power.", 4)
        loadMainScript()
    else
        attemptCount = attemptCount + 1
        statusText.Text = "❌ WRONG KEY! Attempt " .. attemptCount .. "/3"
        statusText.TextColor3 = Color3.fromRGB(255, 0, 0)
        keyBox.Text = ""
        keyBox.PlaceholderText = "WRONG KEY!"
        task.wait(1)
        keyBox.PlaceholderText = "Enter KEY"
        
        if attemptCount >= 3 then
            statusText.Text = "🔒 MAX ATTEMPTS REACHED. SCRIPT LOCKED."
            keyBtn.Visible = false
            keyBox.Visible = false
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- 🚀 MAIN SCRIPT (LOADED AFTER KEY)
-- ═══════════════════════════════════════════════════════════════════════

function loadMainScript()

local player = game.Players.LocalPlayer
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local virtualInput = game:GetService("VirtualInputManager")
local tweenService = game:GetService("TweenService")
local starterGui = game:GetService("StarterGui")

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 SPEED LIMIT (UNLIMITED: 9999999999999999)
-- ═══════════════════════════════════════════════════════════════════════

-- 9999999999999999 = 9.999.999.999.999.999 (9.9 Quadrillion)
-- Ini adalah batas maksimum tipe data number di Lua

local MAX_SPEED = 9999999999999999

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 VARIABLES
-- ═══════════════════════════════════════════════════════════════════════

local character = nil
local humanoid = nil
local hrp = nil

local autoClick = false
local autoUpgrade = false
local autoRace = false
local autoHatch = false
local autoRebirth = false
local autoClaim = false

local clickDelay = 0.01
local currentSpeed = 16

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════

local function updateChar()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    hrp = character:WaitForChild("HumanoidRootPart")
end
updateChar()
player.CharacterAdded:Connect(updateChar)

local function clickScreen()
    pcall(function()
        virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
        task.wait(0.01)
        virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
    end)
end

local function findButton(btnName)
    for _, gui in pairs(coreGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            local btn = gui:FindFirstChild(btnName, true)
            if btn and btn:IsA("TextButton") then
                return btn
            end
        end
    end
    return nil
end

local function clickButton(btn)
    if btn then
        pcall(function() btn:Fire() end)
        return true
    end
    return false
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 AUTO CLICK
-- ═══════════════════════════════════════════════════════════════════════

local function startAutoClick()
    if autoClick then return end
    autoClick = true
    task.spawn(function()
        while autoClick and task.wait(clickDelay) do
            clickScreen()
        end
    end)
    notify("⚡ AUTO CLICK", "Activated!", 2)
end

local function stopAutoClick()
    autoClick = false
    notify("⚡ AUTO CLICK", "Deactivated!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 AUTO UPGRADE
-- ═══════════════════════════════════════════════════════════════════════

local function startAutoUpgrade()
    if autoUpgrade then return end
    autoUpgrade = true
    task.spawn(function()
        while autoUpgrade and task.wait(0.3) do
            local upgradeBtn = findButton("Upgrade") or findButton("Speed") or findButton("Power")
            if upgradeBtn then clickButton(upgradeBtn) end
        end
    end)
    notify("📈 AUTO UPGRADE", "Activated!", 2)
end

local function stopAutoUpgrade()
    autoUpgrade = false
    notify("📈 AUTO UPGRADE", "Deactivated!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 AUTO RACE
-- ═══════════════════════════════════════════════════════════════════════

local function startAutoRace()
    if autoRace then return end
    autoRace = true
    task.spawn(function()
        while autoRace and task.wait(1) do
            local raceBtn = findButton("Start") or findButton("Race") or findButton("Go")
            if raceBtn then 
                clickButton(raceBtn)
                task.wait(5)
            end
            local nextBtn = findButton("Next") or findButton("Continue")
            if nextBtn then clickButton(nextBtn) end
        end
    end)
    notify("🏎️ AUTO RACE", "Activated!", 2)
end

local function stopAutoRace()
    autoRace = false
    notify("🏎️ AUTO RACE", "Deactivated!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 AUTO HATCH
-- ═══════════════════════════════════════════════════════════════════════

local function startAutoHatch()
    if autoHatch then return end
    autoHatch = true
    task.spawn(function()
        while autoHatch and task.wait(0.5) do
            local hatchBtn = findButton("Hatch") or findButton("Open") or findButton("Egg")
            if hatchBtn then clickButton(hatchBtn) end
        end
    end)
    notify("🥚 AUTO HATCH", "Activated!", 2)
end

local function stopAutoHatch()
    autoHatch = false
    notify("🥚 AUTO HATCH", "Deactivated!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 AUTO REBIRTH
-- ═══════════════════════════════════════════════════════════════════════

local function startAutoRebirth()
    if autoRebirth then return end
    autoRebirth = true
    task.spawn(function()
        while autoRebirth and task.wait(2) do
            local rebirthBtn = findButton("Rebirth") or findButton("Prestige") or findButton("Reset")
            if rebirthBtn then 
                clickButton(rebirthBtn)
                notify("🔄 REBIRTH", "Performed!", 2)
                task.wait(3)
            end
        end
    end)
    notify("🔄 AUTO REBIRTH", "Activated!", 2)
end

local function stopAutoRebirth()
    autoRebirth = false
    notify("🔄 AUTO REBIRTH", "Deactivated!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 AUTO CLAIM
-- ═══════════════════════════════════════════════════════════════════════

local function startAutoClaim()
    if autoClaim then return end
    autoClaim = true
    task.spawn(function()
        while autoClaim and task.wait(1) do
            local claimBtn = findButton("Claim") or findButton("Collect") or findButton("Reward")
            if claimBtn then clickButton(claimBtn) end
        end
    end)
    notify("🎁 AUTO CLAIM", "Activated!", 2)
end

local function stopAutoClaim()
    autoClaim = false
    notify("🎁 AUTO CLAIM", "Deactivated!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 SET SPEED FUNCTION (UNLIMITED)
-- ═══════════════════════════════════════════════════════════════════════

local function setSpeed(speed)
    local newSpeed = math.clamp(speed, 16, MAX_SPEED)
    currentSpeed = newSpeed
    if humanoid then
        humanoid.WalkSpeed = newSpeed
    end
    notify("🚀 SPEED SET", tostring(newSpeed) .. " (Unlimited Mode)", 2)
end

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 BLOCK BOX (MENU BUTTON DENGAN GAMBAR/ICON)
-- ═══════════════════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MantaxMenu"
screenGui.Parent = coreGui

-- Block Box (bukan huruf M, pakai gambar lingkaran dengan icon)
local blockBox = Instance.new("ImageButton")
blockBox.Size = UDim2.new(0, 55, 0, 55)
blockBox.Position = getgenv().BlockBoxPos or UDim2.new(1, -70, 1, -70)
blockBox.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
blockBox.BackgroundTransparency = 0.15
blockBox.Image = "rbxassetid://3926305904" -- Lingkaran
blockBox.ImageColor3 = Color3.fromRGB(0, 255, 0)
blockBox.Parent = screenGui

-- Icon di dalam block box (pakai ⚡, bukan M)
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "⚡"
icon.TextColor3 = Color3.fromRGB(0, 255, 0)
icon.TextSize = 32
icon.Font = Enum.Font.GothamBold
icon.Parent = blockBox

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = blockBox

-- Efek glow
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1.4, 0, 1.4, 0)
glow.Position = UDim2.new(-0.2, 0, -0.2, 0)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://3926305904"
glow.ImageColor3 = Color3.fromRGB(0, 255, 0)
glow.ImageTransparency = 0.6
glow.Parent = blockBox

-- Draggable
local dragging = false
local dragStart = nil
local startPos = nil

blockBox.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = blockBox.Position
    end
end)

blockBox.InputEnded:Connect(function()
    dragging = false
    getgenv().BlockBoxPos = blockBox.Position
end)

userInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        blockBox.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 FLUENT GUI
-- ═══════════════════════════════════════════════════════════════════════

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local window = Fluent:CreateWindow({
    Title = "⚡ MANTAXRACE v2.0",
    SubTitle = "Matrix Glow Edition | Unlimited Mode",
    TabWidth = 130,
    Size = UDim2.fromOffset(520, 480),
    Acrylic = false,
    Theme = "Dark"
})

-- Tabs
local mainTab = window:AddTab({Title = "⚡ MAIN"})
local speedTab = window:AddTab({Title = "🚀 SPEED"})
local raceTab = window:AddTab({Title = "🏎️ RACE"})
local upgradeTab = window:AddTab({Title = "📈 UPGRADE"})
local petTab = window:AddTab({Title = "🥚 PET"})

-- Main Tab
mainTab:AddButton({Title = "▶ START AUTO CLICK", Callback = startAutoClick})
mainTab:AddButton({Title = "⏹ STOP AUTO CLICK", Callback = stopAutoClick})
mainTab:AddButton({Title = "▶ START AUTO CLAIM", Callback = startAutoClaim})
mainTab:AddButton({Title = "⏹ STOP AUTO CLAIM", Callback = stopAutoClaim})
mainTab:AddButton({Title = "🔄 AUTO REBIRTH", Callback = startAutoRebirth})
mainTab:AddButton({Title = "⏹ STOP REBIRTH", Callback = stopAutoRebirth})

-- Speed Tab
speedTab:AddSlider("SpeedSlider", {
    Title = "⚡ WALK SPEED (UNLIMITED)",
    Default = 32,
    Min = 16,
    Max = MAX_SPEED,
    Rounding = 0,
    Callback = setSpeed
})
speedTab:AddButton({Title = "🚀 RESET TO NORMAL (16)", Callback = function() setSpeed(16) end})

-- Race Tab
raceTab:AddButton({Title = "🏁 START AUTO RACE", Callback = startAutoRace})
raceTab:AddButton({Title = "🏁 STOP AUTO RACE", Callback = stopAutoRace})

-- Upgrade Tab
upgradeTab:AddButton({Title = "📈 START AUTO UPGRADE", Callback = startAutoUpgrade})
upgradeTab:AddButton({Title = "📈 STOP AUTO UPGRADE", Callback = stopAutoUpgrade})

-- Pet Tab
petTab:AddButton({Title = "🥚 START AUTO HATCH", Callback = startAutoHatch})
petTab:AddButton({Title = "🥚 STOP AUTO HATCH", Callback = stopAutoHatch})

-- Toggle GUI dengan Block Box
local guiVisible = true
blockBox.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    window.Visible = guiVisible
    -- Bounce animation
    local tween = tweenService:Create(blockBox, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(0, 50, 0, 50)})
    tween:Play()
    tween.Completed:Connect(function()
        tweenService:Create(blockBox, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(0, 55, 0, 55)}):Play()
    end)
end)

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 INFINITE JUMP
-- ═══════════════════════════════════════════════════════════════════════

userInputService.JumpRequest:Connect(function()
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- 📁 PLAYER INFO PANEL
-- ═══════════════════════════════════════════════════════════════════════

local infoGui = Instance.new("ScreenGui")
infoGui.Name = "MantaxInfo"
infoGui.Parent = coreGui

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0, 240, 0, 100)
infoFrame.Position = UDim2.new(0, 8, 1, -110)
infoFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
infoFrame.BackgroundTransparency = 0.3
infoFrame.BorderSizePixel = 0
infoFrame.Parent = infoGui

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoFrame

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 22)
infoTitle.Text = "⚡ MANTAXRACE"
infoTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
infoTitle.Font = Enum.Font.GothamBold
infoTitle.TextSize = 10
infoTitle.BackgroundTransparency = 1
infoTitle.Parent = infoFrame

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -10, 0, 70)
infoText.Position = UDim2.new(0, 5, 0, 25)
infoText.Text = "Loading..."
infoText.TextColor3 = Color3.fromRGB(200, 200, 200)
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 9
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.BackgroundTransparency = 1
infoText.RichText = true
infoText.Parent = infoFrame

task.spawn(function()
    while true do
        task.wait(2)
        pcall(function()
            local level = player.Data and player.Data.Level and player.Data.Level.Value or 0
            local cash = player.Data and player.Data.Cash and player.Data.Cash.Value or 0
            infoText.Text = string.format("<b>Level:</b> %s\n<b>Cash:</b> %s\n<b>Speed:</b> %s\n<b>Auto:</b> %s", 
                level, cash, currentSpeed, autoClick and "ON" or "OFF")
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- STARTUP
-- ═══════════════════════════════════════════════════════════════════════

print("MantaxRace v2.0 - Matrix Glow")
print("Unlimited Speed: " .. MAX_SPEED)
print("Tap ⚡ button to open menu")

notify("MantaxRace", "Ready. Tap ⚡ for menu", 3)

end
