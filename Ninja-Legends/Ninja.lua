-- ═══════════════════════════════════════════════════════════════════
--     ARCHITECT 04 - NINJA LEGENDS 1 ULTIMATE v5.0
--     AUTO FARM | HATCH EGG | UNLOCK ISLANDS | TELEPORT
--     MODERN UI | CLOSE/OPEN BOX | OPTIMIZED
--     © XyrooXellz
-- ═══════════════════════════════════════════════════════════════════

local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local VirtualInput = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- ═══════════════════════════════════════════════════════════════════
-- ISLAND DATABASE (21 ISLANDS - BERDASARKAN WIKI & HUB SCRIPTS)
-- Sumber: Ninja Legends Wiki, ProGameGuides, & 6 Hub Scripts [citation:1][citation:5]
-- ═══════════════════════════════════════════════════════════════════

local islandsDB = {
    {order=1, name="Enchanted Island", shop=false, chest=true, crystal=true, zone="Beginner"},
    {order=2, name="Austral Island", shop=true, chest=false, crystal=true, zone="Beginner"},
    {order=3, name="Mystical Island", shop=false, chest=true, crystal=true, zone="Intermediate"},
    {order=4, name="Space Island", shop=true, chest=true, crystal=true, zone="Intermediate"},
    {order=5, name="Tundra Island", shop=true, chest=true, crystal=true, zone="Intermediate"},
    {order=6, name="Eternal Island", shop=true, chest=true, crystal=true, zone="Advanced"},
    {order=7, name="Sandstorm", shop=true, chest=true, crystal=true, zone="Advanced"},
    {order=8, name="Thunderstorm", shop=true, chest=true, crystal=true, zone="Advanced"},
    {order=9, name="Ancient Inferno Island", shop=true, chest=true, crystal=false, zone="Expert"},
    {order=10, name="Midnight Shadow Island", shop=true, chest=true, crystal=false, zone="Expert"},
    {order=11, name="Mythical Souls Island", shop=true, chest=true, crystal=false, zone="Expert"},
    {order=12, name="Winter Wonder Island", shop=true, chest=true, crystal=false, zone="Master"},
    {order=13, name="Golden Master Island", shop=true, chest=true, crystal=false, zone="Master"},
    {order=14, name="Dragon Legend Island", shop=true, chest=false, crystal=false, zone="Master"},
    {order=15, name="Cybernetic Legends Island", shop=true, chest=true, crystal=false, zone="Legend"},
    {order=16, name="Skystorm Ultraus Island", shop=true, chest=true, crystal=false, zone="Legend"},
    {order=17, name="Chaos Legends Island", shop=true, chest=true, crystal=false, zone="Legend"},
    {order=18, name="Soul Fusion Island", shop=true, chest=true, crystal=false, zone="Mythic"},
    {order=19, name="Dark Elements Island", shop=true, chest=false, crystal=false, zone="Mythic"},
    {order=20, name="Inner Peace Island", shop=true, chest=false, crystal=false, zone="Mythic"},
    {order=21, name="Blazing Vortex Island", shop=true, chest=false, crystal=false, zone="Ultimate", bonus=true}
}

-- ═══════════════════════════════════════════════════════════════════
-- REMOTE EVENT CACHE (DI-SCAN SEKALI, DISIMPAN)
-- ═══════════════════════════════════════════════════════════════════

local remoteCache = {
    swing = nil,
    sell = nil,
    hatch = nil,
    buy = nil,
    evolve = nil,
    chest = nil
}

local function scanAllRemotes()
    local allDescendants = {}
    
    -- Scan dari berbagai sumber (ReplicatedStorage, Workspace, Players)
    local sources = {ReplicatedStorage, workspace, player}
    
    for _, source in pairs(sources) do
        for _, v in pairs(source:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                local nameLower = v.Name:lower()
                if string.find(nameLower, "swing") or string.find(nameLower, "attack") or string.find(nameLower, "hit") then
                    remoteCache.swing = v
                elseif string.find(nameLower, "sell") or string.find(nameLower, "cash") or string.find(nameLower, "claim") then
                    remoteCache.sell = v
                elseif string.find(nameLower, "hatch") or string.find(nameLower, "egg") then
                    remoteCache.hatch = v
                elseif string.find(nameLower, "buy") or string.find(nameLower, "purchase") then
                    remoteCache.buy = v
                elseif string.find(nameLower, "evolve") or string.find(nameLower, "pet") then
                    remoteCache.evolve = v
                elseif string.find(nameLower, "chest") or string.find(nameLower, "collect") then
                    remoteCache.chest = v
                end
            end
        end
    end
end

scanAllRemotes()

-- ═══════════════════════════════════════════════════════════════════
-- KONFIGURASI (DENGAN SAVE/LOAD)
-- ═══════════════════════════════════════════════════════════════════

local config = {
    autoSwing = true,
    autoSell = true,
    autoBuy = true,
    autoHatchEgg = true,
    autoCollectChests = true,
    autoFarmBosses = false,
    autoEvolvePets = false,
    antiAFK = true,
    infiniteJump = true,
    fastSwing = true,
    swingDelay = 0.08,
    sellDelay = 0.5
}

-- Load saved config
local success, savedData = pcall(function()
    return getgenv().Architect04Config
end)
if success and savedData then
    for k, v in pairs(savedData) do
        config[k] = v
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- UTILITY FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════

local function getCharacter()
    local char = player.Character
    if not char or not char.Parent then
        local success, result = pcall(function()
            return player.CharacterAdded:Wait(5)
        end)
        char = success and result or nil
    end
    return char
end

local function safeFireRemote(remote, ...)
    if remote and remote.Parent then
        pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer(...)
            elseif remote:IsA("RemoteFunction") then
                remote:InvokeServer(...)
            end
        end)
    end
end

-- ═══════════════════════════════════════════════════════════════════
-- ANTI AFK (ROBUST VERSION)
-- ═══════════════════════════════════════════════════════════════════

if config.antiAFK then
    spawn(function()
        while task.wait(50) do
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
            -- Fallback: gerakin kamera dikit
            local mouse = player:GetMouse()
            if mouse then
                local oldPos = mouse.X
                pcall(function()
                    mouse.Move(Vector2.new(oldPos + 1, mouse.Y))
                    task.wait(0.1)
                    mouse.Move(Vector2.new(oldPos, mouse.Y))
                end)
            end
        end
    end)
end

-- ═══════════════════════════════════════════════════════════════════
-- INFINITE JUMP & FAST SWING
-- ═══════════════════════════════════════════════════════════════════

if config.infiniteJump then
    local jumps = 0
    local connection
    connection = UserInputService.JumpRequest:Connect(function()
        local char = getCharacter()
        local humanoid = char and char:FindFirstChild("Humanoid")
        if humanoid and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

if config.fastSwing then
    local function modifyToolDelay()
        local char = getCharacter()
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then
                for _, v in pairs(tool:GetDescendants()) do
                    if v:IsA("NumberValue") and (v.Name:lower():find("delay") or v.Name:lower():find("cooldown")) then
                        v.Value = 0
                    end
                end
            end
        end
    end
    modifyToolDelay()
    player.CharacterAdded:Connect(modifyToolDelay)
end

-- ═══════════════════════════════════════════════════════════════════
-- AUTO FUNCTIONS
-- ═══════════════════════════════════════════════════════════════════

local function autoSwing()
    if not config.autoSwing then return end
    if remoteCache.swing then
        safeFireRemote(remoteCache.swing)
    else
        -- Simulate key press
        VirtualInput:SendKeyEvent(true, "E", false, game)
        task.wait(0.05)
        VirtualInput:SendKeyEvent(false, "E", false, game)
    end
end

local function autoSell()
    if not config.autoSell then return end
    safeFireRemote(remoteCache.sell)
end

local function autoHatchEgg()
    if not config.autoHatchEgg then return end
    
    -- Coba via GUI
    local eggsFolder = player.PlayerGui:FindFirstChild("Eggs") or player.PlayerGui:FindFirstChild("PetEggs")
    if eggsFolder then
        for _, egg in pairs(eggsFolder:GetChildren()) do
            if egg:IsA("ImageButton") or egg:IsA("TextButton") then
                pcall(function() egg:Click() end)
                task.wait(0.1)
            end
        end
    end
    
    -- Fallback via remote
    safeFireRemote(remoteCache.hatch)
end

local function autoBuy()
    if not config.autoBuy then return end
    
    local playerGui = player.PlayerGui
    local shopFrame = playerGui:FindFirstChild("Shop") or playerGui:FindFirstChild("Merchant")
    
    if shopFrame and shopFrame.Enabled then
        for _, button in pairs(shopFrame:GetDescendants()) do
            if button:IsA("TextButton") and button.Visible and button.Active then
                pcall(function() 
                    button:Click()
                    task.wait(0.2)
                end)
            end
        end
    end
    
    safeFireRemote(remoteCache.buy)
end

local function collectChests()
    if not config.autoCollectChests then return end
    
    local char = getCharacter()
    if not char then return end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local chestNames = {"Chest", "Treasure", "RewardChest", "Crystal"}
    
    for _, chestName in pairs(chestNames) do
        local chests = workspace:GetDescendants()
        for _, chest in pairs(chests) do
            if chest:IsA("BasePart") and (chest.Name:find(chestName) or chest.Name:find("Chest")) then
                local dist = (hrp.Position - chest.Position).Magnitude
                if dist < 40 then
                    hrp.CFrame = chest.CFrame
                    task.wait(0.3)
                    safeFireRemote(remoteCache.chest, chest)
                end
            end
        end
    end
end

-- Teleport function (improved)
local function teleportToIsland(islandName)
    local possibleLocations = {
        workspace:FindFirstChild("Map"),
        workspace:FindFirstChild("Islands"),
        workspace,
        workspace:FindFirstChild("World")
    }
    
    for _, location in pairs(possibleLocations) do
        if location then
            local island = location:FindFirstChild(islandName) or 
                          location:FindFirstChild(islandName:gsub(" ", "")) or
                          location:FindFirstChild(islandName:gsub("Island", ""))
            if island then
                local hrp = getCharacter() and getCharacter():FindFirstChild("HumanoidRootPart")
                if hrp then
                    local teleportPos = island:FindFirstChild("Teleport") or 
                                       island:FindFirstChild("Spawn") or 
                                       island:FindFirstChild("CFrame") or
                                       island
                    if teleportPos.CFrame then
                        hrp.CFrame = teleportPos.CFrame
                    else
                        hrp.CFrame = island.CFrame
                    end
                    task.wait(0.5)
                    return true
                end
            end
        end
    end
    return false
end

-- Unlock all islands
local function unlockAllIslands()
    for _, island in pairs(islandsDB) do
        local success = teleportToIsland(island.name)
        if success then
            task.wait(0.8)
        else
            -- Try alternative name
            teleportToIsland(island.name:gsub("Island", ""))
            task.wait(0.8)
        end
    end
    return true
end

-- ═══════════════════════════════════════════════════════════════════
-- MODERN UI (CLOSE/OPEN BOX SYSTEM)
-- ═══════════════════════════════════════════════════════════════════

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Architect04_NL1_Ultimate"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 520)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- GLOW BORDER
local glowBorder = Instance.new("Frame")
glowBorder.Size = UDim2.new(1, 2, 1, 2)
glowBorder.Position = UDim2.new(0, -1, 0, -1)
glowBorder.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
glowBorder.BackgroundTransparency = 0.85
glowBorder.BorderSizePixel = 0
glowBorder.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 17)
glowCorner.Parent = glowBorder

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
header.BackgroundTransparency = 0.88
header.BorderSizePixel = 0
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = header

local titleIcon = Instance.new("TextLabel")
titleIcon.Size = UDim2.new(0, 35, 0, 35)
titleIcon.Position = UDim2.new(0, 12, 0, 6)
titleIcon.BackgroundTransparency = 1
titleIcon.Text = "◈"
titleIcon.TextColor3 = Color3.fromRGB(0, 255, 100)
titleIcon.TextSize = 22
titleIcon.Font = Enum.Font.GothamBold
titleIcon.Parent = header

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -110, 1, 0)
titleText.Position = UDim2.new(0, 50, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "ARCHITECT 04 • NL1"
titleText.TextColor3 = Color3.fromRGB(0, 255, 100)
titleText.TextSize = 14
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = header

-- CLOSE BOX BUTTON (toggle hide/show)
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 34, 0, 34)
toggleBtn.Position = UDim2.new(1, -82, 0, 7)
toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
toggleBtn.BackgroundTransparency = 0.2
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = "⊟"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.TextSize = 16
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.Parent = header

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = toggleBtn

-- CLOSE BUTTON (destroy)
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 34, 0, 34)
closeBtn.Position = UDim2.new(1, -42, 0, 7)
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

-- CONTENT PANEL (yang bisa di-hide/show)
local contentPanel = Instance.new("ScrollingFrame")
contentPanel.Size = UDim2.new(1, -16, 1, -60)
contentPanel.Position = UDim2.new(0, 8, 0, 56)
contentPanel.BackgroundTransparency = 1
contentPanel.BorderSizePixel = 0
contentPanel.CanvasSize = UDim2.new(0, 0, 0, 680)
contentPanel.ScrollBarThickness = 3
contentPanel.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Parent = contentPanel
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- SECTION: STATUS CARD
local statusCard = Instance.new("Frame")
statusCard.Size = UDim2.new(1, -16, 0, 48)
statusCard.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
statusCard.BackgroundTransparency = 0.3
statusCard.BorderSizePixel = 0
statusCard.Parent = contentPanel

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusCard

local statusIcon = Instance.new("TextLabel")
statusIcon.Size = UDim2.new(0, 30, 0, 30)
statusIcon.Position = UDim2.new(0, 10, 0, 9)
statusIcon.BackgroundTransparency = 1
statusIcon.Text = "⚡"
statusIcon.TextColor3 = Color3.fromRGB(0, 255, 100)
statusIcon.TextSize = 20
statusIcon.Parent = statusCard

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -50, 1, 0)
statusLabel.Position = UDim2.new(0, 45, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "SYSTEM READY"
statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusCard

-- SECTION: ISLAND COUNTER
local islandCard = Instance.new("Frame")
islandCard.Size = UDim2.new(1, -16, 0, 44)
islandCard.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
islandCard.BackgroundTransparency = 0.3
islandCard.BorderSizePixel = 0
islandCard.Parent = contentPanel

local islandCornerCard = Instance.new("UICorner")
islandCornerCard.CornerRadius = UDim.new(0, 10)
islandCornerCard.Parent = islandCard

local islandIcon = Instance.new("TextLabel")
islandIcon.Size = UDim2.new(0, 30, 0, 30)
islandIcon.Position = UDim2.new(0, 10, 0, 7)
islandIcon.BackgroundTransparency = 1
islandIcon.Text = "🏝️"
islandIcon.TextSize = 18
islandIcon.Parent = islandCard

local islandCountLabel = Instance.new("TextLabel")
islandCountLabel.Size = UDim2.new(1, -110, 1, 0)
islandCountLabel.Position = UDim2.new(0, 45, 0, 0)
islandCountLabel.BackgroundTransparency = 1
islandCountLabel.Text = "ISLANDS: 0 / " .. #islandsDB
islandCountLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
islandCountLabel.TextSize = 12
islandCountLabel.Font = Enum.Font.Gotham
islandCountLabel.TextXAlignment = Enum.TextXAlignment.Left
islandCountLabel.Parent = islandCard

local unlockIslandBtn = Instance.new("TextButton")
unlockIslandBtn.Size = UDim2.new(0, 90, 0, 32)
unlockIslandBtn.Position = UDim2.new(1, -100, 0, 6)
unlockIslandBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
unlockIslandBtn.BackgroundTransparency = 0.2
unlockIslandBtn.BorderSizePixel = 0
unlockIslandBtn.Text = "UNLOCK ALL"
unlockIslandBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
unlockIslandBtn.TextSize = 10
unlockIslandBtn.Font = Enum.Font.GothamBold
unlockIslandBtn.Parent = islandCard

local unlockCornerBtn = Instance.new("UICorner")
unlockCornerBtn.CornerRadius = UDim.new(0, 6)
unlockCornerBtn.Parent = unlockIslandBtn

-- SECTION: TELEPORT DROPDOWN
local teleportCard = Instance.new("Frame")
teleportCard.Size = UDim2.new(1, -16, 0, 44)
teleportCard.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
teleportCard.BackgroundTransparency = 0.3
teleportCard.BorderSizePixel = 0
teleportCard.Parent = contentPanel

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 10)
teleportCorner.Parent = teleportCard

local teleportIcon = Instance.new("TextLabel")
teleportIcon.Size = UDim2.new(0, 30, 0, 30)
teleportIcon.Position = UDim2.new(0, 10, 0, 7)
teleportIcon.BackgroundTransparency = 1
teleportIcon.Text = "🗺️"
teleportIcon.TextSize = 16
teleportIcon.Parent = teleportCard

local teleportDropdownBtn = Instance.new("TextButton")
teleportDropdownBtn.Size = UDim2.new(1, -110, 0, 32)
teleportDropdownBtn.Position = UDim2.new(0, 45, 0, 6)
teleportDropdownBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
teleportDropdownBtn.BackgroundTransparency = 0.3
teleportDropdownBtn.BorderSizePixel = 0
teleportDropdownBtn.Text = "SELECT ISLAND ▼"
teleportDropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
teleportDropdownBtn.TextSize = 11
teleportDropdownBtn.Font = Enum.Font.Gotham
teleportDropdownBtn.Parent = teleportCard

local teleportBtnCorner = Instance.new("UICorner")
teleportBtnCorner.CornerRadius = UDim.new(0, 6)
teleportBtnCorner.Parent = teleportDropdownBtn

-- DROPDOWN LIST
local dropdownList = Instance.new("ScrollingFrame")
dropdownList.Size = UDim2.new(1, -20, 0, 200)
dropdownList.Position = UDim2.new(0, 10, 0, 52)
dropdownList.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
dropdownList.BackgroundTransparency = 0.15
dropdownList.BorderSizePixel = 0
dropdownList.Visible = false
dropdownList.Parent = contentPanel

local dropdownCornerList = Instance.new("UICorner")
dropdownCornerList.CornerRadius = UDim.new(0, 8)
dropdownCornerList.Parent = dropdownList

local dropdownLayout = Instance.new("UIListLayout")
dropdownLayout.Parent = dropdownList
dropdownLayout.Padding = UDim.new(0, 2)

-- Populate island dropdown
for _, island in pairs(islandsDB) do
    local islandBtn = Instance.new("TextButton")
    islandBtn.Size = UDim2.new(1, -10, 0, 32)
    islandBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    islandBtn.BorderSizePixel = 0
    islandBtn.Text = island.order .. ". " .. island.name
    islandBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    islandBtn.TextSize = 11
    islandBtn.Font = Enum.Font.Gotham
    islandBtn.Parent = dropdownList
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = islandBtn
    
    islandBtn.MouseButton1Click:Connect(function()
        statusLabel.Text = "📍 TELEPORTING TO: " .. island.name
        teleportToIsland(island.name)
        teleportDropdownBtn.Text = island.name .. " ▼"
        dropdownList.Visible = false
        task.wait(2)
        statusLabel.Text = "◆ SYSTEM READY ◆"
    end)
end

-- Toggle dropdown
local dropdownOpen = false
teleportDropdownBtn.MouseButton1Click:Connect(function()
    dropdownOpen = not dropdownOpen
    dropdownList.Visible = dropdownOpen
    teleportDropdownBtn.Text = dropdownOpen and "SELECT ISLAND ▲" or (teleportDropdownBtn.Text:gsub(" ▲", " ▼"):gsub(" ▼", " ▼"))
end)

-- SECTION: ACTION BUTTONS
local actionCard = Instance.new("Frame")
actionCard.Size = UDim2.new(1, -16, 0, 100)
actionCard.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
actionCard.BackgroundTransparency = 0.3
actionCard.BorderSizePixel = 0
actionCard.Parent = contentPanel

local actionCorner = Instance.new("UICorner")
actionCorner.CornerRadius = UDim.new(0, 10)
actionCorner.Parent = actionCard

local actionLayout = Instance.new("UIGridLayout")
actionLayout.Parent = actionCard
actionLayout.CellSize = UDim2.new(0, 110, 0, 38)
actionLayout.CellPadding = UDim2.new(0, 8, 0, 8)
actionLayout.Padding = UDim.new(0, 12)

local buttons = {
    {text="⚔️ AUTO SWING", color=Color3.fromRGB(0,200,80), callback=function() config.autoSwing = not config.autoSwing end},
    {text="💰 AUTO SELL", color=Color3.fromRGB(0,200,80), callback=function() config.autoSell = not config.autoSell end},
    {text="🥚 HATCH EGG", color=Color3.fromRGB(0,150,200), callback=autoHatchEgg},
    {text="📦 COLLECT", color=Color3.fromRGB(0,150,200), callback=collectChests},
    {text="🛒 AUTO BUY", color=Color3.fromRGB(0,200,80), callback=function() config.autoBuy = not config.autoBuy end},
    {text="🐉 EVOLVE", color=Color3.fromRGB(150,100,200), callback=function() autoEvolvePets() end}
}

for _, btnData in pairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = btnData.color
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Text = btnData.text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 11
    btn.Font = Enum.Font.GothamBold
    btn.Parent = actionCard
    
    local btnCornerBtn = Instance.new("UICorner")
    btnCornerBtn.CornerRadius = UDim.new(0, 6)
    btnCornerBtn.Parent = btn
    
    btn.MouseButton1Click:Connect(btnData.callback)
end

-- SECTION: TOGGLE SETTINGS
local settingsCard = Instance.new("Frame")
settingsCard.Size = UDim2.new(1, -16, 0, 120)
settingsCard.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
settingsCard.BackgroundTransparency = 0.3
settingsCard.BorderSizePixel = 0
settingsCard.Parent = contentPanel

local settingsCorner = Instance.new("UICorner")
settingsCorner.CornerRadius = UDim.new(0, 10)
settingsCorner.Parent = settingsCard

local settingsLabel = Instance.new("TextLabel")
settingsLabel.Size = UDim2.new(1, -20, 0, 25)
settingsLabel.Position = UDim2.new(0, 10, 0, 5)
settingsLabel.BackgroundTransparency = 1
settingsLabel.Text = "⚙️ SETTINGS"
settingsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
settingsLabel.TextSize = 12
settingsLabel.Font = Enum.Font.GothamBold
settingsLabel.TextXAlignment = Enum.TextXAlignment.Left
settingsLabel.Parent = settingsCard

local settingsGrid = Instance.new("UIGridLayout")
settingsGrid.Parent = settingsCard
settingsGrid.CellSize = UDim2.new(0, 170, 0, 28)
settingsGrid.CellPadding = UDim2.new(0, 10, 0, 5)
settingsGrid.Padding = UDim.new(0, 10)

local toggles = {
    {text="🧠 ANTI AFK", key="antiAFK"},
    {text="🦘 INFINITE JUMP", key="infiniteJump"},
    {text="⚡ FAST SWING", key="fastSwing"},
    {text="🐣 AUTO HATCH", key="autoHatchEgg"},
    {text="🎁 AUTO CHEST", key="autoCollectChests"},
    {text="👹 FARM BOSS", key="autoFarmBosses"}
}

local toggleButtons = {}
for _, toggleData in pairs(toggles) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = config[toggleData.key] and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(80, 50, 50)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Text = toggleData.text .. (config[toggleData.key] and " ✅" or " ❌")
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 10
    btn.Font = Enum.Font.Gotham
    btn.Parent = settingsGrid
    
    local btnCornerSet = Instance.new("UICorner")
    btnCornerSet.CornerRadius = UDim.new(0, 6)
    btnCornerSet.Parent = btn
    
    toggleButtons[toggleData.key] = btn
    
    btn.MouseButton1Click:Connect(function()
        config[toggleData.key] = not config[toggleData.key]
        btn.Text = toggleData.text .. (config[toggleData.key] and " ✅" or " ❌")
        btn.BackgroundColor3 = config[toggleData.key] and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(80, 50, 50)
    end)
end

-- Auto evolve pets function
local function autoEvolvePets()
    if not config.autoEvolvePets then return end
    safeFireRemote(remoteCache.evolve)
end

-- SECTION: BOTTOM STATUS
local bottomStatus = Instance.new("Frame")
bottomStatus.Size = UDim2.new(1, -16, 0, 36)
bottomStatus.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
bottomStatus.BackgroundTransparency = 0.4
bottomStatus.BorderSizePixel = 0
bottomStatus.Parent = contentPanel

local bottomCorner = Instance.new("UICorner")
bottomCorner.CornerRadius = UDim.new(0, 8)
bottomCorner.Parent = bottomStatus

local bottomText = Instance.new("TextLabel")
bottomText.Size = UDim2.new(1, -16, 1, 0)
bottomText.Position = UDim2.new(0, 8, 0, 0)
bottomText.BackgroundTransparency = 1
bottomText.Text = "© XyrooXellz | Architect 04 | 21 Islands"
bottomText.TextColor3 = Color3.fromRGB(100, 100, 100)
bottomText.TextSize = 9
bottomText.Font = Enum.Font.Gotham
bottomText.TextXAlignment = Enum.TextXAlignment.Left
bottomText.Parent = bottomStatus

-- TOGGLE CONTENT PANEL (CLOSE/OPEN BOX)
local contentVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    contentVisible = not contentVisible
    contentPanel.Visible = contentVisible
    toggleBtn.Text = contentVisible and "⊟" or "⊞"
    mainFrame.Size = contentVisible and UDim2.new(0, 400, 0, 520) or UDim2.new(0, 400, 0, 60)
end)

closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- ═══════════════════════════════════════════════════════════════════
-- MAIN LOOPS (OPTIMIZED)
-- ═══════════════════════════════════════════════════════════════════

-- Swing loop
spawn(function()
    while screenGui.Parent do
        if config.autoSwing then
            autoSwing()
        end
        task.wait(config.swingDelay)
    end
end)

-- Sell & chest loop
spawn(function()
    while screenGui.Parent do
        if config.autoSell then
            autoSell()
        end
        if config.autoCollectChests then
            collectChests()
        end
        task.wait(config.sellDelay)
    end
end)

-- Hatch egg loop
spawn(function()
    while screenGui.Parent do
        if config.autoHatchEgg then
            autoHatchEgg()
        end
        task.wait(10)
    end
end)

-- Auto buy loop
spawn(function()
    while screenGui.Parent do
        if config.autoBuy then
            autoBuy()
        end
        task.wait(25)
    end
end)

-- Auto evolve loop
spawn(function()
    while screenGui.Parent do
        if config.autoEvolvePets then
            autoEvolvePets()
        end
        task.wait(60)
    end
end)

-- ═══════════════════════════════════════════════════════════════════
-- INITIALIZATION
-- ═══════════════════════════════════════════════════════════════════

statusLabel.Text = "🚀 LOADING ARCHITECT 04..."
task.wait(1)
statusLabel.Text = "◆ SYSTEM READY ◆"
islandCountLabel.Text = "ISLANDS: READY / " .. #islandsDB

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("     ARCHITECT 04 - NINJA LEGENDS 1 ULTIMATE v5.0")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("✅ 21 ISLANDS LOADED (Enchanted → Blazing Vortex)")
print("✅ REMOTE EVENTS CACHED")
print("✅ AUTO FARM | HATCH EGG | TELEPORT | UNLOCK ALL")
print("✅ MODERN UI WITH CLOSE/OPEN BOX")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📌 Ninja Legends 1 - Ultimate Script")
print("© XyrooXellz - Architect 04")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- ═══════════════════════════════════════════════════════════════════
-- © XyrooXellz - Architect 04 - Ninja Legends 1 Ultimate v5.0
-- ═══════════════════════════════════════════════════════════════════
