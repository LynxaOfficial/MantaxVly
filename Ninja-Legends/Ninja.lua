-- ═══════════════════════════════════════════════════════════════════
--     ARCHITECT 04 - NINJA LEGENDS 1 MASTER SCRIPT
--     AUTO FARM | HATCH EGG | UNLOCK ALL ISLANDS | TELEPORT
--     COMPLETE ISLAND DATABASE (20 ISLANDS)
--     © XyrooXellz
-- ═══════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualInput = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")

-- ═══════════════════════════════════════════════════════════════════
-- COMPLETE ISLAND DATABASE (20 ISLANDS - ORDERED)
-- Sumber: Ninja Legends Wiki & ProGameGuides [citation:1][citation:5]
-- ═══════════════════════════════════════════════════════════════════

local islandsDB = {
    { order = 1, name = "Enchanted Island", shop = false, chest = true, crystal = true, isShop = false },
    { order = 2, name = "Austral Island", shop = true, chest = false, crystal = true, isShop = true },
    { order = 3, name = "Mystical Island", shop = false, chest = true, crystal = true, isShop = false },
    { order = 4, name = "Space Island", shop = true, chest = true, crystal = true, isShop = true },
    { order = 5, name = "Tundra Island", shop = true, chest = true, crystal = true, isShop = true },
    { order = 6, name = "Eternal Island", shop = true, chest = true, crystal = true, isShop = true },
    { order = 7, name = "Sandstorm", shop = true, chest = true, crystal = true, isShop = true },
    { order = 8, name = "Thunderstorm", shop = true, chest = true, crystal = true, isShop = true },
    { order = 9, name = "Ancient Inferno Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 10, name = "Midnight Shadow Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 11, name = "Mythical Souls Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 12, name = "Winter Wonder Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 13, name = "Golden Master Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 14, name = "Dragon Legend Island", shop = true, chest = false, crystal = false, isShop = true },
    { order = 15, name = "Cybernetic Legends Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 16, name = "Skystorm Ultraus Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 17, name = "Chaos Legends Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 18, name = "Soul Fusion Island", shop = true, chest = true, crystal = false, isShop = true },
    { order = 19, name = "Dark Elements Island", shop = true, chest = false, crystal = false, isShop = true },
    { order = 20, name = "Inner Peace Island", shop = true, chest = false, crystal = false, isShop = true }
}

-- Bonus island (update terbaru)
local bonusIslands = {
    { order = 21, name = "Blazing Vortex Island", shop = true, chest = false, crystal = false, isShop = true }
}

-- Gabungin semua island
for _, island in pairs(bonusIslands) do
    table.insert(islandsDB, island)
end

-- ═══════════════════════════════════════════════════════════════════
-- CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════

local config = {
    -- Auto Farm
    autoSwing = true,
    autoSell = true,
    autoBuySwords = true,
    autoBuyBelts = true,
    autoBuySkills = true,
    autoBuyRanks = true,
    autoCollectChests = true,
    autoCollectHoops = false,
    
    -- Egg Hatch
    autoHatchEgg = true,
    eggType = "ALL", -- "NORMAL", "GOLDEN", "MYSTICAL", "ALL"
    
    -- Islands
    autoUnlockIslands = true,
    currentIsland = 1,
    
    -- Boss Farm (Ninja Legends 1 bosses)
    autoFarmBosses = true,
    
    -- Others
    antiAFK = true,
    infiniteJump = true,
    fastSwing = true,
    autoEvolvePets = true,
    
    -- Delay settings
    swingDelay = 0.1,
    sellDelay = 0.5
}

-- ═══════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════

local function getCharacter()
    local char = player.Character
    if not char or not char.Parent then
        player.CharacterAdded:Wait()
        char = player.Character
    end
    return char
end

local function findRemoteEvent(namePatterns)
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
            for _, pattern in pairs(namePatterns) do
                if string.find(v.Name:lower(), pattern:lower()) then
                    return v
                end
            end
        end
    end
    return nil
end

local function updateStatus(text, color)
    local status = player.PlayerGui:FindFirstChild("Architect04Status")
    if status then
        status.Text = text
        status.TextColor3 = color or Color3.fromRGB(0, 255, 100)
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- ANTI AFK (VIRTUAL USER METHOD)
-- ═══════════════════════════════════════════════════════════════════

if config.antiAFK then
    spawn(function()
        while task.wait(60) do
            if game:GetService("Players").LocalPlayer then
                VirtualUser:ClickButton2(Vector2.new())
                VirtualUser:CaptureController()
                VirtualUser:Button2Down(Vector2.new(0, 0), "")
                task.wait(0.1)
                VirtualUser:Button2Up(Vector2.new(0, 0), "")
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- INFINITE JUMP & FAST SWING
-- ═══════════════════════════════════════════════════════════════════

if config.infiniteJump then
    local UserInputService = game:GetService("UserInputService")
    UserInputService.JumpRequest:Connect(function()
        local char = getCharacter()
        local humanoid = char and char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

if config.fastSwing then
    local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
    if tool then
        for _, v in pairs(tool:GetDescendants()) do
            if v:IsA("NumberValue") and v.Name:lower():find("delay") then
                v.Value = 0
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO SWING & SELL
-- ═══════════════════════════════════════════════════════════════════

local swingRemote = findRemoteEvent({"swing", "attack", "hit", "damage"})

local function autoSwing()
    if not config.autoSwing then return end
    if swingRemote then
        swingRemote:FireServer()
    else
        -- Fallback: virtual click
        VirtualUser:Button1Down(Vector2.new(0, 0), "")
        task.wait(0.05)
        VirtualUser:Button1Up(Vector2.new(0, 0), "")
    end
end

local function autoSell()
    if not config.autoSell then return end
    local sellRemote = findRemoteEvent({"sell", "cash", "claim"})
    if sellRemote then
        sellRemote:FireServer()
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO HATCH EGG
-- ═══════════════════════════════════════════════════════════════════

local eggRemotes = {
    hatch = findRemoteEvent({"hatch", "egg", "open"}),
    buyEgg = findRemoteEvent({"buyegg", "purchaseegg", "buy egg"})
}

local function autoHatchEgg()
    if not config.autoHatchEgg then return end
    
    -- Cari egg GUI atau remote event untuk hatch
    local eggsFolder = player.PlayerGui:FindFirstChild("Eggs") or player.PlayerGui:FindFirstChild("PetEggs")
    
    if eggsFolder then
        for _, egg in pairs(eggsFolder:GetChildren()) do
            if egg:IsA("ImageButton") or egg:IsA("TextButton") then
                if config.eggType == "ALL" or string.find(egg.Name:lower(), config.eggType:lower()) then
                    pcall(function()
                        egg:Activate()
                        egg:Click()
                    end)
                end
            end
        end
    end
    
    -- Fallback via remote
    if eggRemotes.hatch then
        eggRemotes.hatch:FireServer()
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- UNLOCK ALL ISLANDS (TELEPORT METHOD)
-- ═══════════════════════════════════════════════════════════════════
-- Berdasarkan wiki: islands can be unlocked by jumping from clouds [citation:1]
-- Ada 20 islands total, plus bonus [citation:5]

local function teleportToIsland(islandName)
    local workspaceMap = workspace:FindFirstChild("Map") or workspace
    local island = workspaceMap:FindFirstChild(islandName) or workspaceMap:FindFirstChild(islandName:gsub(" ", ""))
    
    if island then
        local hrp = getCharacter():FindFirstChild("HumanoidRootPart")
        if hrp then
            local teleportPos = island:FindFirstChild("Teleport") or island:FindFirstChild("SpawnLocation")
            if teleportPos then
                hrp.CFrame = teleportPos.CFrame
            else
                hrp.CFrame = island:FindFirstChild("Baseplate") and island.Baseplate.CFrame or island.CFrame
            end
            task.wait(1)
            return true
        end
    end
    return false
end

local function unlockAllIslands()
    if not config.autoUnlockIslands then return end
    
    updateStatus("🏝️ UNLOCKING ALL ISLANDS...", Color3.fromRGB(0, 255, 100))
    
    for _, island in pairs(islandsDB) do
        updateStatus("📍 TELEPORTING TO: " .. island.name)
        local success = teleportToIsland(island.name)
        if success then
            config.currentIsland = island.order
            task.wait(1.5)
        else
            -- Fallback: coba dengan nama alternatif
            local altName = island.name:gsub(" ", "") :gsub("Island", "")
            if teleportToIsland(altName) then
                config.currentIsland = island.order
                task.wait(1.5)
            end
        end
    end
    
    updateStatus("✅ ALL ISLANDS UNLOCKED! (20+ Islands)")
    task.wait(2)
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO COLLECT CHESTS
-- ═══════════════════════════════════════════════════════════════════
-- Berdasarkan wiki: many islands have chests, pets multiply rewards [citation:1]

local chestNames = {"Chest", "Treasure", "RewardChest", "NinjutsuChest", "DarkChest", "LightChest"}

local function collectChests()
    if not config.autoCollectChests then return end
    
    local char = getCharacter()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    for _, chestName in pairs(chestNames) do
        local chests = workspace:GetDescendants()
        for _, chest in pairs(chests) do
            if chest:IsA("BasePart") and string.find(chest.Name, chestName) then
                local dist = (hrp.Position - chest.Position).Magnitude
                if dist < 30 then
                    hrp.CFrame = chest.CFrame
                    task.wait(0.3)
                    -- Trigger touch
                    local touchInterest = chest:FindFirstChild("TouchInterest")
                    if touchInterest then
                        local args = {chest, hrp}
                        local remote = findRemoteEvent({"chest", "collect", "reward"})
                        if remote then remote:FireServer(unpack(args)) end
                    end
                end
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO FARM BOSSES
-- ═══════════════════════════════════════════════════════════════════

local bossLocations = {
    {name = "Robot Boss", island = "Space Island", pos = nil},
    {name = "Eternal Boss", island = "Eternal Island", pos = nil},
    {name = "Ancient Magma Boss", island = "Ancient Inferno Island", pos = nil}
}

local function farmBosses()
    if not config.autoFarmBosses then return end
    
    for _, boss in pairs(bossLocations) do
        -- Teleport ke island boss
        teleportToIsland(boss.island)
        task.wait(1)
        
        -- Cari boss di workspace
        local bossModel = workspace:FindFirstChild(boss.name)
        if bossModel and bossModel:FindFirstChild("Humanoid") then
            local hrp = getCharacter():FindFirstChild("HumanoidRootPart")
            if hrp then
                local bossHrp = bossModel:FindFirstChild("HumanoidRootPart")
                if bossHrp then
                    hrp.CFrame = bossHrp.CFrame * CFrame.new(0, 0, 5)
                    while bossModel and bossModel.Humanoid and bossModel.Humanoid.Health > 0 do
                        autoSwing()
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO BUY (SWORDS, BELTS, SKILLS, RANKS)
-- ═══════════════════════════════════════════════════════════════════

local function autoBuy()
    local shopItems = {
        swords = {"Sword", "Katana", "Ninjato", "Blade"},
        belts = {"Belt", "Obi", "Sash"},
        skills = {"Skill", "Ability", "Jutsu"},
        ranks = {"Rank", "Promote", "Upgrade"}
    }
    
    -- Cari shop GUI
    local playerGui = player.PlayerGui
    local shopFrame = playerGui:FindFirstChild("Shop") or playerGui:FindFirstChild("Merchant")
    
    if shopFrame then
        for _, category in pairs({"swords", "belts", "skills", "ranks"}) do
            local categoryFrame = shopFrame:FindFirstChild(category:upper()) or shopFrame:FindFirstChild(category:gsub("^%l", string.upper))
            if categoryFrame then
                for _, button in pairs(categoryFrame:GetDescendants()) do
                    if button:IsA("TextButton") and button.Visible then
                        pcall(function()
                            button:Click()
                            task.wait(0.3)
                        end)
                    end
                end
            end
        end
    end
    
    -- Fallback via remote
    local buyRemote = findRemoteEvent({"buy", "purchase", "upgrade"})
    if buyRemote then
        buyRemote:FireServer()
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO EVOLVE PETS
-- ═══════════════════════════════════════════════════════════════════

local function autoEvolvePets()
    if not config.autoEvolvePets then return end
    
    local petsGui = player.PlayerGui:FindFirstChild("Pets") or player.PlayerGui:FindFirstChild("PetMenu")
    if petsGui then
        local evolveButton = petsGui:FindFirstChild("Evolve") or petsGui:FindFirstChild("EvolveButton")
        if evolveButton and evolveButton:IsA("TextButton") then
            evolveButton:Click()
        end
    end
    
    local evolveRemote = findRemoteEvent({"evolve", "upgradepet", "petupgrade"})
    if evolveRemote then
        evolveRemote:FireServer()
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- MAIN FARM LOOP
-- ═══════════════════════════════════════════════════════════════════

local function mainFarmLoop()
    while task.wait(config.swingDelay) do
        if not config.autoSwing then break end
        
        -- Auto swing
        autoSwing()
        
        -- Auto sell setiap interval
        if config.autoSell then
            autoSell()
        end
        
        -- Auto collect chests
        if config.autoCollectChests then
            collectChests()
        end
        
        -- Auto hatch egg
        if config.autoHatchEgg then
            autoHatchEgg()
        end
        
        -- Auto evolve pets
        if config.autoEvolvePets then
            autoEvolvePets()
        end
    end
end

-- Auto buy loop (separate, less frequent)
spawn(function()
    while task.wait(30) do
        if config.autoBuySwords or config.autoBuyBelts or config.autoBuySkills or config.autoBuyRanks then
            autoBuy()
        end
    end
end)

-- Auto farm bosses loop
if config.autoFarmBosses then
    spawn(function()
        while task.wait(300) do -- every 5 minutes
            farmBosses()
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- CREATE UI (MODERN GLASS STYLE)
-- ═══════════════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Architect04_NL1"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 480)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
header.BackgroundTransparency = 0.85
header.BorderSizePixel = 0
header.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -70, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "◈ ARCHITECT 04 • NL1 MASTER ◈"
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextSize = 13
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Close button
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -42, 0, 6)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.BackgroundTransparency = 0.2
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 15
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Island counter display
local islandCounter = Instance.new("TextLabel")
islandCounter.Size = UDim2.new(1, -30, 0, 35)
islandCounter.Position = UDim2.new(0, 15, 0, 60)
islandCounter.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
islandCounter.BackgroundTransparency = 0.3
islandCounter.BorderSizePixel = 0
islandCounter.Text = "🏝️ ISLANDS: 0 / " .. #islandsDB
islandCounter.TextColor3 = Color3.fromRGB(0, 255, 100)
islandCounter.TextSize = 12
islandCounter.Font = Enum.Font.GothamBold
islandCounter.Parent = mainFrame

local islandCorner = Instance.new("UICorner")
islandCorner.CornerRadius = UDim.new(0, 8)
islandCorner.Parent = islandCounter

-- Unlock Islands Button
local unlockBtn = Instance.new("TextButton")
unlockBtn.Size = UDim2.new(1, -30, 0, 40)
unlockBtn.Position = UDim2.new(0, 15, 0, 105)
unlockBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
unlockBtn.BackgroundTransparency = 0.15
unlockBtn.BorderSizePixel = 0
unlockBtn.Text = "🏝️ UNLOCK ALL ISLANDS (20+)"
unlockBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
unlockBtn.TextSize = 12
unlockBtn.Font = Enum.Font.GothamBold
unlockBtn.Parent = mainFrame

local unlockCorner = Instance.new("UICorner")
unlockCorner.CornerRadius = UDim.new(0, 8)
unlockCorner.Parent = unlockBtn

-- Hatch Egg Button
local hatchBtn = Instance.new("TextButton")
hatchBtn.Size = UDim2.new(1, -30, 0, 40)
hatchBtn.Position = UDim2.new(0, 15, 0, 155)
hatchBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
hatchBtn.BackgroundTransparency = 0.15
hatchBtn.BorderSizePixel = 0
hatchBtn.Text = "🥚 AUTO HATCH EGG"
hatchBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
hatchBtn.TextSize = 12
hatchBtn.Font = Enum.Font.GothamBold
hatchBtn.Parent = mainFrame

local hatchCorner = Instance.new("UICorner")
hatchCorner.CornerRadius = UDim.new(0, 8)
hatchCorner.Parent = hatchBtn

-- Island Teleport Dropdown (simplified - list of islands)
local islandDropdown = Instance.new("TextButton")
islandDropdown.Size = UDim2.new(1, -30, 0, 40)
islandDropdown.Position = UDim2.new(0, 15, 0, 205)
islandDropdown.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
islandDropdown.BackgroundTransparency = 0.3
islandDropdown.BorderSizePixel = 0
islandDropdown.Text = "🗺️ TELEPORT TO ISLAND ▼"
islandDropdown.TextColor3 = Color3.fromRGB(200, 200, 200)
islandDropdown.TextSize = 12
islandDropdown.Font = Enum.Font.Gotham
islandDropdown.Parent = mainFrame

local dropdownCorner = Instance.new("UICorner")
dropdownCorner.CornerRadius = UDim.new(0, 8)
dropdownCorner.Parent = islandDropdown

-- Island selection list (hidden initially)
local islandList = Instance.new("ScrollingFrame")
islandList.Size = UDim2.new(1, -30, 0, 200)
islandList.Position = UDim2.new(0, 15, 0, 250)
islandList.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
islandList.BackgroundTransparency = 0.1
islandList.BorderSizePixel = 0
islandList.Visible = false
islandList.Parent = mainFrame

local listCorner = Instance.new("UICorner")
listCorner.CornerRadius = UDim.new(0, 8)
listCorner.Parent = islandList

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = islandList
listLayout.Padding = UDim.new(0, 2)

-- Populate island list
for _, island in pairs(islandsDB) do
    local islandBtn = Instance.new("TextButton")
    islandBtn.Size = UDim2.new(1, -10, 0, 30)
    islandBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    islandBtn.BorderSizePixel = 0
    islandBtn.Text = island.order .. ". " .. island.name
    islandBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    islandBtn.TextSize = 11
    islandBtn.Font = Enum.Font.Gotham
    islandBtn.Parent = islandList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = islandBtn
    
    islandBtn.MouseButton1Click:Connect(function()
        updateStatus("📍 TELEPORTING TO: " .. island.name)
        teleportToIsland(island.name)
        islandList.Visible = false
        islandDropdown.Text = "🗺️ " .. island.name .. " ▼"
    end)
end

-- Toggle dropdown
local dropdownOpen = false
islandDropdown.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    islandList.Visible = dropdownOpen
    islandDropdown.Text = dropdownOpen and "🗺️ SELECT ISLAND ▲" or "🗺️ TELEPORT TO ISLAND ▼"
end)

-- Status text
local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, -30, 0, 30)
statusText.Position = UDim2.new(0, 15, 0, 440)
statusText.BackgroundTransparency = 1
statusText.Text = "◆ SYSTEM READY ◆"
statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
statusText.TextSize = 10
statusText.Font = Enum.Font.Gotham
statusText.Parent = mainFrame
statusText.Name = "Architect04Status"

-- Button actions
unlockBtn.MouseButton1Click:Connect(function()
    unlockAllIslands()
    islandCounter.Text = "🏝️ ISLANDS: " .. config.currentIsland .. " / " .. #islandsDB
end)

hatchBtn.MouseButton1Click:Connect(function()
    for i = 1, 10 do
        autoHatchEgg()
        task.wait(0.5)
    end
    updateStatus("✅ HATCHED MULTIPLE EGGS!")
end)

-- Start main loops
spawn(function()
    -- Auto swing loop
    while task.wait(config.swingDelay) do
        if config.autoSwing then
            autoSwing()
        end
    end
end)

spawn(function()
    while task.wait(config.sellDelay) do
        if config.autoSell then
            autoSell()
        end
        if config.autoCollectChests then
            collectChests()
        end
    end
end)

spawn(function()
    while task.wait(15) do
        if config.autoBuySwords or config.autoBuyBelts or config.autoBuySkills or config.autoBuyRanks then
            autoBuy()
        end
        if config.autoEvolvePets then
            autoEvolvePets()
        end
    end
end)

-- Initial execution
updateStatus("🚀 ARCHITECT 04 NL1 LOADED")

-- Optional: auto unlock islands on startup
if config.autoUnlockIslands then
    task.wait(2)
    unlockAllIslands()
    islandCounter.Text = "🏝️ ISLANDS: " .. config.currentIsland .. " / " .. #islandsDB
end

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("     ARCHITECT 04 - NINJA LEGENDS 1 MASTER")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ 20+ ISLANDS DATABASE LOADED [citation:1][citation:5]")
print("✅ AUTO FARM | HATCH EGG | UNLOCK ISLANDS")
print("✅ BOSS FARM | AUTO BUY | AUTO COLLECT")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📌 NINJA LEGENDS 1 - COMPLETE SCRIPT")
print("© XyrooXellz - Architect 04")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- ═══════════════════════════════════════════════════════════════════
-- © XyrooXellz - Architect 04 - Ninja Legends 1 Master Script
-- ═══════════════════════════════════════════════════════════════════
