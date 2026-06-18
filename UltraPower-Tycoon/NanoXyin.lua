-- ============================================
-- NANOXYIN - ULTRA POWER TYCOON ULTIMATE HUB
-- By @XyrooXellz
-- Version: v1.0
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift
-- ============================================

print("[NanoXyin] Initializing Ultra Power Tycoon Hub v1.0...")
print("[NanoXyin] Loading modules...")

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")

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
-- THEME
-- ============================================
local Theme = {
    Background = Color3.fromRGB(10, 10, 20),
    BackgroundLight = Color3.fromRGB(20, 20, 35),
    Surface = Color3.fromRGB(30, 30, 50),
    Accent = Color3.fromRGB(255, 200, 0), -- Gold untuk tycoon theme
    AccentGlow = Color3.fromRGB(255, 170, 0),
    Text = Color3.fromRGB(255, 255, 255),
    TextMuted = Color3.fromRGB(160, 160, 180),
    Danger = Color3.fromRGB(255, 60, 80),
    Success = Color3.fromRGB(0, 255, 130),
    Warning = Color3.fromRGB(255, 200, 0),
    Info = Color3.fromRGB(0, 170, 255)
}

-- ============================================
-- UTILITIES
-- ============================================
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        warn("[NanoXyin] Error: " .. tostring(result))
    end
    return success, result
end

local function Tween(obj, props, duration, style, dir)
    TweenService:Create(obj, TweenInfo.new(duration or 0.35, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end

local function Corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = parent
    return c
end

local function Stroke(parent, color, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color = color or Theme.Accent
    s.Thickness = thick or 1
    s.Transparency = trans or 0.6
    s.Parent = parent
    return s
end

-- ============================================
-- NOTIFICATION
-- ============================================
local NotifQueue = {}
local IsNotif = false

local function ProcessNotif()
    if IsNotif or #NotifQueue == 0 then return end
    IsNotif = true
    local data = table.remove(NotifQueue, 1)
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 80)
    frame.Position = UDim2.new(1, 20, 1, -100)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.ZIndex = 100
    frame.Parent = ScreenGui
    Corner(frame, 14)
    Stroke(frame, Theme.Accent, 1.5, 0.4)
    
    local glow = Instance.new("Frame")
    glow.Size = UDim2.new(1, 0, 0, 2)
    glow.BackgroundColor3 = Theme.Accent
    glow.BorderSizePixel = 0
    glow.ZIndex = 101
    glow.Parent = frame
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 40, 0, 40)
    icon.Position = UDim2.new(0, 15, 0, 15)
    icon.BackgroundTransparency = 1
    icon.Text = "⚡"
    icon.TextColor3 = Theme.Accent
    icon.Font = Enum.Font.GothamBold
    icon.TextSize = 28
    icon.ZIndex = 101
    icon.Parent = frame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -65, 0, 22)
    title.Position = UDim2.new(0, 55, 0, 12)
    title.BackgroundTransparency = 1
    title.Text = data.title
    title.TextColor3 = Theme.Text
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 101
    title.Parent = frame
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, -65, 0, 40)
    text.Position = UDim2.new(0, 55, 0, 34)
    text.BackgroundTransparency = 1
    text.Text = data.text
    text.TextColor3 = Theme.TextMuted
    text.Font = Enum.Font.Gotham
    text.TextSize = 12
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.TextWrapped = true
    text.ZIndex = 101
    text.Parent = frame
    
    Tween(frame, {Position = UDim2.new(1, -380, 1, -100)}, 0.5, Enum.EasingStyle.Back)
    
    task.delay(data.duration or 3, function()
        Tween(frame, {Position = UDim2.new(1, 20, 1, -100)}, 0.4)
        task.wait(0.4)
        SafeCall(function() frame:Destroy() end)
        IsNotif = false
        task.wait(0.1)
        ProcessNotif()
    end)
end

local function Notify(title, text, duration)
    table.insert(NotifQueue, {title = title, text = text, duration = duration})
    ProcessNotif()
end

-- ============================================
-- MAIN GUI
-- ============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NanoXyinUPT"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
Corner(MainFrame, 16)
local mainStroke = Stroke(MainFrame, Theme.Accent, 2, 0.5)

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 55)
TopBar.BackgroundColor3 = Theme.BackgroundLight
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Corner(TopBar, 16)

local topGlow = Instance.new("Frame")
topGlow.Size = UDim2.new(1, 0, 0, 2)
topGlow.Position = UDim2.new(0, 0, 1, -2)
topGlow.BackgroundColor3 = Theme.Accent
topGlow.BorderSizePixel = 0
topGlow.Parent = TopBar

local LogoIcon = Instance.new("TextLabel")
LogoIcon.Size = UDim2.new(0, 30, 0, 30)
LogoIcon.Position = UDim2.new(0, 18, 0, 12)
LogoIcon.BackgroundTransparency = 1
LogoIcon.Text = "⚡"
LogoIcon.TextColor3 = Theme.Accent
LogoIcon.Font = Enum.Font.GothamBold
LogoIcon.TextSize = 24
LogoIcon.Parent = TopBar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(0, 250, 0, 30)
LogoText.Position = UDim2.new(0, 48, 0, 5)
LogoText.BackgroundTransparency = 1
LogoText.Text = "NANOXYIN UPT"
LogoText.TextColor3 = Theme.Text
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 20
LogoText.TextXAlignment = Enum.TextXAlignment.Left
LogoText.Parent = TopBar

local LogoSub = Instance.new("TextLabel")
LogoSub.Size = UDim2.new(0, 250, 0, 18)
LogoSub.Position = UDim2.new(0, 48, 0, 30)
LogoSub.BackgroundTransparency = 1
LogoSub.Text = "Ultra Power Tycoon Hub"
LogoSub.TextColor3 = Theme.TextMuted
LogoSub.Font = Enum.Font.Gotham
LogoSub.TextSize = 10
LogoSub.TextXAlignment = Enum.TextXAlignment.Left
LogoSub.Parent = TopBar

-- Close
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 34, 0, 34)
CloseBtn.Position = UDim2.new(1, -42, 0, 10)
CloseBtn.BackgroundColor3 = Theme.Danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar
Corner(CloseBtn, 10)

CloseBtn.MouseEnter:Connect(function()
    Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 80, 100)}, 0.2)
end)
CloseBtn.MouseLeave:Connect(function()
    Tween(CloseBtn, {BackgroundColor3 = Theme.Danger}, 0.2)
end)

-- Minimize
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 34, 0, 34)
MinBtn.Position = UDim2.new(1, -80, 0, 10)
MinBtn.BackgroundColor3 = Theme.Surface
MinBtn.Text = "−"
MinBtn.TextColor3 = Theme.Text
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.AutoButtonColor = false
MinBtn.Parent = TopBar
Corner(MinBtn, 10)

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 150, 1, -55)
Sidebar.Position = UDim2.new(0, 0, 0, 55)
Sidebar.BackgroundColor3 = Theme.BackgroundLight
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Corner(Sidebar, 16)

local sidebarGlow = Instance.new("Frame")
sidebarGlow.Size = UDim2.new(0, 2, 1, 0)
sidebarGlow.Position = UDim2.new(1, -2, 0, 0)
sidebarGlow.BackgroundColor3 = Theme.Accent
sidebarGlow.BorderSizePixel = 0
sidebarGlow.BackgroundTransparency = 0.7
sidebarGlow.Parent = Sidebar

-- Content
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -165, 1, -65)
ContentFrame.Position = UDim2.new(0, 160, 0, 60)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- ============================================
-- COMPONENTS
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
    
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingBottom = UDim.new(0, 10)
    pad.Parent = tab
    
    return tab
end

local function CreateToggle(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 310, 0, 50)
    frame.BackgroundColor3 = Theme.Surface
    frame.BorderSizePixel = 0
    frame.Parent = parent
    Corner(frame, 12)
    Stroke(frame, Theme.Accent, 0.5, 0.8)
    
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
    
    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 52, 0, 28)
    switchBg.Position = UDim2.new(1, -62, 0.5, -14)
    switchBg.BackgroundColor3 = Theme.BackgroundLight
    switchBg.BorderSizePixel = 0
    switchBg.Parent = frame
    Corner(switchBg, 14)
    
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 22, 0, 22)
    knob.Position = UDim2.new(0, 3, 0.5, -11)
    knob.BackgroundColor3 = Theme.TextMuted
    knob.BorderSizePixel = 0
    knob.Parent = switchBg
    Corner(knob, 11)
    
    local enabled = false
    local click = Instance.new("TextButton")
    click.Size = UDim2.new(1, 0, 1, 0)
    click.BackgroundTransparency = 1
    click.Text = ""
    click.Parent = switchBg
    
    local function SetState(state)
        enabled = state
        if enabled then
            Tween(switchBg, {BackgroundColor3 = Theme.Accent}, 0.25)
            Tween(knob, {Position = UDim2.new(0, 27, 0.5, -11), BackgroundColor3 = Theme.Text}, 0.25)
        else
            Tween(switchBg, {BackgroundColor3 = Theme.BackgroundLight}, 0.25)
            Tween(knob, {Position = UDim2.new(0, 3, 0.5, -11), BackgroundColor3 = Theme.TextMuted}, 0.25)
        end
    end
    
    click.MouseButton1Click:Connect(function()
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
    Corner(btn, 12)
    
    btn.MouseEnter:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.AccentGlow}, 0.2)
    end)
    btn.MouseLeave:Connect(function()
        Tween(btn, {BackgroundColor3 = Theme.Accent}, 0.2)
    end)
    btn.MouseButton1Click:Connect(function()
        SafeCall(callback)
    end)
    
    return btn
end

-- ============================================
-- TABS
-- ============================================
local TycoonTab = CreateTab("Tycoon")
local CombatTab = CreateTab("Combat")
local PowerTab = CreateTab("Powers")
local PlayerTab = CreateTab("Player")
local TeleportTab = CreateTab("Teleport")
local MiscTab = CreateTab("Misc")

local Tabs = {TycoonTab, CombatTab, PowerTab, PlayerTab, TeleportTab, MiscTab}
local TabButtons = {}

local function CreateTabBtn(name, icon, tab)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 140, 0, 40)
    btn.BackgroundColor3 = Theme.BackgroundLight
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Theme.TextMuted
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.Parent = Sidebar
    Corner(btn, 10)
    
    local btnStroke = Stroke(btn, Theme.Accent, 1, 1)
    
    btn.MouseEnter:Connect(function()
        if not tab.Visible then
            Tween(btn, {BackgroundColor3 = Theme.Surface}, 0.2)
        end
    end)
    btn.MouseLeave:Connect(function()
        if not tab.Visible then
            Tween(btn, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(Tabs) do t.Visible = false end
        for _, b in pairs(TabButtons) do
            Tween(b, {BackgroundColor3 = Theme.BackgroundLight}, 0.2)
            local s = b:FindFirstChildOfClass("UIStroke")
            if s then s.Transparency = 1 end
        end
        tab.Visible = true
        Tween(btn, {BackgroundColor3 = Theme.Surface}, 0.2)
        btnStroke.Transparency = 0.3
    end)
    
    table.insert(TabButtons, btn)
    return btn
end

CreateTabBtn("Tycoon", "🏭", TycoonTab)
CreateTabBtn("Combat", "⚔️", CombatTab)
CreateTabBtn("Powers", "⚡", PowerTab)
CreateTabBtn("Player", "👤", PlayerTab)
CreateTabBtn("Teleport", "🌀", TeleportTab)
CreateTabBtn("Misc", "⚙️", MiscTab)

TycoonTab.Visible = true
TabButtons[1].BackgroundColor3 = Theme.Surface
local fs = TabButtons[1]:FindFirstChildOfClass("UIStroke")
if fs then fs.Transparency = 0.3 end

-- ============================================
-- TYCOON TAB
-- ============================================

-- Auto Collect Cash
local AutoCollectEnabled = false
CreateToggle(TycoonTab, "Auto Collect Cash", function(enabled)
    AutoCollectEnabled = enabled
    if enabled then
        Notify("Tycoon", "Auto Collect Cash Enabled", 2)
        spawn(function()
            while AutoCollectEnabled and task.wait(0.5) do
                SafeCall(function()
                    -- Find tycoon cash collectors
                    for _, obj in pairs(Workspace:GetDescendants()) do
                        if obj.Name:find("Cash") or obj.Name:find("Money") or obj.Name:find("Collector") then
                            if obj:FindFirstChild("TouchInterest") and obj:IsA("BasePart") then
                                local dist = (obj.Position - HRP.Position).Magnitude
                                if dist < 50 then
                                    firetouchinterest(HRP, obj, 0)
                                    firetouchinterest(HRP, obj, 1)
                                end
                            end
                        end
                    end
                    
                    -- Alternative: click GUI buttons
                    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        if gui:IsA("TextButton") and (gui.Text:find("Collect") or gui.Text:find("Cash") or gui.Text:find("Money")) then
                            firesignal(gui.MouseButton1Click)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Tycoon", "Auto Collect Cash Disabled", 2)
    end
end)

-- Auto Buy Droppers
local AutoBuyEnabled = false
CreateToggle(TycoonTab, "Auto Buy Droppers", function(enabled)
    AutoBuyEnabled = enabled
    if enabled then
        Notify("Tycoon", "Auto Buy Droppers Enabled", 2)
        spawn(function()
            while AutoBuyEnabled and task.wait(2) do
                SafeCall(function()
                    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        if gui:IsA("TextButton") and gui.Text:find("Buy") and gui.Text:find("Dropper") then
                            if gui.Visible and gui.Parent.Visible then
                                firesignal(gui.MouseButton1Click)
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Tycoon", "Auto Buy Droppers Disabled", 2)
    end
end)

-- Auto Buy Upgrades
local AutoUpgradeEnabled = false
CreateToggle(TycoonTab, "Auto Buy Upgrades", function(enabled)
    AutoUpgradeEnabled = enabled
    if enabled then
        Notify("Tycoon", "Auto Buy Upgrades Enabled", 2)
        spawn(function()
            while AutoUpgradeEnabled and task.wait(3) do
                SafeCall(function()
                    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                        if gui:IsA("TextButton") and (gui.Text:find("Upgrade") or gui.Text:find("Speed") or gui.Text:find("Multiplier")) then
                            if gui.Visible and gui.Parent.Visible then
                                firesignal(gui.MouseButton1Click)
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Tycoon", "Auto Buy Upgrades Disabled", 2)
    end
end)

-- Grab All Tycoons
CreateButton(TycoonTab, "Claim All Tycoons", function()
    SafeCall(function()
        for _, tycoon in pairs(Workspace:GetChildren()) do
            if tycoon.Name:find("Tycoon") or tycoon.Name:find("Base") then
                for _, part in pairs(tycoon:GetDescendants()) do
                    if part:IsA("TouchInterest") or (part:IsA("ClickDetector") and part.Parent:IsA("BasePart")) then
                        if part:IsA("TouchInterest") then
                            firetouchinterest(HRP, part.Parent, 0)
                            firetouchinterest(HRP, part.Parent, 1)
                        elseif part:IsA("ClickDetector") then
                            fireclickdetector(part)
                        end
                    end
                end
            end
        end
        Notify("Tycoon", "Attempted to claim all tycoons", 3)
    end)
end)

-- ============================================
-- COMBAT TAB
-- ============================================

-- Auto Attack
local AutoAttackEnabled = false
CreateToggle(CombatTab, "Auto Attack", function(enabled)
    AutoAttackEnabled = enabled
    if enabled then
        Notify("Combat", "Auto Attack Enabled", 2)
        spawn(function()
            while AutoAttackEnabled and task.wait(0.1) do
                SafeCall(function()
                    -- Find nearest enemy/player
                    local nearest = nil
                    local minDist = math.huge
                    
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (player.Character.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < minDist and dist < 30 then
                                minDist = dist
                                nearest = player.Character
                            end
                        end
                    end
                    
                    -- Attack with tool/ability
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                    
                    -- Fire remote events for powers
                    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and remote.Name:find("Attack") or remote.Name:find("Damage") then
                            if nearest then
                                remote:FireServer(nearest)
                            end
                        end
                    end
                end)
            end
        end)
    else
        Notify("Combat", "Auto Attack Disabled", 2)
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
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local dist = (player.Character.HumanoidRootPart.Position - HRP.Position).Magnitude
                            if dist < 25 then
                                local tool = Character:FindFirstChildOfClass("Tool")
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

-- Auto Block
local AutoBlockEnabled = false
CreateToggle(CombatTab, "Auto Block", function(enabled)
    AutoBlockEnabled = enabled
    if enabled then
        Notify("Combat", "Auto Block Enabled", 2)
        spawn(function()
            while AutoBlockEnabled and task.wait(0.1) do
                SafeCall(function()
                    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and remote.Name:find("Block") then
                            remote:FireServer(true)
                        end
                    end
                end)
            end
        end)
    else
        Notify("Combat", "Auto Block Disabled", 2)
    end
end)

-- ============================================
-- POWERS TAB
-- ============================================

-- Auto Use Power
local AutoPowerEnabled = false
CreateToggle(PowerTab, "Auto Use Power", function(enabled)
    AutoPowerEnabled = enabled
    if enabled then
        Notify("Powers", "Auto Use Power Enabled", 2)
        spawn(function()
            while AutoPowerEnabled and task.wait(0.5) do
                SafeCall(function()
                    -- Try to activate equipped power
                    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                        if remote:IsA("RemoteEvent") and (remote.Name:find("Power") or remote.Name:find("Ability") or remote.Name:find("Skill")) then
                            remote:FireServer()
                        end
                    end
                    
                    -- Try keybinds
                    for _, key in pairs({"Z", "X", "C", "V", "F", "Q", "E", "R"}) do
                        SafeCall(function()
                            local args = {[1] = key}
                            for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
                                if remote:IsA("RemoteEvent") then
                                    remote:FireServer(unpack(args))
                                end
                            end
                        end)
                    end
                end)
            end
        end)
    else
        Notify("Powers", "Auto Use Power Disabled", 2)
    end
end)

-- Unlock All Powers
CreateButton(PowerTab, "Unlock All Powers", function()
    SafeCall(function()
        for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
            if remote:IsA("RemoteEvent") and remote.Name:find("Unlock") then
                remote:FireServer()
            end
            if remote:IsA("RemoteFunction") and remote.Name:find("Unlock") then
                remote:InvokeServer()
            end
        end
        Notify("Powers", "Attempted to unlock all powers", 3)
    end)
end)

-- God Speed Mode
local GodSpeedEnabled = false
CreateToggle(PowerTab, "God Speed Mode", function(enabled)
    GodSpeedEnabled = enabled
    if enabled then
        Notify("Powers", "God Speed Mode Enabled", 2)
        spawn(function()
            while GodSpeedEnabled and task.wait() do
                SafeCall(function()
                    if Humanoid then Humanoid.WalkSpeed = 500 end
                end)
            end
            if Humanoid then Humanoid.WalkSpeed = 16 end
        end)
    else
        Notify("Powers", "God Speed Mode Disabled", 2)
        if Humanoid then Humanoid.WalkSpeed = 16 end
    end
end)

-- ============================================
-- PLAYER TAB
-- ============================================

-- Infinite Health
local InfHealthEnabled = false
CreateToggle(PlayerTab, "Infinite Health", function(enabled)
    InfHealthEnabled = enabled
    if enabled then
        Notify("Player", "Infinite Health Enabled", 2)
        spawn(function()
            while InfHealthEnabled and task.wait(0.1) do
                SafeCall(function()
                    if Humanoid then
                        Humanoid.Health = Humanoid.MaxHealth
                    end
                end)
            end
        end)
    else
        Notify("Player", "Infinite Health Disabled", 2)
    end
end)

-- Super Speed
local SuperSpeedEnabled = false
CreateToggle(PlayerTab, "Super Speed", function(enabled)
    SuperSpeedEnabled = enabled
    if enabled then
        Notify("Player", "Super Speed Enabled", 2)
        spawn(function()
            while SuperSpeedEnabled and task.wait() do
                SafeCall(function()
                    if Humanoid then Humanoid.WalkSpeed = 300 end
                end)
            end
            if Humanoid then Humanoid.WalkSpeed = 16 end
        end)
    else
        Notify("Player", "Super Speed Disabled", 2)
        if Humanoid then Humanoid.WalkSpeed = 16 end
    end
end)

-- Super Jump
local SuperJumpEnabled = false
CreateToggle(PlayerTab, "Super Jump", function(enabled)
    SuperJumpEnabled = enabled
    if enabled then
        Notify("Player", "Super Jump Enabled", 2)
        spawn(function()
            while SuperJumpEnabled and task.wait() do
                SafeCall(function()
                    if Humanoid then Humanoid.JumpPower = 250 end
                end)
            end
            if Humanoid then Humanoid.JumpPower = 50 end
        end)
    else
        Notify("Player", "Super Jump Disabled", 2)
        if Humanoid then Humanoid.JumpPower = 50 end
    end
end)

-- No Clip
local NoClipEnabled = false
local NoClipConn = nil
CreateToggle(PlayerTab, "No Clip", function(enabled)
    NoClipEnabled = enabled
    if enabled then
        Notify("Player", "No Clip Enabled", 2)
        NoClipConn = RunService.Stepped:Connect(function()
            if not NoClipEnabled then return end
            SafeCall(function()
                for _, part in pairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
        end)
    else
        Notify("Player", "No Clip Disabled", 2)
        SafeCall(function()
            if NoClipConn then
                NoClipConn:Disconnect()
                NoClipConn = nil
            end
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end)
    end
end)

-- Fly
local FlyEnabled = false
local FlyConn = nil
local FlyPart = nil
CreateToggle(PlayerTab, "Fly", function(enabled)
    FlyEnabled = enabled
    if enabled then
        Notify("Player", "Fly Enabled - WASD + Space/Shift", 3)
        SafeCall(function()
            FlyPart = Instance.new("Part")
            FlyPart.Name = "NanoFly"
            FlyPart.Size = Vector3.new(1, 1, 1)
            FlyPart.Transparency = 1
            FlyPart.Anchored = true
            FlyPart.CanCollide = false
            FlyPart.Parent = Workspace
            
            FlyConn = RunService.RenderStepped:Connect(function()
                if not FlyEnabled or not FlyPart or not HRP then return end
                FlyPart.CFrame = HRP.CFrame
                local move = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += Workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= Workspace.CurrentCamera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= Workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += Workspace.CurrentCamera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move -= Vector3.new(0, 1, 0) end
                FlyPart.CFrame += move * 5
                HRP.CFrame = FlyPart.CFrame
                HRP.Velocity = Vector3.new(0, 0, 0)
            end)
        end)
    else
        Notify("Player", "Fly Disabled", 2)
        SafeCall(function()
            if FlyConn then FlyConn:Disconnect() FlyConn = nil end
            if FlyPart then FlyPart:Destroy() FlyPart = nil end
        end)
    end
end)

-- ============================================
-- TELEPORT TAB
-- ============================================

CreateButton(TeleportTab, "TP to Base", function()
    SafeCall(function()
        -- Find player's tycoon/base
        for _, obj in pairs(Workspace:GetChildren()) do
            if obj.Name:find(LocalPlayer.Name) or obj.Name:find("Tycoon") then
                if obj:FindFirstChildWhichIsA("BasePart") then
                    HRP.CFrame = obj:FindFirstChildWhichIsA("BasePart").CFrame + Vector3.new(0, 10, 0)
                    Notify("Teleport", "Teleported to base", 2)
                    return
                end
            end
        end
        Notify("Teleport", "Base not found", 2)
    end)
end)

CreateButton(TeleportTab, "TP to Safe Zone", function()
    SafeCall(function()
        HRP.CFrame = CFrame.new(0, 100, 0)
        Notify("Teleport", "Teleported to safe zone", 2)
    end)
end)

CreateButton(TeleportTab, "TP to Random Player", function()
    SafeCall(function()
        local players = Players:GetPlayers()
        if #players > 1 then
            local target = players[math.random(1, #players)]
            if target ~= LocalPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                HRP.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                Notify("Teleport", "Teleported to " .. target.Name, 2)
            end
        end
    end)
end)

-- ============================================
-- MISC TAB
-- ============================================

-- Full Bright
CreateToggle(MiscTab, "Full Bright", function(enabled)
    SafeCall(function()
        if enabled then
            Lighting.Brightness = 10
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 100000
            Notify("Misc", "Full Bright Enabled", 2)
        else
            Lighting.Brightness = 2
            Lighting.GlobalShadows = true
            Lighting.FogEnd = 10000
            Notify("Misc", "Full Bright Disabled", 2)
        end
    end)
end)

-- ESP Players
local ESPEnabled = false
CreateToggle(MiscTab, "ESP Players", function(enabled)
    ESPEnabled = enabled
    if enabled then
        Notify("Misc", "Player ESP Enabled", 2)
        spawn(function()
            while ESPEnabled and task.wait(1) do
                SafeCall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("NanoESP") then
                                local bb = Instance.new("BillboardGui")
                                bb.Name = "NanoESP"
                                bb.AlwaysOnTop = true
                                bb.Size = UDim2.new(0, 120, 0, 40)
                                bb.StudsOffset = Vector3.new(0, 3, 0)
                                bb.Parent = player.Character.HumanoidRootPart
                                
                                local bg = Instance.new("Frame")
                                bg.Size = UDim2.new(1, 0, 1, 0)
                                bg.BackgroundColor3 = Theme.BackgroundDark
                                bg.BackgroundTransparency = 0.3
                                bg.BorderSizePixel = 0
                                bg.Parent = bb
                                Corner(bg, 8)
                                
                                local lbl = Instance.new("TextLabel")
                                lbl.Size = UDim2.new(1, -8, 1, 0)
                                lbl.Position = UDim2.new(0, 4, 0, 0)
                                lbl.BackgroundTransparency = 1
                                lbl.Text = player.Name
                                lbl.TextColor3 = Theme.Accent
                                lbl.Font = Enum.Font.GothamBold
                                lbl.TextSize = 12
                                lbl.Parent = bg
                                
                                local box = Instance.new("BoxHandleAdornment")
                                box.Name = "NanoESPBox"
                                box.Size = player.Character.HumanoidRootPart.Size * 2
                                box.Color3 = Theme.Accent
                                box.Transparency = 0.7
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
        Notify("Misc", "Player ESP Disabled", 2)
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

-- Rejoin Server
CreateButton(MiscTab, "Rejoin Server", function()
    SafeCall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end)

-- Server Hop
CreateButton(MiscTab, "Server Hop", function()
    SafeCall(function()
        local Http = game:GetService("HttpService")
        local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local servers = game:HttpGet(url)
        servers = Http:JSONDecode(servers)
        for _, server in pairs(servers.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                break
            end
        end
    end)
end)

-- ============================================
-- OPEN / CLOSE / MINIMIZE
-- ============================================
local IsOpen = true
local IsMinimized = false

local function CloseGUI()
    IsOpen = false
    Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
    task.wait(0.4)
    SafeCall(function()
        -- Disable all
        AutoCollectEnabled = false
        AutoBuyEnabled = false
        AutoUpgradeEnabled = false
        AutoAttackEnabled = false
        KillAuraEnabled = false
        AutoBlockEnabled = false
        AutoPowerEnabled = false
        GodSpeedEnabled = false
        InfHealthEnabled = false
        SuperSpeedEnabled = false
        SuperJumpEnabled = false
        NoClipEnabled = false
        FlyEnabled = false
        ESPEnabled = false
        
        if NoClipConn then NoClipConn:Disconnect() end
        if FlyConn then FlyConn:Disconnect() end
        if FlyPart then FlyPart:Destroy() end
        
        ScreenGui:Destroy()
    end)
    print("[NanoXyin] Ultra Power Tycoon Hub closed")
end

CloseBtn.MouseButton1Click:Connect(CloseGUI)

local function MinimizeGUI()
    IsMinimized = not IsMinimized
    if IsMinimized then
        Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 55), Position = UDim2.new(0.5, -350, 0.5, -27)}, 0.35)
        ContentFrame.Visible = false
        Sidebar.Visible = false
        MinBtn.Text = "+"
    else
        Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 450), Position = UDim2.new(0.5, -350, 0.5, -225)}, 0.35)
        ContentFrame.Visible = true
        Sidebar.Visible = true
        MinBtn.Text = "−"
    end
end

MinBtn.MouseButton1Click:Connect(MinimizeGUI)

-- ============================================
-- DRAGGING
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
            if input.UserInputState == Enum.UserInputState.End then Dragging = false end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
        local delta = input.Position - DragStart
        MainFrame.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + delta.X, StartPos.Y.Scale, StartPos.Y.Offset + delta.Y)
    end
end)

-- ============================================
-- KEYBIND (RightShift)
-- ============================================
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if IsOpen then
            if IsMinimized then
                MinimizeGUI()
            else
                MainFrame.Visible = not MainFrame.Visible
            end
        end
    end
end)

-- ============================================
-- CHARACTER UPDATE
-- ============================================
LocalPlayer.CharacterAdded:Connect(function(char)
    SafeCall(function()
        Character = char
        Humanoid = char:WaitForChild("Humanoid")
        HRP = char:WaitForChild("HumanoidRootPart")
        print("[NanoXyin] Character updated")
    end)
end)

-- ============================================
-- INTRO
-- ============================================
Tween(MainFrame, {Size = UDim2.new(0, 700, 0, 450), Position = UDim2.new(0.5, -350, 0.5, -225)}, 0.7, Enum.EasingStyle.Back)

spawn(function()
    while MainFrame and MainFrame.Parent do
        SafeCall(function()
            Tween(mainStroke, {Transparency = 0.2}, 1.2)
        end)
        task.wait(1.2)
        SafeCall(function()
            Tween(mainStroke, {Transparency = 0.7}, 1.2)
        end)
        task.wait(1.2)
    end
end)

task.delay(1.2, function()
    Notify("NanoXyin UPT v1.0", "Welcome, " .. LocalPlayer.Name .. "!", 4)
    Notify("Ultra Power Tycoon", "Hub loaded successfully", 3)
    Notify("Keybind", "Press RightShift to toggle GUI", 3)
end)

print("[NanoXyin] Ultra Power Tycoon Hub v1.0 loaded!")
print("[NanoXyin] All systems operational")

-- ============================================
-- END
-- ============================================
-- NANOXYIN UPT v1.0 | Ultra Power Tycoon Ultimate Hub
-- By @XyrooXellz
-- Compatible: Delta, KRNL, Fluxus, Codex, Hydrogen, Swift
-- ============================================
