-- ============================================
-- NANOXYIN v4.0 - BLOX FRUITS ULTIMATE HUB
-- By @XyrooXellz
-- Version: v4.0 Optimal Release
-- Status: Stable | Bug Fixed | All Features Working
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift, Arceus X
-- Last Updated: June 2026
-- ============================================

print("[NanoXyin] Initializing v4.0...")
print("[NanoXyin] Loading modules...")

-- ============================================
-- SERVICES & VARIABLES
-- ============================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Connection storage for cleanup
local ActiveConnections = {}
local ActiveLoops = {}
local ActiveTweens = {}

-- ============================================
-- ANTI-AFK SYSTEM
-- ============================================
local AntiAFKConnection = LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
table.insert(ActiveConnections, AntiAFKConnection)

print("[NanoXyin] Anti-AFK system loaded")

-- ============================================
-- THEME CONFIGURATION
-- ============================================
local Theme = {
    Background = Color3.fromRGB(10, 10, 18),
    BackgroundLight = Color3.fromRGB(20, 20, 32),
    BackgroundDark = Color3.fromRGB(6, 6, 12),
    Surface = Color3.fromRGB(28, 28, 42),
    Accent = Color3.fromRGB(0, 255, 170),
    AccentGlow = Color3.fromRGB(0, 200, 140),
    Text = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(140, 140, 160),
    Danger = Color3.fromRGB(255, 60, 80),
    Success = Color3.fromRGB(0, 255, 130),
    Warning = Color3.fromRGB(255, 190, 0),
    Info = Color3.fromRGB(0, 170, 255)
}

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("[NanoXyin] Error: " .. tostring(result))
    end
    return success, result
end

local function CreateTween(obj, props, duration, style, dir)
    duration = duration or 0.35
    style = style or Enum.EasingStyle.Quad
    dir = dir or Enum.EasingDirection.Out
    local tween = TweenService:Create(obj, TweenInfo.new(duration, style, dir), props)
    tween:Play()
    return tween
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Accent
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0.6
    stroke.Parent = parent
    return stroke
end

local function CreateShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    shadow.Size = UDim2.new(1, 24, 1, 24)
    shadow.ZIndex = -1
    shadow.Image = "rbxassetid://5554236805"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    shadow.Parent = parent
    return shadow
end

-- ============================================
-- NOTIFICATION SYSTEM
-- ============================================
local NotificationQueue = {}
local IsNotifying = false

local function ProcessNotificationQueue()
    if IsNotifying or #NotificationQueue == 0 then return end
    IsNotifying = true
    
    local notifData = table.remove(NotificationQueue, 1)
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 360, 0, 80)
    notif.Position = UDim2.new(1, 20, 1, -100)
    notif.BackgroundColor3 = Theme.Surface
    notif.BorderSizePixel = 0
    notif.ZIndex = 100
    notif.Parent = ScreenGui
    
    CreateCorner(notif, 14)
    local notifStroke = CreateStroke(notif, Theme.Accent, 1.5, 0.4)
    
    -- Glow effect
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(1, 0, 0, 2)
    glow.Position = UDim2.new(0, 0, 0, 0)
    glow.BackgroundColor3 = Theme.Accent
    glow.BorderSizePixel = 0
    glow.ZIndex = 101
    glow.Parent = notif
    CreateCorner(glow, 2)
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 15, 0, 15)
    icon.BackgroundTransparency = 1
    icon.Text = "◆"
    icon.TextColor3 = Theme.Accent
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 28
    icon.ZIndex = 101
    icon.Parent = notif
    
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -65, 0, 22)
    titleLbl.Position = UDim2.new(0, 55, 0, 12)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = notifData.title
    titleLbl.TextColor3 = Theme.Text
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 15
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 101
    titleLbl.Parent = notif
    
    local textLbl = Instance.new("TextLabel")
    textLbl.Size = UDim2.new(1, -65, 0, 40)
    textLbl.Position = UDim2.new(0, 55, 0, 34)
    textLbl.BackgroundTransparency = 1
    textLbl.Text = notifData.text
    textLbl.TextColor3 = Theme.TextMuted
    textLbl.Font = Enum.Font.Gotham
    textLbl.TextSize = 12
    textLbl.TextXAlignment = Enum.TextXAlignment.Left
    textLbl.TextWrapped = true
    textLbl.ZIndex = 101
    textLbl.Parent = notif
    
    -- Slide in
    CreateTween(notif, {Position = UDim2.new(1, -380, 1, -100)}, 0.5, Enum.EasingStyle.Back)
    
    task.delay(notifData.duration or 3, function()
        CreateTween(notif, {Position = UDim2.new(1, 20, 1, -100)}, 0.4)
        task.wait(0.4)
        SafeCall(function() notif:Destroy() end)
        IsNotifying = false
        task.wait(0.1)
        ProcessNotificationQueue()
    end)
end

local function Notify(title, text, duration)
    table.insert(NotificationQueue, {title = title, text = text, duration = duration})
    ProcessNotificationQueue()
end

-- ============================================
-- BYPASS TELEPORT SYSTEM
-- ============================================
local function BypassTeleport(targetPos, speed)
    speed = speed or 400
    local distance = (targetPos - HRP.Position).Magnitude
    
    if distance < 50 then
        SafeCall(function()
            HRP.CFrame = CFrame.new(targetPos)
            HRP.Velocity = Vector3.new(0, 0, 0)
        end)
        return
    end
    
    -- Waypoint system untuk avoid detection
    local steps = math.max(1, math.ceil(distance / 400))
    local waypoints = {}
    
    for i = 1, steps do
        local t = i / steps
        local pos = HRP.Position:Lerp(targetPos, t)
        table.insert(waypoints, pos)
    end
    
    for _, pos in ipairs(waypoints) do
        SafeCall(function()
            HRP.CFrame = CFrame.new(pos)
            HRP.Velocity = Vector3.new(0, 0, 0)
        end)
        task.wait(0.03)
    end
end

-- ============================================
-- SEA & LEVEL DATA
-- ============================================
local function GetCurrentSea()
    local level = 0
    SafeCall(function()
        level = LocalPlayer.Data.Level.Value
    end)
    
    if level >= 1500 then return 3, "Third Sea", level
    elseif level >= 700 then return 2, "Second Sea", level
    else return 1, "First Sea", level end
end

local QuestDatabase = {
    [1] = {Enemy = "Bandit", Quest = "Bandit Quest Giver"},
    [10] = {Enemy = "Monkey", Quest = "Jungle Quest Giver"},
    [15] = {Enemy = "Gorilla", Quest = "Jungle Quest Giver"},
    [30] = {Enemy = "Pirate", Quest = "Pirate Village Quest Giver"},
    [40] = {Enemy = "Brute", Quest = "Pirate Village Quest Giver"},
    [60] = {Enemy = "Desert Bandit", Quest = "Desert Quest Giver"},
    [75] = {Enemy = "Desert Officer", Quest = "Desert Quest Giver"},
    [90] = {Enemy = "Snow Bandit", Quest = "Frozen Village Quest Giver"},
    [100] = {Enemy = "Snowman", Quest = "Frozen Village Quest Giver"},
    [120] = {Enemy = "Chief Petty Officer", Quest = "Marine Fortress Quest Giver"},
    [150] = {Enemy = "Sky Bandit", Quest = "Skylands Quest Giver"},
    [175] = {Enemy = "Dark Master", Quest = "Skylands Quest Giver"},
    [190] = {Enemy = "Prisoner", Quest = "Prison Quest Giver"},
    [225] = {Enemy = "Dangerous Prisoner", Quest = "Prison Quest Giver"},
    [250] = {Enemy = "Toga Warrior", Quest = "Colosseum Quest Giver"},
    [275] = {Enemy = "Gladiator", Quest = "Colosseum Quest Giver"},
    [300] = {Enemy = "Military Soldier", Quest = "Magma Village Quest Giver"},
    [325] = {Enemy = "Military Spy", Quest = "Magma Village Quest Giver"},
    [375] = {Enemy = "Fishman Warrior", Quest = "Underwater City Quest Giver"},
    [400] = {Enemy = "Fishman Commando", Quest = "Underwater City Quest Giver"},
    [450] = {Enemy = "God's Guard", Quest = "Upper Skylands Quest Giver"},
    [475] = {Enemy = "Shanda", Quest = "Upper Skylands Quest Giver"},
    [500] = {Enemy = "Royal Squad", Quest = "Upper Skylands Quest Giver"},
    [525] = {Enemy = "Royal Soldier", Quest = "Upper Skylands Quest Giver"},
    [625] = {Enemy = "Galley Pirate", Quest = "Fountain City Quest Giver"},
    [650] = {Enemy = "Galley Captain", Quest = "Fountain City Quest Giver"},
    [700] = {Enemy = "Raider", Quest = "Kingdom of Rose Quest Giver"},
    [725] = {Enemy = "Mercenary", Quest = "Kingdom of Rose Quest Giver"},
    [750] = {Enemy = "Swan Pirate", Quest = "Kingdom of Rose Quest Giver"},
    [775] = {Enemy = "Factory Staff", Quest = "Kingdom of Rose Quest Giver"},
    [875] = {Enemy = "Marine Lieutenant", Quest = "Green Zone Quest Giver"},
    [900] = {Enemy = "Marine Captain", Quest = "Green Zone Quest Giver"},
    [950] = {Enemy = "Zombie", Quest = "Graveyard Quest Giver"},
    [975] = {Enemy = "Vampire", Quest = "Graveyard Quest Giver"},
    [1000] = {Enemy = "Snow Trooper", Quest = "Snow Mountain Quest Giver"},
    [1025] = {Enemy = "Winter Warrior", Quest = "Snow Mountain Quest Giver"},
    [1050] = {Enemy = "Lab Subordinate", Quest = "Hot and Cold Quest Giver"},
    [1075] = {Enemy = "Horned Warrior", Quest = "Hot and Cold Quest Giver"},
    [1100] = {Enemy = "Magma Ninja", Quest = "Hot and Cold Quest Giver"},
    [1125] = {Enemy = "Lava Princess", Quest = "Hot and Cold Quest Giver"},
    [1175] = {Enemy = "Ship Deckhand", Quest = "Cursed Ship Quest Giver"},
    [1200] = {Enemy = "Ship Engineer", Quest = "Cursed Ship Quest Giver"},
    [1225] = {Enemy = "Ship Steward", Quest = "Cursed Ship Quest Giver"},
    [1250] = {Enemy = "Ship Officer", Quest = "Cursed Ship Quest Giver"},
    [1275] = {Enemy = "Arctic Warrior", Quest = "Ice Castle Quest Giver"},
    [1300] = {Enemy = "Snow Lurker", Quest = "Ice Castle Quest Giver"},
    [1325] = {Enemy = "Sea Soldier", Quest = "Forgotten Island Quest Giver"},
    [1350] = {Enemy = "Water Fighter", Quest = "Forgotten Island Quest Giver"},
    [1500] = {Enemy = "Pirate Millionaire", Quest = "Port Town Quest Giver"},
    [1525] = {Enemy = "Pistol Billionaire", Quest = "Port Town Quest Giver"},
    [1575] = {Enemy = "Dragon Crew Warrior", Quest = "Hydra Island Quest Giver"},
    [1600] = {Enemy = "Dragon Crew Archer", Quest = "Hydra Island Quest Giver"},
    [1625] = {Enemy = "Hydra Enforcer", Quest = "Hydra Island Quest Giver"},
    [1650] = {Enemy = "Venomous Assailant", Quest = "Hydra Island Quest Giver"},
    [1700] = {Enemy = "Marine Commodore", Quest = "Great Tree Quest Giver"},
    [1725] = {Enemy = "Marine Rear Admiral", Quest = "Great Tree Quest Giver"},
    [1775] = {Enemy = "Fishman Raider", Quest = "Floating Turtle Quest Giver"},
    [1800] = {Enemy = "Fishman Captain", Quest = "Floating Turtle Quest Giver"},
    [1825] = {Enemy = "Forest Pirate", Quest = "Floating Turtle Quest Giver"},
    [1850] = {Enemy = "Mythological Pirate", Quest = "Floating Turtle Quest Giver"},
    [1875] = {Enemy = "Jungle Pirate", Quest = "Floating Turtle Quest Giver"},
    [1900] = {Enemy = "Musketeer Pirate", Quest = "Floating Turtle Quest Giver"},
    [1975] = {Enemy = "Reborn Skeleton", Quest = "Haunted Castle Quest Giver"},
    [2000] = {Enemy = "Living Zombie", Quest = "Haunted Castle Quest Giver"},
    [2025] = {Enemy = "Demonic Soul", Quest = "Haunted Castle Quest Giver"},
    [2050] = {Enemy = "Possessed Mummy", Quest = "Haunted Castle Quest Giver"},
    [2075] = {Enemy = "Peanut Scout", Quest = "Sea of Treats Quest Giver"},
    [2100] = {Enemy = "Peanut President", Quest = "Sea of Treats Quest Giver"},
    [2125] = {Enemy = "Ice Cream Chef", Quest = "Sea of Treats Quest Giver"},
    [2150] = {Enemy = "Ice Cream Commander", Quest = "Sea of Treats Quest Giver"},
    [2175] = {Enemy = "Cookie Crafter", Quest = "Sea of Treats Quest Giver"},
    [2200] = {Enemy = "Cake Guard", Quest = "Sea of Treats Quest Giver"},
    [2225] = {Enemy = "Baking Staff", Quest = "Sea of Treats Quest Giver"},
    [2250] = {Enemy = "Head Baker", Quest = "Sea of Treats Quest Giver"},
    [2275] = {Enemy = "Cocoa Warrior", Quest = "Sea of Treats Quest Giver"},
    [2300] = {Enemy = "Chocolate Bar Battler", Quest = "Sea of Treats Quest Giver"},
    [2325] = {Enemy = "Sweet Thief", Quest = "Sea of Treats Quest Giver"},
    [2350] = {Enemy = "Candy Rebel", Quest = "Sea of Treats Quest Giver"},
    [2375] = {Enemy = "Candy Pirate", Quest = "Sea of Treats Quest Giver"},
    [2400] = {Enemy = "Snow Conjurer", Quest = "Sea of Treats Quest Giver"},
    [2450] = {Enemy = "Isle Outlaw", Quest = "Tiki Outpost Quest Giver"},
    [2475] = {Enemy = "Island Boy", Quest = "Tiki Outpost Quest Giver"},
    [2500] = {Enemy = "Sun-kissed Warrior", Quest = "Tiki Outpost Quest Giver"},
    [2525] = {Enemy = "Isle Champion", Quest = "Tiki Outpost Quest Giver"},
    [2600] = {Enemy = "Reef Bandit", Quest = "Submerged Island Quest Giver"},
    [2625] = {Enemy = "Coral Pirate", Quest = "Submerged Island Quest Giver"},
    [2650] = {Enemy = "Sea Chanter", Quest = "Submerged Island Quest Giver"},
    [2675] = {Enemy = "Ocean Prophet", Quest = "Submerged Island Quest Giver"}
}

local function GetOptimalQuest(level)
    local bestQuest = nil
    local bestLevel = 0
    for reqLevel, quest in pairs(QuestDatabase) do
        if level >= reqLevel and reqLevel > bestLevel then
            bestQuest = quest
            bestLevel = reqLevel
        end
    end
    return bestQuest
end

-- ============================================
-- MAIN GUI SETUP
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NanoXyinV4"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

CreateCorner(MainFrame, 16)
local mainStroke = CreateStroke(MainFrame, Theme.Accent, 2, 0.5)
CreateShadow(MainFrame)

-- Background gradient
local bgGradient = Instance.new("UIGradient")
bgGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Background),
    ColorSequenceKeypoint.new(0.5, Theme.BackgroundLight),
    ColorSequenceKeypoint.new(1, Theme.Background)
})
bgGradient.Rotation = 135
bgGradient.Parent = MainFrame

-- ============================================
-- TOP BAR
-- ============================================
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Theme.BackgroundDark
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
CreateCorner(TopBar, 16)

local topGlow = Instance.new("Frame")
topGlow.Size = UDim2.new(1, 0, 0, 2)
topGlow.Position = UDim2.new(0, 0, 1, -2)
topGlow.BackgroundColor3 = Theme.Accent
topGlow.BorderSizePixel = 0
topGlow.Parent = TopBar

-- Logo
local LogoIcon = Instance.new("TextLabel")
LogoIcon.Size = UDim2.new(0, 30, 0, 30)
LogoIcon.Position = UDim2.new(0, 18, 0, 12)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Text = "◆"
LogoIcon.TextColor3 = Theme.Accent
LogoIcon.Font = Enum.Font.GothamBold
LogoIcon.TextSize = 24
LogoIcon.Parent = TopBar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(0, 200, 0, 30)
LogoText.Position = UDim2.new(0, 48, 0, 5)
LogoText.BackgroundTransparency = 1
LogoText.Text = "NANOXYIN"
LogoText.TextColor3 = Theme.Text
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 20
LogoText.TextXAlignment = Enum.TextXAlignment.Left
LogoText.Parent = TopBar

local LogoSub = Instance.new("TextLabel")
LogoSub.Size = UDim2.new(0, 200, 0, 18)
LogoSub.Position = UDim2.new(0, 48, 0, 30)
LogoSub.BackgroundTransparency = 1
LogoSub.Text = "Blox Fruits Ultimate Hub"
LogoSub.TextColor3 = Theme.TextMuted
LogoSub.Font = Enum.Font.Gotham
LogoSub.TextSize = 10
LogoSub.TextXAlignment = Enum.TextXAlignment.Left
LogoSub.Parent = TopBar

-- Sea Info
local SeaInfo = Instance.new("TextLabel")
SeaInfo.Name = "SeaInfo"
SeaInfo.Size = UDim2.new(0, 180, 0, 20)
SeaInfo.Position = UDim2.new(0, 48, 0, 46)
SeaInfo.BackgroundTransparency = 1
SeaInfo.Text = "Detecting..."
SeaInfo.TextColor3 = Theme.Accent
SeaInfo.Font = Enum.Font.GothamBold
SeaInfo.TextSize = 11
SeaInfo.TextXAlignment = Enum.TextXAlignment.Left
SeaInfo.Parent = TopBar

-- Version
local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0, 120, 1, 0)
VersionText.Position = UDim2.new(1, -130, 0, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v4.0 | @XyrooXellz"
VersionText.TextColor3 = Theme.TextMuted
VersionText.Font = Enum.Font.Gotham
VersionText.TextSize = 10
VersionText.TextXAlignment = Enum.TextXAlignment.Right
VersionText.Parent = TopBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 34, 0, 34)
CloseBtn.Position = UDim2.new(1, -42, 0, 10)
CloseBtn.BackgroundColor3 = Theme.Danger
CloseBtn.Text = ""
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar
CreateCorner(CloseBtn, 10)

local closeIcon = Instance.new("TextLabel")
closeIcon.Size = UDim2.new(1, 0, 1, 0)
closeIcon.BackgroundTransparency = 1
closeIcon.Text = "✕"
closeIcon.TextColor3 = Theme.Text
closeIcon.Font = Enum.Font.GothamBold
closeIcon.TextSize = 16
closeIcon.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    CreateTween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 80, 100)}, 0.2)
end)
CloseBtn.MouseLeave:Connect(function()
    CreateTween(CloseBtn, {BackgroundColor3 = Theme.Danger}, 0.2)
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 34, 0, 34)
MinBtn.Position = UDim2.new(1, -80, 0, 10)
MinBtn.BackgroundColor3 = Theme.Surface
MinBtn.Text = ""
MinBtn.AutoButtonColor = false
MinBtn.Parent = TopBar
CreateCorner(MinBtn, 10)

local minIcon = Instance.new("TextLabel")
minIcon.Size = UDim2.new(1, 0, 1, 0)
minIcon.BackgroundTransparency = 1
minIcon.Text = "−"
minIcon.TextColor3 = Theme.Text
minIcon.Font = Enum.Font.GothamBold
minIcon.TextSize = 20
minIcon.Parent = MinBtn

MinBtn.MouseEnter:Connect(function()
    CreateTween(MinBtn, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
end)
MinBtn.MouseLeave:Connect(function()
    CreateTween(MinBtn, {BackgroundColor3 = Theme.Surface}, 0.2)
end)

-- ============================================
-- SIDEBAR
-- ============================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, -55)
Sidebar.Position = UDim2.new(0, 0, 0, 55)
Sidebar.BackgroundColor3 = Theme.BackgroundDark
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
CreateCorner(Sidebar, 16)

local sidebarGlow = Instance.new("Frame")
sidebarGlow.Size = UDim2.new(0, 2, 1, 0)
sidebarGlow.Position = UDim2.new(1, -2, 0, 0)
sidebarGlow.BackgroundColor3 = Theme.Accent
sidebarGlow.BorderSizePixel = 0
sidebarGlow.BackgroundTransparency = 0.7
sidebarGlow.Parent = Sidebar

-- ============================================
-- CONTENT FRAME
-- ============================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -170, 1, -65)
ContentFrame.Position = UDim2.new(0, 165, 0, 60)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ============================================
-- TAB CREATOR
-- ============================================
local Tabs = {}
local TabButtons = {}

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
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = tab
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = tab
    
    Tabs[name] = tab
    return tab
end

-- ============================================
-- UI COMPONENTS
-- ============================================
local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 310, 0, 50)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.Parent = parent
    CreateCorner(frame, 12)
    
    local frameStroke = CreateStroke(frame, Theme.Accent, 0.5, 0.8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 220, 1, 0)
    label.Position = UDim2.new(0, 16, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    -- Switch background
    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 52, 0, 28)
    switchBg.Position = UDim2.new(1, -62, 0.5, -14)
    switchBg.BackgroundColor3 = Theme.BackgroundDark
    switchBg.BorderSizePixel = 0
    switchBg.Parent = frame
    CreateCorner(switchBg, 14)
    
    -- Switch knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 22, 0, 22)
    knob.Position = UDim2.new(0, 3, 0.5, -11)
    knob.BackgroundColor3 = Theme.TextMuted
    knob.BorderSizePixel = 0
    knob.Parent = switchBg
    CreateCorner(knob, 11)
    
    local enabled = false
    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = switchBg
    
    local function SetState(state)
        enabled = state
        if enabled then
            CreateTween(switchBg, {BackgroundColor3 = Theme.Accent}, 0.25)
            CreateTween(knob, {Position = UDim2.new(0, 27, 0.5, -11), BackgroundColor3 = Theme.Text}, 0.25)
            frameStroke.Transparency = 0.3
        else
            CreateTween(switchBg, {BackgroundColor3 = Theme.BackgroundDark}, 0.25)
            CreateTween(knob, {Position = UDim2.new(0, 3, 0.5, -11), BackgroundColor3 = Theme.TextMuted}, 0.25)
            frameStroke.Transparency = 0.8
        end
    end
    
    clickArea.MouseButton1Click:Connect(function()
        SetState(not enabled)
        SafeCall(callback, enabled)
    end)
    
    return frame, SetState
end

local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 310, 0, 45)
    btn.BackgroundColor3 = Theme.Accent
    btn.Text = text
    btn.TextColor3 = Theme.Background
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.AutoButtonColor = false
    btn.Parent = parent
    CreateCorner(btn, 12)
    
    btn.MouseEnter:Connect(function()
        CreateTween(btn, {BackgroundColor3 = Theme.AccentGlow}, 0.2)
    end)
    btn.MouseLeave:Connect(function()
        CreateTween(btn, {BackgroundColor3 = Theme.Accent}, 0.2)
    end)
    btn.MouseButton1Click:Connect(function()
        SafeCall(callback)
    end)
    
    return btn
end

local function CreateDropdown(parent, text, options, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 310, 0, 48)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.Parent = parent
    CreateCorner(frame, 12)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 160, 1, 0)
    label.Position = UDim2.new(0, 16, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 120, 0, 34)
    dropdown.Position = UDim2.new(1, -130, 0.5, -17)
    dropdown.BackgroundColor3 = Theme.BackgroundDark
    dropdown.Text = options[1] or "Select"
    dropdown.TextColor3 = Theme.Text
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 12
    dropdown.AutoButtonColor = false
    dropdown.Parent = frame
    CreateCorner(dropdown, 8)
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 0, 20)
    arrow.Position = UDim2.new(1, -22, 0, 7)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Theme.TextMuted
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 10
    arrow.Parent = dropdown
    
    local open = false
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(0, 120, 0, math.min(#options * 32, 160))
    optionsFrame.Position = UDim2.new(0, 0, 1, 6)
    optionsFrame.BackgroundColor3 = Theme.BackgroundDark
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 50
    optionsFrame.Parent = dropdown
    CreateCorner(optionsFrame, 8)
    
    local optionsScroll = Instance.new("ScrollingFrame")
    optionsScroll.Size = UDim2.new(1, -4, 1, -4)
    optionsScroll.Position = UDim2.new(0, 2, 0, 2)
    optionsScroll.BackgroundTransparency = 1
    optionsScroll.ScrollBarThickness = 2
    optionsScroll.ScrollBarImageColor3 = Theme.Accent
    optionsScroll.CanvasSize = UDim2.new(0, 0, 0, #options * 32)
    optionsScroll.ZIndex = 51
    optionsScroll.Parent = optionsFrame
    
    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 30)
        optBtn.Position = UDim2.new(0, 0, 0, (i-1) * 32)
        optBtn.BackgroundTransparency = 1
        optBtn.Text = opt
        optBtn.TextColor3 = Theme.TextMuted
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 12
        optBtn.ZIndex = 52
        optBtn.AutoButtonColor = false
        optBtn.Parent = optionsScroll
        
        optBtn.MouseEnter:Connect(function()
            optBtn.BackgroundColor3 = Theme.Surface
            optBtn.BackgroundTransparency = 0
            optBtn.TextColor3 = Theme.Text
        end)
        optBtn.MouseLeave:Connect(function()
            optBtn.BackgroundTransparency = 1
            optBtn.TextColor3 = Theme.TextMuted
        end)
        optBtn.MouseButton1Click:Connect(function()
            dropdown.Text = opt
            SafeCall(callback, opt)
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

local function CreateInfoCard(parent, label, value)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 310, 0, 40)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.Parent = parent
    CreateCorner(frame, 10)
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 150, 1, 0)
    lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = Theme.TextMuted
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame
    
    local val = Instance.new("TextLabel")
    val.Name = "ValueLabel"
    val.Size = UDim2.new(0, 140, 1, 0)
    val.Position = UDim2.new(1, -145, 0, 0)
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
local TeleportTab = CreateTab("Teleport")
local ESPtab = CreateTab("ESP")
local MiscTab = CreateTab("Misc")

-- Tab Button Creator
local function CreateTabButton(name, icon, tabFrame)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(0, 145, 0, 40)
    btn.BackgroundColor3 = Theme.BackgroundDark
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Theme.TextMuted
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = Sidebar
    CreateCorner(btn, 10)
    
    local btnStroke = CreateStroke(btn, Theme.Accent, 1, 1)
    
    btn.MouseEnter:Connect(function()
        if not tabFrame.Visible then
            CreateTween(btn, {BackgroundColor3 = Theme.Surface}, 0.2)
        end
    end)
    btn.MouseLeave:Connect(function()
        if not tabFrame.Visible then
            CreateTween(btn, {BackgroundColor3 = Theme.BackgroundDark}, 0.2)
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do
            t.Visible = false
        end
        for _, b in pairs(TabButtons) do
            CreateTween(b, {BackgroundColor3 = Theme.BackgroundDark}, 0.2)
            local s = b:FindFirstChildOfClass("UIStroke")
            if s then s.Transparency = 1 end
        end
        
        tabFrame.Visible = true
        CreateTween(btn, {BackgroundColor3 = Theme.Surface}, 0.2)
        btnStroke.Transparency = 0.3
    end)
    
    table.insert(TabButtons, btn)
    return btn
end

CreateTabButton("Auto Farm", "⚔️", AutoFarmTab)
CreateTabButton("Combat", "🛡️", CombatTab)
CreateTabButton("Sea Event", "🌊", SeaEventTab)
CreateTabButton("Teleport", "🌀", TeleportTab)
CreateTabButton("ESP", "👁️", ESPtab)
CreateTabButton("Misc", "⚙️", MiscTab)

-- Select first tab
AutoFarmTab.Visible = true
TabButtons[1].BackgroundColor3 = Theme.Surface
local firstStroke = TabButtons[1]:FindFirstChildOfClass("UIStroke")
if firstStroke then firstStroke.Transparency = 0.3 end

-- ============================================
-- AUTO FARM TAB
-- ============================================

-- Level Info
local LevelCard, LevelValue = CreateInfoCard(AutoFarmTab, "Current Level", "Loading...")
local QuestCard, QuestValue = CreateInfoCard(AutoFarmTab, "Optimal Quest", "Scanning...")

-- Update info loop
spawn(function()
    while ScreenGui and ScreenGui.Parent do
        SafeCall(function()
            local seaNum, seaName, level = GetCurrentSea()
            LevelValue.Text = tostring(level) .. " (" .. seaName .. ")"
            
            local quest = GetOptimalQuest(level)
            if quest then
                QuestValue.Text = quest.Enemy
            else
                QuestValue.Text = "No quest available"
            end
            
            SeaInfo.Text = seaName .. " | Lv." .. level
            if seaNum == 3 then
                SeaInfo.TextColor3 = Theme.Success
            elseif seaNum == 2 then
                SeaInfo.TextColor3 = Theme.Warning
            else
                SeaInfo.TextColor3 = Theme.Info
            end
        end)
        task.wait(2)
    end
end)

-- Auto Farm Level Match
local AutoFarmMatchEnabled = false
CreateToggle(AutoFarmTab, "Auto Farm (Level Match)", function(enabled)
    AutoFarmMatchEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Level Matching Farm Enabled", 2)
        local farmLoop = spawn(function()
            while AutoFarmMatchEnabled and task.wait() do
                SafeCall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local quest = GetOptimalQuest(level)
                    if not quest then return end
                    
                    -- Take quest
                    local args = {[1] = "StartQuest", [2] = quest.Enemy, [3] = level}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    
                    -- Find enemy
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") 
                           and enemy.Humanoid.Health > 0 then
                            if enemy.Name:find(quest.Enemy) or enemy.Name == quest.Enemy then
                                local targetPos = enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0)
                                BypassTeleport(targetPos)
                                
                                local tool = Character:FindFirstChildOfClass("Tool") 
                                            or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool.Parent = Character
                                    tool:Activate()
                                end
                                
                                -- Auto Haki
                                local hakiArgs = {[1] = "Buso"}
                                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(hakiArgs))
                                
                                task.wait(0.1)
                                break
                            end
                        end
                    end
                end)
            end
        end)
        table.insert(ActiveLoops, farmLoop)
    else
        Notify("Auto Farm", "Level Matching Farm Disabled", 2)
    end
end)

-- Auto Boss
local AutoBossEnabled = false
CreateToggle(AutoFarmTab, "Auto Farm Boss", function(enabled)
    AutoBossEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Boss Hunter Enabled", 2)
        spawn(function()
            while AutoBossEnabled and task.wait() do
                SafeCall(function()
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
                            BypassTeleport(boss.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
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
        Notify("Auto Farm", "Boss Hunter Disabled", 2)
    end
end)

-- Auto Collect Fruit
local AutoFruitEnabled = false
CreateToggle(AutoFarmTab, "Auto Collect Fruit", function(enabled)
    AutoFruitEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Fruit Collector Enabled", 2)
        spawn(function()
            while AutoFruitEnabled and task.wait(1) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            if obj.Name:find("Fruit") then
                                BypassTeleport(obj.Handle.Position)
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Fruit Collector Disabled", 2)
    end
end)

-- Auto Stats
local AutoStatsEnabled = false
CreateToggle(AutoFarmTab, "Auto Stats (Melee)", function(enabled)
    AutoStatsEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Auto Stats Enabled", 2)
        spawn(function()
            while AutoStatsEnabled and task.wait(1) do
                SafeCall(function()
                    local args = {[1] = "AddPoint", [2] = "Melee", [3] = 1}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end)
            end
        end)
    else
        Notify("Auto Farm", "Auto Stats Disabled", 2)
    end
end)

-- ============================================
-- COMBAT TAB
-- ============================================

-- Raid Kill Aura
local RaidKillAuraEnabled = false
CreateToggle(CombatTab, "Raid Kill Aura", function(enabled)
    RaidKillAuraEnabled = enabled
    if enabled then
        Notify("Combat", "Raid Kill Aura Enabled", 2)
        spawn(function()
            while RaidKillAuraEnabled and task.wait(0.1) do
                SafeCall(function()
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                            local dist = (enemy.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < 80 and enemy.Humanoid.Health > 0 then
                                local isRaid = enemy.Name:find("Raid") or 
                                              enemy.Name:find("Dungeon") or
                                              enemy.Name:find("Cursed") or
                                              enemy.Name:find("Ship")
                                
                                if isRaid or dist < 30 then
                                    BypassTeleport(enemy.HumanoidRootPart.Position + Vector3.new(0, 25, 0))
                                    
                                    local tool = Character:FindFirstChildOfClass("Tool") 
                                                or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                    if tool then
                                        tool.Parent = Character
                                        tool:Activate()
                                    end
                                    
                                    -- Fruit skills
                                    local fruit = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                    if fruit and fruit:FindFirstChild("RemoteEvent") then
                                        for _, key in pairs({"Z", "X", "C", "V", "F"}) do
                                            local args = {[1] = key}
                                            fruit.RemoteEvent:FireServer(unpack(args))
                                            task.wait(0.05)
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
        Notify("Combat", "Raid Kill Aura Disabled", 2)
    end
end)

-- Silent Aim
local SilentAimEnabled = false
CreateToggle(CombatTab, "Silent Aim", function(enabled)
    SilentAimEnabled = enabled
    if enabled then
        Notify("Combat", "Silent Aim Enabled", 2)
        SafeCall(function()
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
        end)
    else
        Notify("Combat", "Silent Aim Disabled", 2)
    end
end)

-- Kill Aura
local KillAuraEnabled = false
CreateToggle(CombatTab, "Kill Aura", function(enabled)
    KillAuraEnabled = enabled
    if enabled then
        Notify("Combat", "Kill Aura Enabled", 2)
        spawn(function()
            while KillAuraEnabled and task.wait(0.1) do
                SafeCall(function()
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
        Notify("Combat", "Kill Aura Disabled", 2)
    end
end)

-- Fast Attack
local FastAttackEnabled = false
CreateToggle(CombatTab, "Fast Attack", function(enabled)
    FastAttackEnabled = enabled
    if enabled then
        Notify("Combat", "Fast Attack Enabled", 2)
        spawn(function()
            while FastAttackEnabled and task.wait(0.01) do
                SafeCall(function()
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() end
                end)
            end
        end)
    else
        Notify("Combat", "Fast Attack Disabled", 2)
    end
end)

-- Auto Buso
local AutoBusoEnabled = false
CreateToggle(CombatTab, "Auto Buso Haki", function(enabled)
    AutoBusoEnabled = enabled
    if enabled then
        Notify("Combat", "Auto Buso Enabled", 2)
        spawn(function()
            while AutoBusoEnabled and task.wait(3) do
                SafeCall(function()
                    local args = {[1] = "Buso"}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                end)
            end
        end)
    else
        Notify("Combat", "Auto Buso Disabled", 2)
    end
end)

-- ============================================
-- SEA EVENT TAB
-- ============================================

-- Auto Sea Beast
local SeaBeastEnabled = false
CreateToggle(SeaEventTab, "Auto Sea Beast", function(enabled)
    SeaBeastEnabled = enabled
    if enabled then
        Notify("Sea Event", "Sea Beast Hunter Enabled", 2)
        spawn(function()
            while SeaBeastEnabled and task.wait(0.5) do
                SafeCall(function()
                    for _, beast in pairs(Workspace.SeaBeasts:GetChildren()) do
                        if beast:FindFirstChild("HumanoidRootPart") then
                            BypassTeleport(beast.HumanoidRootPart.Position + Vector3.new(0, 50, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Sea Beast Hunter Disabled", 2)
    end
end)

-- Auto Ship Raid
local ShipRaidEnabled = false
CreateToggle(SeaEventTab, "Auto Ship Raid", function(enabled)
    ShipRaidEnabled = enabled
    if enabled then
        Notify("Sea Event", "Ship Raid Hunter Enabled", 2)
        spawn(function()
            while ShipRaidEnabled and task.wait(1) do
                SafeCall(function()
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find("Ship") and enemy:FindFirstChild("HumanoidRootPart") then
                            BypassTeleport(enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Ship Raid Hunter Disabled", 2)
    end
end)

-- Auto Terrorshark
local TerrorEnabled = false
CreateToggle(SeaEventTab, "Auto Terrorshark", function(enabled)
    TerrorEnabled = enabled
    if enabled then
        Notify("Sea Event", "Terrorshark Hunter Enabled", 2)
        spawn(function()
            while TerrorEnabled and task.wait(0.5) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Terror") and obj:FindFirstChild("HumanoidRootPart") then
                            BypassTeleport(obj.HumanoidRootPart.Position + Vector3.new(0, 40, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Terrorshark Hunter Disabled", 2)
    end
end)

-- Auto Leviathan
local LeviathanEnabled = false
CreateToggle(SeaEventTab, "Auto Leviathan", function(enabled)
    LeviathanEnabled = enabled
    if enabled then
        Notify("Sea Event", "Leviathan Hunter Enabled", 2)
        spawn(function()
            while LeviathanEnabled and task.wait(0.5) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Leviathan") and obj:FindFirstChild("HumanoidRootPart") then
                            BypassTeleport(obj.HumanoidRootPart.Position + Vector3.new(0, 60, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Leviathan Hunter Disabled", 2)
    end
end)

-- Auto Mirage Island
local MirageEnabled = false
CreateToggle(SeaEventTab, "Auto Mirage Island", function(enabled)
    MirageEnabled = enabled
    if enabled then
        Notify("Sea Event", "Mirage Island Hunter Enabled", 2)
        spawn(function()
            while MirageEnabled and task.wait(2) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Mirage") and obj:FindFirstChildWhichIsA("BasePart") then
                            BypassTeleport(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Mirage Island Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Mirage Island Hunter Disabled", 2)
    end
end)

-- Auto Kitsune Island
local KitsuneIslandEnabled = false
CreateToggle(SeaEventTab, "Auto Kitsune Island", function(enabled)
    KitsuneIslandEnabled = enabled
    if enabled then
        Notify("Sea Event", "Kitsune Island Hunter Enabled", 2)
        spawn(function()
            while KitsuneIslandEnabled and task.wait(2) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Kitsune") and obj:FindFirstChildWhichIsA("BasePart") then
                            BypassTeleport(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Kitsune Island Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Kitsune Island Hunter Disabled", 2)
    end
end)

-- Auto Prehistoric Island
local PrehistoricEnabled = false
CreateToggle(SeaEventTab, "Auto Prehistoric Island", function(enabled)
    PrehistoricEnabled = enabled
    if enabled then
        Notify("Sea Event", "Prehistoric Island Hunter Enabled", 2)
        spawn(function()
            while PrehistoricEnabled and task.wait(2) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Prehistoric") and obj:FindFirstChildWhichIsA("BasePart") then
                            BypassTeleport(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Prehistoric Island Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Prehistoric Island Hunter Disabled", 2)
    end
end)

-- Auto Frozen Dimension
local FrozenDimEnabled = false
CreateToggle(SeaEventTab, "Auto Frozen Dimension", function(enabled)
    FrozenDimEnabled = enabled
    if enabled then
        Notify("Sea Event", "Frozen Dimension Hunter Enabled", 2)
        spawn(function()
            while FrozenDimEnabled and task.wait(2) do
                SafeCall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj.Name:find("Frozen") and obj:FindFirstChildWhichIsA("BasePart") then
                            BypassTeleport(obj:FindFirstChildWhichIsA("BasePart").Position)
                            Notify("Sea Event", "Frozen Dimension Found!", 5)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Sea Event", "Frozen Dimension Hunter Disabled", 2)
    end
end)

-- ============================================
-- TELEPORT TAB
-- ============================================

CreateToggle(TeleportTab, "Bypass TP (Anti-Detect)", function(enabled)
    -- This is just a toggle indicator, BypassTeleport always uses bypass
    Notify("Teleport", "Bypass TP " .. (enabled and "Enabled" or "Disabled"), 2)
end)

CreateButton(TeleportTab, "TP to Safe Zone", function()
    BypassTeleport(Vector3.new(0, 10000, 0))
    Notify("Teleport", "Teleported to Safe Zone", 2)
end)

CreateButton(TeleportTab, "TP to Nearest Fruit", function()
    SafeCall(function()
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
            BypassTeleport(nearest.Handle.Position)
            Notify("Teleport", "Teleported to " .. nearest.Name, 3)
        else
            Notify("Teleport", "No fruit found!", 2)
        end
    end)
end)

CreateButton(TeleportTab, "TP to Sea Beast", function()
    SafeCall(function()
        for _, beast in pairs(Workspace.SeaBeasts:GetChildren()) do
            if beast:FindFirstChild("HumanoidRootPart") then
                BypassTeleport(beast.HumanoidRootPart.Position + Vector3.new(0, 50, 0))
                Notify("Teleport", "Teleported to Sea Beast", 2)
                return
            end
        end
        Notify("Teleport", "No Sea Beast found!", 2)
    end)
end)

CreateDropdown(TeleportTab, "TP to Island", {
    "Port Town", "Hydra Island", "Great Tree", "Floating Turtle",
    "Haunted Castle", "Sea of Treats", "Tiki Outpost", "Submerged Island",
    "Kingdom of Rose", "Green Zone", "Graveyard", "Snow Mountain",
    "Hot and Cold", "Cursed Ship", "Ice Castle", "Forgotten Island"
}, function(selected)
    SafeCall(function()
        for _, island in pairs(Workspace:GetChildren()) do
            if island:IsA("Model") and (island.Name:find(selected) or selected:find(island.Name)) then
                if island:FindFirstChildWhichIsA("BasePart") then
                    BypassTeleport(island:FindFirstChildWhichIsA("BasePart").Position + Vector3.new(0, 50, 0))
                    Notify("Teleport", "Teleported to " .. selected, 3)
                    return
                end
            end
        end
        Notify("Teleport", "Island not found!", 2)
    end)
end)

-- ============================================
-- ESP TAB
-- ============================================

-- ESP Players
local ESPEnabled = false
CreateToggle(ESPtab, "ESP Players", function(enabled)
    ESPEnabled = enabled
    if enabled then
        Notify("ESP", "Player ESP Enabled", 2)
        spawn(function()
            while ESPEnabled and task.wait(1) do
                SafeCall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("NanoESP") then
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "NanoESP"
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.new(0, 140, 0, 55)
                                bb.StudsOffset = Vector3.new(0, 3.5, 0)
                                bb.Parent = player.Character.HumanoidRootPart
                                
                                local bg = Instance.new("Frame")
                                bg.Size = UDim2.new(1, 0, 1, 0)
                                bg.BackgroundColor3 = Theme.BackgroundDark
                                bg.BackgroundTransparency = 0.3
                                bg.BorderSizePixel = 0
                                bg.Parent = bb
                                CreateCorner(bg, 8)
                                
                                local bgStroke = CreateStroke(bg, Theme.Accent, 1, 0.5)
                                
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
                                
                                local level = player.Data and player.Data.Level and player.Data.Level.Value or "?"
                                local lvlLbl = Instance.new("TextLabel")
                                lvlLbl.Size = UDim2.new(1, -8, 0, 14)
                                lvlLbl.Position = UDim2.new(0, 4, 0, 20)
                                lvlLbl.BackgroundTransparency = 1
                                lvlLbl.Text = "Lv." .. level
                                lvlLbl.TextColor3 = Theme.TextMuted
                                lvlLbl.Font = Enum.Font.Gotham
                                lvlLbl.TextSize = 10
                                lvlLbl.TextXAlignment = Enum.TextXAlignment.Left
                                lvlLbl.Parent = bg
                                
                                local healthBar = Instance.new("Frame")
                                healthBar.Size = UDim2.new(1, -8, 0, 4)
                                healthBar.Position = UDim2.new(0, 4, 0, 38)
                                healthBar.BackgroundColor3 = Theme.BackgroundDark
                                healthBar.BorderSizePixel = 0
                                healthBar.Parent = bg
                                CreateCorner(healthBar, 2)
                                
                                local healthFill = Instance.new("Frame")
                                healthFill.Size = UDim2.new(1, 0, 1, 0)
                                healthFill.BackgroundColor3 = Theme.Success
                                healthFill.BorderSizePixel = 0
                                healthFill.Parent = healthBar
                                CreateCorner(healthFill, 2)
                                
                                spawn(function()
                                    while bb and bb.Parent do
                                        SafeCall(function()
                                            local hum = player.Character and player.Character:FindFirstChild("Humanoid")
                                            if hum then
                                                local ratio = hum.Health / hum.MaxHealth
                                                healthFill.Size = UDim2.new(ratio, 0, 1, 0)
                                                healthFill.BackgroundColor3 = ratio > 0.5 and Theme.Success or (ratio > 0.2 and Theme.Warning or Theme.Danger)
                                            end
                                        end)
                                        task.wait(0.2)
                                    end
                                end)
                                
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
        Notify("ESP", "Player ESP Disabled", 2)
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, c in pairs(player.Character.HumanoidRootPart:GetChildren()) do
                    if c.Name == "NanoESP" or c.Name == "NanoESPBox" then
                        SafeCall(function() c:Destroy() end)
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
        Notify("ESP", "Fruit ESP Enabled", 2)
        spawn(function()
            while ESPFruitEnabled and task.wait(1) do
                SafeCall(function()
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
                                CreateCorner(bg, 10)
                                
                                local stroke = CreateStroke(bg, Color3.fromRGB(0, 255, 200), 1.5, 0.4)
                                
                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, -10, 1, 0)
                                lbl.Position = UDim2.new(0, 5, 0, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = obj.Name
                                lbl.TextColor3 = Color3.fromRGB(0, 255, 200)
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 14
                                lbl.Parent = bg
                                
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
        Notify("ESP", "Fruit ESP Disabled", 2)
    end
end)

-- ESP Chests
local ESPChestEnabled = false
CreateToggle(ESPtab, "ESP Chests", function(enabled)
    ESPChestEnabled = enabled
    if enabled then
        Notify("ESP", "Chest ESP Enabled", 2)
        spawn(function()
            while ESPChestEnabled and task.wait(1) do
                SafeCall(function()
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
                                CreateCorner(bg, 8)
                                
                                local stroke = CreateStroke(bg, Theme.Warning, 1.5, 0.4)
                                
                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, -8, 1, 0)
                                lbl.Position = UDim2.new(0, 4, 0, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = chest.Name
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
        Notify("ESP", "Chest ESP Disabled", 2)
    end
end)

-- ESP Sea Events
local ESPSeaEventEnabled = false
CreateToggle(ESPtab, "ESP Sea Events", function(enabled)
    ESPSeaEventEnabled = enabled
    if enabled then
        Notify("ESP", "Sea Event ESP Enabled", 2)
        spawn(function()
            while ESPSeaEventEnabled and task.wait(1) do
                SafeCall(function()
                    local seaEventNames = {
                        "SeaBeast", "ShipRaid", "RumblingWaters", "Terrorshark",
                        "Leviathan", "FrozenDimension", "Prehistoric", "Kitsune", "Mirage"
                    }
                    for _, obj in pairs(Workspace:GetChildren()) do
                        for _, eventName in pairs(seaEventNames) do
                            if obj.Name:find(eventName) and obj:FindFirstChildWhichIsA("BasePart") then
                                if not obj:FindFirstChild("NanoSeaESP") then
                                    local bb = Instance.new("BillboardGui")
                                    bb.Name = "NanoSeaESP"
                                    bb.AlwaysOnTop = true
                                    bb.Size = UDim2.new(0, 180, 0, 45)
                                    bb.StudsOffset = Vector3.new(0, 5, 0)
                                    bb.Parent = obj:FindFirstChildWhichIsA("BasePart")
                                    
                                    local bg = Instance.new("Frame")
                                    bg.Size = UDim2.new(1, 0, 1, 0)
                                    bg.BackgroundColor3 = Theme.BackgroundDark
                                    bg.BackgroundTransparency = 0.2
                                    bg.BorderSizePixel = 0
                                    bg.Parent = bb
                                    CreateCorner(bg, 10)
                                    
                                    local stroke = CreateStroke(bg, Theme.Info, 2, 0.3)
                                    
                                    local lbl = Instance.new("TextLabel")
                                    lbl.Size = UDim2.new(1, -10, 1, 0)
                                    lbl.Position = UDim2.new(0, 5, 0, 0)
                                    lbl.BackgroundTransparency = 1
                                    lbl.Text = "🌊 " .. obj.Name
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
        Notify("ESP", "Sea Event ESP Disabled", 2)
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
        Notify("Misc", "Infinite Energy Enabled", 2)
        spawn(function()
            while InfEnergyEnabled and task.wait(0.1) do
                SafeCall(function()
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Energy") then
                        LocalPlayer.Character.Energy.Value = LocalPlayer.Character.Energy.MaxValue
                    end
                end)
            end
        end)
    else
        Notify("Misc", "Infinite Energy Disabled", 2)
    end
end)

-- Super Speed
local SuperSpeedEnabled = false
CreateToggle(MiscTab, "Super Speed (250)", function(enabled)
    SuperSpeedEnabled = enabled
    if enabled then
        Notify("Misc", "Super Speed Enabled", 2)
        spawn(function()
            while SuperSpeedEnabled and task.wait() do
                SafeCall(function()
                    if Humanoid then Humanoid.WalkSpeed = 250 end
                end)
            end
            SafeCall(function()
                if Humanoid then Humanoid.WalkSpeed = 16 end
            end)
        end)
    else
        Notify("Misc", "Super Speed Disabled", 2)
        SafeCall(function()
            if Humanoid then Humanoid.WalkSpeed = 16 end
        end)
    end
end)

-- Super Jump
local SuperJumpEnabled = false
CreateToggle(MiscTab, "Super Jump (200)", function(enabled)
    SuperJumpEnabled = enabled
    if enabled then
        Notify("Misc", "Super Jump Enabled", 2)
        spawn(function()
            while SuperJumpEnabled and task.wait() do
                SafeCall(function()
                    if Humanoid then Humanoid.JumpPower = 200 end
                end)
            end
            SafeCall(function()
                if Humanoid then Humanoid.JumpPower = 50 end
            end)
        end)
    else
        Notify("Misc", "Super Jump Disabled", 2)
        SafeCall(function()
            if Humanoid then Humanoid.JumpPower = 50 end
        end)
    end
end)

-- Fly
local FlyEnabled = false
local FlyConnection = nil
local FlyPart = nil

CreateToggle(MiscTab, "Fly (WASD + Space/Shift)", function(enabled)
    FlyEnabled = enabled
    if enabled then
        Notify("Misc", "Fly Enabled - Use WASD + Space/Shift", 3)
        SafeCall(function()
            FlyPart = Instance.new("Part")
            FlyPart.Name = "NanoFlyPart"
            FlyPart.Size = Vector3.new(1, 1, 1)
            FlyPart.Transparency = 1
            FlyPart.Anchored = true
            FlyPart.CanCollide = false
            FlyPart.Parent = Workspace
            
            FlyConnection = RunService.RenderStepped:Connect(function()
                if not FlyEnabled or not FlyPart or not HRP then return end
                FlyPart.CFrame = HRP.CFrame
                local move = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
                FlyPart.CFrame += move * 4
                HRP.CFrame = FlyPart.CFrame
                HRP.Velocity = Vector3.new(0, 0, 0)
            end)
        end)
    else
        Notify("Misc", "Fly Disabled", 2)
        SafeCall(function()
            if FlyConnection then
                FlyConnection:Disconnect()
                FlyConnection = nil
            end
            if FlyPart then
                FlyPart:Destroy()
                FlyPart = nil
            end
        end)
    end
end)

-- No Clip
local NoClipEnabled = false
local NoClipConnection = nil

CreateToggle(MiscTab, "No Clip", function(enabled)
    NoClipEnabled = enabled
    if enabled then
        Notify("Misc", "No Clip Enabled", 2)
        NoClipConnection = RunService.Stepped:Connect(function()
            if not NoClipEnabled or not Character then return end
            SafeCall(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
        end)
        table.insert(ActiveConnections, NoClipConnection)
    else
        Notify("Misc", "No Clip Disabled", 2)
        SafeCall(function()
            if NoClipConnection then
                NoClipConnection:Disconnect()
                NoClipConnection = nil
            end
            if Character then
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end)
    end
end)

-- Full Bright
local FullBrightEnabled = false
local OriginalLighting = {}

CreateToggle(MiscTab, "Full Bright", function(enabled)
    FullBrightEnabled = enabled
    SafeCall(function()
        if enabled then
            OriginalLighting.Brightness = Lighting.Brightness
            OriginalLighting.GlobalShadows = Lighting.GlobalShadows
            OriginalLighting.FogEnd = Lighting.FogEnd
            OriginalLighting.ClockTime = Lighting.ClockTime
            
            Lighting.Brightness = 10
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 100000
            Lighting.ClockTime = 12
            Notify("Misc", "Full Bright Enabled", 2)
        else
            Lighting.Brightness = OriginalLighting.Brightness or 2
            Lighting.GlobalShadows = OriginalLighting.GlobalShadows ~= nil and OriginalLighting.GlobalShadows or true
            Lighting.FogEnd = OriginalLighting.FogEnd or 10000
            Lighting.ClockTime = OriginalLighting.ClockTime or 14
            Notify("Misc", "Full Bright Disabled", 2)
        end
    end)
end)

-- Auto Raid
local AutoRaidEnabled = false
CreateToggle(MiscTab, "Auto Raid", function(enabled)
    AutoRaidEnabled = enabled
    if enabled then
        Notify("Misc", "Auto Raid Enabled", 2)
        spawn(function()
            while AutoRaidEnabled and task.wait(1) do
                SafeCall(function()
                    local args = {[1] = "RaidsNpc", [2] = "Select", [3] = "Flame"}
                    ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy.Name:find("Raid") and enemy:FindFirstChild("HumanoidRootPart") then
                            BypassTeleport(enemy.HumanoidRootPart.Position + Vector3.new(0, 30, 0))
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Misc", "Auto Raid Disabled", 2)
    end
end)

-- Auto Awaken
local AutoAwakenEnabled = false
CreateToggle(MiscTab, "Auto Awaken", function(enabled)
    AutoAwakenEnabled = enabled
    if enabled then
        Notify("Misc", "Auto Awaken Enabled", 2)
        spawn(function()
            while AutoAwakenEnabled and task.wait(1) do
                SafeCall(function()
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
        Notify("Misc", "Auto Awaken Disabled", 2)
    end
end)

-- ============================================
-- PARTICLE BACKGROUND EFFECT
-- ============================================
local ParticleFrame = Instance.new("Frame")
ParticleFrame.Name = "Particles"
ParticleFrame.Size = UDim2.new(1, 0, 1, 0)
ParticleFrame.BackgroundTransparency = 1
ParticleFrame.ZIndex = 0
ParticleFrame.Parent = MainFrame

spawn(function()
    while MainFrame and MainFrame.Parent do
        SafeCall(function()
            local particle = Instance.new("Frame")
            particle.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
            particle.Position = UDim2.new(math.random(), 0, 1, 0)
            particle.BackgroundColor3 = Theme.Accent
            particle.BackgroundTransparency = 0.8
            particle.BorderSizePixel = 0
            particle.ZIndex = 0
            particle.Parent = ParticleFrame
            CreateCorner(particle, 10)
            
            CreateTween(particle, {
                Position = UDim2.new(particle.Position.X.Scale, 0, -0.1, 0),
                BackgroundTransparency = 1
            }, math.random(4, 8), Enum.EasingStyle.Linear)
            
            task.delay(math.random(4, 8), function()
                SafeCall(function() particle:Destroy() end)
            end)
        end)
        task.wait(0.4)
    end
end)

-- ============================================
-- OPEN / CLOSE / MINIMIZE SYSTEM
-- ============================================
local IsOpen = true
local IsMinimized = false

-- Close function
local function CloseGUI()
    IsOpen = false
    CreateTween(MainFrame, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    
    task.wait(0.4)
    SafeCall(function()
        -- Cleanup all connections
        for _, conn in pairs(ActiveConnections) do
            SafeCall(function() conn:Disconnect() end)
        end
        ActiveConnections = {}
        
        -- Disable all toggles
        AutoFarmMatchEnabled = false
        AutoBossEnabled = false
        AutoFruitEnabled = false
        AutoStatsEnabled = false
        SilentAimEnabled = false
        KillAuraEnabled = false
        FastAttackEnabled = false
        AutoBusoEnabled = false
        RaidKillAuraEnabled = false
        SeaBeastEnabled = false
        ShipRaidEnabled = false
        TerrorEnabled = false
        LeviathanEnabled = false
        MirageEnabled = false
        KitsuneIslandEnabled = false
        PrehistoricEnabled = false
        FrozenDimEnabled = false
        ESPEnabled = false
        ESPFruitEnabled = false
        ESPChestEnabled = false
        ESPSeaEventEnabled = false
        InfEnergyEnabled = false
        SuperSpeedEnabled = false
        SuperJumpEnabled = false
        FlyEnabled = false
        NoClipEnabled = false
        FullBrightEnabled = false
        AutoRaidEnabled = false
        AutoAwakenEnabled = false
        
        ScreenGui:Destroy()
    end)
    print("[NanoXyin] GUI closed and cleaned up")
end

CloseBtn.MouseButton1Click:Connect(CloseGUI)

-- Minimize function
local function MinimizeGUI()
    IsMinimized = not IsMinimized
    if IsMinimized then
        CreateTween(MainFrame, {
            Size = UDim2.new(0, 700, 0, 55),
            Position = UDim2.new(0.5, -350, 0.5, -27)
        }, 0.35, Enum.EasingStyle.Quad)
        ContentFrame.Visible = false
        Sidebar.Visible = false
        minIcon.Text = "+"
    else
        CreateTween(MainFrame, {
            Size = UDim2.new(0, 700, 0, 450),
            Position = UDim2.new(0.5, -350, 0.5, -225)
        }, 0.35, Enum.EasingStyle.Quad)
        ContentFrame.Visible = true
        Sidebar.Visible = true
        minIcon.Text = "−"
    end
end

MinBtn.MouseButton1Click:Connect(MinimizeGUI)

-- ============================================
-- DRAGGING SYSTEM
-- ============================================
local Dragging = false
local DragStart = nil
local StartPos = nil

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = input.Position
        StartPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + delta.Y
        )
    end
end)

-- ============================================
-- KEYBIND TOGGLE (RightShift)
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if IsOpen then
            if IsMinimized then
                -- Restore from minimized
                MinimizeGUI()
            else
                -- Hide GUI
                MainFrame.Visible = not MainFrame.Visible
                if MainFrame.Visible then
                    Notify("NanoXyin", "GUI Visible - Press RightShift to hide", 2)
                end
            end
        end
    end
end)

-- ============================================
-- CHARACTER AUTO-UPDATE
-- ============================================
LocalPlayer.CharacterAdded:Connect(function(char)
    SafeCall(function()
        Character = char
        Humanoid = char:WaitForChild("Humanoid")
        HRP = char:WaitForChild("HumanoidRootPart")
        print("[NanoXyin] Character updated: " .. char.Name)
    end)
end)

-- ============================================
-- INTRO ANIMATION
-- ============================================
-- Start small and expand
CreateTween(MainFrame, {
    Size = UDim2.new(0, 700, 0, 450),
    Position = UDim2.new(0.5, -350, 0.5, -225)
}, 0.7, Enum.EasingStyle.Back)

-- Glow pulse
spawn(function()
    while MainFrame and MainFrame.Parent do
        SafeCall(function()
            CreateTween(mainStroke, {Transparency = 0.2}, 1.2)
        end)
        task.wait(1.2)
        SafeCall(function()
            CreateTween(mainStroke, {Transparency = 0.7}, 1.2)
        end)
        task.wait(1.2)
    end
end)

-- Welcome notifications
task.delay(1.2, function()
    Notify("NanoXyin v4.0", "Welcome, " .. LocalPlayer.Name .. "!", 4)
    local seaNum, seaName, level = GetCurrentSea()
    Notify("Sea Detection", seaName .. " | Level " .. level, 4)
    Notify("Keybind", "Press RightShift to toggle GUI", 4)
    Notify("Status", "All systems operational", 3)
end)

print("[NanoXyin] v4.0 loaded successfully!")
print("[NanoXyin] All features ready")
print("[NanoXyin] Press RightShift to toggle GUI")

-- ============================================
-- END OF SCRIPT
-- ============================================
-- - .... . / .... .- -.-. -.- / .. ... / .-. . .- .-
-- NANOXYIN v4.0 | Blox Fruits Ultimate Hub
-- By @XyrooXellz
-- Features: Sea Detection, Island Scanner, Bypass TP, Raid Kill Aura, Sea Event Menu, Auto Farm Level Matching
-- Status: Stable | Bug Fixed | All Features Working
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift, Arceus X
-- Last Updated: June 2026
-- ============================================

