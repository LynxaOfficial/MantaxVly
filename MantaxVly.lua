--[[
╔══════════════════════════════════════════════════════════════════╗
║  REDZ HUB INSPIRED — BLOX FRUITS SCRIPT                         ║
║  BY GANNADY PROGRAMMER TERBAIK                                  ║
║  STABLE | KEYLESS | UPDATE 2026                                  ║
║  NO GODMODE / NO NOCLIP                                         ║
╚══════════════════════════════════════════════════════════════════╝
--]]

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local player = game.Players.LocalPlayer
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local CollectionService = game:GetService("CollectionService")
local MarketplaceService = game:GetService("MarketplaceService")
local GuiService = game:GetService("GuiService")

-- ═══════════════════════════════════════════════════════════════════
-- 📟 LOADING SCREEN
-- ═══════════════════════════════════════════════════════════════════

local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "RedzHub_Loading"
loadingGui.Parent = CoreGui
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 400, 0, 200)
loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
loadingFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
loadingFrame.BackgroundTransparency = 0.05
loadingFrame.BorderSizePixel = 0
loadingFrame.Parent = loadingGui

local loadingCorner = Instance.new("UICorner")
loadingCorner.CornerRadius = UDim.new(0, 16)
loadingCorner.Parent = loadingFrame

local loadingTitle = Instance.new("TextLabel")
loadingTitle.Size = UDim2.new(1, 0, 0, 50)
loadingTitle.Position = UDim2.new(0, 0, 0, 20)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Text = "REDZ HUB STYLE"
loadingTitle.TextColor3 = Color3.fromRGB(204, 51, 51)
loadingTitle.TextSize = 28
loadingTitle.Font = Enum.Font.GothamBold
loadingTitle.Parent = loadingFrame

local loadingSub = Instance.new("TextLabel")
loadingSub.Size = UDim2.new(1, 0, 0, 30)
loadingSub.Position = UDim2.new(0, 0, 0, 75)
loadingSub.BackgroundTransparency = 1
loadingSub.Text = "Loading system..."
loadingSub.TextColor3 = Color3.fromRGB(180, 180, 200)
loadingSub.TextSize = 14
loadingSub.Font = Enum.Font.Gotham
loadingSub.Parent = loadingFrame

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0.8, 0, 0, 10)
progressBar.Position = UDim2.new(0.1, 0, 0, 120)
progressBar.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
progressBar.BorderSizePixel = 0
progressBar.Parent = loadingFrame

local progressFill = Instance.new("Frame")
progressFill.Size = UDim2.new(0, 0, 1, 0)
progressFill.BackgroundColor3 = Color3.fromRGB(204, 51, 51)
progressFill.BorderSizePixel = 0
progressFill.Parent = progressBar

local progressCorner = Instance.new("UICorner")
progressCorner.CornerRadius = UDim.new(0, 5)
progressCorner.Parent = progressBar

-- Animate loading
for i = 1, 10 do
    progressFill:TweenSize(UDim2.new(i/10, 0, 1, 0), "Out", "Linear", 0.08)
    task.wait(0.08)
end
task.wait(0.5)
loadingGui:Destroy()

-- ═══════════════════════════════════════════════════════════════════
-- 📁 GLOBAL CONFIGURATION
-- ═══════════════════════════════════════════════════════════════════

getgenv().GannadyConfig = {
    Version = "Redz Hub Style v1.0",
    AutoFarm = {
        Enabled = false,
        Method = "Quest",
        Radius = 350,
        FastAttackDelay = 0.4,
        AutoAcceptQuest = true,
        AutoEquipBest = true,
    },
    Sea = {
        LeviathanHunt = {
            Bribe = false,
            AutoFind = false,
            AutoKill = false,
            AutoSailBack = false,
        },
        Fishing = {
            AutoFishing = false,
            AutoSell = false,
            AutoCraftBait = false,
        },
        SeaBeast = {
            AutoKill = false,
            AutoDodge = false,
            UseMIFruit = false,
        },
        AzureEmber = {
            AutoTrade = false,
            Amount = 1,
        },
    },
    Player = {
        WalkSpeed = 32,
        JumpPower = 80,
        InfiniteJump = false,
        AutoHaki = {
            Observation = false,
            ObservationV2 = false,
            Armament = false,
            Conqueror = false,
        },
        AutoFightingStyle = false,
        AutoStats = false,
        StatsPriority = "Melee",
    },
    Misc = {
        FruitSniper = {
            Enabled = false,
            Whitelist = {"Kitsune", "Dragon", "Leopard", "T-Rex", "Mammoth", "Dough", "Spirit", "Venom", "Tiger", "Yeti"},
        },
        AutoStoreFruit = false,
        AutoUnstoreLowValue = false,
        AutoBones = false,
        AutoRandomSurprise = false,
        AutoPray = false,
        AutoEliteHunter = false,
        SwordMastery = {
            Enabled = false,
            Sword = nil,
            TargetMastery = 600,
        },
        Raid = {
            AutoBuyChip = false,
            AutoComplete = false,
            AutoAwaken = false,
            SelectedFruit = "Flame",
        },
        Travel = {
            Sea = 1,
            Island = "Tiki Outpost",
        },
    },
    ESP = {
        Enabled = false,
        Players = true,
        Fruits = true,
        Chests = true,
        Bosses = true,
        MaxDistance = 10000,
    },
}

local config = getgenv().GannadyConfig

-- ═══════════════════════════════════════════════════════════════════
-- 🗺️ LEVEL MAP
-- ═══════════════════════════════════════════════════════════════════

local LevelMap = {
    {min=0, max=10, name="Bandits", loc=CFrame.new(-1223,55,2089), quest="Bandit", npc="Bandit"},
    {min=10, max=30, name="Monkeys", loc=CFrame.new(-1456,45,1850), quest="Monkey", npc="Monkey"},
    {min=30, max=60, name="Pirates", loc=CFrame.new(-1120,55,2150), quest="Pirate", npc="Pirate"},
    {min=60, max=90, name="Brutes", loc=CFrame.new(-1050,55,2200), quest="Brute", npc="Brute"},
    {min=90, max=120, name="Desert Bandits", loc=CFrame.new(-850,50,1950), quest="Desert Bandit", npc="Desert Bandit"},
    {min=120, max=190, name="Marines", loc=CFrame.new(-580,80,1850), quest="Marine", npc="Marine"},
    {min=190, max=275, name="Sky Bandits", loc=CFrame.new(2850,1200,2100), quest="Sky Bandit", npc="Sky Bandit"},
    {min=275, max=375, name="Military Soldiers", loc=CFrame.new(-440,85,1770), quest="Military", npc="Military Soldier"},
    {min=375, max=450, name="Fishmen", loc=CFrame.new(3050,-350,2850), quest="Fishman", npc="Fishman"},
    {min=450, max=625, name="Cyborgs", loc=CFrame.new(5200,50,950), quest="Cyborg", npc="Cyborg"},
    {min=625, max=700, name="Royal Soldiers", loc=CFrame.new(2900,1200,2550), quest="Royal Soldier", npc="Royal Soldier"},
    {min=700, max=850, name="Swan Pirates", loc=CFrame.new(-550,160,250), quest="Swan Pirate", npc="Swan Pirate"},
    {min=850, max=1000, name="Marine Lieutenants", loc=CFrame.new(-380,140,-410), quest="Marine LT", npc="Marine Lieutenant"},
    {min=1000, max=1100, name="Snow Troopers", loc=CFrame.new(100,230,1800), quest="Snow", npc="Snow Trooper"},
    {min=1100, max=1250, name="Lab Subordinates", loc=CFrame.new(-5000,220,-500), quest="Lab", npc="Lab Subordinate"},
    {min=1250, max=1400, name="Ship Deckhands", loc=CFrame.new(5200,40,1020), quest="Ship", npc="Ship Deckhand"},
    {min=1400, max=1500, name="Arctic Warriors", loc=CFrame.new(4700,320,1400), quest="Arctic", npc="Arctic Warrior"},
    {min=1500, max=1575, name="Pirate Millionaires", loc=CFrame.new(-11800,330,8250), quest="Pirate Millionaire", npc="Pirate Millionaire"},
    {min=1575, max=1700, name="Island Empress", loc=CFrame.new(-13800,420,8600), quest="Island Empress", npc="Island Empress"},
    {min=1700, max=2000, name="Marine Commodores", loc=CFrame.new(-12500,600,11250), quest="Marine Commodore", npc="Marine Commodore"},
    {min=2000, max=2200, name="Reborn Skeletons", loc=CFrame.new(-14400,520,12800), quest="Reborn Skeleton", npc="Reborn Skeleton"},
    {min=2200, max=2550, name="Candy Rebels", loc=CFrame.new(-16700,400,14100), quest="Candy Rebel", npc="Candy Rebel"},
}

-- ═══════════════════════════════════════════════════════════════════
-- 🎮 CORE FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════

local function teleport(cframe)
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = cframe
    end
end

local function setWalkSpeed(speed)
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = speed end
    end
end

local function setJumpPower(power)
    local char = player.Character
    if char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = power end
    end
end

local function attackNPC(npc)
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local npcHrp = npc:FindFirstChild("HumanoidRootPart")
    if hrp and npcHrp then
        hrp.CFrame = CFrame.new(hrp.Position, npcHrp.Position)
        if config.AutoFarm.FastAttackDelay > 0 then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(0,0))
                task.wait(config.AutoFarm.FastAttackDelay)
                VirtualUser:ClickButton1(Vector2.new(0,0))
            end)
        end
    end
end

local function getQuestZone(level)
    for _, zone in ipairs(LevelMap) do
        if level >= zone.min and level <= zone.max then
            return zone
        end
    end
    return LevelMap[#LevelMap]
end

local function acceptQuest(questName)
    pcall(function()
        local args = {[1] = "StartQuest", [2] = questName}
        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- 🔄 AUTO FARM SYSTEM
-- ═══════════════════════════════════════════════════════════════════

local autoFarmRunning = false

local function startAutoFarm()
    autoFarmRunning = true
    task.spawn(function()
        while autoFarmRunning and task.wait(0.15) do
            local char = player.Character
            if not char then task.wait(2) goto continue end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then task.wait(3) goto continue end
            
            setWalkSpeed(config.Player.WalkSpeed)
            setJumpPower(config.Player.JumpPower)
            
            local level = player.Data.Level.Value
            local zone = getQuestZone(level)
            if not zone then goto continue end
            
            if config.AutoFarm.AutoAcceptQuest then
                acceptQuest(zone.quest)
            end
            
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp and (hrp.Position - zone.loc.Position).Magnitude > config.AutoFarm.Radius then
                teleport(zone.loc)
            end
            
            -- Find nearest mob
            local nearest, shortest = nil, math.huge
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Name ~= player.Name then
                    local npcHrp = v:FindFirstChild("HumanoidRootPart")
                    if npcHrp and hrp then
                        local dist = (hrp.Position - npcHrp.Position).Magnitude
                        if dist < shortest and dist < config.AutoFarm.Radius then
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

-- ═══════════════════════════════════════════════════════════════════
-- 🐉 SEA EVENT SYSTEM
-- ═══════════════════════════════════════════════════════════════════

-- Leviathan Hunt
local leviathanRunning = false
local function startLeviathan()
    leviathanRunning = true
    task.spawn(function()
        while leviathanRunning and task.wait(5) do
            if config.Sea.LeviathanHunt.Bribe then
                pcall(function() ReplicatedStorage.Remotes.CommF_:InvokeServer("Bribe") end)
            end
            -- Auto find & kill
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name:find("Leviathan") and v:FindFirstChild("HumanoidRootPart") then
                    teleport(v.HumanoidRootPart.CFrame)
                    while v and v.Parent and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 do
                        attackNPC(v)
                        task.wait(0.5)
                    end
                end
            end
            if config.Sea.LeviathanHunt.AutoSailBack then
                teleport(CFrame.new(-13800,300,15800))
            end
        end
    end)
end

-- Fishing
local fishingRunning = false
local function startFishing()
    fishingRunning = true
    task.spawn(function()
        while fishingRunning and task.wait(1) do
            pcall(function()
                local args = {[1]="Fishing", [2]="Start"}
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                task.wait(8)
                args = {[1]="Fishing", [2]="Stop"}
                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                if config.Sea.Fishing.AutoSell then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("SellFish")
                end
            end)
        end
    end)
end

-- Sea Beast
local seaBeastRunning = false
local function startSeaBeast()
    seaBeastRunning = true
    task.spawn(function()
        while seaBeastRunning and task.wait(2) do
            for _, v in pairs(Workspace:GetDescendants()) do
                if v.Name:find("SeaBeast") and v:FindFirstChild("HumanoidRootPart") then
                    teleport(v.HumanoidRootPart.CFrame)
                    while v and v.Parent and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 do
                        attackNPC(v)
                        task.wait(0.3)
                    end
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- 👤 PLAYER SETTINGS
-- ═══════════════════════════════════════════════════════════════════

-- Infinite Jump
UserInputService.JumpRequest:Connect(function()
    if config.Player.InfiniteJump then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

-- Haki Auto Enable
local function startAutoHaki()
    task.spawn(function()
        while task.wait(3) do
            pcall(function()
                if config.Player.AutoHaki.Observation then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Observation")
                end
                if config.Player.AutoHaki.Armament then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
                end
                if config.Player.AutoHaki.Conqueror then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Conqueror")
                end
            end)
        end
    end)
end

-- Fighting Style Auto
local function autoFightingStyle()
    pcall(function()
        local styles = {"BuyDeathStep","BuySharkmanKarate","BuyElectricClaw","BuyDragonTalon","BuySuperhuman","BuyGodhuman"}
        for _, style in ipairs(styles) do
            ReplicatedStorage.Remotes.CommF_:InvokeServer(style)
        end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Fighting Style",
            Text = "Attempting to buy all styles",
            Duration = 3
        })
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- 🍎 FRUIT SNIPER
-- ═══════════════════════════════════════════════════════════════════

local fruitSniperRunning = false
local function startFruitSniper()
    fruitSniperRunning = true
    task.spawn(function()
        while fruitSniperRunning and task.wait(2) do
            for _, fruit in pairs(Workspace:GetDescendants()) do
                if fruit:IsA("Tool") and fruit:FindFirstChild("Handle") then
                    for _, name in ipairs(config.Misc.FruitSniper.Whitelist) do
                        if string.find(fruit.Name, name) then
                            teleport(fruit.Handle.CFrame)
                            break
                        end
                    end
                end
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- 📡 ESP SYSTEM
-- ═══════════════════════════════════════════════════════════════════

local espEnabled = false
local function createESP()
    if espEnabled then return end
    espEnabled = true
    local success, TracerLib = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPNG/ESP_LIBRARY/main/7GrandDadESP"))()
    end)
    if success and TracerLib then
        TracerLib:CreateTracer({
            Name = "GannadyESP",
            Color = Color3.fromRGB(204, 51, 51),
            Enabled = true,
            ShowDistance = true,
            ShowHealth = true,
            CustomText = function(plr)
                local bounty = plr.Data and (plr.Data.Bounty or plr.Data.Honor)
                if bounty and bounty.Value then
                    local n = bounty.Value
                    if n >= 1000000 then return string.format("💰 %s | %.1fM", plr.Name, n/1e6) end
                    if n >= 1000 then return string.format("💰 %s | %.1fK", plr.Name, n/1e3) end
                end
                return plr.Name
            end
        })
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- 🖥️ GUI BUILD
-- ═══════════════════════════════════════════════════════════════════

local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GannadyHub"
    screenGui.Parent = CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 23)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 12)
    mainCorner.Parent = mainFrame

    -- Title Bar (draggable)
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(204, 51, 51)
    titleBar.BackgroundTransparency = 0.2
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar

    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -60, 1, 0)
    titleText.Position = UDim2.new(0, 15, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = "⚡ REDZ HUB STYLE"
    titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleText.TextSize = 18
    titleText.Font = Enum.Font.GothamBold
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 40, 1, 0)
    closeBtn.Position = UDim2.new(1, -40, 0, 0)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 20
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)

    -- Drag functionality
    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Tab Bar
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, 0, 0, 35)
    tabBar.Position = UDim2.new(0, 0, 0, 45)
    tabBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    tabBar.BackgroundTransparency = 0.3
    tabBar.BorderSizePixel = 0
    tabBar.Parent = mainFrame

    local tabs = {"Main", "Sea", "Player", "Misc", "ESP"}
    local tabButtons = {}
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Size = UDim2.new(1, -10, 1, -95)
    contentFrame.Position = UDim2.new(0, 5, 0, 85)
    contentFrame.BackgroundTransparency = 1
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    contentFrame.ScrollBarThickness = 5
    contentFrame.Parent = mainFrame

    local contentList = Instance.new("UIListLayout")
    contentList.Padding = UDim.new(0, 6)
    contentList.SortOrder = Enum.SortOrder.LayoutOrder
    contentList.Parent = contentFrame

    local function switchTab(tabName)
        for _, btn in pairs(tabButtons) do
            btn.BackgroundColor3 = btn.Name == tabName and Color3.fromRGB(204, 51, 51) or Color3.fromRGB(30, 30, 45)
        end
        -- Clear content
        for _, child in pairs(contentFrame:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") or child:IsA("TextLabel") or child:IsA("TextBox") or child:IsA("ScrollingFrame") then
                child:Destroy()
            end
        end
        -- Build content for each tab (simplified for space; full implementation would include all toggles/sliders)
        if tabName == "Main" then
            -- Auto Farm controls
            local farmFrame = Instance.new("Frame")
            farmFrame.Size = UDim2.new(1,0,0,150)
            farmFrame.BackgroundColor3 = Color3.fromRGB(25,25,40)
            farmFrame.Parent = contentFrame
            local farmCorner = Instance.new("UICorner")
            farmCorner.CornerRadius = UDim.new(0,10)
            farmCorner.Parent = farmFrame

            local farmTitle = Instance.new("TextLabel")
            farmTitle.Size = UDim2.new(1,0,0,30)
            farmTitle.BackgroundTransparency = 1
            farmTitle.Text = "🎯 AUTO FARM"
            farmTitle.TextColor3 = Color3.fromRGB(204,51,51)
            farmTitle.TextSize = 14
            farmTitle.Font = Enum.Font.GothamBold
            farmTitle.Parent = farmFrame

            local startBtn = Instance.new("TextButton")
            startBtn.Size = UDim2.new(0.45,-5,0,35)
            startBtn.Position = UDim2.new(0.025,0,0,40)
            startBtn.BackgroundColor3 = Color3.fromRGB(204,51,51)
            startBtn.Text = "▶ START FARM"
            startBtn.TextColor3 = Color3.fromRGB(255,255,255)
            startBtn.TextSize = 14
            startBtn.Font = Enum.Font.GothamBold
            startBtn.Parent = farmFrame
            local startCorner = Instance.new("UICorner")
            startCorner.CornerRadius = UDim.new(0,8)
            startCorner.Parent = startBtn
            startBtn.MouseButton1Click:Connect(startAutoFarm)

            local stopBtn = Instance.new("TextButton")
            stopBtn.Size = UDim2.new(0.45,-5,0,35)
            stopBtn.Position = UDim2.new(0.525,0,0,40)
            stopBtn.BackgroundColor3 = Color3.fromRGB(60,60,80)
            stopBtn.Text = "⏹ STOP FARM"
            stopBtn.TextColor3 = Color3.fromRGB(255,255,255)
            stopBtn.TextSize = 14
            stopBtn.Font = Enum.Font.GothamBold
            stopBtn.Parent = farmFrame
            local stopCorner = Instance.new("UICorner")
            stopCorner.CornerRadius = UDim.new(0,8)
            stopCorner.Parent = stopBtn
            stopBtn.MouseButton1Click:Connect(function() autoFarmRunning = false end)

            -- Status label
            local statusLabel = Instance.new("TextLabel")
            statusLabel.Size = UDim2.new(1,0,0,25)
            statusLabel.Position = UDim2.new(0,0,0,85)
            statusLabel.BackgroundTransparency = 1
            statusLabel.Text = "Status: IDLE"
            statusLabel.TextColor3 = Color3.fromRGB(200,200,200)
            statusLabel.TextSize = 12
            statusLabel.Font = Enum.Font.Gotham
            statusLabel.Parent = farmFrame

            -- Quick info display
            local infoLabel = Instance.new("TextLabel")
            infoLabel.Size = UDim2.new(1,0,0,30)
            infoLabel.Position = UDim2.new(0,0,0,115)
            infoLabel.BackgroundTransparency = 1
            infoLabel.Text = "Level: loading... | Bounty: loading..."
            infoLabel.TextColor3 = Color3.fromRGB(180,180,200)
            infoLabel.TextSize = 11
            infoLabel.Font = Enum.Font.Gotham
            infoLabel.Parent = farmFrame

            -- Update info loop
            task.spawn(function()
                while true do
                    task.wait(1)
                    local lvl = pcall(function() return player.Data.Level.Value end) and player.Data.Level.Value or "??"
                    local bty = pcall(function() return player.Data.Bounty.Value end) and player.Data.Bounty.Value or "??"
                    local fStatus = autoFarmRunning and "🟢 FARMING" or "⚫ IDLE"
                    statusLabel.Text = "Status: "..fStatus
                    infoLabel.Text = "Level: "..tostring(lvl).." | Bounty: "..tostring(bty)
                end
            end)

            -- Other buttons in Main: Fruit Sniper, Godmode not allowed, so skip.
        elseif tabName == "Sea" then
            -- Leviathan
            local levBtn = Instance.new("TextButton")
            levBtn.Size = UDim2.new(1,0,0,40)
            levBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            levBtn.Text = "🐉 LEVIATHAN HUNT [OFF]"
            levBtn.TextColor3 = Color3.fromRGB(255,255,255)
            levBtn.TextSize = 14
            levBtn.Font = Enum.Font.GothamSemibold
            levBtn.Parent = contentFrame
            local levCorner = Instance.new("UICorner")
            levCorner.CornerRadius = UDim.new(0,10)
            levCorner.Parent = levBtn
            local levState = false
            levBtn.MouseButton1Click:Connect(function()
                levState = not levState
                if levState then
                    startLeviathan()
                    levBtn.Text = "🐉 LEVIATHAN HUNT [ON]"
                    levBtn.BackgroundColor3 = Color3.fromRGB(204,51,51)
                else
                    leviathanRunning = false
                    levBtn.Text = "🐉 LEVIATHAN HUNT [OFF]"
                    levBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
                end
            end)

            -- Fishing
            local fishBtn = Instance.new("TextButton")
            fishBtn.Size = UDim2.new(1,0,0,40)
            fishBtn.Position = UDim2.new(0,0,0,50)
            fishBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            fishBtn.Text = "🎣 AUTO FISHING [OFF]"
            fishBtn.TextColor3 = Color3.fromRGB(255,255,255)
            fishBtn.TextSize = 14
            fishBtn.Font = Enum.Font.GothamSemibold
            fishBtn.Parent = contentFrame
            local fishCorner = Instance.new("UICorner")
            fishCorner.CornerRadius = UDim.new(0,10)
            fishCorner.Parent = fishBtn
            local fishState = false
            fishBtn.MouseButton1Click:Connect(function()
                fishState = not fishState
                if fishState then
                    startFishing()
                    fishBtn.Text = "🎣 AUTO FISHING [ON]"
                    fishBtn.BackgroundColor3 = Color3.fromRGB(204,51,51)
                else
                    fishingRunning = false
                    fishBtn.Text = "🎣 AUTO FISHING [OFF]"
                    fishBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
                end
            end)

            -- Sea Beast
            local sbBtn = Instance.new("TextButton")
            sbBtn.Size = UDim2.new(1,0,0,40)
            sbBtn.Position = UDim2.new(0,0,0,100)
            sbBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            sbBtn.Text = "🌊 AUTO SEA BEAST [OFF]"
            sbBtn.TextColor3 = Color3.fromRGB(255,255,255)
            sbBtn.TextSize = 14
            sbBtn.Font = Enum.Font.GothamSemibold
            sbBtn.Parent = contentFrame
            local sbCorner = Instance.new("UICorner")
            sbCorner.CornerRadius = UDim.new(0,10)
            sbCorner.Parent = sbBtn
            local sbState = false
            sbBtn.MouseButton1Click:Connect(function()
                sbState = not sbState
                if sbState then
                    startSeaBeast()
                    sbBtn.Text = "🌊 AUTO SEA BEAST [ON]"
                    sbBtn.BackgroundColor3 = Color3.fromRGB(204,51,51)
                else
                    seaBeastRunning = false
                    sbBtn.Text = "🌊 AUTO SEA BEAST [OFF]"
                    sbBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
                end
            end)

        elseif tabName == "Player" then
            -- WalkSpeed
            local wsFrame = Instance.new("Frame")
            wsFrame.Size = UDim2.new(1,0,0,60)
            wsFrame.BackgroundColor3 = Color3.fromRGB(25,25,40)
            wsFrame.Parent = contentFrame
            local wsCorner = Instance.new("UICorner")
            wsCorner.CornerRadius = UDim.new(0,10)
            wsCorner.Parent = wsFrame
            local wsLabel = Instance.new("TextLabel")
            wsLabel.Size = UDim2.new(1,0,0,25)
            wsLabel.BackgroundTransparency = 1
            wsLabel.Text = "🚀 WalkSpeed: 32"
            wsLabel.TextColor3 = Color3.fromRGB(255,255,255)
            wsLabel.TextSize = 13
            wsLabel.Font = Enum.Font.GothamSemibold
            wsLabel.Parent = wsFrame
            local wsInput = Instance.new("TextBox")
            wsInput.Size = UDim2.new(0.3,0,0,30)
            wsInput.Position = UDim2.new(0.35,0,0,25)
            wsInput.BackgroundColor3 = Color3.fromRGB(50,50,70)
            wsInput.Text = "32"
            wsInput.TextColor3 = Color3.fromRGB(255,255,255)
            wsInput.TextSize = 14
            wsInput.Font = Enum.Font.GothamBold
            wsInput.Parent = wsFrame
            local wsCornerBox = Instance.new("UICorner")
            wsCornerBox.CornerRadius = UDim.new(0,6)
            wsCornerBox.Parent = wsInput
            wsInput.FocusLost:Connect(function()
                local v = tonumber(wsInput.Text)
                if v then
                    v = math.clamp(v,16,350)
                    config.Player.WalkSpeed = v
                    setWalkSpeed(v)
                    wsLabel.Text = "🚀 WalkSpeed: "..v
                end
            end)

            -- Infinite Jump
            local iBtn = Instance.new("TextButton")
            iBtn.Size = UDim2.new(1,0,0,40)
            iBtn.Position = UDim2.new(0,0,0,70)
            iBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            iBtn.Text = "🦘 INFINITE JUMP [OFF]"
            iBtn.TextColor3 = Color3.fromRGB(255,255,255)
            iBtn.TextSize = 14
            iBtn.Font = Enum.Font.GothamSemibold
            iBtn.Parent = contentFrame
            local iCorner = Instance.new("UICorner")
            iCorner.CornerRadius = UDim.new(0,10)
            iCorner.Parent = iBtn
            local iState = false
            iBtn.MouseButton1Click:Connect(function()
                iState = not iState
                config.Player.InfiniteJump = iState
                iBtn.Text = iState and "🦘 INFINITE JUMP [ON]" or "🦘 INFINITE JUMP [OFF]"
                iBtn.BackgroundColor3 = iState and Color3.fromRGB(204,51,51) or Color3.fromRGB(25,25,40)
            end)

            -- Auto Haki toggles (simplified)
            local hakiFrame = Instance.new("Frame")
            hakiFrame.Size = UDim2.new(1,0,0,120)
            hakiFrame.Position = UDim2.new(0,0,0,120)
            hakiFrame.BackgroundColor3 = Color3.fromRGB(25,25,40)
            hakiFrame.Parent = contentFrame
            local hakiCorner = Instance.new("UICorner")
            hakiCorner.CornerRadius = UDim.new(0,10)
            hakiCorner.Parent = hakiFrame
            local hakiTitle = Instance.new("TextLabel")
            hakiTitle.Size = UDim2.new(1,0,0,25)
            hakiTitle.BackgroundTransparency = 1
            hakiTitle.Text = "👁️ AUTO HAKI"
            hakiTitle.TextColor3 = Color3.fromRGB(204,51,51)
            hakiTitle.TextSize = 13
            hakiTitle.Font = Enum.Font.GothamSemibold
            hakiTitle.Parent = hakiFrame

            -- Made simple toggle buttons
            local function makeHakiToggle(y, name, prop)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(0.9,0,0,30)
                btn.Position = UDim2.new(0.05,0,0,y)
                btn.BackgroundColor3 = Color3.fromRGB(30,30,45)
                btn.Text = name.." [OFF]"
                btn.TextColor3 = Color3.fromRGB(200,200,200)
                btn.TextSize = 12
                btn.Font = Enum.Font.Gotham
                btn.Parent = hakiFrame
                local bCorner = Instance.new("UICorner")
                bCorner.CornerRadius = UDim.new(0,6)
                bCorner.Parent = btn
                local state = false
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    config.Player.AutoHaki[prop] = state
                    btn.Text = state and name.." [ON]" or name.." [OFF]"
                    btn.BackgroundColor3 = state and Color3.fromRGB(204,51,51) or Color3.fromRGB(30,30,45)
                end)
            end
            makeHakiToggle(30, "Observation", "Observation")
            makeHakiToggle(65, "Armament", "Armament")
            makeHakiToggle(100, "Conqueror", "Conqueror")

            -- Fighting Style button
            local fsBtn = Instance.new("TextButton")
            fsBtn.Size = UDim2.new(1,0,0,40)
            fsBtn.Position = UDim2.new(0,0,0,250)
            fsBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            fsBtn.Text = "🥋 AUTO FIGHTING STYLES"
            fsBtn.TextColor3 = Color3.fromRGB(255,255,255)
            fsBtn.TextSize = 14
            fsBtn.Font = Enum.Font.GothamSemibold
            fsBtn.Parent = contentFrame
            local fsCorner = Instance.new("UICorner")
            fsCorner.CornerRadius = UDim.new(0,10)
            fsCorner.Parent = fsBtn
            fsBtn.MouseButton1Click:Connect(autoFightingStyle)

        elseif tabName == "Misc" then
            -- Fruit Sniper
            local fsBtn = Instance.new("TextButton")
            fsBtn.Size = UDim2.new(1,0,0,40)
            fsBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            fsBtn.Text = "🍎 FRUIT SNIPER [OFF]"
            fsBtn.TextColor3 = Color3.fromRGB(255,255,255)
            fsBtn.TextSize = 14
            fsBtn.Font = Enum.Font.GothamSemibold
            fsBtn.Parent = contentFrame
            local fsCorner = Instance.new("UICorner")
            fsCorner.CornerRadius = UDim.new(0,10)
            fsCorner.Parent = fsBtn
            local fsState = false
            fsBtn.MouseButton1Click:Connect(function()
                fsState = not fsState
                config.Misc.FruitSniper.Enabled = fsState
                if fsState then
                    startFruitSniper()
                    fsBtn.Text = "🍎 FRUIT SNIPER [ON]"
                    fsBtn.BackgroundColor3 = Color3.fromRGB(204,51,51)
                else
                    fruitSniperRunning = false
                    fsBtn.Text = "🍎 FRUIT SNIPER [OFF]"
                    fsBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
                end
            end)

            -- Auto Bones, Random Surprise, Pray
            local function makeMiscToggle(y, name, prop)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1,0,0,40)
                btn.Position = UDim2.new(0,0,0,y)
                btn.BackgroundColor3 = Color3.fromRGB(25,25,40)
                btn.Text = name.." [OFF]"
                btn.TextColor3 = Color3.fromRGB(255,255,255)
                btn.TextSize = 14
                btn.Font = Enum.Font.GothamSemibold
                btn.Parent = contentFrame
                local bCorner = Instance.new("UICorner")
                bCorner.CornerRadius = UDim.new(0,10)
                bCorner.Parent = btn
                local state = false
                btn.MouseButton1Click:Connect(function()
                    state = not state
                    config.Misc[prop] = state
                    btn.Text = state and name.." [ON]" or name.." [OFF]"
                    btn.BackgroundColor3 = state and Color3.fromRGB(204,51,51) or Color3.fromRGB(25,25,40)
                    -- start loop if needed (simplified)
                    if state then
                        task.spawn(function()
                            while state and task.wait(2) do
                                pcall(function()
                                    ReplicatedStorage.Remotes.CommF_:InvokeServer(prop)
                                end)
                            end
                        end)
                    end
                end)
            end
            makeMiscToggle(50, "🦴 Auto Bones", "AutoBones")
            makeMiscToggle(100, "🎲 Auto Random Surprise", "AutoRandomSurprise")
            makeMiscToggle(150, "🙏 Auto Pray", "AutoPray")

            -- Travel buttons
            local travelFrame = Instance.new("Frame")
            travelFrame.Size = UDim2.new(1,0,0,40)
            travelFrame.Position = UDim2.new(0,0,0,200)
            travelFrame.BackgroundColor3 = Color3.fromRGB(25,25,40)
            travelFrame.Parent = contentFrame
            local travelCorner = Instance.new("UICorner")
            travelCorner.CornerRadius = UDim.new(0,10)
            travelCorner.Parent = travelFrame
            local travelLabel = Instance.new("TextLabel")
            travelLabel.Size = UDim2.new(1,0,1,0)
            travelLabel.BackgroundTransparency = 1
            travelLabel.Text = "🌍 TRAVEL (coming soon)"
            travelLabel.TextColor3 = Color3.fromRGB(200,200,200)
            travelLabel.TextSize = 14
            travelLabel.Font = Enum.Font.Gotham
            travelLabel.Parent = travelFrame

        elseif tabName == "ESP" then
            local espBtn = Instance.new("TextButton")
            espBtn.Size = UDim2.new(1,0,0,40)
            espBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
            espBtn.Text = "📡 ESP [OFF]"
            espBtn.TextColor3 = Color3.fromRGB(255,255,255)
            espBtn.TextSize = 14
            espBtn.Font = Enum.Font.GothamSemibold
            espBtn.Parent = contentFrame
            local espCorner = Instance.new("UICorner")
            espCorner.CornerRadius = UDim.new(0,10)
            espCorner.Parent = espBtn
            local eState = false
            espBtn.MouseButton1Click:Connect(function()
                eState = not eState
                if eState then
                    createESP()
                    espBtn.Text = "📡 ESP [ON]"
                    espBtn.BackgroundColor3 = Color3.fromRGB(204,51,51)
                else
                    -- destroy ESP if needed (simplified)
                    espBtn.Text = "📡 ESP [OFF]"
                    espBtn.BackgroundColor3 = Color3.fromRGB(25,25,40)
                end
            end)
        end
    end

    -- Create tab buttons
    for i, tabName in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Name = tabName
        btn.Size = UDim2.new(0.2, 0, 1, 0)
        btn.Position = UDim2.new((i-1)*0.2, 0, 0, 0)
        btn.BackgroundColor3 = i == 1 and Color3.fromRGB(204, 51, 51) or Color3.fromRGB(30, 30, 45)
        btn.Text = tabName
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = tabBar
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn
        btn.MouseButton1Click:Connect(function() switchTab(tabName) end)
        table.insert(tabButtons, btn)
    end

    switchTab("Main")
    return screenGui
end

-- ═══════════════════════════════════════════════════════════════════
-- 🚀 EXECUTION
-- ═══════════════════════════════════════════════════════════════════

createGUI()

-- Keybind Insert to toggle GUI
local guiVisible = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        guiVisible = not guiVisible
        local gui = CoreGui:FindFirstChild("GannadyHub")
        if gui then gui.Enabled = guiVisible end
    end
end)

-- Auto Haki loop (if any toggled)
startAutoHaki()

-- Startup notification
pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ REDZ HUB STYLE",
        Text = "Loaded! Press Insert to toggle GUI.",
        Duration = 5
    })
end)

print("[[ REDZ HUB STYLE - BY GANNADY ]]: Loaded successfully.")
