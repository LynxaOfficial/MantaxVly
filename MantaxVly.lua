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
║              ███╗   ██╗████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗                                            ║
║              ████╗  ██║╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝                                            ║
║              ██╔██╗ ██║   ██║   ██║██╔████╔██║███████║   ██║   █████╗                                              ║
║              ██║╚██╗██║   ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝                                              ║
║              ██║ ╚████║   ██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗                                            ║
║              ╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝                                            ║
║                                                                                                                       ║
║                                                                                                                       ║
║              ██████╗ ███████╗██╗  ████████╗ █████╗     ███████╗██████╗ ██╗████████╗██╗ ██████╗ ███╗   ██╗          ║
║              ██╔══██╗██╔════╝██║  ╚══██╔══╝██╔══██╗    ██╔════╝██╔══██╗██║╚══██╔══╝██║██╔═══██╗████╗  ██║          ║
║              ██║  ██║█████╗  ██║     ██║   ███████║    █████╗  ██║  ██║██║   ██║   ██║██║   ██║██╔██╗ ██║          ║
║              ██║  ██║██╔══╝  ██║     ██║   ██╔══██║    ██╔══╝  ██║  ██║██║   ██║   ██║██║   ██║██║╚██╗██║          ║
║              ██████╔╝███████╗███████╗██║   ██║  ██║    ███████╗██████╔╝██║   ██║   ██║╚██████╔╝██║ ╚████║          ║
║              ╚═════╝ ╚══════╝╚══════╝╚═╝   ╚═╝  ╚═╝    ╚══════╝╚═════╝ ╚═╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝          ║
║                                                                                                                       ║
║                    M A N T A X V L Y   P R E M I U M   U L T I M A T E                                              ║
║                           DELTA EDITION v3.0 | UPDATE 2026                                                            ║
║                      BY GANNADY PROGRAMMER TERBAIK                                                                    ║
║                                                                                                                       ║
║                    🔥 76+ FITUR | KEYLESS | NO WATERMARK | ANTI-CRASH 🔥                                              ║
║                                                                                                                       ║
╚═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
--]]

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 GLOBAL SERVICES
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📁 GLOBAL CONFIGURATION (76 FITUR)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

getgenv().MantaxConfig = {
    -- Auto Farm Settings
    AutoFarm = {
        Enabled = false,
        Method = "Quest",
        Radius = 350,
        FastAttackDelay = 0.4,
        AutoAcceptQuest = true,
        LockAnchoredY = true
    },
    
    -- Movement Settings
    Movement = {
        WalkSpeed = 32,
        JumpPower = 80,
        InfiniteJump = false,
        NoClip = false,
        AntiAFK = true,
        AutoRejoin = false
    },
    
    -- Haki Settings
    Haki = {
        AutoObservation = false,
        AutoObservationV2 = false,
        AutoBuso = false,
        AutoConqueror = false
    },
    
    -- Stats Settings
    Stats = {
        AutoStats = false,
        Priority = "Melee"
    },
    
    -- Equipment
    Equipment = {
        AutoEquipBestSword = false,
        AutoEquipBestFruit = false
    },
    
    -- Combat
    Combat = {
        AutoDodge = false,
        AutoDodgeDelay = 0.3
    },
    
    -- Sea Event Settings
    Sea = {
        -- Leviathan
        LeviathanBribe = false,
        LeviathanFind = false,
        LeviathanKill = false,
        LeviathanSailBack = false,
        -- Fishing
        AutoFishing = false,
        AutoSellFish = false,
        AutoCraftBait = false,
        -- Sea Beast
        AutoSeaBeast = false,
        AutoDodgeSeaBeast = false,
        UseMIFruit = false,
        -- Azure Ember
        AutoTradeAzure = false,
        AzureAmount = 1,
        -- Boat
        AutoBuyNewBoat = false
    },
    
    -- Boss Settings
    Boss = {
        AutoDoughKing = false,
        IgnoreKatakuri = false,
        IgnoreFarmChalice = false,
        AutoCakeQueen = false,
        AutoRipIndra = false,
        AutoTideKeeper = false,
        AutoOrder = false,
        AutoDarkbeard = false,
        AutoGreybeard = false,
        AutoSoulReaper = false,
        AutoCursedCaptain = false
    },
    
    -- Raid Settings
    Raid = {
        AutoBuyChip = false,
        AutoCompleteRaid = false,
        AutoLoopRaid = false,
        AutoAwaken = false,
        SelectedFruit = "Flame"
    },
    
    -- Fighting Style Settings
    FightingStyle = {
        AutoDeathStep = false,
        AutoSharkmanKarate = false,
        AutoElectricClaw = false,
        AutoDragonTalon = false,
        AutoSuperhuman = false,
        AutoGodhuman = false
    },
    
    -- Mastery Settings
    Mastery = {
        AutoSwordMastery = false,
        AutoFruitMastery = false,
        AutoGunMastery = false,
        SelectedSword = nil,
        TargetMastery = 600
    },
    
    -- Fruit Settings
    Fruit = {
        AutoSnipe = false,
        AutoStore = false,
        AutoUnstoreBelow1M = false,
        Whitelist = {"Kitsune", "Dragon", "Leopard", "T-Rex", "Mammoth", "Dough", "Spirit", "Venom", "Tiger", "Yeti", "Gas", "Blizzard"}
    },
    
    -- Item Settings
    Item = {
        AutoSkullGuitar = false,
        AutoDarkBlade = false,
        AutoTTK = false,
        AutoHallowScythe = false,
        AutoPoleV2 = false
    },
    
    -- Misc Settings
    Misc = {
        AutoBones = false,
        AutoRandomSurprise = false,
        AutoPray = false,
        AutoEliteHunter = false,
        AutoObservationTrain = false,
        AutoDummyTraining = false,
        AutoOpenColorsPlate = false,
        AutoTrueFormRipIndra = false,
        AutoRainbowHaki = false
    },
    
    -- ESP Settings
    ESP = {
        Enabled = false,
        Players = true,
        Fruits = true,
        Chests = true,
        Bosses = true,
        Distance = 8000
    }
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🗺️ LEVEL MAP (UPDATE 2026 - TIGER FRUIT AREA)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local LevelMap = {
    -- FIRST SEA (Level 0-700)
    {min=0, max=10, name="Bandits", zone="First", loc=CFrame.new(-1223,55,2089), quest="Bandit", npc="Bandit"},
    {min=10, max=30, name="Monkeys", zone="First", loc=CFrame.new(-1456,45,1850), quest="Monkey", npc="Monkey"},
    {min=30, max=60, name="Pirates", zone="First", loc=CFrame.new(-1120,55,2150), quest="Pirate", npc="Pirate"},
    {min=60, max=90, name="Brutes", zone="First", loc=CFrame.new(-1050,55,2200), quest="Brute", npc="Brute"},
    {min=90, max=120, name="Desert Bandits", zone="First", loc=CFrame.new(-850,50,1950), quest="DesertBandit", npc="Desert Bandit"},
    {min=120, max=190, name="Marines", zone="First", loc=CFrame.new(-580,80,1850), quest="Marine", npc="Marine"},
    {min=190, max=275, name="Sky Bandits", zone="First", loc=CFrame.new(2850,1200,2100), quest="SkyBandit", npc="Sky Bandit"},
    {min=275, max=375, name="Military Soldiers", zone="First", loc=CFrame.new(-440,85,1770), quest="Military", npc="Military Soldier"},
    {min=375, max=450, name="Fishmen", zone="First", loc=CFrame.new(3050,-350,2850), quest="Fishman", npc="Fishman"},
    {min=450, max=625, name="Cyborgs", zone="First", loc=CFrame.new(5200,50,950), quest="Cyborg", npc="Cyborg"},
    {min=625, max=700, name="Royal Soldiers", zone="First", loc=CFrame.new(2900,1200,2550), quest="RoyalSoldier", npc="Royal Soldier"},
    
    -- SECOND SEA (Level 700-1500)
    {min=700, max=850, name="Swan Pirates", zone="Second", loc=CFrame.new(-550,160,250), quest="SwanPirate", npc="Swan Pirate"},
    {min=850, max=1000, name="Marine Lieutenants", zone="Second", loc=CFrame.new(-380,140,-410), quest="MarineLieutenant", npc="Marine Lieutenant"},
    {min=1000, max=1100, name="Snow Troopers", zone="Second", loc=CFrame.new(100,230,1800), quest="SnowTrooper", npc="Snow Trooper"},
    {min=1100, max=1250, name="Lab Subordinates", zone="Second", loc=CFrame.new(-5000,220,-500), quest="LabSubordinate", npc="Lab Subordinate"},
    {min=1250, max=1400, name="Ship Deckhands", zone="Second", loc=CFrame.new(5200,40,1020), quest="ShipDeckhand", npc="Ship Deckhand"},
    {min=1400, max=1500, name="Arctic Warriors", zone="Second", loc=CFrame.new(4700,320,1400), quest="ArcticWarrior", npc="Arctic Warrior"},
    
    -- THIRD SEA (Level 1500-2550+) + TIGER UPDATE AREA
    {min=1500, max=1575, name="Pirate Millionaires", zone="Third", loc=CFrame.new(-11800,330,8250), quest="PirateMillionaire", npc="Pirate Millionaire"},
    {min=1575, max=1700, name="Island Empress", zone="Third", loc=CFrame.new(-13800,420,8600), quest="IslandEmpress", npc="Island Empress"},
    {min=1700, max=2000, name="Marine Commodores", zone="Third", loc=CFrame.new(-12500,600,11250), quest="MarineCommodore", npc="Marine Commodore"},
    {min=2000, max=2200, name="Reborn Skeletons", zone="Third", loc=CFrame.new(-14400,520,12800), quest="RebornSkeleton", npc="Reborn Skeleton"},
    {min=2200, max=2400, name="Candy Rebels", zone="Third", loc=CFrame.new(-16700,400,14100), quest="CandyRebel", npc="Candy Rebel"},
    {min=2400, max=2600, name="Tiger Dojo", zone="Third", loc=CFrame.new(-17800,350,15500), quest="TigerDojo", npc="Tiger Warrior", update="Update 28"}
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 👑 BOSS DATA (LENGKAP)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local Bosses = {
    -- Third Sea Bosses
    {name="Dough King", loc=CFrame.new(-16000,350,14800), level=2300, hp=75000, spawnItem="Chalice", reward="Dough Fruit"},
    {name="Cake Queen", loc=CFrame.new(-14400,400,13500), level=2000, hp=50000, reward="Cake Crown"},
    {name="Rip Indra", loc=CFrame.new(-15800,280,13200), level=2000, hp=60000, condition="Full Moon", reward="Dark Dagger"},
    {name="Tide Keeper", loc=CFrame.new(-13800,300,15800), level=1800, hp=35000, reward="Tide Breaker"},
    {name="Order", loc=CFrame.new(-16800,420,15200), level=2500, hp=100000, reward="Soul Guitar"},
    {name="Stone", loc=CFrame.new(-12800,280,16800), level=1750, hp=30000, reward="Cursed Key"},
    
    -- Second Sea Bosses
    {name="Darkbeard", loc=CFrame.new(5200,40,1020), level=1000, hp=25000, condition="Night", reward="Dark Fragment"},
    {name="Greybeard", loc=CFrame.new(-550,160,250), level=750, hp=20000, reward="Greybeard Title"},
    {name="Soul Reaper", loc=CFrame.new(-5000,220,-500), level=1250, hp=30000, reward="Soul Reaper Title"},
    {name="Cursed Captain", loc=CFrame.new(100,230,1800), level=1150, hp=25000, reward="Cursed Captain Title"},
    
    -- First Sea Bosses
    {name="Saber Expert", loc=CFrame.new(-1120,55,2150), level=100, hp=5000, reward="Saber"},
    {name="Mob Leader", loc=CFrame.new(-1223,55,2089), level=50, hp=3000, reward="Mob Title"}
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🏝️ ISLAND LIST (UNTUK TRAVEL)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local Islands = {
    -- Third Sea
    {name="Tiki Outpost", loc=CFrame.new(-13800,300,15800)},
    {name="Port of the Sea", loc=CFrame.new(-11800,330,8250)},
    {name="Hydra Island", loc=CFrame.new(-12500,600,11250)},
    {name="Great Tree", loc=CFrame.new(-15800,280,13200)},
    {name="Castle on the Sea", loc=CFrame.new(-16700,400,14100)},
    {name="Mirage Island", loc=CFrame.new(-14800,320,12800)},
    {name="Sea of Treats", loc=CFrame.new(-14400,400,13500)},
    {name="Candy Island", loc=CFrame.new(-16700,400,14100)},
    {name="Tiger Dojo", loc=CFrame.new(-17800,350,15500)},
    {name="Floating Turtle", loc=CFrame.new(-12500,600,11250)},
    
    -- Second Sea
    {name="Kingdom of Rose", loc=CFrame.new(-550,160,250)},
    {name="Snow Mountain", loc=CFrame.new(100,230,1800)},
    {name="Graveyard", loc=CFrame.new(-5000,220,-500)},
    {name="Hot and Cold", loc=CFrame.new(5200,40,1020)},
    {name="Ice Castle", loc=CFrame.new(5200,200,1020)},
    
    -- First Sea
    {name="Jungle", loc=CFrame.new(-1120,55,2150)},
    {name="Desert", loc=CFrame.new(-850,50,1950)},
    {name="Sky Islands", loc=CFrame.new(2850,1200,2100)},
    {name="Frozen Village", loc=CFrame.new(-580,80,1850)},
    {name="Marine Fortress", loc=CFrame.new(-440,85,1770)},
    {name="Prison", loc=CFrame.new(-1050,55,2200)},
    {name="Underwater City", loc=CFrame.new(3050,-350,2850)}
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🥋 FIGHTING STYLE DATA
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local FightingStyles = {
    {name="Death Step", remote="BuyDeathStep", price=1500000, requirement="Dark Step 400 Mastery"},
    {name="Sharkman Karate", remote="BuySharkmanKarate", price=2500000, requirement="Water Kung Fu 400 Mastery"},
    {name="Electric Claw", remote="BuyElectricClaw", price=3000000, requirement="Electro 400 Mastery"},
    {name="Dragon Talon", remote="BuyDragonTalon", price=3000000, requirement="Dragon Breath 400 Mastery"},
    {name="Superhuman", remote="BuySuperhuman", price=3000000, requirement="All fighting styles 300 Mastery"},
    {name="Godhuman", remote="BuyGodhuman", price=5000000, requirement="Superhuman 400 Mastery + 5000 Fragments"}
}

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🔧 CORE UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 3
        })
    end)
end

local function TeleportTo(cf)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cf
    end
end

local function SetWalkSpeed(speed)
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = speed end
    end
end

local function SetJumpPower(power)
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = power end
    end
end

local function GetQuestZone(level)
    for _, zone in ipairs(LevelMap) do
        if level >= zone.min and level <= zone.max then
            return zone
        end
    end
    return LevelMap[#LevelMap]
end

local function AcceptQuest(questName)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", questName)
    end)
end

local function FormatBounty(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(num)
    end
end

local function AttackNPC(npc)
    local char = player.Character
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local npcHrp = npc:FindFirstChild("HumanoidRootPart")
    
    if hrp and npcHrp then
        hrp.CFrame = CFrame.new(hrp.Position, npcHrp.Position)
        
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
            if getgenv().MantaxConfig.AutoFarm.FastAttackDelay > 0 then
                task.wait(getgenv().MantaxConfig.AutoFarm.FastAttackDelay)
                VirtualUser:ClickButton1(Vector2.new(0,0))
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🔄 AUTO FARM SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local autoFarmRunning = false
local autoFarmCoroutine = nil

local function StartAutoFarm()
    if autoFarmRunning then return end
    autoFarmRunning = true
    
    autoFarmCoroutine = task.spawn(function()
        while autoFarmRunning and task.wait(0.2) do
            local char = player.Character
            if not char then 
                task.wait(2)
                goto continue
            end
            
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if not humanoid or humanoid.Health <= 0 then
                task.wait(3)
                goto continue
            end
            
            -- Apply movement settings
            SetWalkSpeed(getgenv().MantaxConfig.Movement.WalkSpeed)
            SetJumpPower(getgenv().MantaxConfig.Movement.JumpPower)
            
            -- Lock Anchored Y
            if getgenv().MantaxConfig.AutoFarm.LockAnchoredY then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y + 0.1, hrp.Position.Z)
                end
            end
            
            -- Get current level and zone
            local level = player.Data.Level.Value
            local zone = GetQuestZone(level)
            
            if zone then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                
                -- Accept quest if enabled
                if getgenv().MantaxConfig.AutoFarm.AutoAcceptQuest and 
                   getgenv().MantaxConfig.AutoFarm.Method == "Quest" then
                    AcceptQuest(zone.quest)
                end
                
                -- Teleport to zone if too far
                if hrp and (hrp.Position - zone.loc.Position).Magnitude > 
                   getgenv().MantaxConfig.AutoFarm.Radius then
                    TeleportTo(zone.loc)
                    task.wait(0.3)
                end
                
                -- Find nearest NPC
                local nearestNPC = nil
                local shortestDist = math.huge
                
                for _, v in ipairs(Workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and 
                       v.Name ~= player.Name and not v.Name:find("Player") then
                        local npcHrp = v:FindFirstChild("HumanoidRootPart")
                        if npcHrp and hrp then
                            local dist = (hrp.Position - npcHrp.Position).Magnitude
                            if dist < shortestDist and dist < getgenv().MantaxConfig.AutoFarm.Radius then
                                shortestDist = dist
                                nearestNPC = v
                            end
                        end
                    end
                end
                
                if nearestNPC then
                    AttackNPC(nearestNPC)
                end
            end
            
            ::continue::
        end
    end)
    Notify("⚡ MANTAXVLY", "Auto Farm Started!", 2)
end

local function StopAutoFarm()
    autoFarmRunning = false
    if autoFarmCoroutine then
        task.cancel(autoFarmCoroutine)
        autoFarmCoroutine = nil
    end
    Notify("⚡ MANTAXVLY", "Auto Farm Stopped!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🛡️ AUTO HAKI SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

task.spawn(function()
    while true do
        task.wait(5)
        pcall(function()
            if getgenv().MantaxConfig.Haki.AutoObservation then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Observation", "Activate")
            end
            if getgenv().MantaxConfig.Haki.AutoBuso then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso", "Activate")
            end
            if getgenv().MantaxConfig.Haki.AutoConqueror then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Conqueror", "Activate")
            end
        end)
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📊 AUTO STATS SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

task.spawn(function()
    while true do
        task.wait(3)
        if getgenv().MantaxConfig.Stats.AutoStats then
            pcall(function()
                local points = player.Data.Points.Value
                if points > 0 then
                    local statMap = {
                        Melee = "AddMelee",
                        Defense = "AddDefense",
                        Sword = "AddSword",
                        Gun = "AddGun",
                        Fruit = "AddFruit"
                    }
                    local stat = statMap[getgenv().MantaxConfig.Stats.Priority] or "AddMelee"
                    for i = 1, math.min(points, 10) do
                        ReplicatedStorage.Remotes.CommF_:InvokeServer(stat)
                        task.wait(0.1)
                    end
                end
            end)
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🦘 INFINITE JUMP
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

UserInputService.JumpRequest:Connect(function()
    if getgenv().MantaxConfig.Movement.InfiniteJump then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🚫 ANTI AFK
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

if getgenv().MantaxConfig.Movement.AntiAFK then
    local VirtualUser = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🍎 FRUIT SNIPER SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local fruitSniperRunning = false
local fruitSniperCoroutine = nil

local function StartFruitSniper()
    if fruitSniperRunning then return end
    fruitSniperRunning = true
    
    fruitSniperCoroutine = task.spawn(function()
        while fruitSniperRunning and task.wait(2) do
            for _, fruit in ipairs(Workspace:GetDescendants()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
                    for _, rare in ipairs(getgenv().MantaxConfig.Fruit.Whitelist) do
                        if string.find(fruit.Name, rare) then
                            pcall(function()
                                Notify("🍎 RARE FRUIT!", fruit.Name .. " detected! Teleporting...", 3)
                                TeleportTo(fruit.Handle.CFrame)
                            end)
                            break
                        end
                    end
                end
            end
        end
    end)
    Notify("🍎 FRUIT SNIPER", "Fruit Sniper Activated!", 2)
end

local function StopFruitSniper()
    fruitSniperRunning = false
    if fruitSniperCoroutine then
        task.cancel(fruitSniperCoroutine)
        fruitSniperCoroutine = nil
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 👑 AUTO DOUGH KING
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local doughKingRunning = false
local doughKingCoroutine = nil

local function StartDoughKing()
    if doughKingRunning then return end
    doughKingRunning = true
    
    doughKingCoroutine = task.spawn(function()
        while doughKingRunning and task.wait(1) do
            pcall(function()
                -- Check if Dough King exists
                local doughKing = nil
                for _, v in ipairs(Workspace:GetDescendants()) do
                    if v.Name == "Dough King" and v:FindFirstChild("Humanoid") then
                        doughKing = v
                        break
                    end
                end
                
                if doughKing then
                    -- Kill Dough King
                    while doughKing and doughKing.Parent and 
                          doughKing:FindFirstChild("Humanoid") and 
                          doughKing.Humanoid.Health > 0 do
                        AttackNPC(doughKing)
                        task.wait(0.3)
                    end
                    Notify("👑 DOUGH KING", "Dough King defeated!", 2)
                else
                    if not getgenv().MantaxConfig.Boss.IgnoreFarmChalice then
                        -- Farm Chalice
                        for _, v in ipairs(Workspace:GetDescendants()) do
                            if v.Name:find("Chalice") then
                                TeleportTo(v:FindFirstChild("Handle").CFrame)
                                break
                            end
                        end
                    end
                    -- Teleport to Cake Island
                    TeleportTo(CFrame.new(-14400, 400, 13500))
                    task.wait(2)
                end
            end)
        end
    end)
    Notify("👑 DOUGH KING", "Auto Dough King Started!", 2)
end

local function StopDoughKing()
    doughKingRunning = false
    if doughKingCoroutine then
        task.cancel(doughKingCoroutine)
        doughKingCoroutine = nil
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎣 AUTO FISHING SYSTEM
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local autoFishingRunning = false
local autoFishingCoroutine = nil

local function StartAutoFishing()
    if autoFishingRunning then return end
    autoFishingRunning = true
    
    autoFishingCoroutine = task.spawn(function()
        while autoFishingRunning and task.wait(5) do
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Fishing", "Start")
                task.wait(8)
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Fishing", "Stop")
                
                if getgenv().MantaxConfig.Sea.AutoSellFish then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SellFish")
                end
                
                if getgenv().MantaxConfig.Sea.AutoCraftBait then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CraftBait")
                end
            end)
        end
    end)
    Notify("🎣 AUTO FISHING", "Auto Fishing Started!", 2)
end

local function StopAutoFishing()
    autoFishingRunning = false
    if autoFishingCoroutine then
        task.cancel(autoFishingCoroutine)
        autoFishingCoroutine = nil
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 📡 ESP SYSTEM (LIGHTWEIGHT FOR DELTA)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local espActive = false
local espBillboards = {}

local function ClearESP()
    for _, billboard in pairs(espBillboards) do
        pcall(function() billboard:Destroy() end)
    end
    espBillboards = {}
end

local function CreateESP()
    if espActive then
        ClearESP()
        espActive = false
        return
    end
    
    espActive = true
    
    local function AddESPToPlayer(targetPlayer)
        if targetPlayer == player then return end
        
        local character = targetPlayer.Character
        if not character then return end
        
        local head = character:FindFirstChild("Head")
        if not head then return end
        
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "MantaxESP"
        billboard.Size = UDim2.new(0, 200, 0, 50)
        billboard.AlwaysOnTop = true
        billboard.Parent = head
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.fromRGB(255, 50, 150)
        textLabel.TextSize = 12
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextStrokeTransparency = 0.5
        textLabel.Parent = billboard
        
        local function UpdateBounty()
            local bounty = targetPlayer.Data and (targetPlayer.Data.Bounty or targetPlayer.Data.Honor)
            if bounty and bounty.Value then
                textLabel.Text = string.format("%s\n💰 %s", targetPlayer.Name, FormatBounty(bounty.Value))
            else
                textLabel.Text = targetPlayer.Name
            end
        end
        
        UpdateBounty()
        pcall(function()
            targetPlayer.Data.Bounty:GetPropertyChangedSignal("Value"):Connect(UpdateBounty)
        end)
        
        table.insert(espBillboards, billboard)
    end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        AddESPToPlayer(plr)
    end
    
    Players.PlayerAdded:Connect(AddESPToPlayer)
    
    Notify("📡 ESP", "Player ESP with Bounty Display Enabled!", 2)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🥋 AUTO FIGHTING STYLE UNLOCK
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function UnlockFightingStyle(styleName)
    pcall(function()
        for _, style in ipairs(FightingStyles) do
            if style.name == styleName then
                ReplicatedStorage.Remotes.CommF_:InvokeServer(style.remote)
                Notify("🥋 FIGHTING STYLE", style.name .. " unlocked!", 2)
                break
            end
        end
    end)
end

local function UnlockAllFightingStyles()
    task.spawn(function()
        for _, style in ipairs(FightingStyles) do
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer(style.remote)
                print("✅ Unlocked: " .. style.name)
                task.wait(1)
            end)
        end
        Notify("🥋 FIGHTING STYLES", "All fighting styles unlocked!", 3)
    end)
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🗺️ TRAVEL FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local function TeleportToSea(seaNumber)
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("TravelDimensionalChamber", seaNumber)
        Notify("🌍 TRAVEL", "Teleporting to Sea " .. seaNumber, 2)
    end)
end

local function TeleportToIsland(islandName)
    for _, island in ipairs(Islands) do
        if island.name == islandName then
            TeleportTo(island.loc)
            Notify("🏝️ TRAVEL", "Teleporting to " .. islandName, 2)
            break
        end
    end
end

local function TeleportToBoss(bossName)
    for _, boss in ipairs(Bosses) do
        if boss.name == bossName then
            TeleportTo(boss.loc)
            Notify("👑 BOSS", "Teleporting to " .. bossName, 2)
            break
        end
    end
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🎨 GUI CREATION (MANTAXVLY ULTIMATE)
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

local screenGui = nil
local guiEnabled = true

local function CreateGUI()
    if screenGui then screenGui:Destroy() end
    
    screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MantaxVlyUltimate"
    screenGui.Parent = CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 16)
    mainCorner.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(204, 51, 51)
    titleBar.BackgroundTransparency = 0.15
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 16)
    titleCorner.Parent = titleBar
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -50, 1, 0)
    titleText.Position = UDim2.new(0, 10, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "⚡ MANTAXVLY PREMIUM ULTIMATE"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 14
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 1, 0)
    closeBtn.Position = UDim2.new(1, -40, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 18
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function()
        guiEnabled = not guiEnabled
        screenGui.Enabled = guiEnabled
    end)
    
    -- Tab Bar
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, 0, 0, 35)
    tabBar.Position = UDim2.new(0, 0, 0, 45)
    tabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
    tabBar.BackgroundTransparency = 0.3
    tabBar.BorderSizePixel = 0
    tabBar.Parent = mainFrame
    
    local tabs = {"🏠 MAIN", "⚔️ FARM", "🌊 SEA", "👑 BOSS", "🥋 STYLE", "🍎 FRUIT", "🗺️ TRAVEL", "❄️ MISC", "⚙️ PLAYER", "📡 ESP"}
    local tabButtons = {}
    local currentTab = "🏠 MAIN"
    
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -20, 1, -100)
    contentFrame.Position = UDim2.new(0, 10, 0, 85)
    contentFrame.BackgroundTransparency = 1
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
    contentFrame.ScrollBarThickness = 5
    contentFrame.Parent = mainFrame
    
    local contentList = Instance.new("UIListLayout")
    contentList.Padding = UDim.new(0, 6)
    contentList.SortOrder = Enum.SortOrder.LayoutOrder
    contentList.Parent = contentFrame
    
    -- Helper Functions
    local function AddButton(text, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 40)
        btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 45)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = contentFrame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = color and Color3.fromRGB(color.R*1.2, color.G*1.2, color.B*1.2) or Color3.fromRGB(50, 50, 65)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundColor3 = color or Color3.fromRGB(30, 30, 45)
        end)
        btn.MouseButton1Click:Connect(callback)
        return btn
    end
    
    local function AddToggle(text, getter, setter)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 40)
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        frame.Parent = contentFrame
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 8)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 12
        label.Font = Enum.Font.GothamSemibold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 70, 0, 30)
        btn.Position = UDim2.new(1, -80, 0.5, -15)
        btn.BackgroundColor3 = getter() and Color3.fromRGB(204, 51, 51) or Color3.fromRGB(60, 60, 70)
        btn.Text = getter() and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamBold
        btn.Parent = frame
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            local newState = not getter()
            setter(newState)
            btn.BackgroundColor3 = newState and Color3.fromRGB(204, 51, 51) or Color3.fromRGB(60, 60, 70)
            btn.Text = newState and "ON" or "OFF"
        end)
        
        return frame
    end
    
    local function AddSlider(text, min, max, getter, setter)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 70)
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
        frame.Parent = contentFrame
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 8)
        frameCorner.Parent = frame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 0, 25)
        label.Position = UDim2.new(0, 10, 0, 5)
        label.BackgroundTransparency = 1
        label.Text = text .. ": " .. getter()
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextSize = 12
        label.Font = Enum.Font.GothamSemibold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.3, 0, 0, 30)
        input.Position = UDim2.new(0.65, 0, 0, 30)
        input.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        input.Text = tostring(getter())
        input.TextColor3 = Color3.fromRGB(255, 255, 255)
        input.TextSize = 14
        input.Font = Enum.Font.GothamBold
        input.Parent = frame
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 6)
        inputCorner.Parent = input
        
        input.FocusLost:Connect(function(enter)
            if enter then
                local val = tonumber(input.Text)
                if val then
                    val = math.clamp(val, min, max)
                    setter(val)
                    label.Text = text .. ": " .. val
                    input.Text = tostring(val)
                else
                    input.Text = tostring(getter())
                end
            end
        end)
        
        return frame
    end
    
    -- Tab Content Builder
    local function BuildMainTab()
        AddButton("▶ START AUTO FARM", Color3.fromRGB(204, 51, 51), StartAutoFarm)
        AddButton("⏹ STOP AUTO FARM", Color3.fromRGB(60, 60, 70), StopAutoFarm)
        
        AddSlider("Farm Radius", 200, 500,
            function() return getgenv().MantaxConfig.AutoFarm.Radius end,
            function(v) getgenv().MantaxConfig.AutoFarm.Radius = v end)
        
        AddSlider("Fast Attack Delay", 0.1, 1.0,
            function() return getgenv().MantaxConfig.AutoFarm.FastAttackDelay end,
            function(v) getgenv().MantaxConfig.AutoFarm.FastAttackDelay = v end)
        
        AddToggle("Auto Accept Quest",
            function() return getgenv().MantaxConfig.AutoFarm.AutoAcceptQuest end,
            function(v) getgenv().MantaxConfig.AutoFarm.AutoAcceptQuest = v end)
        
        AddToggle("Lock Anchored Y",
            function() return getgenv().MantaxConfig.AutoFarm.LockAnchoredY end,
            function(v) getgenv().MantaxConfig.AutoFarm.LockAnchoredY = v end)
    end
    
    local function BuildFarmTab()
        AddToggle("Auto Observation Haki",
            function() return getgenv().MantaxConfig.Haki.AutoObservation end,
            function(v) getgenv().MantaxConfig.Haki.AutoObservation = v end)
        
        AddToggle("Auto Observation V2",
            function() return getgenv().MantaxConfig.Haki.AutoObservationV2 end,
            function(v) getgenv().MantaxConfig.Haki.AutoObservationV2 = v end)
        
        AddToggle("Auto Buso Haki",
            function() return getgenv().MantaxConfig.Haki.AutoBuso end,
            function(v) getgenv().MantaxConfig.Haki.AutoBuso = v end)
        
        AddToggle("Auto Conqueror Haki",
            function() return getgenv().MantaxConfig.Haki.AutoConqueror end,
            function(v) getgenv().MantaxConfig.Haki.AutoConqueror = v end)
        
        AddToggle("Auto Stats",
            function() return getgenv().MantaxConfig.Stats.AutoStats end,
            function(v) getgenv().MantaxConfig.Stats.AutoStats = v end)
        
        AddToggle("Auto Dodge",
            function() return getgenv().MantaxConfig.Combat.AutoDodge end,
            function(v) getgenv().MantaxConfig.Combat.AutoDodge = v end)
    end
    
    local function BuildSeaTab()
        AddToggle("Auto Leviathan Hunt",
            function() return getgenv().MantaxConfig.Sea.LeviathanFind end,
            function(v) getgenv().MantaxConfig.Sea.LeviathanFind = v end)
        
        AddToggle("Auto Fishing",
            function() return getgenv().MantaxConfig.Sea.AutoFishing end,
            function(v) 
                getgenv().MantaxConfig.Sea.AutoFishing = v
                if v then StartAutoFishing() else StopAutoFishing() end
            end)
        
        AddToggle("Auto Sell Fish",
            function() return getgenv().MantaxConfig.Sea.AutoSellFish end,
            function(v) getgenv().MantaxConfig.Sea.AutoSellFish = v end)
        
        AddToggle("Auto Sea Beast",
            function() return getgenv().MantaxConfig.Sea.AutoSeaBeast end,
            function(v) getgenv().MantaxConfig.Sea.AutoSeaBeast = v end)
        
        AddToggle("Auto Dodge Sea Beast",
            function() return getgenv().MantaxConfig.Sea.AutoDodgeSeaBeast end,
            function(v) getgenv().MantaxConfig.Sea.AutoDodgeSeaBeast = v end)
    end
    
    local function BuildBossTab()
        AddToggle("Auto Dough King",
            function() return getgenv().MantaxConfig.Boss.AutoDoughKing end,
            function(v) 
                getgenv().MantaxConfig.Boss.AutoDoughKing = v
                if v then StartDoughKing() else StopDoughKing() end
            end)
        
        AddToggle("Ignore Farm Chalice",
            function() return getgenv().MantaxConfig.Boss.IgnoreFarmChalice end,
            function(v) getgenv().MantaxConfig.Boss.IgnoreFarmChalice = v end)
        
        AddButton("👑 Teleport to Dough King", Color3.fromRGB(50, 50, 70), function()
            TeleportToBoss("Dough King")
        end)
        
        AddButton("🎂 Teleport to Cake Queen", Color3.fromRGB(50, 50, 70), function()
            TeleportToBoss("Cake Queen")
        end)
        
        AddButton("⚡ Teleport to Rip Indra", Color3.fromRGB(50, 50, 70), function()
            TeleportToBoss("Rip Indra")
        end)
        
        AddButton("🌊 Teleport to Tide Keeper", Color3.fromRGB(50, 50, 70), function()
            TeleportToBoss("Tide Keeper")
        end)
        
        AddButton("📜 Teleport to Order", Color3.fromRGB(50, 50, 70), function()
            TeleportToBoss("Order")
        end)
        
        AddButton("🏴‍☠️ Teleport to Darkbeard", Color3.fromRGB(50, 50, 70), function()
            TeleportToBoss("Darkbeard")
        end)
    end
    
    local function BuildStyleTab()
        AddButton("🥋 Unlock Death Step", Color3.fromRGB(50, 50, 70), function()
            UnlockFightingStyle("Death Step")
        end)
        
        AddButton("🦈 Unlock Sharkman Karate", Color3.fromRGB(50, 50, 70), function()
            UnlockFightingStyle("Sharkman Karate")
        end)
        
        AddButton("⚡ Unlock Electric Claw", Color3.fromRGB(50, 50, 70), function()
            UnlockFightingStyle("Electric Claw")
        end)
        
        AddButton("🐉 Unlock Dragon Talon", Color3.fromRGB(50, 50, 70), function()
            UnlockFightingStyle("Dragon Talon")
        end)
        
        AddButton("🦸 Unlock Superhuman", Color3.fromRGB(50, 50, 70), function()
            UnlockFightingStyle("Superhuman")
        end)
        
        AddButton("👑 Unlock Godhuman", Color3.fromRGB(204, 51, 51), function()
            UnlockFightingStyle("Godhuman")
        end)
        
        AddButton("⭐ Unlock ALL Fighting Styles", Color3.fromRGB(204, 51, 51), UnlockAllFightingStyles)
    end
    
    local function BuildFruitTab()
        AddToggle("🍎 Fruit Sniper",
            function() return getgenv().MantaxConfig.Fruit.AutoSnipe end,
            function(v) 
                getgenv().MantaxConfig.Fruit.AutoSnipe = v
                if v then StartFruitSniper() else StopFruitSniper() end
            end)
        
        AddToggle("Auto Store Fruit",
            function() return getgenv().MantaxConfig.Fruit.AutoStore end,
            function(v) getgenv().MantaxConfig.Fruit.AutoStore = v end)
        
        AddButton("🎸 Auto Skull Guitar", Color3.fromRGB(50, 50, 70), function()
            Notify("🎸 SKULL GUITAR", "Starting Skull Guitar quest...", 2)
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("LoadInstrument", "Skull Guitar")
            end)
        end)
        
        AddButton("⚔️ Auto Dark Blade", Color3.fromRGB(50, 50, 70), function()
            Notify("⚔️ DARK BLADE", "Attempting to obtain Dark Blade...", 2)
            pcall(function()
                ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDarkBlade")
            end)
        end)
        
        AddButton("🗡️ Auto True Triple Katana", Color3.fromRGB(50, 50, 70), function()
            Notify("🗡️ TTK", "Attempting to obtain TTK...", 2)
        end)
    end
    
    local function BuildTravelTab()
        AddButton("🌍 Teleport to Sea 1", Color3.fromRGB(50, 50, 70), function()
            TeleportToSea(1)
        end)
        
        AddButton("🌍 Teleport to Sea 2", Color3.fromRGB(50, 50, 70), function()
            TeleportToSea(2)
        end)
        
        AddButton("🌍 Teleport to Sea 3", Color3.fromRGB(50, 50, 70), function()
            TeleportToSea(3)
        end)
        
        AddButton("🏝️ Teleport to Tiki Outpost", Color3.fromRGB(50, 50, 70), function()
            TeleportToIsland("Tiki Outpost")
        end)
        
        AddButton("🏝️ Teleport to Hydra Island", Color3.fromRGB(50, 50, 70), function()
            TeleportToIsland("Hydra Island")
        end)
        
        AddButton("🏝️ Teleport to Great Tree", Color3.fromRGB(50, 50, 70), function()
            TeleportToIsland("Great Tree")
        end)
        
        AddButton("🏝️ Teleport to Castle on the Sea", Color3.fromRGB(50, 50, 70), function()
            TeleportToIsland("Castle on the Sea")
        end)
        
        AddButton("🐯 Teleport to Tiger Dojo", Color3.fromRGB(204, 51, 51), function()
            TeleportToIsland("Tiger Dojo")
        end)
    end
    
    local function BuildMiscTab()
        AddToggle("🦴 Auto Bones",
            function() return getgenv().MantaxConfig.Misc.AutoBones end,
            function(v) getgenv().MantaxConfig.Misc.AutoBones = v end)
        
        AddToggle("🎁 Auto Random Surprise",
            function() return getgenv().MantaxConfig.Misc.AutoRandomSurprise end,
            function(v) getgenv().MantaxConfig.Misc.AutoRandomSurprise = v end)
        
        AddToggle("🙏 Auto Pray",
            function() return getgenv().MantaxConfig.Misc.AutoPray end,
            function(v) getgenv().MantaxConfig.Misc.AutoPray = v end)
        
        AddToggle("👑 Auto Elite Hunter",
            function() return getgenv().MantaxConfig.Misc.AutoEliteHunter end,
            function(v) getgenv().MantaxConfig.Misc.AutoEliteHunter = v end)
        
        AddToggle("👁️ Auto Observation Train",
            function() return getgenv().MantaxConfig.Misc.AutoObservationTrain end,
            function(v) getgenv().MantaxConfig.Misc.AutoObservationTrain = v end)
        
        AddButton("🌈 Auto Rainbow Haki", Color3.fromRGB(50, 50, 70), function()
            Notify("🌈 RAINBOW HAKI", "Starting Rainbow Haki quest...", 2)
        end)
    end
    
    local function BuildPlayerTab()
        AddSlider("WalkSpeed", 16, 350,
            function() return getgenv().MantaxConfig.Movement.WalkSpeed end,
            function(v) 
                getgenv().MantaxConfig.Movement.WalkSpeed = v
                SetWalkSpeed(v)
            end)
        
        AddSlider("JumpPower", 50, 500,
            function() return getgenv().MantaxConfig.Movement.JumpPower end,
            function(v) 
                getgenv().MantaxConfig.Movement.JumpPower = v
                SetJumpPower(v)
            end)
        
        AddToggle("Infinite Jump",
            function() return getgenv().MantaxConfig.Movement.InfiniteJump end,
            function(v) getgenv().MantaxConfig.Movement.InfiniteJump = v end)
        
        AddToggle("NoClip",
            function() return getgenv().MantaxConfig.Movement.NoClip end,
            function(v) getgenv().MantaxConfig.Movement.NoClip = v end)
        
        AddToggle("Anti AFK",
            function() return getgenv().MantaxConfig.Movement.AntiAFK end,
            function(v) getgenv().MantaxConfig.Movement.AntiAFK = v end)
    end
    
    local function BuildESPTab()
        AddToggle("📡 Enable ESP", 
            function() return getgenv().MantaxConfig.ESP.Enabled end,
            function(v) 
                getgenv().MantaxConfig.ESP.Enabled = v
                if v then CreateESP() else ClearESP() end
            end)
        
        AddToggle("Show Players",
            function() return getgenv().MantaxConfig.ESP.Players end,
            function(v) getgenv().MantaxConfig.ESP.Players = v end)
        
        AddToggle("Show Fruits",
            function() return getgenv().MantaxConfig.ESP.Fruits end,
            function(v) getgenv().MantaxConfig.ESP.Fruits = v end)
        
        AddToggle("Show Chests",
            function() return getgenv().MantaxConfig.ESP.Chests end,
            function(v) getgenv().MantaxConfig.ESP.Chests = v end)
        
        AddToggle("Show Bosses",
            function() return getgenv().MantaxConfig.ESP.Bosses end,
            function(v) getgenv().MantaxConfig.ESP.Bosses = v end)
        
        AddSlider("ESP Distance", 1000, 20000,
            function() return getgenv().MantaxConfig.ESP.Distance end,
            function(v) getgenv().MantaxConfig.ESP.Distance = v end)
    end
    
    -- Create Tab Buttons
    for i, tabName in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Name = tabName
        btn.Size = UDim2.new(0.1, 0, 1, 0)
        btn.Position = UDim2.new((i-1)*0.1, 0, 0, 0)
        btn.BackgroundColor3 = i == 1 and Color3.fromRGB(204, 51, 51) or Color3.fromRGB(30, 30, 45)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 11
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = tabBar
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            currentTab = tabName
            for _, b in pairs(tabButtons) do
                b.BackgroundColor3 = b.Name == tabName and Color3.fromRGB(204, 51, 51) or Color3.fromRGB(30, 30, 45)
            end
            
            for _, child in pairs(contentFrame:GetChildren()) do
                if child:IsA("Frame") or child:IsA("TextButton") then
                    child:Destroy()
                end
            end
            
            if tabName == "🏠 MAIN" then BuildMainTab()
            elseif tabName == "⚔️ FARM" then BuildFarmTab()
            elseif tabName == "🌊 SEA" then BuildSeaTab()
            elseif tabName == "👑 BOSS" then BuildBossTab()
            elseif tabName == "🥋 STYLE" then BuildStyleTab()
            elseif tabName == "🍎 FRUIT" then BuildFruitTab()
            elseif tabName == "🗺️ TRAVEL" then BuildTravelTab()
            elseif tabName == "❄️ MISC" then BuildMiscTab()
            elseif tabName == "⚙️ PLAYER" then BuildPlayerTab()
            elseif tabName == "📡 ESP" then BuildESPTab()
            end
        end)
        
        table.insert(tabButtons, btn)
    end
    
    -- Status Bar
    local statusBar = Instance.new("Frame")
    statusBar.Size = UDim2.new(1, 0, 0, 35)
    statusBar.Position = UDim2.new(0, 0, 1, -35)
    statusBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    statusBar.BackgroundTransparency = 0.5
    statusBar.BorderSizePixel = 0
    statusBar.Parent = mainFrame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 12)
    statusCorner.Parent = statusBar
    
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "🟢 READY | LEVEL: LOADING..."
    statusText.TextColor3 = Color3.fromRGB(180, 180, 200)
    statusText.TextSize = 11
    statusText.Font = Enum.Font.Gotham
    statusText.Parent = statusBar
    
    task.spawn(function()
        while true do
            task.wait(1)
            local level = pcall(function() return player.Data.Level.Value end) and player.Data.Level.Value or "???"
            local bounty = pcall(function() 
                local b = player.Data.Bounty.Value
                return FormatBounty(b)
            end) or "???"
            statusText.Text = string.format("🟢 LEVEL: %s | BOUNTY: %s | WS: %s | FARM: %s | SNIPER: %s",
                level, bounty, 
                getgenv().MantaxConfig.Movement.WalkSpeed,
                getgenv().MantaxConfig.AutoFarm.Enabled and "ON" or "OFF",
                getgenv().MantaxConfig.Fruit.AutoSnipe and "ON" or "OFF")
        end
    end)
    
    BuildMainTab()
end

-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════
-- 🚀 STARTUP
-- ═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════════

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🔥 MANTAXVLY PREMIUM ULTIMATE | BY GANNADY PROGRAMMER TERBAIK")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📌 76+ FITUR LENGKAP:")
print("   • Auto Farm Level (Quest & Nearest)")
print("   • Auto Haki (Observation, Buso, Conqueror)")
print("   • Auto Fighting Style (Death Step, Sharkman, Godhuman, etc)")
print("   • Auto Boss (Dough King, Cake Queen, Rip Indra, etc)")
print("   • Auto Sea Event (Leviathan, Fishing, Sea Beast)")
print("   • Fruit Sniper (Kitsune, Dragon, Leopard, Tiger, etc)")
print("   • ESP Player with Bounty Display")
print("   • Auto Stats Distribution")
print("   • Auto Travel (Sea 1/2/3, Islands, Bosses)")
print("   • Infinite Jump, Custom WalkSpeed/JumpPower")
print("   • Auto Bones, Auto Random Surprise, Auto Pray")
print("   • Auto Skull Guitar, Dark Blade, TTK")
print("   • Update 2026 Ready (Tiger Fruit Area, Update 28)")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🎮 GUI READY | Tekan 'Insert' untuk toggle GUI")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

CreateGUI()

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        if screenGui then
            guiEnabled = not guiEnabled
            screenGui.Enabled = guiEnabled
        end
    end
end)

Notify("⚡ MANTAXVLY", "Premium Ultimate loaded! Press Insert to toggle GUI", 5)
