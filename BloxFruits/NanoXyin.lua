-- ============================================
-- NANOXYIN v3.0 - BLOX FRUITS ULTIMATE HUB
-- By @XyrooXellz
-- Features: Sea Detection, Island Scanner, Bypass TP, Sea Event, Raid Kill Aura, Auto Farm Level Matching
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift
-- Update: June 2026
-- ============================================

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- ============================================
-- SEA & ISLAND DATA (Based on Blox Fruits Wiki 2026)
-- ============================================
local SeaData = {
    [1] = {
        Name = "First Sea",
        MinLevel = 0,
        MaxLevel = 700,
        Islands = {
            {Name = "Pirate Starter Island", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Marine Starter Island", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Jungle", Level = 15, Position = Vector3.new(0, 0, 0)},
            {Name = "Pirate Village", Level = 30, Position = Vector3.new(0, 0, 0)},
            {Name = "Desert", Level = 60, Position = Vector3.new(0, 0, 0)},
            {Name = "Frozen Village", Level = 90, Position = Vector3.new(0, 0, 0)},
            {Name = "Middle Town", Level = 100, Position = Vector3.new(0, 0, 0)},
            {Name = "Marine Fortress", Level = 120, Position = Vector3.new(0, 0, 0)},
            {Name = "Skylands", Level = 150, Position = Vector3.new(0, 0, 0)},
            {Name = "Prison", Level = 190, Position = Vector3.new(0, 0, 0)},
            {Name = "Colosseum", Level = 225, Position = Vector3.new(0, 0, 0)},
            {Name = "Magma Village", Level = 300, Position = Vector3.new(0, 0, 0)},
            {Name = "Underwater City", Level = 375, Position = Vector3.new(0, 0, 0)},
            {Name = "Upper Skylands", Level = 450, Position = Vector3.new(0, 0, 0)},
            {Name = "Fountain City", Level = 625, Position = Vector3.new(0, 0, 0)}
        }
    },
    [2] = {
        Name = "Second Sea",
        MinLevel = 700,
        MaxLevel = 1500,
        Islands = {
            {Name = "Kingdom of Rose", Level = 700, Position = Vector3.new(0, 0, 0)},
            {Name = "Green Zone", Level = 875, Position = Vector3.new(0, 0, 0)},
            {Name = "Graveyard", Level = 950, Position = Vector3.new(0, 0, 0)},
            {Name = "Snow Mountain", Level = 1000, Position = Vector3.new(0, 0, 0)},
            {Name = "Hot and Cold", Level = 1100, Position = Vector3.new(0, 0, 0)},
            {Name = "Cursed Ship", Level = 1250, Position = Vector3.new(0, 0, 0)},
            {Name = "Ice Castle", Level = 1350, Position = Vector3.new(0, 0, 0)},
            {Name = "Forgotten Island", Level = 1425, Position = Vector3.new(0, 0, 0)},
            {Name = "Dark Arena", Level = 1000, Position = Vector3.new(0, 0, 0)},
            {Name = "Remote Island", Level = 700, Position = Vector3.new(0, 0, 0)},
            {Name = "Cave Island", Level = 700, Position = Vector3.new(0, 0, 0)}
        }
    },
    [3] = {
        Name = "Third Sea",
        MinLevel = 1500,
        MaxLevel = 2800,
        Islands = {
            {Name = "Port Town", Level = 1500, Position = Vector3.new(0, 0, 0)},
            {Name = "Hydra Island", Level = 1575, Position = Vector3.new(0, 0, 0)},
            {Name = "Great Tree", Level = 1700, Position = Vector3.new(0, 0, 0)},
            {Name = "Floating Turtle", Level = 1775, Position = Vector3.new(0, 0, 0)},
            {Name = "Castle on the Sea", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Haunted Castle", Level = 1975, Position = Vector3.new(0, 0, 0)},
            {Name = "Sea of Treats", Level = 2075, Position = Vector3.new(0, 0, 0)},
            {Name = "Tiki Outpost", Level = 2450, Position = Vector3.new(0, 0, 0)},
            {Name = "Submerged Island", Level = 2600, Position = Vector3.new(0, 0, 0)},
            {Name = "Treasure Island", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Kitsune Island", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Mirage Island", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Frozen Dimension", Level = 0, Position = Vector3.new(0, 0, 0)},
            {Name = "Prehistoric Island", Level = 0, Position = Vector3.new(0, 0, 0)}
        }
    }
}

-- Sea Event Data
local SeaEvents = {
    "SeaBeasts",
    "ShipRaid",
    "RumblingWaters",
    "Terrorshark",
    "Leviathan",
    "FrozenDimension",
    "PrehistoricIsland",
    "KitsuneIsland",
    "MirageIsland"
}

-- Quest Data per Level (Auto Farm Matching)
local QuestData = {
    -- First Sea
    [1] = {Quest = "Bandit", NPC = "Bandit Quest Giver", Island = "Pirate Starter Island"},
    [10] = {Quest = "Monkey", NPC = "Jungle Quest Giver", Island = "Jungle"},
    [15] = {Quest = "Gorilla", NPC = "Jungle Quest Giver", Island = "Jungle"},
    [30] = {Quest = "Pirate", NPC = "Pirate Village Quest Giver", Island = "Pirate Village"},
    [40] = {Quest = "Brute", NPC = "Pirate Village Quest Giver", Island = "Pirate Village"},
    [60] = {Quest = "Desert Bandit", NPC = "Desert Quest Giver", Island = "Desert"},
    [75] = {Quest = "Desert Officer", NPC = "Desert Quest Giver", Island = "Desert"},
    [90] = {Quest = "Snow Bandit", NPC = "Frozen Village Quest Giver", Island = "Frozen Village"},
    [100] = {Quest = "Snowman", NPC = "Frozen Village Quest Giver", Island = "Frozen Village"},
    [120] = {Quest = "Chief Petty Officer", NPC = "Marine Fortress Quest Giver", Island = "Marine Fortress"},
    [150] = {Quest = "Sky Bandit", NPC = "Skylands Quest Giver", Island = "Skylands"},
    [175] = {Quest = "Dark Master", NPC = "Skylands Quest Giver", Island = "Skylands"},
    [190] = {Quest = "Prisoner", NPC = "Prison Quest Giver", Island = "Prison"},
    [225] = {Quest = "Dangerous Prisoner", NPC = "Prison Quest Giver", Island = "Prison"},
    [250] = {Quest = "Toga Warrior", NPC = "Colosseum Quest Giver", Island = "Colosseum"},
    [275] = {Quest = "Gladiator", NPC = "Colosseum Quest Giver", Island = "Colosseum"},
    [300] = {Quest = "Military Soldier", NPC = "Magma Village Quest Giver", Island = "Magma Village"},
    [325] = {Quest = "Military Spy", NPC = "Magma Village Quest Giver", Island = "Magma Village"},
    [375] = {Quest = "Fishman Warrior", NPC = "Underwater City Quest Giver", Island = "Underwater City"},
    [400] = {Quest = "Fishman Commando", NPC = "Underwater City Quest Giver", Island = "Underwater City"},
    [450] = {Quest = "God's Guard", NPC = "Upper Skylands Quest Giver", Island = "Upper Skylands"},
    [475] = {Quest = "Shanda", NPC = "Upper Skylands Quest Giver", Island = "Upper Skylands"},
    [500] = {Quest = "Royal Squad", NPC = "Upper Skylands Quest Giver", Island = "Upper Skylands"},
    [525] = {Quest = "Royal Soldier", NPC = "Upper Skylands Quest Giver", Island = "Upper Skylands"},
    [625] = {Quest = "Galley Pirate", NPC = "Fountain City Quest Giver", Island = "Fountain City"},
    [650] = {Quest = "Galley Captain", NPC = "Fountain City Quest Giver", Island = "Fountain City"},
    
    -- Second Sea
    [700] = {Quest = "Raider", NPC = "Kingdom of Rose Quest Giver", Island = "Kingdom of Rose"},
    [725] = {Quest = "Mercenary", NPC = "Kingdom of Rose Quest Giver", Island = "Kingdom of Rose"},
    [750] = {Quest = "Swan Pirate", NPC = "Kingdom of Rose Quest Giver", Island = "Kingdom of Rose"},
    [775] = {Quest = "Factory Staff", NPC = "Kingdom of Rose Quest Giver", Island = "Kingdom of Rose"},
    [875] = {Quest = "Marine Lieutenant", NPC = "Green Zone Quest Giver", Island = "Green Zone"},
    [900] = {Quest = "Marine Captain", NPC = "Green Zone Quest Giver", Island = "Green Zone"},
    [950] = {Quest = "Zombie", NPC = "Graveyard Quest Giver", Island = "Graveyard"},
    [975] = {Quest = "Vampire", NPC = "Graveyard Quest Giver", Island = "Graveyard"},
    [1000] = {Quest = "Snow Trooper", NPC = "Snow Mountain Quest Giver", Island = "Snow Mountain"},
    [1025] = {Quest = "Winter Warrior", NPC = "Snow Mountain Quest Giver", Island = "Snow Mountain"},
    [1050] = {Quest = "Lab Subordinate", NPC = "Hot and Cold Quest Giver", Island = "Hot and Cold"},
    [1075] = {Quest = "Horned Warrior", NPC = "Hot and Cold Quest Giver", Island = "Hot and Cold"},
    [1100] = {Quest = "Magma Ninja", NPC = "Hot and Cold Quest Giver", Island = "Hot and Cold"},
    [1125] = {Quest = "Lava Princess", NPC = "Hot and Cold Quest Giver", Island = "Hot and Cold"},
    [1175] = {Quest = "Ship Deckhand", NPC = "Cursed Ship Quest Giver", Island = "Cursed Ship"},
    [1200] = {Quest = "Ship Engineer", NPC = "Cursed Ship Quest Giver", Island = "Cursed Ship"},
    [1225] = {Quest = "Ship Steward", NPC = "Cursed Ship Quest Giver", Island = "Cursed Ship"},
    [1250] = {Quest = "Ship Officer", NPC = "Cursed Ship Quest Giver", Island = "Cursed Ship"},
    [1275] = {Quest = "Arctic Warrior", NPC = "Ice Castle Quest Giver", Island = "Ice Castle"},
    [1300] = {Quest = "Snow Lurker", NPC = "Ice Castle Quest Giver", Island = "Ice Castle"},
    [1325] = {Quest = "Sea Soldier", NPC = "Forgotten Island Quest Giver", Island = "Forgotten Island"},
    [1350] = {Quest = "Water Fighter", NPC = "Forgotten Island Quest Giver", Island = "Forgotten Island"},
    
    -- Third Sea
    [1500] = {Quest = "Pirate Millionaire", NPC = "Port Town Quest Giver", Island = "Port Town"},
    [1525] = {Quest = "Pistol Billionaire", NPC = "Port Town Quest Giver", Island = "Port Town"},
    [1575] = {Quest = "Dragon Crew Warrior", NPC = "Hydra Island Quest Giver", Island = "Hydra Island"},
    [1600] = {Quest = "Dragon Crew Archer", NPC = "Hydra Island Quest Giver", Island = "Hydra Island"},
    [1625] = {Quest = "Hydra Enforcer", NPC = "Hydra Island Quest Giver", Island = "Hydra Island"},
    [1650] = {Quest = "Venomous Assailant", NPC = "Hydra Island Quest Giver", Island = "Hydra Island"},
    [1700] = {Quest = "Marine Commodore", NPC = "Great Tree Quest Giver", Island = "Great Tree"},
    [1725] = {Quest = "Marine Rear Admiral", NPC = "Great Tree Quest Giver", Island = "Great Tree"},
    [1775] = {Quest = "Fishman Raider", NPC = "Floating Turtle Quest Giver", Island = "Floating Turtle"},
    [1800] = {Quest = "Fishman Captain", NPC = "Floating Turtle Quest Giver", Island = "Floating Turtle"},
    [1825] = {Quest = "Forest Pirate", NPC = "Floating Turtle Quest Giver", Island = "Floating Turtle"},
    [1850] = {Quest = "Mythological Pirate", NPC = "Floating Turtle Quest Giver", Island = "Floating Turtle"},
    [1875] = {Quest = "Jungle Pirate", NPC = "Floating Turtle Quest Giver", Island = "Floating Turtle"},
    [1900] = {Quest = "Musketeer Pirate", NPC = "Floating Turtle Quest Giver", Island = "Floating Turtle"},
    [1975] = {Quest = "Reborn Skeleton", NPC = "Haunted Castle Quest Giver", Island = "Haunted Castle"},
    [2000] = {Quest = "Living Zombie", NPC = "Haunted Castle Quest Giver", Island = "Haunted Castle"},
    [2025] = {Quest = "Demonic Soul", NPC = "Haunted Castle Quest Giver", Island = "Haunted Castle"},
    [2050] = {Quest = "Possessed Mummy", NPC = "Haunted Castle Quest Giver", Island = "Haunted Castle"},
    [2075] = {Quest = "Peanut Scout", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2100] = {Quest = "Peanut President", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2125] = {Quest = "Ice Cream Chef", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2150] = {Quest = "Ice Cream Commander", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2175] = {Quest = "Cookie Crafter", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2200] = {Quest = "Cake Guard", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2225] = {Quest = "Baking Staff", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2250] = {Quest = "Head Baker", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2275] = {Quest = "Cocoa Warrior", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2300] = {Quest = "Chocolate Bar Battler", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2325] = {Quest = "Sweet Thief", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2350] = {Quest = "Candy Rebel", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2375] = {Quest = "Candy Pirate", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2400] = {Quest = "Snow Conjurer", NPC = "Sea of Treats Quest Giver", Island = "Sea of Treats"},
    [2450] = {Quest = "Isle Outlaw", NPC = "Tiki Outpost Quest Giver", Island = "Tiki Outpost"},
    [2475] = {Quest = "Island Boy", NPC = "Tiki Outpost Quest Giver", Island = "Tiki Outpost"},
    [2500] = {Quest = "Sun-kissed Warrior", NPC = "Tiki Outpost Quest Giver", Island = "Tiki Outpost"},
    [2525] = {Quest = "Isle Champion", NPC = "Tiki Outpost Quest Giver", Island = "Tiki Outpost"},
    [2600] = {Quest = "Reef Bandit", NPC = "Submerged Island Quest Giver", Island = "Submerged Island"},
    [2625] = {Quest = "Coral Pirate", NPC = "Submerged Island Quest Giver", Island = "Submerged Island"},
    [2650] = {Quest = "Sea Chanter", NPC = "Submerged Island Quest Giver", Island = "Submerged Island"},
    [2675] = {Quest = "Ocean Prophet", NPC = "Submerged Island Quest Giver", Island = "Submerged Island"}
}

-- ============================================
-- BYPASS TP FUNCTION (Anti-Detect)
-- ============================================
local function BypassTeleport(targetCFrame, speed)
    speed = speed or 350
    local distance = (targetCFrame.Position - HRP.Position).Magnitude
    local duration = distance / speed
    
    -- Method 1: Tween (Smooth, less detectable)
    local tween = TweenService:Create(HRP, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        CFrame = targetCFrame
    })
    tween:Play()
    tween.Completed:Wait()
    
    -- Method 2: Velocity manipulation (Alternative)
    --[[
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(400000, 400000, 400000)
    bv.Velocity = (targetCFrame.Position - HRP.Position).Unit * speed
    bv.Parent = HRP
    task.wait(duration)
    bv:Destroy()
    HRP.CFrame = targetCFrame
    --]]
end

-- Faster bypass for short distances
local function FastBypassTP(targetPos)
    local distance = (targetPos - HRP.Position).Magnitude
    if distance < 100 then
        HRP.CFrame = CFrame.new(targetPos)
    else
        local waypoints = {}
        local steps = math.ceil(distance / 500)
        for i = 1, steps do
            local t = i / steps
            local pos = HRP.Position:Lerp(targetPos, t)
            table.insert(waypoints, pos)
        end
        
        for _, pos in ipairs(waypoints) do
            HRP.CFrame = CFrame.new(pos)
            HRP.Velocity = Vector3.new(0, 0, 0)
            task.wait(0.05)
        end
    end
end

-- ============================================
-- SEA DETECTION FUNCTION
-- ============================================
local function DetectCurrentSea()
    local level = LocalPlayer.Data.Level.Value
    
    if level >= 1500 then
        return 3, "Third Sea"
    elseif level >= 700 then
        return 2, "Second Sea"
    else
        return 1, "First Sea"
    end
end

-- ============================================
-- ISLAND SCANNER FUNCTION
-- ============================================
local function ScanNearbyIslands()
    local nearby = {}
    local seaNum, seaName = DetectCurrentSea()
    
    for _, island in pairs(SeaData[seaNum].Islands) do
        -- Scan workspace for island models
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Model") and (obj.Name:find(island.Name) or island.Name:find(obj.Name)) then
                if obj:FindFirstChildWhichIsA("BasePart") then
                    local pos = obj:FindFirstChildWhichIsA("BasePart").Position
                    local dist = (pos - HRP.Position).Magnitude
                    table.insert(nearby, {
                        Name = island.Name,
                        Distance = math.floor(dist),
                        LevelReq = island.Level,
                        Position = pos
                    })
                end
            end
        end
    end
    
    -- Sort by distance
    table.sort(nearby, function(a, b) return a.Distance < b.Distance end)
    return nearby
end

-- ============================================
-- AUTO FARM LEVEL MATCHING
-- ============================================
local function GetOptimalQuest(level)
    local bestQuest = nil
    local bestLevel = 0
    
    for reqLevel, quest in pairs(QuestData) do
        if level >= reqLevel and reqLevel > bestLevel then
            bestQuest = quest
            bestLevel = reqLevel
        end
    end
    
    return bestQuest
end

-- ============================================
-- THEME CONFIGURATION
-- ============================================
local Theme = {
    Background = Color3.fromRGB(12, 12, 20),
    BackgroundLight = Color3.fromRGB(22, 22, 35),
    BackgroundDark = Color3.fromRGB(8, 8, 15),
    Accent = Color3.fromRGB(0, 255, 170),
    AccentDark = Color3.fromRGB(0, 200, 130),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(160, 160, 180),
    Danger = Color3.fromRGB(255, 60, 60),
    Success = Color3.fromRGB(0, 255, 150),
    Warning = Color3.fromRGB(255, 200, 0),
    Info = Color3.fromRGB(0, 150, 255)
}

-- ============================================
-- GUI SETUP
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NanoXyinV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 700, 0, 450)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -225)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Theme.Accent
mainStroke.Thickness = 1.5
mainStroke.Transparency = 0.6
mainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = Theme.BackgroundDark
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

local topGradient = Instance.new("UIGradient")
topGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Accent),
    ColorSequenceKeypoint.new(0.5, Theme.AccentDark),
    ColorSequenceKeypoint.new(1, Theme.BackgroundDark)
})
topGradient.Rotation = 0
topGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(1, 1)
})
topGradient.Parent = TopBar

-- Logo with animated text
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 250, 1, 0)
Logo.Position = UDim2.new(0, 20, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "◆ NANOXYIN v3.0"
Logo.TextColor3 = Theme.Accent
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 20
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

-- Sea Indicator
local SeaIndicator = Instance.new("TextLabel")
SeaIndicator.Name = "SeaIndicator"
SeaIndicator.Size = UDim2.new(0, 150, 0, 20)
SeaIndicator.Position = UDim2.new(0, 20, 0, 32)
SeaIndicator.BackgroundTransparency = 1
SeaIndicator.Text = "Detecting Sea..."
SeaIndicator.TextColor3 = Theme.Info
SeaIndicator.Font = Enum.Font.Gotham
SeaIndicator.TextSize = 11
SeaIndicator.TextXAlignment = Enum.TextXAlignment.Left
SeaIndicator.Parent = TopBar

-- Update Sea Indicator
spawn(function()
    while task.wait(2) do
        pcall(function()
            local seaNum, seaName = DetectCurrentSea()
            local level = LocalPlayer.Data.Level.Value
            SeaIndicator.Text = seaName .. " | Lv." .. level
            SeaIndicator.TextColor3 = seaNum == 3 and Theme.Success or (seaNum == 2 and Theme.Warning or Theme.Info)
        end)
    end
end)

-- Version
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 150, 1, 0)
VersionLabel.Position = UDim2.new(1, -160, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "By @XyrooXellz"
VersionLabel.TextColor3 = Theme.TextDark
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 11
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.Parent = TopBar

-- Close & Minimize
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -40, 0, 9)
CloseBtn.BackgroundColor3 = Theme.Danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

CloseBtn.MouseButton1Click:Connect(function()
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.4)
    task.wait(0.4)
    ScreenGui:Destroy()
end)

-- ============================================
-- SIDEBAR
-- ============================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -50)
Sidebar.Position = UDim2.new(0, 0, 0, 50)
Sidebar.BackgroundColor3 = Theme.BackgroundDark
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 14)

-- ============================================
-- CONTENT FRAME
-- ============================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -160, 1, -60)
ContentFrame.Position = UDim2.new(0, 155, 0, 55)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ============================================
-- UTILITY FUNCTIONS GUI
-- ============================================
local function Tween(obj, props, duration, style, dir)
    TweenService:Create(obj, TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end

local function Notify(title, text, duration)
    duration = duration or 3
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 340, 0, 75)
    notif.Position = UDim2.new(1, 20, 1, -95)
    notif.BackgroundColor3 = Theme.BackgroundLight
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 12)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Accent
    stroke.Thickness = 1.5
    stroke.Transparency = 0.5
    stroke.Parent = notif
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 35, 0, 35)
    icon.Position = UDim2.new(0, 12, 0, 12)
    icon.BackgroundTransparency = 1
    icon.Text = "◆"
    icon.TextColor3 = Theme.Accent
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 24
    icon.Parent = notif
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -60, 0, 22)
    titleLbl.Position = UDim2.new(0, 50, 0, 8)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = title
    titleLbl.TextColor3 = Theme.Text
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 15
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.Parent = notif
    
    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, -60, 0, 40)
    textLbl.Position = UDim2.new(0, 50, 0, 30)
    textLbl.BackgroundTransparency = 1
    textLbl.Text = text
    textLbl.TextColor3 = Theme.TextDark
    textLbl.Font = Enum.Font.Gotham
    textLbl.TextSize = 12
    textLbl.TextXAlignment = Enum.TextXAlignment.Left
    textLbl.TextWrapped = true
    textLbl.Parent = notif
    
    Tween(notif, {Position = UDim2.new(1, -360, 1, -95)}, 0.5, Enum.EasingStyle.Back)
    task.delay(duration, function()
        Tween(notif, {Position = UDim2.new(1, 20, 1, -95)}, 0.4)
        task.wait(0.4)
        notif:Destroy()
    end)
end

-- ============================================
-- TAB CREATOR
-- ============================================
local function CreateTab(name)
    local tab = Instance.new("ScrollingFrame")
    tab.Name = name .. "Tab"
    tab.Size = UDim2.new(1, 0, 1, 0)
    tab.BackgroundTransparency = 1
    tab.ScrollBarThickness = 4
    tab.ScrollBarImageColor3 = Theme.Accent
    tab.Visible = false
    tab.Parent = ContentFrame
    
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = tab
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = tab
    
    return tab
end

-- Toggle Switch
local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 48)
    frame.BackgroundColor3 = Theme.BackgroundLight
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.Accent
    stroke.Thickness = 0.5
    stroke.Transparency = 0.8
    stroke.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 220, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 52, 0, 28)
    switch.Position = UDim2.new(1, -62, 0.5, -14)
    switch.BackgroundColor3 = Theme.BackgroundDark
    switch.BorderSizePixel = 0
    switch.Parent = frame
    Instance.new("UICorner", switch).CornerRadius = UDim.new(0, 14)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 22, 0, 22)
    knob.Position = UDim2.new(0, 3, 0.5, -11)
    knob.BackgroundColor3 = Theme.TextDark
    knob.BorderSizePixel = 0
    knob.Parent = switch
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 11)
    
    local enabled = false
    local click = Instance.new("TextButton")
    click.Size = UDim2.new(1, 0, 1, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Parent = switch
    
    click.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Tween(switch, {BackgroundColor3 = Theme.Accent}, 0.2)
            Tween(knob, {Position = UDim2.new(0, 27, 0.5, -11), BackgroundColor3 = Theme.Text}, 0.2)
            stroke.Transparency = 0.3
        else
            Tween(switch, {BackgroundColor3 = Theme.BackgroundDark}, 0.2)
            Tween(knob, {Position = UDim2.new(0, 3, 0.5, -11), BackgroundColor3 = Theme.TextDark}, 0.2)
            stroke.Transparency = 0.8
        end
        callback(enabled)
    end)
    
    return frame, function(state)
        enabled = state
        if enabled then
            switch.BackgroundColor3 = Theme.Accent
            knob.Position = UDim2.new(0, 27, 0.5, -11)
            knob.BackgroundColor3 = Theme.Text
            stroke.Transparency = 0.3
        else
            switch.BackgroundColor3 = Theme.BackgroundDark
            knob.Position = UDim2.new(0, 3, 0.5, -11)
            knob.BackgroundColor3 = Theme.TextDark
            stroke.Transparency = 0.8
        end
    end
end

-- Button
local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 300, 0, 42)
    btn.BackgroundColor3 = Theme.Accent
    btn.Text = text
    btn.TextColor3 = Theme.Background
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.AccentDark}, 0.2)
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.Accent}, 0.2)
    end)
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

-- Dropdown
local function CreateDropdown(parent, text, options, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 45)
    frame.BackgroundColor3 = Theme.BackgroundLight
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 120, 0, 32)
    dropdown.Position = UDim2.new(1, -130, 0.5, -16)
    dropdown.BackgroundColor3 = Theme.BackgroundDark
    dropdown.Text = options[1] or "Select"
    dropdown.TextColor3 = Theme.Text
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 12
    dropdown.Parent = frame
    Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 8)
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 0, 20)
    arrow.Position = UDim2.new(1, -22, 0, 6)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Theme.TextDark
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 10
    arrow.Parent = dropdown
    
    local open = false
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(0, 120, 0, #options * 30)
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Theme.BackgroundDark
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 10
    optionsFrame.Parent = dropdown
    Instance.new("UICorner", optionsFrame).CornerRadius = UDim.new(0, 8)
    
    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 30)
        optBtn.Position = UDim2.new(0, 0, 0, (i-1) * 30)
        optBtn.BackgroundTransparency = 1
        optBtn.Text = opt
        optBtn.TextColor3 = Theme.TextDark
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 12
        optBtn.ZIndex = 11
        optBtn.Parent = optionsFrame
        
        optBtn.MouseEnter:Connect(function()
            optBtn.BackgroundColor3 = Theme.BackgroundLight
            optBtn.BackgroundTransparency = 0
        end)
        optBtn.MouseLeave:Connect(function()
            optBtn.BackgroundTransparency = 1
        end)
        optBtn.MouseButton1Click:Connect(function()
            dropdown.Text = opt
            callback(opt)
            open = false
            optionsFrame.Visible = false
            arrow.Text = "▼"
        end)
    end
    
    dropdown.MouseButton1Click:Connect(function()
        open = not open
        optionsFrame.Visible = open
        arrow.Text = open and "▲" or "▼"
    end)
    
    return frame
end

-- Info Display
local function CreateInfoDisplay(parent, label, value)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 35)
    frame.BackgroundColor3 = Theme.BackgroundLight
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 150, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Theme.TextDark
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    local val = Instance.new("TextLabel")
    val.Name = "ValueLabel"
    val.Size = UDim2.new(0, 130, 1, 0)
    val.Position = UDim2.new(1, -135, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = value
    val.TextColor3 = Theme.Accent
    val.Font = Enum.Font.GothamBold
    val.TextSize = 12
    val.TextXAlignment = Enum.TextXAlignment.Right
    val.Parent = frame
    
    return frame, val
end

-- ============================================
-- CREATE TABS
-- ============================================
local AutoFarmTab = CreateTab("AutoFarm")
local CombatTab = CreateTab("Combat")
local SeaEventTab = CreateTab("SeaEvent")
local IslandTab = CreateTab("Island")
local TeleportTab = CreateTab("Teleport")
local ESPtab = CreateTab("ESP")
local MiscTab = CreateTab("Misc")

-- Tab Buttons
local function CreateTabButton(name, icon, tabFrame)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 135, 0, 38)
    btn.BackgroundColor3 = Theme.Background
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Theme.TextDark
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = Theme.Accent
    btnStroke.Thickness = 1
    btnStroke.Transparency = 1
    btnStroke.Parent = btn
    
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
    end)
    btn.MouseLeave:Connect(function()
        if not tabFrame.Visible then
            Tween(btn, {BackgroundColor3 = Theme.Background}, 0.2)
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") then child.Visible = false end
        end
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                Tween(child, {BackgroundColor3 = Theme.Background}, 0.2)
                local s = child:FindFirstChildOfClass("UIStroke")
                if s then s.Transparency = 1 end
            end
        end
        tabFrame.Visible = true
        Tween(btn, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
        btnStroke.Transparency = 0.4
    end)
    
    return btn
end

CreateTabButton("Auto Farm", "⚔️", AutoFarmTab)
CreateTabButton("Combat", "🛡️", CombatTab)
CreateTabButton("Sea Event", "🌊", SeaEventTab)
CreateTabButton("Island", "🏝️", IslandTab)
CreateTabButton("Teleport", "🌀", TeleportTab)
CreateTabButton("ESP", "👁️", ESPtab)
CreateTabButton("Misc", "⚙️", MiscTab)

AutoFarmTab.Visible = true

-- ============================================
-- AUTO FARM TAB - LEVEL MATCHING
-- ============================================

-- Current Level Display
local LevelInfo, LevelValue = CreateInfoDisplay(AutoFarmTab, "Current Level:", "Loading...")
spawn(function()
    while task.wait(1) do
        pcall(function()
            LevelValue.Text = tostring(LocalPlayer.Data.Level.Value)
        end)
    end
end)

-- Optimal Quest Display
local QuestInfo, QuestValue = CreateInfoDisplay(AutoFarmTab, "Optimal Quest:", "Scanning...")
spawn(function()
    while task.wait(2) do
        pcall(function()
            local level = LocalPlayer.Data.Level.Value
            local quest = GetOptimalQuest(level)
            if quest then
                QuestValue.Text = quest.Quest .. " (" .. quest.Island .. ")"
            else
                QuestValue.Text = "No quest available"
            end
        end)
    end
end)

-- Auto Farm Level Matching
local AutoFarmMatchEnabled = false
CreateToggle(AutoFarmTab, "Auto Farm (Level Match)", function(enabled)
    AutoFarmMatchEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Level Matching Farm Activated", 2)
        spawn(function()
            while AutoFarmMatchEnabled and task.wait() do
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local quest = GetOptimalQuest(level)
                    if not quest then return end
                    
                    -- Auto take quest
                    local args = {[1] = "StartQuest", [2] = quest.Quest, [3] = level}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    
                    -- Find and farm enemy
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") 
                           and enemy.Humanoid.Health > 0 then
                            if enemy.Name:find(quest.Quest) or enemy.Name == quest.Quest then
                                local targetPos = enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0)
                                FastBypassTP(targetPos)
                                
                                local tool = Character:FindFirstChildOfClass("Tool") 
                                            or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool.Parent = Character
                                    tool:Activate()
                                end
                                
                                -- Auto Haki
                                local args2 = {[1] = "Buso"}
                                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args2))
                                
                                task.wait(0.1)
                                break
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Level Matching Farm Deactivated", 2)
    end
end)

-- Auto Farm Boss
local AutoBossEnabled = false
CreateToggle(AutoFarmTab, "Auto Farm Boss", function(enabled)
    AutoBossEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Boss Hunt Activated", 2)
        spawn(function()
            while AutoBossEnabled and task.wait() do
                pcall(function()
                    local bosses = {
                        "The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral",
                        "Warden", "Saber Expert", "Chief Warden", "Swan", "Magma Admiral",
                        "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral",
                        "Don Swan", "Darkbeard", "Rip_Indra", "Order", "Soul Reaper",
                        "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant",
                        "Beautiful Pirate", "Longma", "Cursed Skeleton Boss", "Cake Prince"
                    }
                    for _, bossName in pairs(bosses) do
                        local boss = Workspace.Enemies:FindFirstChild(bossName) 
                                     or Workspace.ReplicatedStorage:FindFirstChild(bossName)
                        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                            FastBypassTP(boss.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                            local tool = Character:FindFirstChildOfClass("Tool") 
                                        or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                            if tool then
                                tool.Parent = Character
                                tool:Activate()
                            end
                            task.wait(0.2)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Boss Hunt Deactivated", 2)
    end
end)

-- Auto Collect Fruit
local AutoFruitEnabled = false
CreateToggle(AutoFarmTab, "Auto Collect Fruit", function(enabled)
    AutoFruitEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Fruit Collector Activated", 2)
        spawn(function()
            while AutoFruitEnabled and task.wait(1) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            if obj.Name:find("Fruit") then
                                FastBypassTP(obj.Handle.Position)
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Fruit Collector Deactivated", 2)
    end
end)

-- Auto Stats
local AutoStatsEnabled = false
CreateToggle(AutoFarmTab, "Auto Stats (Melee)", function(enabled)
    AutoStatsEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Auto Stats Activated", 2)
        spawn(function()
            while AutoStatsEnabled and task.wait(1) do
                pcall(function()
                    local args = {[1] = "AddPoint", [2] = "Melee", [3] = 1}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end)
            end
        end)
    else
        Notify("Auto Farm", "Auto Stats Deactivated", 2)
    end
end)

-- ============================================
-- COMBAT TAB - RAID KILL AURA
-- ============================================

-- Raid Kill Aura
local RaidKillAuraEnabled = false
CreateToggle(CombatTab, "Raid Kill Aura", function(enabled)
    RaidKillAuraEnabled = enabled
    if enabled then
        Notify("Combat", "Raid Kill Aura Activated", 2)
        spawn(function()
            while RaidKillAuraEnabled and task.wait(0.1) do
                pcall(function()
                    -- Detect raid enemies (they have specific names/patterns)
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                            local dist = (enemy.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < 80 and enemy.Humanoid.Health > 0 then
                                -- Check if it's a raid enemy
                                local isRaidEnemy = enemy.Name:find("Raid") or 
                                                   enemy.Name:find("Dungeon") or
                                                   enemy.Name:find("Cursed") or
                                                   enemy.Name:find("Ship")
                                
                                if isRaidEnemy or dist < 30 then
                                    FastBypassTP(enemy.HumanoidRootPart.Position + Vector3.new(0, 25, 0))
                                    
                                    local tool = Character:FindFirstChildOfClass("Tool") 
                                                or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool.Parent = Character
                                        tool:Activate()
                                    end
                                    
                                    -- Spam fruit skills for raid
                                    local fruit = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                    if fruit and fruit:FindFirstChild("RemoteEvent") then
                                        for _, key in pairs({"Z", "X", "C", "V", "F"}) do
                                            local args = {[1] = key}
                                            fruit.RemoteEvent:FireServer(unpack(args))
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Combat", "Raid Kill Aura Deactivated", 2)
    end
end)

-- Silent Aim
local SilentAimEnabled = false
CreateToggle(CombatTab, "Silent Aim", function(enabled)
    SilentAimEnabled = enabled
    if enabled then
        Notify("Combat", "Silent Aim Activated", 2)
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and tostring(self):find("Remote") and SilentAimEnabled then
                local args = {...}
                if typeof(args[1]) == "Vector3" then
                    local closest = nil
                    local minDist = math.huge
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (player.Character.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < minDist and dist < 200 then
                                minDist = dist
                                closest = player
                            end
                        end
                    end
                    if closest then
                        args[1] = closest.Character.HumanoidRootPart.Position + Vector3.new(0, 2, 0)
                    end
                end
                return old(self, unpack(args))
            end
            return old(self, ...)
        end)
        
        setreadonly(mt, true)
    else
        Notify("Combat", "Silent Aim Deactivated", 2)
    end
end)

-- Kill Aura
local KillAuraEnabled = false
CreateToggle(CombatTab, "Kill Aura", function(enabled)
    KillAuraEnabled = enabled
    if enabled then
        Notify("Combat", "Kill Aura Activated", 2)
        spawn(function()
            while KillAuraEnabled and task.wait(0.1) do
                pcall(function()
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                            local dist = (enemy.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < 50 and enemy.Humanoid.Health > 0 then
                                local tool = Character:FindFirstChildOfClass("Tool") 
                                            or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool.Parent = Character
                                    tool:Activate()
                                end
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Combat", "Kill Aura Deactivated", 2)
    end
end)

-- Fast Attack
local FastAttackEnabled = false
CreateToggle(CombatTab, "Fast Attack", function(enabled)
    FastAttackEnabled = enabled
    if enabled then
        Notify("Combat", "Fast Attack Activated", 2)
        spawn(function()
            while FastAttackEnabled and task.wait(0.01) do
                pcall(function()
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end)
            end
        end)
    else
        Notify("Combat", "Fast Attack Deactivated", 2)
    end
end)

-- Auto Buso
local AutoBusoEnabled = false
CreateToggle(CombatTab, "Auto Buso Haki", function(enabled)
    AutoBusoEnabled = enabled
    if enabled then
        Notify("Combat", "Auto Buso Activated", 2)
        spawn(function()
            while AutoBusoEnabled and task.wait(3) do
                pcall(function()
                    local args = {[1] = "Buso"}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end)
            end
        end)
    else
        Notify("Combat", "Auto Buso Deactivated", 2)
    end
end)

-- ============================================
-- SEA EVENT TAB
-- ============================================

-- Sea Beast Hunter
local SeaBeastEnabled = false
CreateToggle(SeaEventTab, "Auto Sea Beast", function(enabled)
    SeaBeastEnabled = enabled
    if enabled then
        Notify("Sea Event", "Sea Beast Hunter Activated", 2)
        spawn(function()
            while SeaBeastEnabled and task.wait(0.5) do
                pcall(function()
                    for _, beast in pairs(Workspace.SeaBeasts:GetChildren()) do
                        if beast:FindFirstChild("HumanoidRootPart") then
                            FastBypassTP(beast.HumanoidRootPart.Position + Vector3.new(0, 50, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Sea Beast Hunter Deactivated", 2)
    end
end)

-- Auto Ship Raid
local ShipRaidEnabled = false
CreateToggle(SeaEventTab, "Auto Ship Raid", function(enabled)
    ShipRaidEnabled = enabled
    if enabled then
        Notify("Sea Event", "Ship Raid Activated", 2)
        spawn(function()
            while ShipRaidEnabled and task.wait(1) do
                pcall(function()
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find("Ship") and enemy:FindFirstChild("HumanoidRootPart") then
                            FastBypassTP(enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Ship Raid Deactivated", 2)
    end
end)

-- Auto Terrorshark
local TerrorEnabled = false
CreateToggle(SeaEventTab, "Auto Terrorshark", function(enabled)
    TerrorEnabled = enabled
    if enabled then
        Notify("Sea Event", "Terrorshark Hunter Activated", 2)
        spawn(function()
            while TerrorEnabled and task.wait(0.5) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Terror") and obj:FindFirstChild("HumanoidRootPart") then
                            FastBypassTP(obj.HumanoidRootPart.Position + Vector3.new(0, 40, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Terrorshark Hunter Deactivated", 2)
    end
end)

-- Auto Leviathan
local LeviathanEnabled = false
CreateToggle(SeaEventTab, "Auto Leviathan", function(enabled)
    LeviathanEnabled = enabled
    if enabled then
        Notify("Sea Event", "Leviathan Hunter Activated", 2)
        spawn(function()
            while LeviathanEnabled and task.wait(0.5) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Leviathan") and obj:FindFirstChild("HumanoidRootPart") then
                            FastBypassTP(obj.HumanoidRootPart.Position + Vector3.new(0, 60, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Leviathan Hunter Deactivated", 2)
    end
end)

-- Auto Mirage Island
local MirageEnabled = false
CreateToggle(SeaEventTab, "Auto Mirage Island", function(enabled)
    MirageEnabled = enabled
    if enabled then
        Notify("Sea Event", "Mirage Island Hunter Activated", 2)
        spawn(function()
            while MirageEnabled and task.wait(2) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Mirage") and obj:FindFirstChildWhichIsA("BasePart") then
                            FastBypassTP(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Mirage Island Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Mirage Island Hunter Deactivated", 2)
    end
end)

-- Auto Kitsune Island
local KitsuneIslandEnabled = false
CreateToggle(SeaEventTab, "Auto Kitsune Island", function(enabled)
    KitsuneIslandEnabled = enabled
    if enabled then
        Notify("Sea Event", "Kitsune Island Hunter Activated", 2)
        spawn(function()
            while KitsuneIslandEnabled and task.wait(2) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Kitsune") and obj:FindFirstChildWhichIsA("BasePart") then
                            FastBypassTP(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Kitsune Island Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Kitsune Island Hunter Deactivated", 2)
    end
end)

-- Auto Prehistoric Island
local PrehistoricEnabled = false
CreateToggle(SeaEventTab, "Auto Prehistoric Island", function(enabled)
    PrehistoricEnabled = enabled
    if enabled then
        Notify("Sea Event", "Prehistoric Island Hunter Activated", 2)
        spawn(function()
            while PrehistoricEnabled and task.wait(2) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Prehistoric") and obj:FindFirstChildWhichIsA("BasePart") then
                            FastBypassTP(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Prehistoric Island Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Prehistoric Island Hunter Deactivated", 2)
    end
end)

-- Auto Frozen Dimension
local FrozenDimEnabled = false
CreateToggle(SeaEventTab, "Auto Frozen Dimension", function(enabled)
    FrozenDimEnabled = enabled
    if enabled then
        Notify("Sea Event", "Frozen Dimension Hunter Activated", 2)
        spawn(function()
            while FrozenDimEnabled and task.wait(2) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Frozen") and obj:FindFirstChildWhichIsA("BasePart") then
                            FastBypassTP(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Frozen Dimension Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Frozen Dimension Hunter Deactivated", 2)
    end
end)

-- ============================================
-- ISLAND TAB - SCANNER
-- ============================================

-- Island Scanner Display
local ScannerFrame = Instance.new("Frame")
ScannerFrame.Size = UDim2.new(0, 300, 0, 200)
ScannerFrame.BackgroundColor3 = Theme.BackgroundLight
ScannerFrame.BorderSizePixel = 0
ScannerFrame.Parent = IslandTab
Instance.new("UICorner", ScannerFrame).CornerRadius = UDim.new(0, 10)

local ScannerTitle = Instance.new("TextLabel")
ScannerTitle.Size = UDim2.new(1, 0, 0, 25)
ScannerTitle.BackgroundTransparency = 1
ScannerTitle.Text = "🏝️ NEARBY ISLANDS"
ScannerTitle.TextColor3 = Theme.Accent
ScannerTitle.Font = Enum.Font.GothamBold
ScannerTitle.TextSize = 14
ScannerTitle.Parent = ScannerFrame

local ScannerList = Instance.new("ScrollingFrame")
ScannerList.Size = UDim2.new(1, -10, 1, -35)
ScannerList.Position = UDim2.new(0, 5, 0, 30)
ScannerList.BackgroundTransparency = 1
ScannerList.ScrollBarThickness = 3
ScannerList.Parent = ScannerFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = ScannerList

-- Auto Scan Islands
local AutoScanEnabled = false
CreateToggle(IslandTab, "Auto Scan Islands", function(enabled)
    AutoScanEnabled = enabled
    if enabled then
        Notify("Island Scanner", "Auto Scan Activated", 2)
        spawn(function()
            while AutoScanEnabled and task.wait(3) do
                pcall(function()
                    -- Clear old list
                    for _, child in pairs(ScannerList:GetChildren()) do
                        if child:IsA("TextLabel") then child:Destroy() end
                    end
                    
                    local islands = ScanNearbyIslands()
                    for _, island in ipairs(islands) do
                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 0, 22)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = island.Name .. " | " .. island.Distance .. "m | Lv." .. island.LevelReq
                        lbl.TextColor3 = island.Distance < 500 and Theme.Success or Theme.TextDark
                        lbl.Font = Enum.Font.Gotham
                        lbl.TextSize = 11
                        lbl.TextXAlignment = Enum.TextXAlignment.Left
                        lbl.Parent = ScannerList
                    end
                    
                    if #islands == 0 then
                        local lbl = Instance.new("TextLabel")
                        lbl.Size = UDim2.new(1, 0, 0, 22)
                        lbl.BackgroundTransparency = 1
                        lbl.Text = "No islands detected nearby"
                        lbl.TextColor3 = Theme.TextDark
                        lbl.Font = Enum.Font.Gotham
                        lbl.TextSize = 11
                        lbl.Parent = ScannerList
                    end
                end)
            end
        end)
    else
        Notify("Island Scanner", "Auto Scan Deactivated", 2)
    end
end)

-- TP to Specific Island
CreateDropdown(IslandTab, "TP to Island", {
    "Port Town", "Hydra Island", "Great Tree", "Floating Turtle",
    "Haunted Castle", "Sea of Treats", "Tiki Outpost", "Submerged Island",
    "Kingdom of Rose", "Green Zone", "Graveyard", "Snow Mountain",
    "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island"
}, function(selected)
    pcall(function()
        for _, island in pairs(Workspace:GetChildren()) do
            if island:IsA("Model") and (island.Name:find(selected) or selected:find(island.Name)) then
                if island:FindFirstChildWhichIsA("BasePart") then
                    FastBypassTP(island:FindFirstChildWhichIsA("BasePart").Position + Vector3.new(0, 50, 0))
                    Notify("Teleport", "Teleported to " .. selected, 3)
                    return
                end
            end
        end
        Notify("Teleport", "Island not found!", 2)
    end)
end)

-- ============================================
-- TELEPORT TAB
-- ============================================

-- Bypass TP Toggle
local BypassTPEnabled = true
CreateToggle(TeleportTab, "Bypass TP (Anti-Detect)", function(enabled)
    BypassTPEnabled = enabled
    Notify("Teleport", "Bypass TP " .. (enabled and "Enabled" or "Disabled"), 2)
end)

-- TP to Safe Zone
CreateButton(TeleportTab, "TP to Safe Zone", function()
    FastBypassTP(Vector3.new(0, 10000, 0))
    Notify("Teleport", "Teleported to Safe Zone", 2)
end)

-- TP to Nearest Fruit
CreateButton(TeleportTab, "TP to Nearest Fruit", function()
    pcall(function()
        local nearest = nil
        local minDist = math.huge
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                if obj.Name:find("Fruit") then
                    local dist = (obj.Handle.Position - HRP.Position).Magnitude
                    if dist < minDist then
                        minDist = dist
                        nearest = obj
                    end
                end
            end
        end
        if nearest then
            FastBypassTP(nearest.Handle.Position)
            Notify("Teleport", "Teleported to " .. nearest.Name, 3)
        else
            Notify("Teleport", "No fruit found!", 2)
        end
    end)
end)

-- TP to Sea Beast
CreateButton(TeleportTab, "TP to Sea Beast", function()
    pcall(function()
        for _, beast in pairs(Workspace.SeaBeasts:GetChildren()) do
            if beast:FindFirstChild("HumanoidRootPart") then
                FastBypassTP(beast.HumanoidRootPart.Position + Vector3.new(0, 50, 0))
                Notify("Teleport", "Teleported to Sea Beast", 2)
                return
            end
        end
        Notify("Teleport", "No Sea Beast found!", 2)
    end)
end)

-- ============================================
-- ESP TAB (LANJUTAN)
-- ============================================

-- ESP Players
local ESPEnabled = false
CreateToggle(ESPtab, "ESP Players", function(enabled)
    ESPEnabled = enabled
    if enabled then
        Notify("ESP", "Player ESP Activated", 2)
        spawn(function()
            while ESPEnabled and task.wait(1) do
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("NanoESP") then
                                -- Billboard
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "NanoESP"
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.new(0, 140, 0, 55)
                                bb.StudsOffset = Vector3.new(0, 3.5, 0)
                                bb.Parent = player.Character.HumanoidRootPart
                                
                                -- Background frame
                                local bg = Instance.new("Frame")
                                bg.Size = UDim2.new(1, 0, 1, 0)
                                bg.BackgroundColor3 = Theme.BackgroundDark
                                bg.BackgroundTransparency = 0.3
                                bg.BorderSizePixel = 0
                                bg.Parent = bb
                                Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 8)
                                
                                local bgStroke = Instance.new("UIStroke")
                                bgStroke.Color = Theme.Accent
                                bgStroke.Thickness = 1
                                bgStroke.Transparency = 0.5
                                bgStroke.Parent = bg
                                
                                -- Name
                                local nameLbl = Instance.new("TextLabel")
                                nameLbl.Size = UDim2.new(1, -8, 0, 18)
                                nameLbl.Position = UDim2.new(0, 4, 0, 2)
                                nameLbl.BackgroundTransparency = 1
                                nameLbl.Text = player.Name
                                nameLbl.TextColor3 = Theme.Accent
                                nameLbl.Font = Enum.Font.GothamBold
                                nameLbl.TextSize = 12
                                nameLbl.TextXAlignment = Enum.TextXAlignment.Left
                                nameLbl.Parent = bg
                                
                                -- Level
                                local level = player.Data and player.Data.Level and player.Data.Level.Value or "?"
                                local lvlLbl = Instance.new("TextLabel")
                                lvlLbl.Size = UDim2.new(1, -8, 0, 14)
                                lvlLbl.Position = UDim2.new(0, 4, 0, 20)
                                lvlLbl.BackgroundTransparency = 1
                                lvlLbl.Text = "Lv." .. level .. " | " .. (player.Team and player.Team.Name or "No Team")
                                lvlLbl.TextColor3 = Theme.TextDark
                                lvlLbl.Font = Enum.Font.Gotham
                                lvlLbl.TextSize = 10
                                lvlLbl.TextXAlignment = Enum.TextXAlignment.Left
                                lvlLbl.Parent = bg
                                
                                -- Health bar
                                local healthBar = Instance.new("Frame")
                                healthBar.Size = UDim2.new(1, -8, 0, 4)
                                healthBar.Position = UDim2.new(0, 4, 0, 38)
                                healthBar.BackgroundColor3 = Theme.BackgroundDark
                                healthBar.BorderSizePixel = 0
                                healthBar.Parent = bg
                                Instance.new("UICorner", healthBar).CornerRadius = UDim.new(0, 2)
                                
                                local healthFill = Instance.new("Frame")
                                healthFill.Size = UDim2.new(1, 0, 1, 0)
                                healthFill.BackgroundColor3 = Theme.Success
                                healthFill.BorderSizePixel = 0
                                healthFill.Parent = healthBar
                                Instance.new("UICorner", healthFill).CornerRadius = UDim.new(0, 2)
                                
                                -- Update health
                                spawn(function()
                                    while bb and bb.Parent do
                                        pcall(function()
                                            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
                                            if hum then
                                                healthFill.Size = UDim2.new(hum.Health / hum.MaxHealth, 0, 1, 0)
                                                healthFill.BackgroundColor3 = hum.Health / hum.MaxHealth > 0.5 and Theme.Success or (hum.Health / hum.MaxHealth > 0.2 and Theme.Warning or Theme.Danger)
                                            end
                                        end)
                                        task.wait(0.2)
                                    end
                                end)
                                
                                -- Box ESP
                                local box = Instance.new("BoxHandleAdornment")
                                box.Name = "NanoESPBox"
                                box.Size = player.Character.HumanoidRootPart.Size * 2.5
                                box.Color3 = Theme.Accent
                                box.Transparency = 0.7
                                box.AlwaysOnTop = true
                                box.Adornee = player.Character.HumanoidRootPart
                                box.ZIndex = 5
                                box.Parent = player.Character.HumanoidRootPart
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("ESP", "Player ESP Deactivated", 2)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, c in pairs(player.Character.HumanoidRootPart:GetChildren()) do
                    if c.Name == "NanoESP" or c.Name == "NanoESPBox" then
                        c:Destroy()
                    end
                end
            end
        end
    end
end)

-- ESP Fruits
local ESPFruitEnabled = false
CreateToggle(ESPtab, "ESP Fruits", function(enabled)
    ESPFruitEnabled = enabled
    if enabled then
        Notify("ESP", "Fruit ESP Activated", 2)
        spawn(function()
            while ESPFruitEnabled and task.wait(1) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            if obj.Name:find("Fruit") and not obj.Handle:FindFirstChild("NanoFruitESP") then
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "NanoFruitESP"
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.new(0, 160, 0, 50)
                                bb.StudsOffset = Vector3.new(0, 2.5, 0)
                                bb.Parent = obj.Handle
                                
                                local bg = Instance.new("Frame")
                                bg.Size = UDim2.new(1, 0, 1, 0)
                                bg.BackgroundColor3 = Theme.BackgroundDark
                                bg.BackgroundTransparency = 0.2
                                bg.BorderSizePixel = 0
                                bg.Parent = bb
                                Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 10)
                                
                                local stroke = Instance.new("UIStroke")
                                stroke.Color = Color3.fromRGB(0, 255, 200)
                                stroke.Thickness = 1.5
                                stroke.Transparency = 0.4
                                stroke.Parent = bg
                                
                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, -10, 1, 0)
                                lbl.Position = UDim2.new(0, 5, 0, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = "🍎 " .. obj.Name
                                lbl.TextColor3 = Color3.fromRGB(0, 255, 200)
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 14
                                lbl.TextStrokeTransparency = 0.8
                                lbl.Parent = bg
                                
                                -- Glow effect
                                local glow = Instance.new("PointLight")
                                glow.Name = "NanoFruitGlow"
                                glow.Color = Color3.fromRGB(0, 255, 200)
                                glow.Brightness = 5
                                glow.Range = 20
                                glow.Parent = obj.Handle
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("ESP", "Fruit ESP Deactivated", 2)
    end
end)

-- ESP Chests
local ESPChestEnabled = false
CreateToggle(ESPtab, "ESP Chests", function(enabled)
    ESPChestEnabled = enabled
    if enabled then
        Notify("ESP", "Chest ESP Activated", 2)
        spawn(function()
            while ESPChestEnabled and task.wait(1) do
                pcall(function()
                    for _, chest in pairs(Workspace:GetChildren()) do
                        if chest.Name:find("Chest") and chest:FindFirstChild("Handle") then
                            if not chest.Handle:FindFirstChild("NanoChestESP") then
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "NanoChestESP"
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.new(0, 120, 0, 35)
                                bb.StudsOffset = Vector3.new(0, 1.5, 0)
                                bb.Parent = chest.Handle
                                
                                local bg = Instance.new("Frame")
                                bg.Size = UDim2.new(1, 0, 1, 0)
                                bg.BackgroundColor3 = Theme.BackgroundDark
                                bg.BackgroundTransparency = 0.2
                                bg.BorderSizePixel = 0
                                bg.Parent = bb
                                Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 8)
                                
                                local stroke = Instance.new("UIStroke")
                                stroke.Color = Theme.Warning
                                stroke.Thickness = 1.5
                                stroke.Transparency = 0.4
                                stroke.Parent = bg
                                
                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, -8, 1, 0)
                                lbl.Position = UDim2.new(0, 4, 0, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = "📦 " .. chest.Name
                                lbl.TextColor3 = Theme.Warning
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 12
                                lbl.Parent = bg
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("ESP", "Chest ESP Deactivated", 2)
    end
end)

-- ESP Sea Events
local ESPSeaEventEnabled = false
CreateToggle(ESPtab, "ESP Sea Events", function(enabled)
    ESPSeaEventEnabled = enabled
    if enabled then
        Notify("ESP", "Sea Event ESP Activated", 2)
        spawn(function()
            while ESPSeaEventEnabled and task.wait(1) do
                pcall(function()
                    for _, event in pairs(Workspace:GetChildren()) do
                        for _, eventName in pairs(SeaEvents) do
                            if event.Name:find(eventName) and event:FindFirstChildWhichIsA("BasePart") then
                                if not event:FindFirstChild("NanoSeaESP") then
                                    local bb = Instance.new("BillboardGui")
                                    bb.Name = "NanoSeaESP"
                                    bb.AlwaysOnTop = true
                                    bb.Size = UDim2.new(0, 180, 0, 45)
                                    bb.StudsOffset = Vector3.new(0, 5, 0)
                                    bb.Parent = event:FindFirstChildWhichIsA("BasePart")
                                    
                                    local bg = Instance.new("Frame")
                                    bg.Size = UDim2.new(1, 0, 1, 0)
                                    bg.BackgroundColor3 = Theme.BackgroundDark
                                    bg.BackgroundTransparency = 0.2
                                    bg.BorderSizePixel = 0
                                    bg.Parent = bb
                                    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 10)
                                    
                                    local stroke = Instance.new("UIStroke")
                                    stroke.Color = Theme.Info
                                    stroke.Thickness = 2
                                    stroke.Transparency = 0.3
                                    stroke.Parent = bg
                                    
                                    local lbl = Instance.new("TextLabel")
                                    lbl.Size = UDim2.new(1, -10, 1, 0)
                                    lbl.Position = UDim2.new(0, 5, 0, 0)
                                    lbl.BackgroundTransparency = 1
                                    lbl.Text = "🌊 " .. event.Name
                                    lbl.TextColor3 = Theme.Info
                                    lbl.Font = Enum.Font.GothamBold
                                    lbl.TextSize = 14
                                    lbl.Parent = bg
                                end
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("ESP", "Sea Event ESP Deactivated", 2)
    end
end)

-- ============================================
-- MISC TAB
-- ============================================

-- Infinite Energy
local InfEnergyEnabled = false
CreateToggle(MiscTab, "Infinite Energy", function(enabled)
    InfEnergyEnabled = enabled
    if enabled then
        Notify("Misc", "Infinite Energy Activated", 2)
        spawn(function()
            while InfEnergyEnabled and task.wait(0.1) do
                pcall(function()
                    LocalPlayer.Character.Energy.Value = LocalPlayer.Character.Energy.MaxValue
                end)
            end
        end)
    else
        Notify("Misc", "Infinite Energy Deactivated", 2)
    end
end)

-- Super Speed Slider
CreateToggle(MiscTab, "Super Speed", function(enabled)
    if enabled then
        Notify("Misc", "Super Speed Activated", 2)
        spawn(function()
            while enabled and task.wait() do
                pcall(function() Humanoid.WalkSpeed = 250 end)
            end
            Humanoid.WalkSpeed = 16
        end)
    else
        Notify("Misc", "Super Speed Deactivated", 2)
        Humanoid.WalkSpeed = 16
    end
end)

-- Super Jump
CreateToggle(MiscTab, "Super Jump", function(enabled)
    if enabled then
        Notify("Misc", "Super Jump Activated", 2)
        spawn(function()
            while enabled and task.wait() do
                pcall(function() Humanoid.JumpPower = 200 end)
            end
            Humanoid.JumpPower = 50
        end)
    else
        Notify("Misc", "Super Jump Deactivated", 2)
        Humanoid.JumpPower = 50
    end
end)

-- Fly
local FlyEnabled = false
CreateToggle(MiscTab, "Fly (WASD + Space/Shift)", function(enabled)
    FlyEnabled = enabled
    if enabled then
        Notify("Misc", "Fly Activated", 2)
        local flyPart = Instance.new("Part")
        flyPart.Size = Vector3.new(1, 1, 1)
        flyPart.Transparency = 1
        flyPart.Anchored = true
        flyPart.CanCollide = false
        flyPart.Parent = Workspace
        
        local conn = RunService.RenderStepped:Connect(function()
            if not FlyEnabled then return end
            flyPart.CFrame = HRP.CFrame
            local move = Vector3.new(0, 0, 0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
            flyPart.CFrame += move * 4
            HRP.CFrame = flyPart.CFrame
            HRP.Velocity = Vector3.new(0, 0, 0)
        end)
        
        spawn(function()
            while FlyEnabled and task.wait() do end
            conn:Disconnect()
            flyPart:Destroy()
        end)
    else
        Notify("Misc", "Fly Deactivated", 2)
    end
end)

-- No Clip
local NoClipEnabled = false
CreateToggle(MiscTab, "No Clip", function(enabled)
    NoClipEnabled = enabled
    if enabled then
        Notify("Misc", "No Clip Activated", 2)
        spawn(function()
            while NoClipEnabled and RunService.Stepped:Wait() do
                pcall(function()
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end)
            end
        end)
    else
        Notify("Misc", "No Clip Deactivated", 2)
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end)

-- Full Bright
CreateToggle(MiscTab, "Full Bright", function(enabled)
    if enabled then
        Lighting.Brightness = 10
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.ClockTime = 12
        Notify("Misc", "Full Bright Activated", 2)
    else
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 10000
        Notify("Misc", "Full Bright Deactivated", 2)
    end
end)

-- Auto Raid
local AutoRaidEnabled = false
CreateToggle(MiscTab, "Auto Raid", function(enabled)
    AutoRaidEnabled = enabled
    if enabled then
        Notify("Misc", "Auto Raid Activated", 2)
        spawn(function()
            while AutoRaidEnabled and task.wait(1) do
                pcall(function()
                    local args = {[1] = "RaidsNpc", [2] = "Select", [3] = "Flame"}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find("Raid") and enemy:FindFirstChild("HumanoidRootPart") then
                            FastBypassTP(enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Misc", "Auto Raid Deactivated", 2)
    end
end)

-- Auto Awaken
local AutoAwakenEnabled = false
CreateToggle(MiscTab, "Auto Awaken", function(enabled)
    AutoAwakenEnabled = enabled
    if enabled then
        Notify("Misc", "Auto Awaken Activated", 2)
        spawn(function()
            while AutoAwakenEnabled and task.wait(1) do
                pcall(function()
                    local args = {[1] = "AwakenedAbilities", [2] = "Check"}
                    local result = ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    if result then
                        for i = 1, 5 do
                            local args2 = {[1] = "AwakenedAbilities", [2] = "Touched", [3] = i}
                            ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args2))
                        end
                    end
                end)
            end
        end)
    else
        Notify("Misc", "Auto Awaken Deactivated", 2)
    end
end)

-- ============================================
-- PARTICLE BACKGROUND EFFECT
-- ============================================
local ParticleFrame = Instance.new("Frame")
ParticleFrame.Size = UDim2.new(1, 0, 1, 0)
ParticleFrame.BackgroundTransparency = 1
ParticleFrame.ZIndex = 0
ParticleFrame.Parent = MainFrame

spawn(function()
    while MainFrame and MainFrame.Parent do
        pcall(function()
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
            particle.Position = UDim2.new(math.random(), 0, 1, 0)
            particle.BackgroundColor3 = Theme.Accent
            particle.BackgroundTransparency = 0.7
            particle.BorderSizePixel = 0
            particle.ZIndex = 0
            particle.Parent = ParticleFrame
            Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)
            
            Tween(particle, {Position = UDim2.new(particle.Position.X.Scale, 0, -0.1, 0)}, math.random(3, 8), Enum.EasingStyle.Linear)
            
            task.delay(math.random(3, 8), function()
                if particle then particle:Destroy() end
            end)
        end)
        task.wait(0.3)
    end
end)

-- ============================================
-- DRAGGING & KEYBIND
-- ============================================
local dragToggle, dragStart, startPos
TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Toggle GUI with RightShift
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ============================================
-- AUTO UPDATE CHARACTER
-- ============================================
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- ============================================
-- INTRO ANIMATION
-- ============================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)

-- Scale up animation
Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 450), Position = UDim2.new(0.5, -350, 0.5, -225)}, 0.7, Enum.EasingStyle.Back)

-- Glow pulse animation
spawn(function()
    while MainFrame and MainFrame.Parent do
        Tween(mainStroke, {Transparency = 0.3}, 1)
        task.wait(1)
        Tween(mainStroke, {Transparency = 0.7}, 1)
        task.wait(1)
    end
end)

task.delay(1.5, function()
    Notify("NanoXyin v3.0", "Welcome " .. LocalPlayer.Name .. "! | Press RightShift to toggle", 5)
    Notify("NanoXyin v3.0", "Sea: " .. ({DetectCurrentSea()})[2] .. " | By @XyrooXellz", 4)
end)

-- ============================================
-- END OF SCRIPT
-- ============================================
-- - .... . / .... .- -.-. -.- / .. ... / .-. . .- .-
-- NANOXYIN v3.0 | Blox Fruits Ultimate Hub
-- Features: Sea Detection, Island Scanner, Bypass TP, Raid Kill Aura, Sea Event, Auto Farm Level Matching
-- By @XyrooXellz
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift
-- Update: June 2026
-- ============================================
