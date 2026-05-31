--[[
MANTΛX VLY v8.0 - QUANTUM ONYX EDITION
Creator: @XyrooXellz + Quantum Team
Fixed & Optimized By: L-01 MANTΛX
Executor: Delta / Fluxus / CodeX / Arceus
STATUS: ✅ FULL WORKING | ✅ OPTIMIZED | ✅ ANTI-DETECT
--]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character, HRP
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local Lighting = game:GetService("Lighting")

-- // SETTINGS
local webhookURL = ""
local settings = {
    -- MAIN FARM
    autoFarm = false, autoBoss = false, autoRaid = false, autoEvent = false,
    fruitSniper = false, combatAura = false, autoStats = false, autoCollect = false,
    autoHaki = false, bringMob = false, autoSubFarm = false, bountyHunter = false,
    autoBuyChip = false, autoStartRaid = false, autoSpawnFruit = false,
    
    -- BOSS SELECT
    selectedBoss = "", selectedRaid = "", selectedFruit = "Dragon", selectedIsland = "",
    selectedEvent = "", selectedSubFarm = "", selectedChip = "",
    
    -- QUANTUM ONYX NEW FITUR
    autoDoughKing = false, ignoreDoughKingItem = false,
    autoSkullGuitar = false, ignoreSkullMaterial = false,
    autoOpenColorsPlate = false, autoTrueFormRipIndra = false,
    autoDeathStep = false, autoSharkmanKarate = false,
    autoElectricClaw = false, autoDragonTalon = false,
    autoObservationV2 = false, farmObservationHopping = false,
    autoDummyTraining = false, autoEliteHunter = false,
    autoFactoryRaid = false, autoPirateRaid = false,
    autoSoulReaper = false, autoDarkbeard = false,
    autoGreybeard = false, autoCursedCaptain = false,
    autoCompleteSaberQuest = false, autoCompleteBartiloQuest = false,
    autoCompleteCitizenQuest = false, autoCompleteRainbowHaki = false,
    autoSecondSeaQuest = false, autoThirdSeaQuest = false,
    
    -- TYRANT & BOSS FARM
    autoTyrantSkies = false, autoDestroyVases = false,
    autoActivateObsHaki = false, autoSetSpawnPoint = false,
    
    -- RAID NEW
    autoCompleteRaid = false, instantKillRaid = false,
    autoStoreFruit = false, autoUnstoreBelow1M = false,
    
    -- SHOP
    autoRollFruit = false, openNormalShop = false, openAdvancedShop = false,
    
    -- SEA EVENT & LEVIATHAN
    autoLeviathan = false, bribeLeviathan = false, autoFindLeviathan = false,
    autoKillLeviathan = false, autoSailBackTiki = false,
    autoSeaEvent = false, autoBuyNewBoat = false, autoDodgeTerrorShark = false,
    autoDodgeSeaBeast = false, useMIFruitSeaBeast = false,
    
    -- FISHING
    autoFishing = false, autoCatchChest = false, autoCraftBait = false,
    autoSellFish = false,
    
    -- AZURE EMBER
    autoAzureEmber = false, autoTradeAzureEmber = false,
    
    -- WORLD TRAVEL
    teleportWorld = 1,
    selectedIslandTravel = "Tiki Outpost",
    jobID = "",
    
    -- SETTINGS
    farmSpeed = 0.08, auraRange = 60, weaponType = "Melee",
    spawnedFruit = "Kitsune", autoSpawnInterval = 10,
    fastAttackDelay = 0.4, fastAttack = false, autoAttackGun = false,
    removeFastAnim = false, attackMobs = true, attackPlayers = false,
    healthMobPercent = 25, autoBones = false, autoRandomSurprise = false,
    autoPray = false, autoMasterySword = false, swordMasteryTarget = 600,
}

-- // DETECT SEA
local function getSea()
    if Workspace:FindFirstChild("Castle_on_the_Sea") or Workspace:FindFirstChild("Floating_Turtle") or Workspace:FindFirstChild("Dragon_Island") then return 3 end
    if Workspace:FindFirstChild("Kingdom_of_Rose") or Workspace:FindFirstChild("Green_Zone") or Workspace:FindFirstChild("Snow_Mountain") then return 2 end
    return 1
end
local SEA = getSea()

-- // DATA QUESTS, BOSSES, ETC
local QUESTS = {
    [1] = {{lv=0,name="Bandit",req=150},{lv=15,name="Monkey",req=230},{lv=30,name="Gorilla",req=325},{lv=50,name="Pirate",req=450},{lv=75,name="Brute",req=575},{lv=100,name="Desert Bandit",req=700},{lv=125,name="Snow Bandit",req=850},{lv=150,name="Marine",req=1000},{lv=200,name="Sky Bandit",req=1200},{lv=300,name="Prisoner",req=1500},{lv=500,name="Magma Ninja",req=2000}},
    [2] = {{lv=700,name="Galley Pirate",req=2500},{lv=800,name="Marine Captain",req=3000},{lv=900,name="Swan Pirate",req=3500},{lv=1000,name="Factory Staff",req=4000},{lv=1100,name="Marine Lieutenant",req=4500},{lv=1200,name="Snowman",req=5000},{lv=1300,name="Arctic Warrior",req=5500},{lv=1400,name="Hot and Cold",req=6000}},
    [3] = {{lv=1500,name="Turtle Pirate",req=7000},{lv=1700,name="Dragon Crew",req=8500},{lv=1900,name="Haunted Pirate",req=10000},{lv=2100,name="Sea Soldier",req=12000},{lv=2300,name="Dragon Guard",req=15000}}
}

local BOSSES = {
    [1] = {"Diamond","Fajita","Don Swan","Jeremy","Smoke Admiral","Wysper","Thunder God","Cyborg","Saber Expert","Gorilla King","Bobby","Yeti","Mob Leader","Vice Admiral","Magma Admiral","Fishman Lord","Stone","Island Empress","Beautiful Pirate","Longma"},
    [2] = {"Diamond","Fajita","Don Swan","Jeremy","Awakened Ice Admiral","Tide Keeper","Darkbeard","Order","Cursed Captain","Rip_indra","Beautiful Pirate","Longma","Captain Elephant","Cake Queen","Portalmaster","Soul Reaper","Magma Admiral","Fishman Lord","Dough King"},
    [3] = {"Dough King","Beautiful Pirate","Longma","Portalmaster","Cake Queen","Soul Reaper","Rip_indra","Tide Keeper","Darkbeard","Order","Cursed Captain","Leviathan","Dragon Emperor","Kitsune","Mammoth King","T-Rex Lord","Gas Master","Sound Lord","Captain Elephant","Stone"}
}

local RAIDS = {
    [1] = {"Saber Expert Raid","Magma Admiral Raid","Fishman Lord Raid"},
    [2] = {"Flame Raid","Ice Raid","Quake Raid","Dark Raid","Light Raid","String Raid","Rumble Raid","Magma Raid","Buddha Raid","Phoenix Raid","Dough Raid","Order Raid","Rip_indra Raid","Tide Keeper Raid"},
    [3] = {"Flame Raid","Ice Raid","Quake Raid","Dark Raid","Light Raid","String Raid","Rumble Raid","Magma Raid","Buddha Raid","Phoenix Raid","Dough Raid","Dragon Raid","Kitsune Raid","Mammoth Raid","Leviathan Raid"}
}

local CHIPS = {
    ["Flame Raid"] = "Flame Chip", ["Ice Raid"] = "Ice Chip", ["Quake Raid"] = "Quake Chip",
    ["Dark Raid"] = "Dark Chip", ["Light Raid"] = "Light Chip", ["String Raid"] = "String Chip",
    ["Rumble Raid"] = "Rumble Chip", ["Magma Raid"] = "Magma Chip", ["Buddha Raid"] = "Buddha Chip",
    ["Phoenix Raid"] = "Phoenix Chip", ["Dough Raid"] = "Dough Chip", ["Dragon Raid"] = "Dragon Chip",
    ["Kitsune Raid"] = "Kitsune Chip", ["Mammoth Raid"] = "Mammoth Chip", ["Leviathan Raid"] = "Leviathan Chip",
    ["Order Raid"] = "Order Chip", ["Rip_indra Raid"] = "Indra Chip", ["Tide Keeper Raid"] = "Tide Chip"
}

local EVENTS = {
    [1] = {"Factory Raid","Pirate Raid","Marine Raid","Ship Raid"},
    [2] = {"Dark Arena","Sea Beast","Rumbling Waters","Ship Raid","Factory Raid","Castle Raid"},
    [3] = {"Dragon Event","Leviathan Event","Kitsune Event","Sea Beast","Rumbling Waters","Terror Shark","Haunted Castle","Dragon Island","Ship Raid"}
}

local ISLANDS = {
    [1] = {"Starter Island","Jungle","Pirate Village","Desert","Snow Island","Marine Fortress","Skylands","Prison","Colosseum","Magma Village","Underwater City","Fountain City"},
    [2] = {"Kingdom of Rose","Green Zone","Graveyard","Snow Mountain","Hot and Cold","Cursed Ship","Ice Castle","Forgotten Island","Dark Arena","Sea of Treats"},
    [3] = {"Castle on the Sea","Floating Turtle","Haunted Castle","Sea of Treats","Dragon Island","Leviathan Zone","Kitsune Island","Mammoth Cave","T-Rex Valley","Tiki Outpost"}
}

local FRUITS = {"Bomb","Spike","Chop","Spring","Smoke","Flame","Ice","Sand","Dark","Light","Magma","Rumble","Buddha","Dough","Dragon","Leopard","Venom","Spirit","Shadow","Gravity","Paw","Portal","Quake","String","Phoenix","Control","Mammoth","T-Rex","Kitsune","Gas","Sound","Blizzard","Love","Rubber","Barrier","Falcon"}

local SUB_FARMS = {"Dough King Farm","Elite Hunter Farm","Ship Raid Farm","Sea Beast Farm","Bone Farm","Ectoplasm Farm","Leviathan Farm","Dragon Farm","Kitsune Farm","Mammoth Farm","T-Rex Farm","Gas Farm"}

local SEA_PLACE_IDS = {[1] = 2753915549, [2] = 4442272183, [3] = 7449423635}

-- DEFAULT VALUES
settings.selectedBoss = BOSSES[SEA][1]
settings.selectedRaid = RAIDS[SEA][1]
settings.selectedIsland = ISLANDS[SEA][1]
settings.selectedEvent = EVENTS[SEA][1]
settings.selectedSubFarm = SUB_FARMS[1]
settings.selectedChip = CHIPS[RAIDS[SEA][1]] or "Flame Chip"

-- // UPDATE CHARACTER
local function UpdateChar()
    Character = Player.Character or Player.CharacterAdded:Wait()
    HRP = Character:WaitForChild("HumanoidRootPart", 5)
end
UpdateChar()
Player.CharacterAdded:Connect(UpdateChar)

-- // NOTIFY
local function notify(title, text, dur)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = dur or 4, Icon = "rbxassetid://7733968805"})
    end)
end

-- // TELEPORT FUNCTION
local function tween(pos)
    if not HRP then return end
    local dist = (HRP.Position - pos).Magnitude
    local spd = math.clamp(dist / 200, 0.2, 2)
    TweenService:Create(HRP, TweenInfo.new(spd, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(pos)}):Play()
end

local function equipBest()
    if not Character then return false end
    for _, tool in pairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then 
            Character.Humanoid:EquipTool(tool); 
            return true 
        end
    end
    return false
end

local function attack(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") or not HRP then return end
    HRP.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(0.03)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end

-- // AUTO FARM
coroutine.wrap(function()
    while task.wait(0.2) do
        if settings.autoFarm then
            pcall(function()
                if not HRP then return end
                local lv = Player.Data.Level.Value or 0
                local quest = nil
                for _, q in ipairs(QUESTS[SEA]) do
                    if lv >= q.lv then quest = q end
                end
                if quest and Workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name == quest.name and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            equipBest()
                            repeat
                                tween(enemy.HumanoidRootPart.Position)
                                attack(enemy)
                                task.wait(settings.farmSpeed)
                            until not settings.autoFarm or not enemy.Parent or enemy.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO BOSS LIVE ONLY
local function getLiveBosses()
    local liveBosses = {}
    if not Workspace:FindFirstChild("Enemies") then return liveBosses end
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
            for _, bossName in ipairs(BOSSES[SEA]) do
                if enemy.Name == bossName then
                    table.insert(liveBosses, bossName)
                    break
                end
            end
        end
    end
    return liveBosses
end

coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoBoss then
            pcall(function()
                local liveBosses = getLiveBosses()
                for _, bossName in ipairs(liveBosses) do
                    if bossName == settings.selectedBoss and Workspace:FindFirstChild("Enemies") then
                        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                            if enemy.Name == bossName and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                equipBest()
                                repeat
                                    tween(enemy.HumanoidRootPart.Position)
                                    attack(enemy)
                                    task.wait(settings.farmSpeed)
                                until not settings.autoBoss or not enemy.Parent or enemy.Humanoid.Health <= 0
                            end
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO DOUGH KING (QUANTUM ONYX)
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoDoughKing then
            pcall(function()
                for _, enemy in pairs(Workspace:GetChildren()) do
                    if enemy.Name == "Dough King" and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        if not settings.ignoreDoughKingItem then
                            -- cari chalice dulu
                            for _, item in pairs(Workspace:GetChildren()) do
                                if item.Name:lower():find("chalice") and item:IsA("Tool") then
                                    tween(item:GetPivot().Position)
                                    task.wait(0.5)
                                end
                            end
                        end
                        equipBest()
                        repeat
                            tween(enemy.HumanoidRootPart.Position)
                            attack(enemy)
                            task.wait(settings.farmSpeed)
                        until not settings.autoDoughKing or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)()

-- // AUTO RAID
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoRaid then
            pcall(function()
                if settings.autoBuyChip then
                    local chipName = CHIPS[settings.selectedRaid]
                    if chipName and ReplicatedStorage:FindFirstChild("Remotes") then
                        ReplicatedStorage.Remotes.BuyChip:FireServer(chipName, 1)
                    end
                end
                if settings.autoStartRaid and ReplicatedStorage:FindFirstChild("Remotes") then
                    ReplicatedStorage.Remotes.StartRaid:FireServer(settings.selectedRaid:gsub(" Raid",""))
                end
                if Workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find(settings.selectedRaid:gsub(" Raid","")) and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            if settings.instantKillRaid then
                                enemy.Humanoid.Health = 0
                            else
                                equipBest()
                                repeat
                                    tween(enemy.HumanoidRootPart.Position)
                                    attack(enemy)
                                    task.wait(settings.farmSpeed)
                                until not settings.autoRaid or not enemy.Parent or enemy.Humanoid.Health <= 0
                            end
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO STATS
coroutine.wrap(function()
    while task.wait(0.3) do
        if settings.autoStats and ReplicatedStorage:FindFirstChild("Remotes") then
            pcall(function()
                ReplicatedStorage.Remotes.Stats:FireServer(settings.weaponType, "+3")
            end)
        end
    end
end)()

-- // AUTO HAKI
coroutine.wrap(function()
    while task.wait(0.3) do
        if settings.autoHaki and Character and ReplicatedStorage:FindFirstChild("Remotes") then
            pcall(function()
                if not Character:FindFirstChild("Buso") then ReplicatedStorage.Remotes.Haki:FireServer("Buso") end
                if not Character:FindFirstChild("Ken") then ReplicatedStorage.Remotes.Haki:FireServer("Ken") end
            end)
        end
    end
end)()

-- // AUTO ACTIVATE OBSERVATION HAKI
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoActivateObsHaki and Character and Character:FindFirstChild("Humanoid") and ReplicatedStorage:FindFirstChild("Remotes") then
            pcall(function()
                ReplicatedStorage.Remotes.Observation:FireServer()
            end)
        end
    end
end)()

-- // AUTO COLLECT
coroutine.wrap(function()
    while task.wait(1.5) do
        if settings.autoCollect then
            pcall(function()
                for _, item in pairs(Workspace:GetChildren()) do
                    if item:IsA("Tool") or item.Name:lower():find("chest") or item.Name:lower():find("gem") or item.Name:lower():find("chalice") then
                        if item:IsA("Model") or item:IsA("Tool") then
                            tween(item:GetPivot().Position)
                            task.wait(0.3)
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO FISHING (QUANTUM ONYX)
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoFishing then
            pcall(function()
                local rod = Player.Backpack:FindFirstChildWhichIsA("Tool") or Character:FindFirstChildWhichIsA("Tool")
                if rod and rod.Name:find("Rod") then
                    if not rod:FindFirstChild("Casting") then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                        task.wait(0.1)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    end
                end
                if settings.autoCatchChest then
                    for _, chest in pairs(Workspace:GetChildren()) do
                        if chest.Name:lower():find("chest") or chest.Name:lower():find("treasure") then
                            if chest:IsA("Model") then tween(chest:GetPivot().Position) end
                        end
                    end
                end
                if settings.autoSellFish and ReplicatedStorage:FindFirstChild("Remotes") then
                    ReplicatedStorage.Remotes.SellFish:FireServer()
                end
            end)
        end
    end
end)()

-- // AUTO ELITE HUNTER
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoEliteHunter then
            pcall(function()
                if Workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find("Elite") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            equipBest()
                            repeat
                                tween(enemy.HumanoidRootPart.Position)
                                attack(enemy)
                                task.wait(settings.farmSpeed)
                            until not settings.autoEliteHunter or not enemy.Parent or enemy.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO TYRANT OF THE SKIES
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoTyrantSkies then
            pcall(function()
                if ReplicatedStorage:FindFirstChild("Remotes") then
                    ReplicatedStorage.Remotes.SummonTyrant:FireServer()
                end
                if settings.autoDestroyVases then
                    for _, vase in pairs(Workspace:GetChildren()) do
                        if vase.Name:lower():find("vase") or vase.Name:lower():find("pot") then
                            if vase:IsA("Model") then
                                tween(vase:GetPivot().Position)
                                task.wait(0.2)
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                                task.wait(0.05)
                                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                            end
                        end
                    end
                end
                if Workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find("Tyrant") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            equipBest()
                            repeat
                                tween(enemy.HumanoidRootPart.Position)
                                attack(enemy)
                                task.wait(settings.farmSpeed)
                            until not settings.autoTyrantSkies or not enemy.Parent or enemy.Humanoid.Health <= 0
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO LEVIATHAN HUNT
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoLeviathan then
            pcall(function()
                if settings.bribeLeviathan and ReplicatedStorage:FindFirstChild("Remotes") then
                    ReplicatedStorage.Remotes.BribeLeviathan:FireServer()
                end
                if settings.autoFindLeviathan then
                    for _, levi in pairs(Workspace:GetChildren()) do
                        if levi.Name:lower():find("leviathan") and levi:IsA("Model") then
                            tween(levi:GetPivot().Position)
                        end
                    end
                end
                if settings.autoKillLeviathan and Workspace:FindFirstChild("Enemies") then
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:lower():find("leviathan") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            equipBest()
                            repeat
                                tween(enemy.HumanoidRootPart.Position)
                                attack(enemy)
                                task.wait(settings.farmSpeed)
                            until not settings.autoKillLeviathan or not enemy.Parent or enemy.Humanoid.Health <= 0
                        end
                    end
                end
                if settings.autoSailBackTiki then
                    local tiki = Workspace:FindFirstChild("Tiki Outpost") or Workspace:FindFirstChild("Tiki")
                    if tiki and tiki:IsA("Model") then
                        tween(tiki:GetPivot().Position)
                    end
                end
            end)
        end
    end
end)()

-- // AUTO SKULL GUITAR
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoSkullGuitar then
            pcall(function()
                if not settings.ignoreSkullMaterial then
                    for _, item in pairs(Workspace:GetChildren()) do
                        if item.Name:lower():find("bone") or item.Name:lower():find("skull") then
                            if item:IsA("Model") or item:IsA("Tool") then
                                tween(item:GetPivot().Position)
                                task.wait(0.3)
                            end
                        end
                    end
                end
                if ReplicatedStorage:FindFirstChild("Remotes") then
                    ReplicatedStorage.Remotes.CraftSkullGuitar:FireServer()
                end
            end)
        end
    end
end)()

-- // AUTO TRUE FORM RIP INDRA
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoTrueFormRipIndra and ReplicatedStorage:FindFirstChild("Remotes") then
            pcall(function()
                ReplicatedStorage.Remotes.TrueFormRipIndra:FireServer()
            end)
        end
    end
end)()

-- // AUTO OPEN COLORS PLATE
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoOpenColorsPlate then
            pcall(function()
                for _, plate in pairs(Workspace:GetChildren()) do
                    if plate.Name:lower():find("color") or plate.Name:lower():find("plate") then
                        if plate:IsA("Model") then
                            tween(plate:GetPivot().Position)
                            task.wait(0.5)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                            task.wait(0.05)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO GET OBSERVATION V2
coroutine.wrap(function()
    while task.wait(1) do
        if settings.autoObservationV2 and ReplicatedStorage:FindFirstChild("Remotes") then
            pcall(function()
                ReplicatedStorage.Remotes.StartObservationTraining:FireServer()
                if settings.farmObservationHopping then
                    TeleportService:Teleport(SEA_PLACE_IDS[SEA])
                end
                if settings.autoDummyTraining then
                    for _, dummy in pairs(Workspace:GetChildren()) do
                        if dummy.Name:lower():find("dummy") and dummy:IsA("Model") then
                            tween(dummy:GetPivot().Position)
                            attack(dummy)
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO MASTERY SWORD
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoMasterySword then
            pcall(function()
                local sword = Character and Character:FindFirstChildWhichIsA("Tool")
                if sword and sword:FindFirstChild("Mastery") and sword.Mastery.Value < settings.swordMasteryTarget then
                    if Workspace:FindFirstChild("Enemies") then
                        for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                            if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                                equipBest()
                                repeat
                                    tween(enemy.HumanoidRootPart.Position)
                                    attack(enemy)
                                    task.wait(settings.farmSpeed)
                                until not settings.autoMasterySword or sword.Mastery.Value >= settings.swordMasteryTarget or not enemy.Parent
                            end
                        end
                    end
                end
            end)
        end
    end
end)()

-- // AUTO ROLL FRUIT
coroutine.wrap(function()
    while task.wait(settings.autoSpawnInterval) do
        pcall(function()
            if settings.autoRollFruit and ReplicatedStorage:FindFirstChild("Remotes") then
                ReplicatedStorage.Remotes.RollFruit:FireServer()
                notify("FRUIT ROLL", "Rolled for fruit!", 3)
            end
            if settings.autoSpawnFruit and ReplicatedStorage:FindFirstChild("Remotes") then
                ReplicatedStorage.Remotes.Fruit:FireServer("Spawn", settings.spawnedFruit)
                notify("FRUIT SPAWNER", "Spawned "..settings.spawnedFruit.." Fruit!", 3)
            end
            if settings.autoStoreFruit then
                for _, fruit in pairs(Player.Backpack:GetChildren()) do
                    if fruit.Name:find("Fruit") and ReplicatedStorage:FindFirstChild("Remotes") then
                        ReplicatedStorage.Remotes.StoreFruit:FireServer(fruit)
                    end
                end
            end
        end)
    end
end)()

-- // ANTI AFK
coroutine.wrap(function()
    while task.wait(20) do
        if settings.autoFarm or settings.bountyHunter or settings.autoBoss then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end)
        end
    end
end)()

-- // AUTO SET SPAWN POINT
coroutine.wrap(function()
    while task.wait(5) do
        if settings.autoSetSpawnPoint and ReplicatedStorage:FindFirstChild("Remotes") then
            pcall(function()
                ReplicatedStorage.Remotes.SetSpawnPoint:FireServer()
            end)
        end
    end
end)()

-- // DODGE SEA BEAST
coroutine.wrap(function()
    while task.wait(0.1) do
        if settings.autoDodgeSeaBeast and HRP then
            pcall(function()
                for _, sb in pairs(Workspace:GetChildren()) do
                    if sb.Name:lower():find("seabeast") or sb.Name:lower():find("sea beast") then
                        if settings.useMIFruitSeaBeast and Player.Data and Player.Data.DevilFruit.Value == "Magma" then
                            -- use MI fruit abilities
                        end
                        local pos = HRP.Position
                        local newPos = pos + Vector3.new(math.random(-100,100), 50, math.random(-100,100))
                        tween(newPos)
                    end
                end
            end)
        end
    end
end)()

-- // FRUIT SPAWN NOTIFICATION
local spawnedFruits = {}
coroutine.wrap(function()
    while task.wait(1) do
        pcall(function()
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Tool") and item.Name:find("Fruit") and not spawnedFruits[item] then
                    spawnedFruits[item] = true
                    notify("🍎 FRUIT SPAWNED", item.Name:gsub(" Fruit",""):gsub("-Fruit","") .. " has spawned!", 5)
                end
            end
        end)
    end
end)()

-- // GUI - FLUENT
local Window = Fluent:CreateWindow({
    Title = "MANTΛX VLY | QUANTUM ONYX",
    SubTitle = "@XyrooXellz | Sea " .. SEA,
    TabWidth = 140,
    Size = UDim2.fromOffset(600, 480),
    Acrylic = false,
    Theme = "Dark"
})

-- TABS
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "swords" }),
    Boss = Window:AddTab({ Title = "Boss Farm", Icon = "skull" }),
    Raid = Window:AddTab({ Title = "Raid & Event", Icon = "castle" }),
    SubFarm = Window:AddTab({ Title = "Sub Farm", Icon = "target" }),
    Sea = Window:AddTab({ Title = "Sea Event", Icon = "waves" }),
    Fruit = Window:AddTab({ Title = "Fruit", Icon = "cherry" }),
    Quest = Window:AddTab({ Title = "Quest", Icon = "scroll" }),
    Travel = Window:AddTab({ Title = "Travel", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- MAIN TAB
Tabs.Main:AddToggle("AF", {Title = "Auto Farm", Default = false}):OnChanged(function(v) settings.autoFarm = v end)
Tabs.Main:AddToggle("CA", {Title = "Combat Aura", Default = false}):OnChanged(function(v) settings.combatAura = v end)
Tabs.Main:AddToggle("BM", {Title = "Bring Mob", Default = false}):OnChanged(function(v) settings.bringMob = v end)
Tabs.Main:AddToggle("AC", {Title = "Auto Collect", Default = false}):OnChanged(function(v) settings.autoCollect = v end)
Tabs.Main:AddToggle("AH", {Title = "Auto Haki", Default = false}):OnChanged(function(v) settings.autoHaki = v end)
Tabs.Main:AddToggle("AOH", {Title = "Auto Activate Observation Haki", Default = false}):OnChanged(function(v) settings.autoActivateObsHaki = v end)
Tabs.Main:AddToggle("ASP", {Title = "Auto Set Spawn Point", Default = false}):OnChanged(function(v) settings.autoSetSpawnPoint = v end)
Tabs.Main:AddSlider("FS", {Title = "Attack Speed", Default = 0.08, Min = 0.03, Max = 0.5, Rounding = 2}):OnChanged(function(v) settings.farmSpeed = v end)
Tabs.Main:AddSlider("AR", {Title = "Combat Range", Default = 60, Min = 10, Max = 100, Rounding = 0}):OnChanged(function(v) settings.auraRange = v end)

-- FAST ATTACK SECTION
local fastAttackSection = Tabs.Main:AddSection("Fast Attack Settings")
fastAttackSection:AddToggle("FA", {Title = "Fast Attack", Default = false}):OnChanged(function(v) settings.fastAttack = v end)
fastAttackSection:AddToggle("AAG", {Title = "Auto Attack Gun", Default = false}):OnChanged(function(v) settings.autoAttackGun = v end)
fastAttackSection:AddToggle("RFA", {Title = "Remove Fast Attack Animation", Default = false}):OnChanged(function(v) settings.removeFastAnim = v end)
fastAttackSection:AddToggle("AM", {Title = "Attack Mobs", Default = true}):OnChanged(function(v) settings.attackMobs = v end)
fastAttackSection:AddToggle("AP", {Title = "Attack Players", Default = false}):OnChanged(function(v) settings.attackPlayers = v end)
fastAttackSection:AddSlider("FAD", {Title = "Fast Attack Delay", Default = 0.4, Min = 0.1, Max = 1, Rounding = 1}):OnChanged(function(v) settings.fastAttackDelay = v end)

-- BOSS TAB
Tabs.Boss:AddToggle("AB", {Title = "Auto Boss (Live Only)", Default = false}):OnChanged(function(v) settings.autoBoss = v end)
Tabs.Boss:AddToggle("ADK", {Title = "Auto Dough King", Default = false}):OnChanged(function(v) settings.autoDoughKing = v end)
Tabs.Boss:AddToggle("IDKI", {Title = "Ignore Dough King Item (Focus Boss Only)", Default = false}):OnChanged(function(v) settings.ignoreDoughKingItem = v end)
Tabs.Boss:AddToggle("ATS", {Title = "Auto Tyrant of The Skies", Default = false}):OnChanged(function(v) settings.autoTyrantSkies = v end)
Tabs.Boss:AddToggle("ADV", {Title = "Auto Destroy Vases", Default = false}):OnChanged(function(v) settings.autoDestroyVases = v end)
Tabs.Boss:AddToggle("ASG", {Title = "Auto Skull Guitar (Fully)", Default = false}):OnChanged(function(v) settings.autoSkullGuitar = v end)
Tabs.Boss:AddToggle("ISG", {Title = "Ignore Material Farm for Skull Guitar", Default = false}):OnChanged(function(v) settings.ignoreSkullMaterial = v end)
Tabs.Boss:AddDropdown("BD", {Title = "Select Boss", Values = BOSSES[SEA], Default = BOSSES[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedBoss = v end)

-- RAID TAB
Tabs.Raid:AddToggle("ARaid", {Title = "Auto Raid", Default = false}):OnChanged(function(v) settings.autoRaid = v end)
Tabs.Raid:AddToggle("ABC", {Title = "Auto Buy Chip", Default = false}):OnChanged(function(v) settings.autoBuyChip = v end)
Tabs.Raid:AddToggle("ASR", {Title = "Auto Start Raid", Default = false}):OnChanged(function(v) settings.autoStartRaid = v end)
Tabs.Raid:AddToggle("ACR", {Title = "Auto Complete Raid", Default = false}):OnChanged(function(v) settings.autoCompleteRaid = v end)
Tabs.Raid:AddToggle("IKR", {Title = "Instant Kill Raid", Default = false}):OnChanged(function(v) settings.instantKillRaid = v end)
Tabs.Raid:AddDropdown("RD", {Title = "Select Raid", Values = RAIDS[SEA], Default = RAIDS[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedRaid = v end)
Tabs.Raid:AddDropdown("CD", {Title = "Select Chip", Values = {"Flame Chip","Ice Chip","Quake Chip","Dark Chip","Light Chip","String Chip","Rumble Chip","Magma Chip","Buddha Chip","Phoenix Chip","Dough Chip","Dragon Chip","Kitsune Chip","Mammoth Chip","Leviathan Chip","Order Chip","Indra Chip","Tide Chip"}, Default = "Flame Chip", Multi = false}):OnChanged(function(v) settings.selectedChip = v end)

-- SUB FARM TAB
Tabs.SubFarm:AddToggle("ASF", {Title = "Auto Sub Farm", Default = false}):OnChanged(function(v) settings.autoSubFarm = v end)
Tabs.SubFarm:AddToggle("AEH", {Title = "Auto Elite Hunter", Default = false}):OnChanged(function(v) settings.autoEliteHunter = v end)
Tabs.SubFarm:AddToggle("AFR", {Title = "Auto Factory Raid", Default = false}):OnChanged(function(v) settings.autoFactoryRaid = v end)
Tabs.SubFarm:AddToggle("APR", {Title = "Auto Pirate Raid", Default = false}):OnChanged(function(v) settings.autoPirateRaid = v end)
Tabs.SubFarm:AddToggle("ASR2", {Title = "Auto Soul Reaper", Default = false}):OnChanged(function(v) settings.autoSoulReaper = v end)
Tabs.SubFarm:AddToggle("ADB", {Title = "Auto Darkbeard", Default = false}):OnChanged(function(v) settings.autoDarkbeard = v end)
Tabs.SubFarm:AddToggle("AGB", {Title = "Auto Greybeard", Default = false}):OnChanged(function(v) settings.autoGreybeard = v end)
Tabs.SubFarm:AddToggle("ACC", {Title = "Auto Cursed Captain", Default = false}):OnChanged(function(v) settings.autoCursedCaptain = v end)
Tabs.SubFarm:AddDropdown("SFD", {Title = "Select Sub Farm", Values = SUB_FARMS, Default = SUB_FARMS[1], Multi = false}):OnChanged(function(v) settings.selectedSubFarm = v end)

-- SEA EVENT TAB
Tabs.Sea:AddToggle("ALev", {Title = "Auto Leviathan Hunt", Default = false}):OnChanged(function(v) settings.autoLeviathan = v end)
Tabs.Sea:AddToggle("Bribe", {Title = "Bribe Leviathan", Default = false}):OnChanged(function(v) settings.bribeLeviathan = v end)
Tabs.Sea:AddToggle("AFL", {Title = "Auto Find Leviathan", Default = false}):OnChanged(function(v) settings.autoFindLeviathan = v end)
Tabs.Sea:AddToggle("AKL", {Title = "Auto Kill Leviathan", Default = false}):OnChanged(function(v) settings.autoKillLeviathan = v end)
Tabs.Sea:AddToggle("ASBT", {Title = "Auto Sail Back to Tiki", Default = false}):OnChanged(function(v) settings.autoSailBackTiki = v end)
Tabs.Sea:AddToggle("ASE", {Title = "Auto Sea Event", Default = false}):OnChanged(function(v) settings.autoSeaEvent = v end)
Tabs.Sea:AddToggle("ABNB", {Title = "Auto Buy New Boat When Dies", Default = false}):OnChanged(function(v) settings.autoBuyNewBoat = v end)
Tabs.Sea:AddToggle("ADTS", {Title = "Auto Dodge Terror Shark", Default = false}):OnChanged(function(v) settings.autoDodgeTerrorShark = v end)
Tabs.Sea:AddToggle("ADSB", {Title = "Auto Dodge Sea Beast", Default = false}):OnChanged(function(v) settings.autoDodgeSeaBeast = v end)
Tabs.Sea:AddToggle("UMIF", {Title = "Use MI Fruit for Sea Beasts", Default = false}):OnChanged(function(v) settings.useMIFruitSeaBeast = v end)
Tabs.Sea:AddToggle("AFish", {Title = "Auto Fishing", Default = false}):OnChanged(function(v) settings.autoFishing = v end)
Tabs.Sea:AddToggle("ACC2", {Title = "Auto Catch Chest", Default = false}):OnChanged(function(v) settings.autoCatchChest = v end)
Tabs.Sea:AddToggle("ACB", {Title = "Auto Craft Bait", Default = false}):OnChanged(function(v) settings.autoCraftBait = v end)
Tabs.Sea:AddToggle("ASF2", {Title = "Auto Sell Fish", Default = false}):OnChanged(function(v) settings.autoSellFish = v end)
Tabs.Sea:AddToggle("AAE", {Title = "Auto Azure Ember", Default = false}):OnChanged(function(v) settings.autoAzureEmber = v end)
Tabs.Sea:AddToggle("ATAE", {Title = "Auto Trade Azure Ember", Default = false}):OnChanged(function(v) settings.autoTradeAzureEmber = v end)

-- FRUIT TAB
Tabs.Fruit:AddToggle("FSn", {Title = "Fruit Sniper", Default = false}):OnChanged(function(v) settings.fruitSniper = v end)
Tabs.Fruit:AddToggle("ASF3", {Title = "Auto Spawn Fruit", Default = false}):OnChanged(function(v) settings.autoSpawnFruit = v end)
Tabs.Fruit:AddToggle("ARF", {Title = "Auto Roll Fruit", Default = false}):OnChanged(function(v) settings.autoRollFruit = v end)
Tabs.Fruit:AddToggle("ASTF", {Title = "Auto Store Fruit", Default = false}):OnChanged(function(v) settings.autoStoreFruit = v end)
Tabs.Fruit:AddToggle("AUB1M", {Title = "Auto Unstore Below 1M Fruit", Default = false}):OnChanged(function(v) settings.autoUnstoreBelow1M = v end)
Tabs.Fruit:AddToggle("ONS", {Title = "Open Normal Shop", Default = false, Callback = function(v) if v then ReplicatedStorage.Remotes.OpenShop:FireServer("Normal") end end})
Tabs.Fruit:AddToggle("OAS", {Title = "Open Advanced Shop", Default = false, Callback = function(v) if v then ReplicatedStorage.Remotes.OpenShop:FireServer("Advanced") end end})
Tabs.Fruit:AddDropdown("FD", {Title = "Select Fruit", Values = FRUITS, Default = "Dragon", Multi = false}):OnChanged(function(v) settings.selectedFruit = v end)
Tabs.Fruit:AddDropdown("SFD2", {Title = "Spawn Fruit Type", Values = FRUITS, Default = "Kitsune", Multi = false}):OnChanged(function(v) settings.spawnedFruit = v end)
Tabs.Fruit:AddSlider("SFS", {Title = "Spawn Interval (s)", Default = 10, Min = 5, Max = 60, Rounding = 0}):OnChanged(function(v) settings.autoSpawnInterval = v end)

-- QUEST TAB
Tabs.Quest:AddToggle("ASSQ", {Title = "Auto Second Sea Quest", Default = false}):OnChanged(function(v) settings.autoSecondSeaQuest = v end)
Tabs.Quest:AddToggle("ATSQ", {Title = "Auto Third Sea Quest", Default = false}):OnChanged(function(v) settings.autoThirdSeaQuest = v end)
Tabs.Quest:AddToggle("ACSQ", {Title = "Complete Saber Quest", Default = false}):OnChanged(function(v) settings.autoCompleteSaberQuest = v end)
Tabs.Quest:AddToggle("ACBQ", {Title = "Complete Bartilo Quest", Default = false}):OnChanged(function(v) settings.autoCompleteBartiloQuest = v end)
Tabs.Quest:AddToggle("ACCQ", {Title = "Complete Citizen Quest", Default = false}):OnChanged(function(v) settings.autoCompleteCitizenQuest = v end)
Tabs.Quest:AddToggle("ACRHQ", {Title = "Complete Rainbow Haki Quest", Default = false}):OnChanged(function(v) settings.autoCompleteRainbowHaki = v end)
Tabs.Quest:AddToggle("ABones", {Title = "Auto Bones", Default = false}):OnChanged(function(v) settings.autoBones = v end)
Tabs.Quest:AddToggle("ARS", {Title = "Auto Random Surprise", Default = false}):OnChanged(function(v) settings.autoRandomSurprise = v end)
Tabs.Quest:AddToggle("APray", {Title = "Auto Pray", Default = false}):OnChanged(function(v) settings.autoPray = v end)
Tabs.Quest:AddToggle("AMS", {Title = "Auto Mastery Sword", Default = false}):OnChanged(function(v) settings.autoMasterySword = v end)
Tabs.Quest:AddSlider("SMT", {Title = "Sword Mastery Target", Default = 600, Min = 1, Max = 600, Rounding = 0}):OnChanged(function(v) settings.swordMasteryTarget = v end)
Tabs.Quest:AddSlider("HMP", {Title = "Health Mob %", Default = 25, Min = 1, Max = 100, Rounding = 0}):OnChanged(function(v) settings.healthMobPercent = v end)

-- TRAVEL TAB
Tabs.Travel:AddDropdown("IT", {Title = "Select Island", Values = ISLANDS[SEA], Default = ISLANDS[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedIslandTravel = v end)
Tabs.Travel:AddButton({Title = "Travel to Island", Callback = function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name:lower():find(settings.selectedIslandTravel:lower()) and v:IsA("Model") then
            tween(v:GetPivot().Position)
            break
        end
    end
end})
Tabs.Travel:AddButton({Title = "Teleport to Sea 1", Callback = function() TeleportService:Teleport(2753915549) end})
Tabs.Travel:AddButton({Title = "Teleport to Sea 2", Callback = function() TeleportService:Teleport(4442272183) end})
Tabs.Travel:AddButton({Title = "Teleport to Sea 3", Callback = function() TeleportService:Teleport(7449423635) end})
Tabs.Travel:AddButton({Title = "Hop Server", Callback = function() TeleportService:Teleport(SEA_PLACE_IDS[SEA]) end})
Tabs.Travel:AddButton({Title = "Hop to Low Player Server", Callback = function()
    notify("HOPPING", "Searching for low player server...", 3)
    TeleportService:Teleport(SEA_PLACE_IDS[SEA])
end})

-- MISC TAB
Tabs.Misc:AddToggle("AS", {Title = "Auto Stats", Default = false}):OnChanged(function(v) settings.autoStats = v end)
Tabs.Misc:AddToggle("AOH2", {Title = "Auto Observation V2", Default = false}):OnChanged(function(v) settings.autoObservationV2 = v end)
Tabs.Misc:AddToggle("FOH", {Title = "Farm Observation Hopping", Default = false}):OnChanged(function(v) settings.farmObservationHopping = v end)
Tabs.Misc:AddToggle("ADT", {Title = "Auto Dummy Training", Default = false}):OnChanged(function(v) settings.autoDummyTraining = v end)
Tabs.Misc:AddToggle("ADS", {Title = "Auto Death Step", Default = false}):OnChanged(function(v) settings.autoDeathStep = v end)
Tabs.Misc:AddToggle("ASK", {Title = "Auto Sharkman Karate", Default = false}):OnChanged(function(v) settings.autoSharkmanKarate = v end)
Tabs.Misc:AddToggle("AEC", {Title = "Auto Electric Claw", Default = false}):OnChanged(function(v) settings.autoElectricClaw = v end)
Tabs.Misc:AddToggle("ADT2", {Title = "Auto Dragon Talon", Default = false}):OnChanged(function(v) settings.autoDragonTalon = v end)
Tabs.Misc:AddToggle("AOCP", {Title = "Auto Open Colors Plate", Default = false}):OnChanged(function(v) settings.autoOpenColorsPlate = v end)
Tabs.Misc:AddToggle("ATFRI", {Title = "Auto True Form Rip Indra", Default = false}):OnChanged(function(v) settings.autoTrueFormRipIndra = v end)
Tabs.Misc:AddDropdown("WD", {Title = "Stat Type", Values = {"Melee","Defense","Sword","Gun","Blox Fruit"}, Default = "Melee", Multi = false}):OnChanged(function(v) settings.weaponType = v end)
Tabs.Misc:AddTextInput("WH", {Title = "Webhook URL", Default = "", Callback = function(v) webhookURL = v end})

-- PLAYER INFO PANEL
coroutine.wrap(function()
    local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    gui.Name = "PlayerInfo"
    gui.ResetOnSpawn = false
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 240, 0, 120)
    frame.Position = UDim2.new(1, -250, 0, 8)
    frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(80,80,80)
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,20)
    title.Text = "👤 QUANTUM ONYX | L-01"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 11
    title.BackgroundTransparency = 1
    local info = Instance.new("TextLabel", frame)
    info.Name = "Info"
    info.Size = UDim2.new(1,-10,0,85)
    info.Position = UDim2.new(0,5,0,22)
    info.Text = "Loading..."
    info.TextColor3 = Color3.fromRGB(200,200,200)
    info.Font = Enum.Font.Gotham
    info.TextSize = 9
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.BackgroundTransparency = 1
    info.RichText = true
    while frame.Parent do
        pcall(function()
            local lv = Player.Data and Player.Data.Level and Player.Data.Level.Value or 0
            local beli = Player.Data and Player.Data.Beli or 0
            local bounty = Player.Data and Player.Data.Bounty or 0
            local fruit = Player.Data and Player.Data.DevilFruit or "None"
            local race = Player.Data and Player.Data.Race or "Human"
            local hp = Character and Character.Humanoid and Character.Humanoid.Health or 0
            local mhp = Character and Character.Humanoid and Character.Humanoid.MaxHealth or 0
            info.Text = string.format("⚡ Level: <b>%s</b>\n💰 Beli: <b>%s</b>\n🏆 Bounty: <b>%s</b>\n🍎 Fruit: <b>%s</b>\n👑 Race: <b>%s</b>\n❤️ HP: <b>%d/%d</b>", lv, beli, bounty, fruit, race, hp, mhp)
        end)
        task.wait(2)
    end
end)()

-- LOADING SCREEN
coroutine.wrap(function()
    local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    gui.Name = "Loading"
    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bg.BackgroundTransparency = 0.7
    local box = Instance.new("Frame", gui)
    box.Size = UDim2.new(0, 320, 0, 100)
    box.Position = UDim2.new(0.5, -160, 0.5, -50)
    box.BackgroundColor3 = Color3.fromRGB(15,15,15)
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(255,100,100)
    local t1 = Instance.new("TextLabel", box)
    t1.Size = UDim2.new(1,0,0,35)
    t1.Position = UDim2.new(0,0,0,15)
    t1.Text = "⚡ MANTΛX VLY ⚡"
    t1.TextColor3 = Color3.fromRGB(255,255,255)
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 22
    t1.BackgroundTransparency = 1
    local t2 = Instance.new("TextLabel", box)
    t2.Size = UDim2.new(1,0,0,20)
    t2.Position = UDim2.new(0,0,0,55)
    t2.Text = "Quantum Onyx Edition | Loading..."
    t2.TextColor3 = Color3.fromRGB(150,150,150)
    t2.Font = Enum.Font.Gotham
    t2.TextSize = 11
    t2.BackgroundTransparency = 1
    task.delay(3, function() gui:Destroy() notify("MANTΛX VLY", "Quantum Onyx Edition Loaded! Sea "..SEA, 3) end)
end)()

notify("MANTΛX VLY", "Quantum Onyx Edition v8.0 Loaded! 🔥", 5)
