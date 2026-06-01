repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local coreGui = game:GetService("CoreGui")
local virtualInput = game:GetService("VirtualInputManager")
local userInputService = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")
local starterGui = game:GetService("StarterGui")
local teleportService = game:GetService("TeleportService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")

-- ═══════════════════════════════════════════════════════════════════════
-- GLOBAL VARIABLES
-- ═══════════════════════════════════════════════════════════════════════

local state = {
    autoClick = false,
    autoUpgrade = false,
    autoRace = false,
    autoHatch = false,
    autoRebirth = false,
    autoClaim = false,
    clickDelay = 0.01,
    currentSpeed = 32,
    maxSpeed = 250,
    character = nil,
    humanoid = nil,
    hrp = nil,
    selectedEgg = "Common Egg",
    selectedWorld = 1
}

-- ═══════════════════════════════════════════════════════════════════════
-- EGG DATA (LENGKAP DARI WIKI RACE CLICKER UPDATE TERBARU)
-- ═══════════════════════════════════════════════════════════════════════

local eggData = {
    {name = "Common Egg", price = 100, rarity = "Common", pet = "Cat, Dog, Rabbit", hatchTime = 5},
    {name = "Uncommon Egg", price = 500, rarity = "Uncommon", pet = "Fox, Raccoon, Otter", hatchTime = 10},
    {name = "Rare Egg", price = 2000, rarity = "Rare", pet = "Wolf, Eagle, Snake", hatchTime = 30},
    {name = "Epic Egg", price = 10000, rarity = "Epic", pet = "Dragon, Phoenix, Griffin", hatchTime = 60},
    {name = "Legendary Egg", price = 50000, rarity = "Legendary", pet = "Kitsune, Leopard, Fenrir", hatchTime = 120},
    {name = "Mythic Egg", price = 250000, rarity = "Mythic", pet = "Mammoth, T-Rex, Titan", hatchTime = 300},
    {name = "Divine Egg", price = 1000000, rarity = "Divine", pet = "Celestial Dragon, Angel, Demon", hatchTime = 600},
    {name = "Golden Egg", price = 5000000, rarity = "Godly", pet = "Golden Phoenix, Golden Dragon", hatchTime = 900},
    {name = "Matrix Egg", price = 10000000, rarity = "Matrix", pet = "Neon Glow Dragon, Cyber Wolf", hatchTime = 1200},
    {name = "Chrono Egg", price = 25000000, rarity = "Chrono", pet = "Time Warden, Chrono Beast", hatchTime = 1800},
    {name = "Void Egg", price = 50000000, rarity = "Void", pet = "Void Reaper, Abyss Walker", hatchTime = 2400},
    {name = "Stellar Egg", price = 100000000, rarity = "Stellar", pet = "Star Dragon, Comet Fox", hatchTime = 3600},
    {name = "Omni Egg", price = 250000000, rarity = "Omni", pet = "Omnidragon, Primordial Beast", hatchTime = 4800},
    {name = "Ethereal Egg", price = 500000000, rarity = "Ethereal", pet = "Ethereal Phoenix, Spirit Wolf", hatchTime = 6000},
    {name = "Ultimate Egg", price = 1000000000, rarity = "Ultimate", pet = "Ultimate Celestial, God of Racing", hatchTime = 7200}
}

-- ═══════════════════════════════════════════════════════════════════════
-- WORLD DATA (LENGKAP DARI WIKI RACE CLICKER UPDATE TERBARU)
-- ═══════════════════════════════════════════════════════════════════════

local worldData = {
    {id = 1, name = "Racing Hub", desc = "★ Starting World ★", requirement = 0, color = "Green"},
    {id = 2, name = "Speed Realm", desc = "⚡ Speed Challenge Arena", requirement = 100, color = "Cyan"},
    {id = 3, name = "Matrix Dimension", desc = "💠 Neon Racing Zone", requirement = 500, color = "Purple"},
    {id = 4, name = "Chrono Void", desc = "⏰ Time Distortion Track", requirement = 1000, color = "Blue"},
    {id = 5, name = "Stellar Highway", desc = "⭐ Cosmic Racing Path", requirement = 2500, color = "Gold"},
    {id = 6, name = "Abyss Circuit", desc = "🌊 Dark Water Track", requirement = 5000, color = "Dark Blue"},
    {id = 7, name = "Ethereal Sky", desc = "☁️ Floating Islands Race", requirement = 10000, color = "White"},
    {id = 8, name = "Ultimate Colosseum", desc = "🏆 Final Racing Arena", requirement = 25000, color = "Rainbow"}
}

-- ═══════════════════════════════════════════════════════════════════════
-- MATRIX GLOW LOADING ANIMATION
-- ═══════════════════════════════════════════════════════════════════════

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "MatrixLoading"
loadingGui.Parent = coreGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.Parent = loadingGui

local glows = {}
for i = 1, 4 do
    local g = Instance.new("Frame")
    local size = 100 + (i-1)*40
    g.Size = UDim2.new(0, size, 0, size)
    g.Position = UDim2.new(0.5, -size/2, 0.5, -size/2 - 50)
    g.BackgroundColor3 = Color3.fromRGB(0, 255 - (i-1)*60, 0)
    g.BackgroundTransparency = 0.9
    g.BorderSizePixel = 0
    g.Parent = loadingGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = g
    glows[i] = {frame = g, angle = 0}
end

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0.5, -80)
title.BackgroundTransparency = 1
title.Text = "『 MANTAXRACE 』"
title.TextColor3 = Color3.fromRGB(0, 255, 0)
title.TextSize = 36
title.Font = Enum.Font.GothamBold
title.Parent = loadingGui

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0.5, -35)
sub.BackgroundTransparency = 1
sub.Text = "✦ ULTIMATE EDITION ✦"
sub.TextColor3 = Color3.fromRGB(0, 200, 0)
sub.TextSize = 11
sub.Font = Enum.Font.Gotham
sub.Parent = loadingGui

local bar = Instance.new("Frame")
bar.Size = UDim2.new(0.5, 0, 0, 2)
bar.Position = UDim2.new(0.25, 0, 0.5, 25)
bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
bar.BorderSizePixel = 0
bar.Parent = loadingGui

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
fill.BorderSizePixel = 0
fill.Parent = bar

local pct = Instance.new("TextLabel")
pct.Size = UDim2.new(1, 0, 0, 18)
pct.Position = UDim2.new(0, 0, 0.5, 50)
pct.BackgroundTransparency = 1
pct.Text = "0%"
pct.TextColor3 = Color3.fromRGB(0, 255, 0)
pct.TextSize = 10
pct.Font = Enum.Font.GothamBold
pct.Parent = loadingGui

local steps = {"INITIALIZING", "LOADING EGG DATA", "LOADING WORLD DATA", "CONNECTING", "READY"}
local stepText = Instance.new("TextLabel")
stepText.Size = UDim2.new(1, 0, 0, 16)
stepText.Position = UDim2.new(0, 0, 0.5, 75)
stepText.BackgroundTransparency = 1
stepText.Text = steps[1]
stepText.TextColor3 = Color3.fromRGB(100, 100, 100)
stepText.TextSize = 9
stepText.Font = Enum.Font.Gotham
stepText.Parent = loadingGui

local angle = 0
task.spawn(function()
    while loadingGui.Parent do
        angle = angle + 0.03
        for i, g in ipairs(glows) do
            local phase = angle + (i * math.pi / 3)
            local scale = 1 + math.sin(phase * 2) * 0.1
            local alpha = 0.9 - math.sin(phase) * 0.2
            local size = (100 + (i-1)*40) * scale
            g.frame.Size = UDim2.new(0, size, 0, size)
            g.frame.Position = UDim2.new(0.5, -size/2, 0.5, -size/2 - 50)
            g.frame.BackgroundTransparency = alpha
            local intensity = 0.4 + math.sin(phase * 3) * 0.3
            g.frame.BackgroundColor3 = Color3.fromRGB(0, 255 * intensity, 0)
        end
        task.wait(0.04)
    end
end)

for i = 0, 1, 0.02 do
    fill.Size = UDim2.new(i, 0, 1, 0)
    pct.Text = math.floor(i * 100) .. "%"
    local idx = math.min(math.floor(i * #steps) + 1, #steps)
    stepText.Text = steps[idx]
    title.TextColor3 = Color3.fromRGB(0, 255 * math.min(i * 1.5, 1), 0)
    task.wait(0.012)
end

task.wait(0.4)
loadingGui:Destroy()

-- ═══════════════════════════════════════════════════════════════════════
-- NOTIFY
-- ═══════════════════════════════════════════════════════════════════════

local function notify(title, text, dur)
    pcall(function() starterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = dur or 2}) end)
end

-- ═══════════════════════════════════════════════════════════════════════
-- KEY SYSTEM
-- ═══════════════════════════════════════════════════════════════════════

local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeySystem"
keyGui.Parent = coreGui

local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 320, 0, 200)
keyFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
keyFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
keyFrame.BackgroundTransparency = 0.05
keyFrame.BorderSizePixel = 0
keyFrame.Parent = keyGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 20)
keyCorner.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 40)
keyTitle.Position = UDim2.new(0, 0, 0, 12)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "『 MANTAXRACE 』"
keyTitle.TextColor3 = Color3.fromRGB(0, 255, 0)
keyTitle.TextSize = 22
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.7, 0, 0, 40)
keyBox.Position = UDim2.new(0.15, 0, 0, 65)
keyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(0, 255, 0)
keyBox.TextSize = 15
keyBox.Font = Enum.Font.GothamBold
keyBox.PlaceholderText = "Enter Key"
keyBox.Parent = keyFrame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 10)
boxCorner.Parent = keyBox

local keyBtn = Instance.new("TextButton")
keyBtn.Size = UDim2.new(0.5, 0, 0, 40)
keyBtn.Position = UDim2.new(0.25, 0, 0, 120)
keyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
keyBtn.Text = "ACTIVATE"
keyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
keyBtn.TextSize = 14
keyBtn.Font = Enum.Font.GothamBold
keyBtn.Parent = keyFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = keyBtn

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 0, 18)
statusText.Position = UDim2.new(0, 0, 0, 172)
statusText.BackgroundTransparency = 1
statusText.Text = ""
statusText.TextColor3 = Color3.fromRGB(255, 0, 0)
statusText.TextSize = 9
statusText.Font = Enum.Font.Gotham
statusText.Parent = keyFrame

local attempt = 0
keyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "Mantax" then
        keyGui:Destroy()
        notify("『 ACCESS GRANTED 』", "Welcome to MantaxRace Ultimate Edition", 3)
        startMainScript()
    else
        attempt = attempt + 1
        statusText.Text = "✗ Wrong key · Attempt " .. attempt .. "/3"
        keyBox.Text = ""
        if attempt >= 3 then
            statusText.Text = "『 SCRIPT LOCKED 』 · Restart to try again"
            keyBtn.Visible = false
            keyBox.Visible = false
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- MAIN SCRIPT
-- ═══════════════════════════════════════════════════════════════════════

local function startMainScript()

local function updateChar()
    state.character = player.Character or player.CharacterAdded:Wait()
    state.humanoid = state.character:WaitForChild("Humanoid")
    state.hrp = state.character:WaitForChild("HumanoidRootPart")
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

local function findButton(names)
    for _, gui in pairs(coreGui:GetChildren()) do
        if gui:IsA("ScreenGui") then
            for _, n in ipairs(names) do
                local btn = gui:FindFirstChild(n, true)
                if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return btn end
            end
        end
    end
    local pg = player:FindFirstChild("PlayerGui")
    if pg then
        for _, n in ipairs(names) do
            local btn = pg:FindFirstChild(n, true)
            if btn and (btn:IsA("TextButton") or btn:IsA("ImageButton")) then return btn end
        end
    end
    return nil
end

local function clickBtn(btn)
    if btn then pcall(function() btn:Fire() btn:FireServer() end) return true end
    return false
end

-- ═══════════════════════════════════════════════════════════════════════
-- TELEPORT WORLD (8 WORLD LENGKAP)
-- ═══════════════════════════════════════════════════════════════════════

local function teleportToWorld(worldId)
    pcall(function()
        local remote = replicatedStorage:FindFirstChild("Remotes")
        if remote then
            remote:FireServer("Teleport", worldId)
        end
        local world = worldData[worldId]
        if world then
            notify("『 TELEPORT 』", "Moving to " .. world.name, 2)
        end
    end)
end

local function teleportWorld1() teleportToWorld(1) end
local function teleportWorld2() teleportToWorld(2) end
local function teleportWorld3() teleportToWorld(3) end
local function teleportWorld4() teleportToWorld(4) end
local function teleportWorld5() teleportToWorld(5) end
local function teleportWorld6() teleportToWorld(6) end
local function teleportWorld7() teleportToWorld(7) end
local function teleportWorld8() teleportToWorld(8) end

-- ═══════════════════════════════════════════════════════════════════════
-- HATCH PET LENGKAP
-- ═══════════════════════════════════════════════════════════════════════

local function getEggPrice(eggName)
    for _, egg in ipairs(eggData) do
        if egg.name == eggName then
            return egg.price
        end
    end
    return 0
end

local function getEggInfo(eggName)
    for _, egg in ipairs(eggData) do
        if egg.name == eggName then
            return egg
        end
    end
    return nil
end

local function buyEggAndHatch(eggName)
    local egg = getEggInfo(eggName)
    if not egg then
        notify("『 ERROR 』", "Egg not found!", 2)
        return
    end
    
    pcall(function()
        local buyBtn = findButton({"BuyEgg", "PurchaseEgg", "Buy", eggName})
        if buyBtn then
            clickBtn(buyBtn)
            notify("『 PURCHASED 』", egg.name .. " - $" .. egg.price, 2)
            task.wait(0.5)
        end
        
        local hatchBtn = findButton({"Hatch", "Open", "HatchEgg", "OpenEgg"})
        if hatchBtn then
            clickBtn(hatchBtn)
            notify("『 HATCHING 』", "Hatching " .. egg.name .. "...", 2)
        end
    end)
end

local function startSmartHatch()
    if state.autoHatch then return end
    state.autoHatch = true
    notify("『 SMART HATCH 』", "Hatching: " .. state.selectedEgg, 2)
    task.spawn(function()
        while state.autoHatch and task.wait(1) do
            buyEggAndHatch(state.selectedEgg)
        end
    end)
end

local function stopSmartHatch()
    state.autoHatch = false
    notify("『 SMART HATCH 』", "Stopped", 1)
end

-- ═══════════════════════════════════════════════════════════════════════
-- GET PLAYER CASH
-- ═══════════════════════════════════════════════════════════════════════

local function getPlayerCash()
    local cash = 0
    pcall(function()
        cash = player.Data and player.Data.Cash and player.Data.Cash.Value or 0
    end)
    return cash
end

-- ═══════════════════════════════════════════════════════════════════════
-- AUTO FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════

local function startAC() if state.autoClick then return end state.autoClick = true notify("『 AUTO CLICK 』", "ON", 1) task.spawn(function() while state.autoClick and task.wait(state.clickDelay) do clickScreen() end end) end
local function stopAC() state.autoClick = false notify("『 AUTO CLICK 』", "OFF", 1) end

local function startAU() if state.autoUpgrade then return end state.autoUpgrade = true notify("『 AUTO UPGRADE 』", "ON", 1) task.spawn(function() while state.autoUpgrade and task.wait(0.5) do local b = findButton({"Upgrade","Speed","Power","Buy"}) if b then clickBtn(b) end end end) end
local function stopAU() state.autoUpgrade = false notify("『 AUTO UPGRADE 』", "OFF", 1) end

local function startAR() if state.autoRace then return end state.autoRace = true notify("『 AUTO RACE 』", "ON", 1) task.spawn(function() while state.autoRace and task.wait(1) do local s = findButton({"Start","Race","Go"}) if s then clickBtn(s) task.wait(5) end local n = findButton({"Next","Continue"}) if n then clickBtn(n) end end end) end
local function stopAR() state.autoRace = false notify("『 AUTO RACE 』", "OFF", 1) end

local function startARb() if state.autoRebirth then return end state.autoRebirth = true notify("『 AUTO REBIRTH 』", "ON", 1) task.spawn(function() while state.autoRebirth and task.wait(2) do local b = findButton({"Rebirth","Prestige","Reset"}) if b then clickBtn(b) notify("『 REBIRTH 』", "Performed", 2) task.wait(3) end end end) end
local function stopARb() state.autoRebirth = false notify("『 AUTO REBIRTH 』", "OFF", 1) end

local function startACl() if state.autoClaim then return end state.autoClaim = true notify("『 AUTO CLAIM 』", "ON", 1) task.spawn(function() while state.autoClaim and task.wait(1) do local b = findButton({"Claim","Collect","Reward"}) if b then clickBtn(b) end end end) end
local function stopACl() state.autoClaim = false notify("『 AUTO CLAIM 』", "OFF", 1) end

local function setSpeed(s)
    local ns = math.clamp(s, 16, state.maxSpeed)
    state.currentSpeed = ns
    if state.humanoid then state.humanoid.WalkSpeed = ns end
    notify("『 SPEED 』", tostring(ns), 1)
end

-- PLAYER STATS
local function getStats()
    local s = {level=0, cash=0, rebirths=0, clicks=0, clickPower=1, upgrade=1, petPower=0, raceWins=0, pet="None"}
    pcall(function()
        if player.Data then
            s.level = player.Data.Level and player.Data.Level.Value or 0
            s.cash = player.Data.Cash and player.Data.Cash.Value or 0
            s.rebirths = player.Data.Rebirths and player.Data.Rebirths.Value or 0
            s.clicks = player.Data.TotalClicks and player.Data.TotalClicks.Value or 0
            s.clickPower = player.Data.ClickPower and player.Data.ClickPower.Value or 1
            s.upgrade = player.Data.UpgradeLevel and player.Data.UpgradeLevel.Value or 1
            s.petPower = player.Data.PetPower and player.Data.PetPower.Value or 0
            s.raceWins = player.Data.RaceWins and player.Data.RaceWins.Value or 0
            s.pet = player.Data.CurrentPet and player.Data.CurrentPet.Value or "None"
        end
    end)
    return s
end

-- ═══════════════════════════════════════════════════════════════════════
-- BLOCK BOX
-- ═══════════════════════════════════════════════════════════════════════

local menuGui = Instance.new("ScreenGui")
menuGui.Name = "MantaxMenu"
menuGui.Parent = coreGui

local block = Instance.new("ImageButton")
block.Size = UDim2.new(0, 50, 0, 50)
block.Position = getgenv().BlockBoxPos or UDim2.new(1, -65, 1, -65)
block.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
block.BackgroundTransparency = 0.15
block.Image = "rbxassetid://3926305904"
block.ImageColor3 = Color3.fromRGB(0, 255, 0)
block.Parent = menuGui

local blockIcon = Instance.new("TextLabel")
blockIcon.Size = UDim2.new(1, 0, 1, 0)
blockIcon.BackgroundTransparency = 1
blockIcon.Text = "⚡"
blockIcon.TextColor3 = Color3.fromRGB(0, 255, 0)
blockIcon.TextSize = 28
blockIcon.Font = Enum.Font.GothamBold
blockIcon.Parent = block

local blockCorner = Instance.new("UICorner")
blockCorner.CornerRadius = UDim.new(1, 0)
blockCorner.Parent = block

local dragging = false
local dragStart, startPos
block.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = i.Position
        startPos = block.Position
    end
end)
block.InputEnded:Connect(function() dragging = false getgenv().BlockBoxPos = block.Position end)
userInputService.InputChanged:Connect(function(i)
    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
        local d = i.Position - dragStart
        block.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════
-- FLUENT GUI
-- ═══════════════════════════════════════════════════════════════════════

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local win = Fluent:CreateWindow({Title = "『 MANTAXRACE 』", SubTitle = "Ultimate Edition", Size = UDim2.fromOffset(520, 560), Theme = "Dark"})

local tabs = {
    main = win:AddTab({Title = "『 MAIN 』"}),
    auto = win:AddTab({Title = "『 AUTO 』"}),
    race = win:AddTab({Title = "『 RACE 』"}),
    pet = win:AddTab({Title = "『 PET 』"}),
    travel = win:AddTab({Title = "『 TRAVEL 』"}),
    stats = win:AddTab({Title = "『 STATS 』"}),
    settings = win:AddTab({Title = "『 SETTINGS 』"})
}

-- MAIN TAB
tabs.main:AddButton({Title = "▶ START AUTO CLICK", Callback = startAC})
tabs.main:AddButton({Title = "⏹ STOP AUTO CLICK", Callback = stopAC})
tabs.main:AddButton({Title = "🎁 START AUTO CLAIM", Callback = startACl})
tabs.main:AddButton({Title = "⏹ STOP AUTO CLAIM", Callback = stopACl})
tabs.main:AddButton({Title = "🔄 START AUTO REBIRTH", Callback = startARb})
tabs.main:AddButton({Title = "⏹ STOP REBIRTH", Callback = stopARb})

-- AUTO TAB
tabs.auto:AddButton({Title = "📈 START AUTO UPGRADE", Callback = startAU})
tabs.auto:AddButton({Title = "⏹ STOP AUTO UPGRADE", Callback = stopAU})
tabs.auto:AddButton({Title = "🥚 START AUTO HATCH", Callback = startSmartHatch})
tabs.auto:AddButton({Title = "⏹ STOP AUTO HATCH", Callback = stopSmartHatch})

-- RACE TAB
tabs.race:AddButton({Title = "🏁 START AUTO RACE", Callback = startAR})
tabs.race:AddButton({Title = "⏹ STOP AUTO RACE", Callback = stopAR})

-- PET TAB
local petSection = tabs.pet:AddSection("『 Egg Selection 』")

local eggNames = {}
for _, egg in ipairs(eggData) do
    table.insert(eggNames, egg.name .. " - $" .. egg.price)
end

tabs.pet:AddDropdown("EggSelector", {Title = "『 Select Egg 』", Values = eggNames, Default = eggNames[1], Callback = function(v)
    for _, egg in ipairs(eggData) do
        if egg.name .. " - $" .. egg.price == v then
            state.selectedEgg = egg.name
        end
    end
end})

tabs.pet:AddButton({Title = "🥚 BUY & HATCH", Callback = function() buyEggAndHatch(state.selectedEgg) end})
tabs.pet:AddButton({Title = "⚡ SMART HATCH (AUTO)", Callback = startSmartHatch})
tabs.pet:AddButton({Title = "⏹ STOP SMART HATCH", Callback = stopSmartHatch})

local eggInfoSection = tabs.pet:AddSection("『 Egg Info 』")
local eggInfoLabel = eggInfoSection:AddLabel("Select an egg")

task.spawn(function()
    while true do
        task.wait(1)
        local egg = getEggInfo(state.selectedEgg)
        if egg then
            eggInfoLabel:SetText(string.format([[
『 %s 』
💰 Price: $%s
✨ Rarity: %s
🐣 Possible Pets: %s
⏱️ Hatch Time: %s seconds
💎 Your Cash: $%s
]], egg.name, egg.price, egg.rarity, egg.pet, egg.hatchTime, getPlayerCash()))
        end
    end
end)

-- TRAVEL TAB (8 WORLDS)
local travelSection = tabs.travel:AddSection("『 World Teleportation 』")
for i = 1, 8 do
    local world = worldData[i]
    tabs.travel:AddButton({Title = "🌍 TELEPORT TO " .. world.name, Callback = function() teleportToWorld(i) end})
end

local worldInfoSection = tabs.travel:AddSection("『 World Info 』")
local worldInfoLabel = worldInfoSection:AddLabel("Select a world to teleport")

-- STATS TAB
local statsSection = tabs.stats:AddSection("『 Player Statistics 』")
local statsLabel = statsSection:AddLabel("Loading...")

task.spawn(function()
    while true do
        task.wait(1.5)
        local s = getStats()
        statsLabel:SetText(string.format([[
⚡ Level          : %s
💰 Cash           : %s
🔄 Rebirths       : %s
🖱️ Total Clicks   : %s
💥 Click Power    : %s
📈 Upgrade Level  : %s
🐾 Pet Power      : %s
🏆 Race Wins      : %s
🥚 Current Pet    : %s
]], s.level, s.cash, s.rebirths, s.clicks, s.clickPower, s.upgrade, s.petPower, s.raceWins, s.pet))
    end
end)

-- SETTINGS TAB
tabs.settings:AddSlider("Speed", {Title = "『 Walk Speed 』", Default = 32, Min = 16, Max = state.maxSpeed, Rounding = 0, Callback = setSpeed})
tabs.settings:AddButton({Title = "⟳ Reset to 16", Callback = function() setSpeed(16) end})
tabs.settings:AddSlider("ClickDelay", {Title = "『 Click Delay 』(ms)", Default = 10, Min = 1, Max = 100, Rounding = 0, Callback = function(v) state.clickDelay = v / 1000 end})

-- Toggle GUI
local visible = true
block.MouseButton1Click:Connect(function()
    visible = not visible
    win.Visible = visible
    local t = tweenService:Create(block, TweenInfo.new(0.08, Enum.EasingStyle.Back), {Size = UDim2.new(0, 42, 0, 42)})
    t:Play()
    t.Completed:Connect(function() tweenService:Create(block, TweenInfo.new(0.08, Enum.EasingStyle.Back), {Size = UDim2.new(0, 50, 0, 50)}):Play() end)
end)

-- Infinite Jump
userInputService.JumpRequest:Connect(function()
    if state.humanoid then state.humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- STARTUP
print("『 MANTAXRACE ULTIMATE EDITION 』")
print("✦ 15 Egg Types | 8 Worlds | Auto All ✦")
print("✦ Tap ⚡ to open menu ✦")
notify("『 MANTAXRACE 』", "Ultimate Edition Ready · Tap ⚡ for menu", 4)

end
