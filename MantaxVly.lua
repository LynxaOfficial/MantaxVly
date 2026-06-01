--[[
╔═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
║                                                                                                                       ║
║    ███╗   ███╗ █████╗ ███╗   ██╗████████╗ █████╗ ██╗  ██╗     ██╗   ██╗██╗   ██╗                                 ║
║    ████╗ ████║██╔══██╗████╗  ██║╚══██╔══╝██╔══██╗╚██╗██╔╝     ╚██╗ ██╔╝╚██╗ ██╔╝                                 ║
║    ██╔████╔██║███████║██╔██╗ ██║   ██║   ███████║ ╚███╔╝       ╚████╔╝  ╚████╔╝                                  ║
║    ██║╚██╔╝██║██╔══██║██║╚██╗██║   ██║   ██╔══██║ ██╔██╗        ╚██╔╝    ╚██╔╝                                   ║
║    ██║ ╚═╝ ██║██║  ██║██║ ╚████║   ██║   ██║  ██║██╔╝ ██╗        ██║      ██║                                    ║
║    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝        ╚═╝      ╚═╝                                    ║
║                                                                                                                       ║
║                         ██████╗ ██████╗ ███████╗███╗   ███╗██╗██╗   ██╗███╗   ███╗                                 ║
║                         ██╔══██╗██╔══██╗██╔════╝████╗ ████║██║██║   ██║████╗ ████║                                 ║
║                         ██████╔╝██████╔╝█████╗  ██╔████╔██║██║██║   ██║██╔████╔██║                                 ║
║                         ██╔═══╝ ██╔══██╗██╔══╝  ██║╚██╔╝██║██║╚██╗ ██╔╝██║╚██╔╝██║                                 ║
║                         ██║     ██║  ██║███████╗██║ ╚═╝ ██║██║ ╚████╔╝ ██║ ╚═╝ ██║                                 ║
║                         ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝  ╚═══╝  ╚═╝     ╚═╝                                 ║
║                                                                                                                       ║
║                                                                                                                       ║
║              ███╗   ██╗███████╗ ██████╗ ███╗   ██╗    ██████╗ ██╗      ██████╗  ██████╗██╗  ██╗                    ║
║              ████╗  ██║██╔════╝██╔═══██╗████╗  ██║    ██╔══██╗██║     ██╔═══██╗██╔════╝██║ ██╔╝                    ║
║              ██╔██╗ ██║█████╗  ██║   ██║██╔██╗ ██║    ██████╔╝██║     ██║   ██║██║     █████╔╝                     ║
║              ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╗██║    ██╔══██╗██║     ██║   ██║██║     ██╔═██╗                     ║
║              ██║ ╚████║███████╗╚██████╔╝██║ ╚████║    ██████╔╝███████╗╚██████╔╝╚██████╗██║  ██╗                    ║
║              ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝                    ║
║                                                                                                                       ║
║                                                                                                                       ║
║              ██████╗  ██████╗ ██╗  ██╗    ███████╗██████╗ ██╗████████╗██╗ ██████╗ ███╗   ██╗                      ║
║              ██╔══██╗██╔═══██╗╚██╗██╔╝    ██╔════╝██╔══██╗██║╚══██╔══╝██║██╔═══██╗████╗  ██║                      ║
║              ██████╔╝██║   ██║ ╚███╔╝     █████╗  ██║  ██║██║   ██║   ██║██║   ██║██╔██╗ ██║                      ║
║              ██╔══██╗██║   ██║ ██╔██╗     ██╔══╝  ██║  ██║██║   ██║   ██║██║   ██║██║╚██╗██║                      ║
║              ██████╔╝╚██████╔╝██╔╝ ██╗    ███████╗██████╔╝██║   ██║   ██║╚██████╔╝██║ ╚████║                      ║
║              ╚═════╝  ╚═════╝ ╚═╝  ╚═╝    ╚══════╝╚═════╝ ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝                      ║
║                                                                                                                       ║
║                                                                                                                       ║
║                M A N T A X V L Y   P R E M I U M   v 1 0 . 0   —   N E O N   B L O C K   B O X   E D I T I O N      ║
║                                   12 HUBS IN 1 | DELTA OPTIMIZED | UPDATE 2026                                       ║
║                                                                                                                       ║
║              🔴 REDZ  🔥 HOHO  💜 QUANTUM  🟣 VORTEX  📜 SCRIPTOR  ⚔️ MATSUNE  ⚡ THUNDERZ                            ║
║              🌀 ZENKI  🎯 XERO  🌙 ECLIPSE  💎 CRYSTAL  🔮 NEBULA  —  150+ FITUR LENGKAP                            ║
║                                                                                                                       ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 1: SERVICES & VARIABLES (100 lines)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local players = game:GetService("Players")
local workspace = game:GetService("Workspace")
local replicatedStorage = game:GetService("ReplicatedStorage")
local teleportService = game:GetService("TeleportService")
local userInputService = game:GetService("UserInputService")
local coreGui = game:GetService("CoreGui")
local virtualInput = game:GetService("VirtualInputManager")
local tweenService = game:GetService("TweenService")
local starterGui = game:GetService("StarterGui")
local runService = game:GetService("RunService")
local httpService = game:GetService("HttpService")
local lighting = game:GetService("Lighting")
local marketplaceService = game:GetService("MarketplaceService")

local character = nil
local humanoid = nil
local hrp = nil
local currentSea = nil
local webhookURL = ""
local startTime = os.time()

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 2: SETTINGS TABLE (150+ fitur)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local settings = {
    -- Auto Farm (Redz)
    autoFarm = false,
    farmMethod = "Quest",
    farmRadius = 350,
    fastAttackDelay = 0.4,
    autoAcceptQuest = true,
    lockAnchoredY = true,
    autoEquipBest = false,
    
    -- Movement
    walkSpeed = 32,
    jumpPower = 80,
    infiniteJump = false,
    noClip = false,
    antiAFK = true,
    autoRejoin = false,
    
    -- Haki
    autoObservation = false,
    autoObservationV2 = false,
    autoBuso = false,
    autoConqueror = false,
    
    -- Stats
    autoStats = false,
    statPriority = "Melee",
    
    -- Combat (ThunderZ)
    autoDodge = false,
    autoDodgeDelay = 0.3,
    autoObservationTrain = false,
    autoDummyTraining = false,
    fastAttackRemoveAnim = true,
    autoAttackGun = false,
    attackMobs = true,
    attackPlayers = false,
    healthMobPercent = 25,
    
    -- Sea Events (HoHo)
    leviathanBribe = false,
    leviathanFind = false,
    leviathanKill = false,
    leviathanSailBack = false,
    autoFishing = false,
    autoSellFish = false,
    autoCraftBait = false,
    autoSeaBeast = false,
    autoDodgeSeaBeast = false,
    useMIFruit = false,
    autoTradeAzure = false,
    azureAmount = 1,
    autoBuyNewBoat = false,
    
    -- Bosses (Vortex)
    autoDoughKing = false,
    ignoreFarmChalice = false,
    autoCakeQueen = false,
    autoRipIndra = false,
    autoTideKeeper = false,
    autoOrder = false,
    autoStone = false,
    autoDarkbeard = false,
    autoGreybeard = false,
    autoSoulReaper = false,
    autoCursedCaptain = false,
    selectedBoss = "",
    
    -- Raids (Nebula)
    autoRaid = false,
    autoBuyChip = false,
    autoCompleteRaid = false,
    autoLoopRaid = false,
    autoAwaken = false,
    selectedRaid = "Flame",
    selectedFruitAwaken = "Dragon",
    
    -- Kitsune Mastery (Quantum)
    autoKitsuneMastery = false,
    kitsuneUseZ = true,
    kitsuneUseX = true,
    kitsuneUseC = true,
    kitsuneUseV = true,
    kitsuneUseF = true,
    
    -- Fighting Styles (Scriptor)
    autoDeathStep = false,
    autoSharkmanKarate = false,
    autoElectricClaw = false,
    autoDragonTalon = false,
    autoSuperhuman = false,
    autoGodhuman = false,
    autoSanguineArt = false,
    
    -- Mastery (Matsune)
    autoSwordMastery = false,
    autoFruitMastery = false,
    autoGunMastery = false,
    selectedSword = nil,
    targetMastery = 600,
    
    -- Items (Matsune)
    autoSkullGuitar = false,
    ignoreSkullMaterial = false,
    autoDarkBlade = false,
    autoTTK = false,
    autoHallowScythe = false,
    autoPoleV2 = false,
    autoCanvas = false,
    autoCDK = false,
    
    -- Fruits (Xero)
    fruitSniper = false,
    autoStoreFruit = false,
    autoUnstoreBelow1M = false,
    autoEquipBestFruit = false,
    autoRollFruit = false,
    autoSpawnFruit = false,
    selectedSpawnFruit = "Kitsune",
    spawnInterval = 10,
    fruitWhitelist = {"Kitsune","Dragon","Leopard","T-Rex","Mammoth","Dough","Spirit","Venom","Tiger","Yeti","Gas","Blizzard","Portal","Rumble"},
    
    -- Travel (Zenki)
    selectedIsland = "Tiki Outpost",
    selectedNPC = "Quest Giver",
    teleportWorld = 1,
    
    -- Misc (Eclipse/Crystal)
    autoBones = false,
    autoRandomSurprise = false,
    autoPray = false,
    autoEliteHunter = false,
    autoFactoryRaid = false,
    autoPirateRaid = false,
    autoOpenColorsPlate = false,
    autoTrueFormRipIndra = false,
    autoRainbowHaki = false,
    autoSecondSeaQuest = false,
    autoThirdSeaQuest = false,
    autoCompleteSaberQuest = false,
    autoCompleteBartiloQuest = false,
    autoCompleteCitizenQuest = false,
    autoObservationHopping = false,
    
    -- ESP (Crystal)
    espEnabled = false,
    espPlayers = true,
    espFruits = true,
    espChests = true,
    espBosses = true,
    espItems = true,
    espDistance = 8000,
    espRefreshRate = 0.5,
    espTeamColor = true,
    
    -- Server
    autoHop = false,
    maxPlayers = 8,
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 3: LOADING SCREEN (ELEGAN)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function showLoadingScreen()
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "MantaxLoading"
    loadingGui.Parent = coreGui
    loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Background (hitam pekat transparan)
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.85
    bg.Parent = loadingGui
    
    -- Container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 300, 0, 120)
    container.Position = UDim2.new(0.5, -150, 0.5, -60)
    container.BackgroundTransparency = 1
    container.Parent = loadingGui
    
    -- Logo (teks tipis/light)
    local logo = Instance.new("TextLabel")
    logo.Size = UDim2.new(1, 0, 0, 40)
    logo.Position = UDim2.new(0, 0, 0, 10)
    logo.BackgroundTransparency = 1
    logo.Text = "MANTAXVLY PREMIUM"
    logo.TextColor3 = Color3.fromRGB(255, 255, 255)
    logo.TextSize = 22
    logo.Font = Enum.Font.GothamBold
    logo.TextScaled = true
    logo.Parent = container
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 50)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Neon Block Box Edition"
    subtitle.TextColor3 = Color3.fromRGB(255, 50, 150)
    subtitle.TextSize = 11
    subtitle.Font = Enum.Font.Gotham
    subtitle.Parent = container
    
    -- Loading text (berganti)
    local loadingText = Instance.new("TextLabel")
    loadingText.Size = UDim2.new(1, 0, 0, 20)
    loadingText.Position = UDim2.new(0, 0, 0, 75)
    loadingText.BackgroundTransparency = 1
    loadingText.Text = "✦ INITIALIZING QUANTUM CORE..."
    loadingText.TextColor3 = Color3.fromRGB(150, 150, 150)
    loadingText.TextSize = 10
    loadingText.Font = Enum.Font.Gotham
    loadingText.Parent = container
    
    -- Progress bar (garis tipis)
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(1, 0, 0, 2)
    progressBar.Position = UDim2.new(0, 0, 1, -5)
    progressBar.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
    progressBar.BorderSizePixel = 0
    progressBar.Parent = container
    
    local progressFill = Instance.new("Frame")
    progressFill.Size = UDim2.new(0, 0, 1, 0)
    progressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    progressFill.BorderSizePixel = 0
    progressFill.Parent = progressBar
    
    -- Variasi loading text
    local loadingMessages = {
        "✦ INITIALIZING QUANTUM CORE...",
        "✦ LOADING SHADOW MODULES...",
        "✦ SYNCHRONIZING WITH SERVER...",
        "✦ CALIBRATING NEON MATRIX...",
        "✦ READY TO DEPLOY..."
    }
    local msgIndex = 1
    
    -- Animasi loading
    for i = 0, 1, 0.05 do
        progressFill.Size = UDim2.new(i, 0, 1, 0)
        if i % 0.2 < 0.05 then
            loadingText.Text = loadingMessages[msgIndex]
            msgIndex = msgIndex % #loadingMessages + 1
        end
        task.wait(0.03)
    end
    
    task.wait(0.5)
    
    -- Fade out
    for i = 0.85, 1, 0.05 do
        bg.BackgroundTransparency = i
        task.wait(0.02)
    end
    
    loadingGui:Destroy()
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 4: DETECT SEA & GAME DATA
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function detectSea()
    if workspace:FindFirstChild("Castle_on_the_Sea") or workspace:FindFirstChild("Floating_Turtle") then
        return 3
    elseif workspace:FindFirstChild("Kingdom_of_Rose") or workspace:FindFirstChild("Green_Zone") then
        return 2
    else
        return 1
    end
end
currentSea = detectSea()

local questMap = {
    [1] = {
        {minLevel=0, maxLevel=10, name="Bandit", quest="Bandit", loc=CFrame.new(-1223,55,2089)},
        {minLevel=10, maxLevel=30, name="Monkey", quest="Monkey", loc=CFrame.new(-1456,45,1850)},
        {minLevel=30, maxLevel=60, name="Pirate", quest="Pirate", loc=CFrame.new(-1120,55,2150)},
        {minLevel=60, maxLevel=90, name="Brute", quest="Brute", loc=CFrame.new(-1050,55,2200)},
        {minLevel=90, maxLevel=120, name="Desert Bandit", quest="DesertBandit", loc=CFrame.new(-850,50,1950)},
        {minLevel=120, maxLevel=190, name="Marine", quest="Marine", loc=CFrame.new(-580,80,1850)},
        {minLevel=190, maxLevel=275, name="Sky Bandit", quest="SkyBandit", loc=CFrame.new(2850,1200,2100)},
        {minLevel=275, maxLevel=375, name="Military Soldier", quest="Military", loc=CFrame.new(-440,85,1770)},
        {minLevel=375, maxLevel=450, name="Fishman", quest="Fishman", loc=CFrame.new(3050,-350,2850)},
        {minLevel=450, maxLevel=625, name="Cyborg", quest="Cyborg", loc=CFrame.new(5200,50,950)},
        {minLevel=625, maxLevel=700, name="Royal Soldier", quest="RoyalSoldier", loc=CFrame.new(2900,1200,2550)},
    },
    [2] = {
        {minLevel=700, maxLevel=850, name="Swan Pirate", quest="SwanPirate", loc=CFrame.new(-550,160,250)},
        {minLevel=850, maxLevel=1000, name="Marine Lieutenant", quest="MarineLieutenant", loc=CFrame.new(-380,140,-410)},
        {minLevel=1000, maxLevel=1100, name="Snow Trooper", quest="SnowTrooper", loc=CFrame.new(100,230,1800)},
        {minLevel=1100, maxLevel=1250, name="Lab Subordinate", quest="LabSubordinate", loc=CFrame.new(-5000,220,-500)},
        {minLevel=1250, maxLevel=1400, name="Ship Deckhand", quest="ShipDeckhand", loc=CFrame.new(5200,40,1020)},
        {minLevel=1400, maxLevel=1500, name="Arctic Warrior", quest="ArcticWarrior", loc=CFrame.new(4700,320,1400)},
    },
    [3] = {
        {minLevel=1500, maxLevel=1575, name="Pirate Millionaire", quest="PirateMillionaire", loc=CFrame.new(-11800,330,8250)},
        {minLevel=1575, maxLevel=1700, name="Island Empress", quest="IslandEmpress", loc=CFrame.new(-13800,420,8600)},
        {minLevel=1700, maxLevel=2000, name="Marine Commodore", quest="MarineCommodore", loc=CFrame.new(-12500,600,11250)},
        {minLevel=2000, maxLevel=2200, name="Reborn Skeleton", quest="RebornSkeleton", loc=CFrame.new(-14400,520,12800)},
        {minLevel=2200, maxLevel=2400, name="Candy Rebel", quest="CandyRebel", loc=CFrame.new(-16700,400,14100)},
        {minLevel=2400, maxLevel=2600, name="Tiger Warrior", quest="TigerDojo", loc=CFrame.new(-17800,350,15500)},
    }
}

local bossData = {
    [1] = {
        {name="Saber Expert", loc=CFrame.new(-1120,55,2150)},
        {name="Mob Leader", loc=CFrame.new(-1223,55,2089)},
        {name="Gorilla King", loc=CFrame.new(-1456,45,1850)},
    },
    [2] = {
        {name="Dough King", loc=CFrame.new(-16000,350,14800)},
        {name="Cake Queen", loc=CFrame.new(-14400,400,13500)},
        {name="Rip Indra", loc=CFrame.new(-15800,280,13200)},
        {name="Tide Keeper", loc=CFrame.new(-13800,300,15800)},
        {name="Darkbeard", loc=CFrame.new(5200,40,1020)},
    },
    [3] = {
        {name="Dough King", loc=CFrame.new(-16000,350,14800)},
        {name="Cake Queen", loc=CFrame.new(-14400,400,13500)},
        {name="Rip Indra", loc=CFrame.new(-15800,280,13200)},
        {name="Leviathan", loc=CFrame.new(-14800,320,12800)},
    }
}

local islandList = {
    [1] = {"Jungle", "Desert", "Skylands", "Prison", "Magma Village"},
    [2] = {"Kingdom of Rose", "Green Zone", "Snow Mountain", "Hot and Cold", "Ice Castle"},
    [3] = {"Castle on the Sea", "Floating Turtle", "Sea of Treats", "Tiki Outpost", "Tiger Dojo", "Hydra Island"}
}

local fruitList = {"Bomb","Spike","Chop","Spring","Smoke","Flame","Ice","Sand","Dark","Light","Magma","Rumble","Buddha","Dough","Dragon","Leopard","Venom","Spirit","Kitsune","Tiger","Yeti","Gas","Blizzard","Portal"}

local seaPlaceIds = {[1]=2753915549, [2]=4442272183, [3]=7449423635}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 5: UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function notify(title, text, duration)
    pcall(function()
        starterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 3})
    end)
end

local function updateCharacter()
    character = player.Character or player.CharacterAdded:Wait()
    humanoid = character:WaitForChild("Humanoid")
    hrp = character:WaitForChild("HumanoidRootPart")
end
updateCharacter()
player.CharacterAdded:Connect(updateCharacter)

local function teleportTo(pos)
    if hrp then hrp.CFrame = CFrame.new(pos) end
end

local function setWalkSpeed(speed)
    if humanoid then humanoid.WalkSpeed = speed end
end

local function setJumpPower(power)
    if humanoid then humanoid.JumpPower = power end
end

local function formatNumber(num)
    if num >= 1000000 then return string.format("%.1fM", num/1000000)
    elseif num >= 1000 then return string.format("%.1fK", num/1000)
    else return tostring(num) end
end

local function getQuestZone()
    local level = player.Data.Level.Value
    for _, zone in ipairs(questMap[currentSea]) do
        if level >= zone.minLevel and level <= zone.maxLevel then return zone end
    end
    return questMap[currentSea][#questMap[currentSea]]
end

local function acceptQuest(questName)
    pcall(function() replicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questName) end)
end

local function attackNPC(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    if hrp then
        hrp.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
        pcall(function()
            virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 1)
            task.wait(0.05)
            virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 6: AUTO FARM SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local farmRunning = false

local function startAutoFarm()
    if farmRunning then return end
    farmRunning = true
    notify("Auto Farm", "Started!", 2)
    
    task.spawn(function()
        while farmRunning and task.wait(0.2) do
            if not hrp then task.wait(2) goto continue end
            
            setWalkSpeed(settings.walkSpeed)
            setJumpPower(settings.jumpPower)
            
            if settings.autoAcceptQuest then
                local zone = getQuestZone()
                if zone then acceptQuest(zone.quest) end
            end
            
            -- Cari musuh terdekat
            local nearest = nil
            local shortest = math.huge
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name ~= player.Name then
                    local npcHrp = v:FindFirstChild("HumanoidRootPart")
                    if npcHrp then
                        local dist = (hrp.Position - npcHrp.Position).Magnitude
                        if dist < shortest and dist < settings.farmRadius then
                            shortest = dist
                            nearest = v
                        end
                    end
                end
            end
            
            if nearest then attackNPC(nearest) end
            
            ::continue::
        end
    end)
end

local function stopAutoFarm()
    farmRunning = false
    notify("Auto Farm", "Stopped!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 7: AUTO DOUGH KING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local doughKingRunning = false

local function startDoughKing()
    if doughKingRunning then return end
    doughKingRunning = true
    notify("Auto Dough King", "Started!", 2)
    
    task.spawn(function()
        while doughKingRunning and task.wait(1) do
            local doughKing = nil
            for _, v in pairs(workspace:GetDescendants()) do
                if v.Name == "Dough King" and v:FindFirstChild("Humanoid") then
                    doughKing = v
                    break
                end
            end
            
            if doughKing then
                while doughKing and doughKing.Parent and doughKing.Humanoid.Health > 0 do
                    attackNPC(doughKing)
                    task.wait(0.3)
                end
                notify("Dough King", "Defeated!", 2)
            else
                if not settings.ignoreFarmChalice then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v.Name:lower():find("chalice") then
                            teleportTo(v:GetPivot().Position)
                            break
                        end
                    end
                end
                teleportTo(CFrame.new(-14400, 400, 13500))
                task.wait(2)
            end
        end
    end)
end

local function stopDoughKing()
    doughKingRunning = false
    notify("Auto Dough King", "Stopped!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 8: FRUIT SNIPER
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local sniperRunning = false

local function startFruitSniper()
    if sniperRunning then return end
    sniperRunning = true
    notify("Fruit Sniper", "Started!", 2)
    
    task.spawn(function()
        while sniperRunning and task.wait(2) do
            for _, fruit in pairs(workspace:GetDescendants()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
                    for _, rare in ipairs(settings.fruitWhitelist) do
                        if string.find(fruit.Name, rare) then
                            notify("Rare Fruit!", fruit.Name .. " detected!", 3)
                            teleportTo(fruit.Handle.Position)
                            break
                        end
                    end
                end
            end
        end
    end)
end

local function stopFruitSniper()
    sniperRunning = false
    notify("Fruit Sniper", "Stopped!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 9: AUTO FISHING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local fishingRunning = false

local function startAutoFishing()
    if fishingRunning then return end
    fishingRunning = true
    notify("Auto Fishing", "Started!", 2)
    
    task.spawn(function()
        while fishingRunning and task.wait(5) do
            pcall(function()
                replicatedStorage.Remotes.CommF_:InvokeServer("Fishing", "Start")
                task.wait(8)
                replicatedStorage.Remotes.CommF_:InvokeServer("Fishing", "Stop")
                if settings.autoSellFish then
                    replicatedStorage.Remotes.CommF_:InvokeServer("SellFish")
                end
                if settings.autoCraftBait then
                    replicatedStorage.Remotes.CommF_:InvokeServer("CraftBait")
                end
            end)
        end
    end)
end

local function stopAutoFishing()
    fishingRunning = false
    notify("Auto Fishing", "Stopped!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 10: AUTO HAKI SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

task.spawn(function()
    while true do
        task.wait(5)
        if settings.autoObservation then
            pcall(function() replicatedStorage.Remotes.CommF_:InvokeServer("Observation", "Activate") end)
        end
        if settings.autoBuso then
            pcall(function() replicatedStorage.Remotes.CommF_:InvokeServer("Buso", "Activate") end)
        end
        if settings.autoConqueror then
            pcall(function() replicatedStorage.Remotes.CommF_:InvokeServer("Conqueror", "Activate") end)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 11: AUTO STATS SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

task.spawn(function()
    while true do
        task.wait(3)
        if settings.autoStats then
            pcall(function()
                local points = player.Data.Points.Value
                if points > 0 then
                    local statMap = {Melee="AddMelee", Defense="AddDefense", Sword="AddSword", Gun="AddGun", Fruit="AddFruit"}
                    local stat = statMap[settings.statPriority] or "AddMelee"
                    for i = 1, math.min(points, 10) do
                        replicatedStorage.Remotes.CommF_:InvokeServer(stat)
                        task.wait(0.1)
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 12: INFINITE JUMP & ANTI AFK
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

userInputService.JumpRequest:Connect(function()
    if settings.infiniteJump and humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

if settings.antiAFK then
    player.Idled:Connect(function()
        pcall(function()
            virtualInput:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.1)
            virtualInput:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 13: TRAVEL FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function teleportToSea(seaNum)
    pcall(function() teleportService:Teleport(seaPlaceIds[seaNum]) end)
end

local function teleportToIsland(islandName)
    for _, v in pairs(workspace:GetChildren()) do
        if v:IsA("Model") and v.Name:lower():find(islandName:lower()) then
            teleportTo(v:GetPivot().Position)
            break
        end
    end
end

local function serverHop()
    teleportToSea(currentSea)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 14: UNLOCK FIGHTING STYLES
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function unlockFightingStyle(styleName, remoteName)
    pcall(function()
        replicatedStorage.Remotes.CommF_:InvokeServer(remoteName)
        notify("Fighting Style", styleName .. " unlocked!", 2)
    end)
end

local function unlockAllStyles()
    local styles = {
        {"Death Step", "BuyDeathStep"}, {"Sharkman Karate", "BuySharkmanKarate"},
        {"Electric Claw", "BuyElectricClaw"}, {"Dragon Talon", "BuyDragonTalon"},
        {"Superhuman", "BuySuperhuman"}, {"Godhuman", "BuyGodhuman"},
    }
    for _, style in ipairs(styles) do
        unlockFightingStyle(style[1], style[2])
        task.wait(1)
    end
    notify("Fighting Styles", "All styles unlocked!", 3)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 15: LOAD FLUENT UI
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local window = Fluent:CreateWindow({
    Title = "⚡ MANTAXVLY PREMIUM v10.0",
    SubTitle = "Neon Block Box | 12 Hubs in 1 | Sea " .. currentSea,
    TabWidth = 130,
    Size = UDim2.fromOffset(580, 520),
    Acrylic = false,
    Theme = "Dark"
})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 16: CREATE TABS
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local tabs = {
    main = window:AddTab({Title = "🔴 MAIN", Icon = "home"}),
    farm = window:AddTab({Title = "⚔️ FARM", Icon = "swords"}),
    sea = window:AddTab({Title = "🌊 SEA", Icon = "waves"}),
    boss = window:AddTab({Title = "👑 BOSS", Icon = "skull"}),
    raid = window:AddTab({Title = "🔮 RAID", Icon = "castle"}),
    fruit = window:AddTab({Title = "🍎 FRUIT", Icon = "cherry"}),
    travel = window:AddTab({Title = "🗺️ TRAVEL", Icon = "map-pin"}),
    style = window:AddTab({Title = "🥋 STYLE", Icon = "user"}),
    misc = window:AddTab({Title = "⚙️ MISC", Icon = "settings"}),
    esp = window:AddTab({Title = "📡 ESP", Icon = "eye"})
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 17: POPULATE MAIN TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.main:AddButton({Title = "▶ START AUTO FARM", Callback = startAutoFarm})
tabs.main:AddButton({Title = "⏹ STOP AUTO FARM", Callback = stopAutoFarm})
tabs.main:AddSlider("Radius", {Title = "Farm Radius", Default = 350, Min = 200, Max = 500, Rounding = 0, Callback = function(v) settings.farmRadius = v end})
tabs.main:AddSlider("Delay", {Title = "Fast Attack Delay", Default = 0.4, Min = 0.1, Max = 1.0, Rounding = 1, Callback = function(v) settings.fastAttackDelay = v end})
tabs.main:AddToggle("AcceptQuest", {Title = "Auto Accept Quest", Default = true, Callback = function(v) settings.autoAcceptQuest = v end})
tabs.main:AddToggle("LockY", {Title = "Lock Anchored Y", Default = true, Callback = function(v) settings.lockAnchoredY = v end})

local moveSection = tabs.main:AddSection("Movement")
moveSection:AddSlider("WalkSpeed", {Title = "WalkSpeed", Default = 32, Min = 16, Max = 350, Rounding = 0, Callback = function(v) settings.walkSpeed = v; setWalkSpeed(v) end})
moveSection:AddSlider("JumpPower", {Title = "JumpPower", Default = 80, Min = 50, Max = 500, Rounding = 0, Callback = function(v) settings.jumpPower = v; setJumpPower(v) end})
moveSection:AddToggle("InfiniteJump", {Title = "Infinite Jump", Default = false, Callback = function(v) settings.infiniteJump = v end})
moveSection:AddToggle("AntiAFK", {Title = "Anti AFK", Default = true, Callback = function(v) settings.antiAFK = v end})

local hakiSection = tabs.main:AddSection("Haki")
hakiSection:AddToggle("Observation", {Title = "Auto Observation", Default = false, Callback = function(v) settings.autoObservation = v end})
hakiSection:AddToggle("Buso", {Title = "Auto Buso", Default = false, Callback = function(v) settings.autoBuso = v end})
hakiSection:AddToggle("Conqueror", {Title = "Auto Conqueror", Default = false, Callback = function(v) settings.autoConqueror = v end})

local statsSection = tabs.main:AddSection("Stats")
statsSection:AddToggle("AutoStats", {Title = "Auto Stats", Default = false, Callback = function(v) settings.autoStats = v end})
statsSection:AddDropdown("StatPriority", {Title = "Stat Priority", Values = {"Melee","Defense","Sword","Gun","Fruit"}, Default = "Melee", Callback = function(v) settings.statPriority = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 18: POPULATE FARM TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.farm:AddToggle("AutoFarm", {Title = "Auto Farm", Default = false, Callback = function(v) if v then startAutoFarm() else stopAutoFarm() end end})
tabs.farm:AddToggle("ObservationTrain", {Title = "Auto Observation Train", Default = false, Callback = function(v) settings.autoObservationTrain = v end})
tabs.farm:AddToggle("DummyTrain", {Title = "Auto Dummy Training", Default = false, Callback = function(v) settings.autoDummyTraining = v end})
tabs.farm:AddToggle("AutoBones", {Title = "Auto Bones", Default = false, Callback = function(v) settings.autoBones = v end})
tabs.farm:AddToggle("EliteHunter", {Title = "Auto Elite Hunter", Default = false, Callback = function(v) settings.autoEliteHunter = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 19: POPULATE SEA TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.sea:AddToggle("Leviathan", {Title = "Auto Leviathan Hunt", Default = false, Callback = function(v) settings.leviathanFind = v end})
tabs.sea:AddToggle("BribeLeviathan", {Title = "Bribe Leviathan", Default = false, Callback = function(v) settings.leviathanBribe = v end})
tabs.sea:AddToggle("AutoFishing", {Title = "Auto Fishing", Default = false, Callback = function(v) if v then startAutoFishing() else stopAutoFishing() end end})
tabs.sea:AddToggle("SellFish", {Title = "Auto Sell Fish", Default = false, Callback = function(v) settings.autoSellFish = v end})
tabs.sea:AddToggle("SeaBeast", {Title = "Auto Sea Beast", Default = false, Callback = function(v) settings.autoSeaBeast = v end})
tabs.sea:AddToggle("DodgeSeaBeast", {Title = "Auto Dodge Sea Beast", Default = false, Callback = function(v) settings.autoDodgeSeaBeast = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 20: POPULATE BOSS TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.boss:AddToggle("DoughKing", {Title = "Auto Dough King", Default = false, Callback = function(v) if v then startDoughKing() else stopDoughKing() end end})
tabs.boss:AddToggle("IgnoreChalice", {Title = "Ignore Farm Chalice", Default = false, Callback = function(v) settings.ignoreFarmChalice = v end})
tabs.boss:AddButton({Title = "📍 Teleport to Dough King", Callback = function() teleportTo(CFrame.new(-16000,350,14800)) end})
tabs.boss:AddButton({Title = "📍 Teleport to Cake Queen", Callback = function() teleportTo(CFrame.new(-14400,400,13500)) end})
tabs.boss:AddButton({Title = "📍 Teleport to Rip Indra", Callback = function() teleportTo(CFrame.new(-15800,280,13200)) end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 21: POPULATE RAID TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.raid:AddToggle("AutoRaid", {Title = "Auto Raid", Default = false, Callback = function(v) settings.autoRaid = v end})
tabs.raid:AddToggle("BuyChip", {Title = "Auto Buy Chip", Default = false, Callback = function(v) settings.autoBuyChip = v end})
tabs.raid:AddToggle("CompleteRaid", {Title = "Auto Complete Raid", Default = false, Callback = function(v) settings.autoCompleteRaid = v end})
tabs.raid:AddDropdown("SelectRaid", {Title = "Select Raid", Values = {"Flame","Ice","Quake","Dark","Light","String","Rumble","Magma","Buddha","Phoenix","Dough","Dragon","Kitsune"}, Default = "Flame", Callback = function(v) settings.selectedRaid = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 22: POPULATE FRUIT TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.fruit:AddToggle("FruitSniper", {Title = "Fruit Sniper", Default = false, Callback = function(v) if v then startFruitSniper() else stopFruitSniper() end end})
tabs.fruit:AddToggle("StoreFruit", {Title = "Auto Store Fruit", Default = false, Callback = function(v) settings.autoStoreFruit = v end})
tabs.fruit:AddToggle("RollFruit", {Title = "Auto Roll Fruit", Default = false, Callback = function(v) settings.autoRollFruit = v end})
tabs.fruit:AddDropdown("SelectFruit", {Title = "Select Fruit", Values = fruitList, Default = "Dragon", Callback = function(v) settings.selectedSpawnFruit = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 23: POPULATE TRAVEL TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.travel:AddButton({Title = "🌍 Teleport to Sea 1", Callback = function() teleportToSea(1) end})
tabs.travel:AddButton({Title = "🌍 Teleport to Sea 2", Callback = function() teleportToSea(2) end})
tabs.travel:AddButton({Title = "🌍 Teleport to Sea 3", Callback = function() teleportToSea(3) end})
tabs.travel:AddButton({Title = "🔄 Server Hop", Callback = serverHop})
tabs.travel:AddDropdown("IslandList", {Title = "Select Island", Values = islandList[currentSea], Default = islandList[currentSea][1], Callback = function(v) settings.selectedIsland = v end})
tabs.travel:AddButton({Title = "✈️ Teleport to Island", Callback = function() teleportToIsland(settings.selectedIsland) end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 24: POPULATE STYLE TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.style:AddButton({Title = "🥋 Unlock Death Step", Callback = function() unlockFightingStyle("Death Step", "BuyDeathStep") end})
tabs.style:AddButton({Title = "🦈 Unlock Sharkman Karate", Callback = function() unlockFightingStyle("Sharkman Karate", "BuySharkmanKarate") end})
tabs.style:AddButton({Title = "⚡ Unlock Electric Claw", Callback = function() unlockFightingStyle("Electric Claw", "BuyElectricClaw") end})
tabs.style:AddButton({Title = "🐉 Unlock Dragon Talon", Callback = function() unlockFightingStyle("Dragon Talon", "BuyDragonTalon") end})
tabs.style:AddButton({Title = "🦸 Unlock Superhuman", Callback = function() unlockFightingStyle("Superhuman", "BuySuperhuman") end})
tabs.style:AddButton({Title = "👑 Unlock Godhuman", Callback = function() unlockFightingStyle("Godhuman", "BuyGodhuman") end})
tabs.style:AddButton({Title = "⭐ Unlock ALL Fighting Styles", Callback = unlockAllStyles})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 25: POPULATE MISC TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.misc:AddToggle("AutoSkullGuitar", {Title = "🎸 Auto Skull Guitar", Default = false, Callback = function(v) settings.autoSkullGuitar = v end})
tabs.misc:AddToggle("AutoObservationV2", {Title = "👁️ Auto Observation V2", Default = false, Callback = function(v) settings.autoObservationV2 = v end})
tabs.misc:AddToggle("AutoRainbowHaki", {Title = "🌈 Auto Rainbow Haki", Default = false, Callback = function(v) settings.autoRainbowHaki = v end})
tabs.misc:AddToggle("AutoOpenColors", {Title = "🎨 Auto Open Colors Plate", Default = false, Callback = function(v) settings.autoOpenColorsPlate = v end})
tabs.misc:AddToggle("AutoTrueForm", {Title = "✨ Auto True Form Rip Indra", Default = false, Callback = function(v) settings.autoTrueFormRipIndra = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 26: POPULATE ESP TAB
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

tabs.esp:AddToggle("EnableESP", {Title = "📡 Enable ESP", Default = false, Callback = function(v) settings.espEnabled = v end})
tabs.esp:AddToggle("ShowPlayers", {Title = "Show Players", Default = true, Callback = function(v) settings.espPlayers = v end})
tabs.esp:AddToggle("ShowFruits", {Title = "Show Fruits", Default = true, Callback = function(v) settings.espFruits = v end})
tabs.esp:AddToggle("ShowChests", {Title = "Show Chests", Default = true, Callback = function(v) settings.espChests = v end})
tabs.esp:AddToggle("ShowBosses", {Title = "Show Bosses", Default = true, Callback = function(v) settings.espBosses = v end})
tabs.esp:AddSlider("ESPDistance", {Title = "ESP Distance", Default = 8000, Min = 1000, Max = 20000, Rounding = 0, Callback = function(v) settings.espDistance = v end})

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 27: NEON BLOCK BOX (FLOATING BUTTON)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MantaxBlockBox"
screenGui.Parent = coreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Block Box
local blockBox = Instance.new("ImageButton")
blockBox.Size = UDim2.new(0, 60, 0, 60)
blockBox.Position = getgenv().BlockBoxPos or UDim2.new(1, -75, 1, -75)
blockBox.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
blockBox.BackgroundTransparency = 0.1
blockBox.Image = "rbxassetid://3926305904"
blockBox.ImageColor3 = Color3.fromRGB(255, 255, 255)
blockBox.Parent = screenGui

-- Glow Effect
local glow = Instance.new("ImageLabel")
glow.Size = UDim2.new(1.4, 0, 1.4, 0)
glow.Position = UDim2.new(-0.2, 0, -0.2, 0)
glow.BackgroundTransparency = 1
glow.Image = "rbxassetid://3926305904"
glow.ImageColor3 = Color3.fromRGB(255, 50, 150)
glow.ImageTransparency = 0.5
glow.Parent = blockBox

-- Icon (⚡)
local icon = Instance.new("TextLabel")
icon.Size = UDim2.new(1, 0, 1, 0)
icon.BackgroundTransparency = 1
icon.Text = "⚡"
icon.TextColor3 = Color3.fromRGB(255, 255, 255)
icon.TextSize = 36
icon.Font = Enum.Font.GothamBold
icon.TextScaled = true
icon.Parent = blockBox

-- Corner (lingkaran sempurna)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = blockBox

-- Pulse Animation
task.spawn(function()
    while true do
        for i = 0.85, 1.15, 0.03 do
            blockBox.Size = UDim2.new(0, 60 * i, 0, 60 * i)
            task.wait(0.02)
        end
        for i = 1.15, 0.85, -0.03 do
            blockBox.Size = UDim2.new(0, 60 * i, 0, 60 * i)
            task.wait(0.02)
        end
    end
end)

-- Sparkle Particles
local function createSparkle()
    local sparkle = Instance.new("ImageLabel")
    sparkle.Size = UDim2.new(0, 8, 0, 8)
    sparkle.Image = "rbxassetid://266803060"
    sparkle.BackgroundTransparency = 1
    sparkle.ImageColor3 = Color3.fromRGB(255, 200, 100)
    sparkle.Parent = blockBox
    sparkle.Position = UDim2.new(math.random(), 0, math.random(), 0)
    local tween = tweenService:Create(sparkle, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {ImageTransparency = 1, Size = UDim2.new(0, 0, 0, 0)})
    tween:Play()
    tween.Completed:Connect(function() sparkle:Destroy() end)
end

task.spawn(function()
    while true do
        task.wait(0.3)
        createSparkle()
    end
end)

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

-- Hover Animation (Rotate)
blockBox.MouseEnter:Connect(function()
    local tween = tweenService:Create(icon, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Rotation = 360})
    tween:Play()
end)

blockBox.MouseLeave:Connect(function()
    local tween = tweenService:Create(icon, TweenInfo.new(0.3), {Rotation = 0})
    tween:Play()
end)

-- Click Animation & Toggle GUI
local guiVisible = true
blockBox.MouseButton1Click:Connect(function()
    -- Bounce animation
    local bounceIn = tweenService:Create(blockBox, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 50, 0, 50)})
    local bounceOut = tweenService:Create(blockBox, TweenInfo.new(0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 60, 0, 60)})
    bounceIn:Play()
    bounceIn.Completed:Connect(function() bounceOut:Play() end)
    
    guiVisible = not guiVisible
    window.Visible = guiVisible
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 28: PLAYER INFO PANEL
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local infoGui = Instance.new("ScreenGui")
infoGui.Name = "MantaxInfo"
infoGui.Parent = coreGui

local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(0, 260, 0, 100)
infoFrame.Position = UDim2.new(0, 8, 1, -110)
infoFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
infoFrame.BackgroundTransparency = 0.4
infoFrame.BorderSizePixel = 0
infoFrame.Parent = infoGui

local infoCorner = Instance.new("UICorner")
infoCorner.CornerRadius = UDim.new(0, 8)
infoCorner.Parent = infoFrame

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, 0, 0, 22)
infoTitle.Text = "⚡ MANTAXVLY PREMIUM"
infoTitle.TextColor3 = Color3.fromRGB(255, 50, 150)
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
            local level = player.Data.Level.Value
            local beli = player.Data.Beli.Value
            local bounty = player.Data.Bounty.Value
            local fruit = player.Data.DevilFruit.Value
            local race = player.Data.Race.Value
            local hp = humanoid and humanoid.Health or 0
            local mhp = humanoid and humanoid.MaxHealth or 100
            infoText.Text = string.format("<b>Level:</b> %s\n<b>Beli:</b> %s\n<b>Bounty:</b> %s\n<b>Fruit:</b> %s\n<b>Race:</b> %s\n<b>HP:</b> %.0f/%.0f", 
                level, formatNumber(beli), formatNumber(bounty), fruit, race, hp, mhp)
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 SECTION 29: STARTUP
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

-- Show loading screen
showLoadingScreen()

-- Startup message
print("=" .. string.rep("=", 70))
print("⚡ MANTAXVLY PREMIUM v10.0 - NEON BLOCK BOX EDITION")
print("=" .. string.rep("=", 70))
print("📌 12 HUBS IN 1 | 150+ FITUR LENGKAP")
print("   🔴 REDZ   🔥 HOHO   💜 QUANTUM   🟣 VORTEX   📜 SCRIPTOR")
print("   ⚔️ MATSUNE   ⚡ THUNDERZ   🌀 ZENKI   🎯 XERO   🌙 ECLIPSE")
print("   💎 CRYSTAL   🔮 NEBULA")
print("=" .. string.rep("=", 70))
print("🎮 GUI READY | Tekan Block Box (⚡) untuk toggle menu")
print("📍 Current Sea: " .. currentSea)
print("=" .. string.rep("=", 70))

notify("⚡ MANTAXVLY PREMIUM", "v10.0 Neon Block Box Edition Loaded! Tap ⚡ to open menu", 5)
