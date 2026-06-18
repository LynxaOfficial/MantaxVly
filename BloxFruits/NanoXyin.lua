-- ============================================
-- NANOXYIN - BLOX FRUITS ULTIMATE HUB
-- By @XyrooXellz
-- Version: v2.0 Full Release
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift
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
-- THEME CONFIGURATION
-- ============================================
local Theme = {
    Background = Color3.fromRGB(15, 15, 25),
    BackgroundLight = Color3.fromRGB(25, 25, 40),
    BackgroundDark = Color3.fromRGB(10, 10, 18),
    Accent = Color3.fromRGB(0, 255, 170),
    AccentDark = Color3.fromRGB(0, 200, 130),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(180, 180, 200),
    Danger = Color3.fromRGB(255, 80, 80),
    Success = Color3.fromRGB(0, 255, 150),
    Warning = Color3.fromRGB(255, 200, 0)
}

-- ============================================
-- UTILITY FUNCTIONS
-- ============================================
local function Tween(obj, props, duration, easing, direction)
    duration = duration or 0.3
    easing = easing or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    TweenService:Create(obj, TweenInfo.new(duration, easing, direction), props):Play()
end

local function CreateCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function CreateStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Accent
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.7
    stroke.Parent = parent
    return stroke
end

local function CreateGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1 or Theme.Accent),
        ColorSequenceKeypoint.new(1, color2 or Theme.AccentDark)
    })
    gradient.Rotation = rotation or 45
    gradient.Parent = parent
    return gradient
end

local function Notify(title, text, duration)
    duration = duration or 3
    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 320, 0, 70)
    notif.Position = UDim2.new(1, 20, 1, -90)
    notif.BackgroundColor3 = Theme.BackgroundLight
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    
    CreateCorner(notif, 10)
    CreateStroke(notif, Theme.Accent, 1.5)
    
    local notifGradient = Instance.new("UIGradient")
    notifGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Theme.BackgroundLight),
        ColorSequenceKeypoint.new(1, Theme.Background)
    })
    notifGradient.Rotation = 90
    notifGradient.Parent = notif
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 10, 0, 10)
    icon.BackgroundTransparency = 1
    icon.Text = "◆"
    icon.TextColor3 = Theme.Accent
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 20
    icon.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -50, 0, 20)
    titleLabel.Position = UDim2.new(0, 45, 0, 8)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Theme.Text
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notif
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -50, 0, 35)
    textLabel.Position = UDim2.new(0, 45, 0, 28)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Theme.TextDark
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 12
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextWrapped = true
    textLabel.Parent = notif
    
    Tween(notif, {Position = UDim2.new(1, -340, 1, -90)}, 0.5, Enum.EasingStyle.Back)
    
    task.delay(duration, function()
        Tween(notif, {Position = UDim2.new(1, 20, 1, -90)}, 0.4)
        task.wait(0.4)
        notif:Destroy()
    end)
end

-- ============================================
-- MAIN GUI SETUP
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NanoXyinHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

-- Background Blur Effect
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 420)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -210)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

CreateCorner(MainFrame, 12)
CreateStroke(MainFrame, Theme.Accent, 1.5)

local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Background),
    ColorSequenceKeypoint.new(0.5, Theme.BackgroundLight),
    ColorSequenceKeypoint.new(1, Theme.Background)
})
mainGradient.Rotation = 135
mainGradient.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Theme.BackgroundDark
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

CreateCorner(TopBar, 12)

local topBarGradient = Instance.new("UIGradient")
topBarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.Accent),
    ColorSequenceKeypoint.new(1, Theme.AccentDark)
})
topBarGradient.Rotation = 90
topBarGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(1, 1)
})
topBarGradient.Parent = TopBar

-- Logo
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 200, 1, 0)
Logo.Position = UDim2.new(0, 15, 0, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "◆ NANOXYIN"
Logo.TextColor3 = Theme.Accent
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 18
Logo.TextXAlignment = Enum.TextXAlignment.Left
Logo.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(0, 200, 0, 15)
Subtitle.Position = UDim2.new(0, 15, 0, 28)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Blox Fruits Ultimate Hub"
Subtitle.TextColor3 = Theme.TextDark
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 10
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

-- Version
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 100, 1, 0)
VersionLabel.Position = UDim2.new(1, -110, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v2.0 | @XyrooXellz"
VersionLabel.TextColor3 = Theme.TextDark
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 10
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.Parent = TopBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 8)
CloseBtn.BackgroundColor3 = Theme.Danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = TopBar
CreateCorner(CloseBtn, 6)

CloseBtn.MouseButton1Click:Connect(function()
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
    task.wait(0.3)
    ScreenGui:Destroy()
    blur:Destroy()
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 8)
MinBtn.BackgroundColor3 = Theme.BackgroundLight
MinBtn.Text = "−"
MinBtn.TextColor3 = Theme.Text
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.Parent = TopBar
CreateCorner(MinBtn, 6)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 45)}, 0.3)
    else
        Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 420)}, 0.3)
    end
end)

-- ============================================
-- SIDEBAR / TAB BUTTONS
-- ============================================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 140, 1, -45)
Sidebar.Position = UDim2.new(0, 0, 0, 45)
Sidebar.BackgroundColor3 = Theme.BackgroundDark
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

CreateCorner(Sidebar, 12)

local sidebarGradient = Instance.new("UIGradient")
sidebarGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Theme.BackgroundDark),
    ColorSequenceKeypoint.new(1, Theme.Background)
})
sidebarGradient.Rotation = 0
sidebarGradient.Parent = Sidebar

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 5)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.Parent = Sidebar

-- Tab Button Creator
local function CreateTabButton(name, icon, tabFrame)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 125, 0, 35)
    btn.BackgroundColor3 = Theme.Background
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Theme.TextDark
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = Sidebar
    CreateCorner(btn, 8)
    
    local btnStroke = CreateStroke(btn, Theme.Accent, 0)
    btnStroke.Transparency = 1
    
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
        Tween(btnStroke, {Transparency = 0.5}, 0.2)
    end)
    
    btn.MouseLeave:Connect(function()
        if tabFrame.Visible then return end
        Tween(btn, {BackgroundColor3 = Theme.Background}, 0.2)
        Tween(btnStroke, {Transparency = 1}, 0.2)
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, child in pairs(ContentFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") then
                child.Visible = false
            end
        end
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                Tween(child, {BackgroundColor3 = Theme.Background}, 0.2)
                local stroke = child:FindFirstChildOfClass("UIStroke")
                if stroke then Tween(stroke, {Transparency = 1}, 0.2) end
            end
        end
        tabFrame.Visible = true
        Tween(btn, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
        Tween(btnStroke, {Transparency = 0.5}, 0.2)
    end)
    
    return btn
end

-- ============================================
-- CONTENT FRAME
-- ============================================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -150, 1, -55)
ContentFrame.Position = UDim2.new(0, 145, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ============================================
-- TAB CREATOR FUNCTION
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
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = tab
    
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 10)
    padding.PaddingBottom = UDim.new(0, 10)
    padding.Parent = tab
    
    return tab
end

-- Toggle Switch Creator
local function CreateToggleSwitch(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 45)
    frame.BackgroundColor3 = Theme.BackgroundLight
    frame.BorderSizePixel = 0
    frame.Parent = parent
    CreateCorner(frame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 50, 0, 26)
    switch.Position = UDim2.new(1, -60, 0.5, -13)
    switch.BackgroundColor3 = Theme.BackgroundDark
    switch.BorderSizePixel = 0
    switch.Parent = frame
    CreateCorner(switch, 13)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 3, 0.5, -10)
    knob.BackgroundColor3 = Theme.TextDark
    knob.BorderSizePixel = 0
    knob.Parent = switch
    CreateCorner(knob, 10)
    
    local enabled = false
    local clickArea = Instance.new("TextButton")
    clickArea.Size = UDim2.new(1, 0, 1, 0)
    clickArea.BackgroundTransparency = 1
    clickArea.Text = ""
    clickArea.Parent = switch
    
    clickArea.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Tween(switch, {BackgroundColor3 = Theme.Accent}, 0.2)
            Tween(knob, {Position = UDim2.new(0, 27, 0.5, -10), BackgroundColor3 = Theme.Text}, 0.2)
        else
            Tween(switch, {BackgroundColor3 = Theme.BackgroundDark}, 0.2)
            Tween(knob, {Position = UDim2.new(0, 3, 0.5, -10), BackgroundColor3 = Theme.TextDark}, 0.2)
        end
        callback(enabled)
    end)
    
    return frame, function(state) 
        enabled = state
        if enabled then
            switch.BackgroundColor3 = Theme.Accent
            knob.Position = UDim2.new(0, 27, 0.5, -10)
            knob.BackgroundColor3 = Theme.Text
        else
            switch.BackgroundColor3 = Theme.BackgroundDark
            knob.Position = UDim2.new(0, 3, 0.5, -10)
            knob.BackgroundColor3 = Theme.TextDark
        end
    end
end

-- Slider Creator
local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 55)
    frame.BackgroundColor3 = Theme.BackgroundLight
    frame.BorderSizePixel = 0
    frame.Parent = parent
    CreateCorner(frame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 200, 0, 20)
    label.Position = UDim2.new(0, 12, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -55, 0, 5)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Theme.Accent
    valueLabel.Font = Enum.Font.GothamBold
    label.TextSize = 13
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = frame
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, 256, 0, 6)
    track.Position = UDim2.new(0, 12, 0, 35)
    track.BackgroundColor3 = Theme.BackgroundDark
    track.BorderSizePixel = 0
    track.Parent = frame
    CreateCorner(track, 3)
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = track
    CreateCorner(fill, 3)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    knob.BackgroundColor3 = Theme.Text
    knob.BorderSizePixel = 0
    knob.Parent = track
    CreateCorner(knob, 7)
    
    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        fill.Size = UDim2.new(pos, 0, 1, 0)
        knob.Position = UDim2.new(pos, -7, 0.5, -7)
        valueLabel.Text = tostring(value)
        callback(value)
    end
    
    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            update(input)
        end
    end)
    
    return frame
end

-- Dropdown Creator
local function CreateDropdown(parent, text, options, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 280, 0, 45)
    frame.BackgroundColor3 = Theme.BackgroundLight
    frame.BorderSizePixel = 0
    frame.Parent = parent
    CreateCorner(frame, 8)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 150, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Theme.Text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0, 110, 0, 30)
    dropdown.Position = UDim2.new(1, -120, 0.5, -15)
    dropdown.BackgroundColor3 = Theme.BackgroundDark
    dropdown.Text = options[1] or "Select"
    dropdown.TextColor3 = Theme.Text
    dropdown.Font = Enum.Font.Gotham
    dropdown.TextSize = 12
    dropdown.Parent = frame
    CreateCorner(dropdown, 6)
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 20, 0, 20)
    arrow.Position = UDim2.new(1, -25, 0, 5)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = Theme.TextDark
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 10
    arrow.Parent = dropdown
    
    local open = false
    local optionsFrame = Instance.new("Frame")
    optionsFrame.Size = UDim2.new(0, 110, 0, #options * 28)
    optionsFrame.Position = UDim2.new(0, 0, 1, 5)
    optionsFrame.BackgroundColor3 = Theme.BackgroundDark
    optionsFrame.BorderSizePixel = 0
    optionsFrame.Visible = false
    optionsFrame.ZIndex = 10
    optionsFrame.Parent = dropdown
    CreateCorner(optionsFrame, 6)
    
    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 28)
        optBtn.Position = UDim2.new(0, 0, 0, (i-1) * 28)
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

-- Button Creator
local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 280, 0, 40)
    btn.BackgroundColor3 = Theme.Accent
    btn.Text = text
    btn.TextColor3 = Theme.Background
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    CreateCorner(btn, 8)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.AccentDark}, 0.2)
    end)
    
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.Accent}, 0.2)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

-- ============================================
-- CREATE TABS
-- ============================================
local AutoFarmTab = CreateTab("AutoFarm")
local CombatTab = CreateTab("Combat")
local TeleportTab = CreateTab("Teleport")
local ESPtab = CreateTab("ESP")
local MiscTab = CreateTab("Misc")
local SettingsTab = CreateTab("Settings")

-- Tab Buttons
CreateTabButton("Auto Farm", "⚔️", AutoFarmTab)
CreateTabButton("Combat", "🛡️", CombatTab)
CreateTabButton("Teleport", "🌀", TeleportTab)
CreateTabButton("ESP", "👁️", ESPtab)
CreateTabButton("Misc", "⚙️", MiscTab)
CreateTabButton("Settings", "🔧", SettingsTab)

-- Select first tab
AutoFarmTab.Visible = true

-- ============================================
-- AUTO FARM TAB
-- ============================================

-- Auto Farm Level
local AutoFarmEnabled = false
local SelectedEnemy = "Bandit"
local FarmMethod = "Above"

CreateToggleSwitch(AutoFarmTab, "Auto Farm Level", function(enabled)
    AutoFarmEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Auto Farm Level Activated", 2)
        spawn(function()
            while AutoFarmEnabled and task.wait() do
                pcall(function()
                    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") 
                           and enemy.Humanoid.Health > 0 then
                            local dist = (enemy.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < 500 then
                                local offset = Vector3.new(0, 30, 0)
                                if FarmMethod == "Behind" then
                                    offset = -enemy.HumanoidRootPart.CFrame.LookVector * 5
                                elseif FarmMethod == "Below" then
                                    offset = Vector3.new(0, -5, 0)
                                end
                                
                                HRP.CFrame = CFrame.new(enemy.HumanoidRootPart.Position + offset)
                                
                                local tool = Character:FindFirstChildOfClass("Tool") 
                                            or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool.Parent = Character
                                    tool:Activate()
                                end
                                
                                -- Auto Buso Haki
                                local args = {[1] = "Buso"}
                                ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                                
                                task.wait(0.1)
                                break
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Auto Farm Level Deactivated", 2)
    end
end)

-- Auto Farm Boss
local AutoBossEnabled = false
CreateToggleSwitch(AutoFarmTab, "Auto Farm Boss", function(enabled)
    AutoBossEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Auto Boss Hunt Activated", 2)
        spawn(function()
            while AutoBossEnabled and task.wait() do
                pcall(function()
                    local bosses = {
                        "The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral",
                        "Warden", "Saber Expert", "Chief Warden", "Swan", "Magma Admiral",
                        "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral",
                        "Don Swan", "Darkbeard", "Rip_Indra", "Order", "Soul Reaper"
                    }
                    for _, bossName in pairs(bosses) do
                        local boss = Workspace.Enemies:FindFirstChild(bossName) 
                                     or Workspace.ReplicatedStorage:FindFirstChild(bossName)
                        if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 then
                            HRP.CFrame = boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
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
        Notify("Auto Farm", "Auto Boss Hunt Deactivated", 2)
    end
end)

-- Auto Collect Fruit
local AutoFruitEnabled = false
CreateToggleSwitch(AutoFarmTab, "Auto Collect Fruit", function(enabled)
    AutoFruitEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Auto Fruit Collector Activated", 2)
        spawn(function()
            while AutoFruitEnabled and task.wait(1) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            if obj.Name:find("Fruit") then
                                HRP.CFrame = obj.Handle.CFrame
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Auto Fruit Collector Deactivated", 2)
    end
end)

-- Auto Quest
local AutoQuestEnabled = false
CreateToggleSwitch(AutoFarmTab, "Auto Quest", function(enabled)
    AutoQuestEnabled = enabled
    if enabled then
        Notify("Auto Farm", "Auto Quest Activated", 2)
        spawn(function()
            while AutoQuestEnabled and task.wait(2) do
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local questData = {
                        [1] = "Bandit", [10] = "Monkey", [30] = "Pirate", [40] = "Brute",
                        [60] = "Desert Bandit", [75] = "Snowman", [100] = "Chief Petty Officer",
                        [150] = "Sky Bandit", [175] = "Dark Master", [225] = "Prisoner",
                        [250] = "Dangerous Prisoner", [300] = "Magma Ninja", [375] = "Fishman Warrior",
                        [400] = "Fishman Commando", [450] = "God's Guard", [475] = "Shanda",
                        [525] = "Royal Squad", [550] = "Royal Soldier", [625] = "Gladiator",
                        [700] = "Military Soldier", [725] = "Military Spy", [775] = "Zombie",
                        [800] = "Vampire", [850] = "Snow Trooper", [875] = "Winter Warrior",
                        [925] = "Lab Subordinate", [950] = "Horned Warrior", [1000] = "Smoke Admiral",
                        [1050] = "Peanut Scout", [1075] = "Peanut President", [1100] = "Ice Cream Chef",
                        [1125] = "Ice Cream Commander", [1175] = "Cookie Crafter", [1200] = "Cake Guard",
                        [1225] = "Baking Staff", [1250] = "Head Baker", [1275] = "Cocoa Warrior",
                        [1300] = "Chocolate Bar Battler", [1325] = "Sweet Thief", [1350] = "Candy Rebel",
                        [1375] = "Candy Pirate", [1400] = "Snow Conjurer", [1500] = "Isle Outlaw"
                    }
                    
                    local currentQuest = nil
                    for reqLevel, quest in pairs(questData) do
                        if level >= reqLevel then
                            currentQuest = quest
                        end
                    end
                    
                    if currentQuest then
                        SelectedEnemy = currentQuest
                        local args = {[1] = "StartQuest", [2] = currentQuest, [3] = level}
                        ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(args))
                    end
                end)
            end
        end)
    else
        Notify("Auto Farm", "Auto Quest Deactivated", 2)
    end
end)

-- Auto Stats
local AutoStatsEnabled = false
CreateToggleSwitch(AutoFarmTab, "Auto Stats (Melee)", function(enabled)
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

-- Farm Method Dropdown
CreateDropdown(AutoFarmTab, "Farm Method", {"Above", "Behind", "Below"}, function(selected)
    FarmMethod = selected
    Notify("Auto Farm", "Farm Method: " .. selected, 2)
end)

-- ============================================
-- COMBAT TAB
-- ============================================

-- Silent Aim
local SilentAimEnabled = false
CreateToggleSwitch(CombatTab, "Silent Aim", function(enabled)
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
CreateToggleSwitch(CombatTab, "Kill Aura", function(enabled)
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
CreateToggleSwitch(CombatTab, "Fast Attack", function(enabled)
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

-- Auto Dodge
local AutoDodgeEnabled = false
CreateToggleSwitch(CombatTab, "Auto Dodge", function(enabled)
    AutoDodgeEnabled = enabled
    if enabled then
        Notify("Combat", "Auto Dodge Activated", 2)
        spawn(function()
            while AutoDodgeEnabled and task.wait(0.1) do
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (player.Character.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < 15 then
                                local dodgeDir = (HRP.Position - player.Character.HumanoidRootPart.Position).Unit
                                HRP.CFrame = HRP.CFrame + dodgeDir * 20
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Combat", "Auto Dodge Deactivated", 2)
    end
end)

-- Auto Buso Haki
local AutoBusoEnabled = false
CreateToggleSwitch(CombatTab, "Auto Buso Haki", function(enabled)
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
-- TELEPORT TAB
-- ============================================

-- Teleport to Sea Beast
local TPSeaBeastEnabled = false
CreateToggleSwitch(TeleportTab, "TP to Sea Beast", function(enabled)
    TPSeaBeastEnabled = enabled
    if enabled then
        Notify("Teleport", "Sea Beast TP Activated", 2)
        spawn(function()
            while TPSeaBeastEnabled and task.wait(0.5) do
                pcall(function()
                    for _, obj in pairs(Workspace.SeaBeasts:GetChildren()) do
                        if obj:FindFirstChild("HumanoidRootPart") then
                            HRP.CFrame = obj.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Teleport", "Sea Beast TP Deactivated", 2)
    end
end)

-- Teleport to Fruit
CreateButton(TeleportTab, "TP to Nearest Fruit", function()
    pcall(function()
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                if obj.Name:find("Fruit") then
                    HRP.CFrame = obj.Handle.CFrame
                    Notify("Teleport", "Teleported to " .. obj.Name, 3)
                    return
                end
            end
        end
        Notify("Teleport", "No fruit found!", 2)
    end)
end)

-- Teleport to Safe Zone
CreateButton(TeleportTab, "TP to Safe Zone", function()
    HRP.CFrame = CFrame.new(0, 10000, 0)
    Notify("Teleport", "Teleported to Safe Zone", 2)
end)

-- ============================================
-- ESP TAB
-- ============================================

-- ESP Players
local ESPEnabled = false
CreateToggleSwitch(ESPtab, "ESP Players", function(enabled)
    ESPEnabled = enabled
    if enabled then
        Notify("ESP", "Player ESP Activated", 2)
        spawn(function()
            while ESPEnabled and task.wait(1) do
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("NanoESP") then
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "NanoESP"
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.new(0, 120, 0, 50)
                                bb.StudsOffset = Vector3.new(0, 3, 0)
                                bb.Parent = player.Character.HumanoidRootPart
                                
                                local lbl = Instance.new("TextLabel", bb)
                                lbl.Size = UDim2.new(1, 0, 1, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = player.Name .. " | Lv." .. (player.Data and player.Data.Level and player.Data.Level.Value or "?")
                                lbl.TextColor3 = Color3.fromRGB(255, 0, 80)
                                lbl.TextStrokeTransparency = 0
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 12
                                
                                local box = Instance.new("BoxHandleAdornment")
                                box.Name = "NanoESPBox"
                                box.Size = player.Character.HumanoidRootPart.Size * 2
                                box.Color3 = Color3.fromRGB(255, 0, 80)
                                box.Transparency = 0.6
                                box.AlwaysOnTop = true
                                box.Adornee = player.Character.HumanoidRootPart
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
CreateToggleSwitch(ESPtab, "ESP Fruits", function(enabled)
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
                                bb.Size = UDim2.new(0, 150, 0, 50)
                                bb.StudsOffset = Vector3.new(0, 2, 0)
                                bb.Parent = obj.Handle
                                
                                local lbl = Instance.new("TextLabel", bb)
                                lbl.Size = UDim2.new(1, 0, 1, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = "🍎 " .. obj.Name
                                lbl.TextColor3 = Color3.fromRGB(0, 255, 200)
                                lbl.TextStrokeTransparency = 0
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 14
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
CreateToggleSwitch(ESPtab, "ESP Chests", function(enabled)
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
                                bb.Size = UDim2.new(0, 100, 0, 30)
                                bb.StudsOffset = Vector3.new(0, 1, 0)
                                bb.Parent = chest.Handle
                                
                                local lbl = Instance.new("TextLabel", bb)
                                lbl.Size = UDim2.new(1, 0, 1, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = "📦 " .. chest.Name
                                lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
                                lbl.TextStrokeTransparency = 0
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 12
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

-- ============================================
-- MISC TAB
-- ============================================

-- Infinite Energy
local InfEnergyEnabled = false
CreateToggleSwitch(MiscTab, "Infinite Energy", function(enabled)
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

-- Super Speed
local WalkSpeedEnabled = false
CreateSlider(MiscTab, "Walk Speed", 16, 500, 100, function(value)
    Humanoid.WalkSpeed = value
end)

-- Super Jump
local JumpPowerEnabled = false
CreateSlider(MiscTab, "Jump Power", 50, 500, 100, function(value)
    Humanoid.JumpPower = value
end)

-- Fly
local FlyEnabled = false
CreateToggleSwitch(MiscTab, "Fly", function(enabled)
    FlyEnabled = enabled
    if enabled then
        Notify("Misc", "Fly Activated (WASD + Space/Shift)", 2)
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
            flyPart.CFrame += move * 3
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
CreateToggleSwitch(MiscTab, "No Clip", function(enabled)
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
CreateToggleSwitch(MiscTab, "Full Bright", function(enabled)
    if enabled then
        Lighting.Brightness = 10
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Notify("Misc", "Full Bright Activated", 2)
    else
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
        Notify("Misc", "Full Bright Deactivated", 2)
    end
end)

-- Auto Raid
local AutoRaidEnabled = false
CreateToggleSwitch(MiscTab, "Auto Raid", function(enabled)
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
                            HRP.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
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

-- ============================================
-- SETTINGS TAB
-- ============================================

-- Theme Color Picker (Simple)
CreateDropdown(SettingsTab, "Accent Color", {"Cyan", "Green", "Red", "Purple", "Orange"}, function(selected)
    local colors = {
        Cyan = Color3.fromRGB(0, 255, 170),
        Green = Color3.fromRGB(0, 255, 100),
        Red = Color3.fromRGB(255, 80, 80),
        Purple = Color3.fromRGB(180, 100, 255),
        Orange = Color3.fromRGB(255, 150, 0)
    }
    Theme.Accent = colors[selected] or Theme.Accent
    Notify("Settings", "Accent color changed to " .. selected, 2)
end)

-- Destroy GUI Button
CreateButton(SettingsTab, "Destroy GUI", function()
    ScreenGui:Destroy()
    blur:Destroy()
end)

-- Rejoin Server
CreateButton(SettingsTab, "Rejoin Server", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- Server Hop
CreateButton(SettingsTab, "Server Hop", function()
    local Http = game:GetService("HttpService")
    local servers = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
    servers = Http:JSONDecode(servers)
    for _, server in pairs(servers.data) do
        if server.playing < server.maxPlayers and server.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
            break
        end
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
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
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
        if MainFrame.Visible then
            Tween(blur, {Size = 10}, 0.3)
        else
            Tween(blur, {Size = 0}, 0.3)
        end
    end
end)

-- Blur effect on open
Tween(blur, {Size = 10}, 0.5)

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
Tween(MainFrame, {Size = UDim2.new(0, 650, 0, 420), Position = UDim2.new(0.5, -325, 0.5, -210)}, 0.6, Enum.EasingStyle.Back)

task.delay(1, function()
    Notify("NanoXyin", "Welcome " .. LocalPlayer.Name .. "! | Press RightShift to toggle", 4)
    Notify("NanoXyin", "By @XyrooXellz | v2.0 Full Release", 3)
end)

-- ============================================
-- END OF SCRIPT
-- ============================================
-- - .... . / .... .- -.-. -.- / .. ... / .-. . .- .-
-- NANOXYIN v2.0 | Blox Fruits Ultimate Hub
-- By @XyrooXellz
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift
-- ============================================
