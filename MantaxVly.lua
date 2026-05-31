-- [[ MANTΛX VLY :: BLOX FRUITS PREMIUM ]]
-- [[ Creator: @XyrooXellz | L-01 Shadow System ]]
-- [[ Executor: Delta / Fluxus / CodeX ]]
-- [[ Version: Final Release ]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

-- // DETECT SEA
local function getSea()
    if Workspace:FindFirstChild("Castle_on_the_Sea") or Workspace:FindFirstChild("Floating_Turtle") or Workspace:FindFirstChild("Dragon_Island") then return 3 end
    if Workspace:FindFirstChild("Kingdom_of_Rose") or Workspace:FindFirstChild("Green_Zone") or Workspace:FindFirstChild("Snow_Mountain") then return 2 end
    return 1
end
local SEA = getSea()

-- // DATA
local BOSSES = {
    [1] = {"Diamond","Fajita","Don Swan","Jeremy","Smoke Admiral","Wysper","Thunder God","Cyborg","Saber Expert","Gorilla King","Bobby","Yeti","Mob Leader","Vice Admiral","Magma Admiral","Fishman Lord","Stone","Island Empress","Beautiful Pirate","Longma"},
    [2] = {"Diamond","Fajita","Don Swan","Jeremy","Awakened Ice Admiral","Tide Keeper","Darkbeard","Order","Cursed Captain","Rip_indra","Beautiful Pirate","Longma","Captain Elephant","Cake Queen","Portalmaster","Soul Reaper","Magma Admiral","Fishman Lord","Dough King"},
    [3] = {"Dough King","Beautiful Pirate","Longma","Portalmaster","Cake Queen","Soul Reaper","Rip_indra","Tide Keeper","Darkbeard","Order","Cursed Captain","Leviathan","Dragon Emperor","Kitsune","Mammoth King","T-Rex Lord","Gas Master","Sound Lord","Captain Elephant"}
}

local RAIDS = {
    [1] = {"Saber Expert Raid","Magma Admiral Raid","Fishman Lord Raid"},
    [2] = {"Flame Raid","Ice Raid","Quake Raid","Dark Raid","Light Raid","String Raid","Rumble Raid","Magma Raid","Buddha Raid","Phoenix Raid","Dough Raid","Order Raid","Rip_indra Raid","Tide Keeper Raid"},
    [3] = {"Flame Raid","Ice Raid","Quake Raid","Dark Raid","Light Raid","String Raid","Rumble Raid","Magma Raid","Buddha Raid","Phoenix Raid","Dough Raid","Dragon Raid","Kitsune Raid","Mammoth Raid","Leviathan Raid"}
}

local EVENTS = {
    [1] = {"Factory Raid","Pirate Raid","Marine Raid","Ship Raid"},
    [2] = {"Dark Arena","Sea Beast","Rumbling Waters","Ship Raid","Factory Raid","Castle Raid"},
    [3] = {"Dragon Event","Leviathan Event","Kitsune Event","Sea Beast","Rumbling Waters","Terror Shark","Haunted Castle","Dragon Island","Ship Raid"}
}

local ISLANDS = {
    [1] = {"Starter Island","Jungle","Pirate Village","Desert","Snow Island","Marine Fortress","Skylands","Prison","Colosseum","Magma Village","Underwater City","Fountain City"},
    [2] = {"Kingdom of Rose","Green Zone","Graveyard","Snow Mountain","Hot and Cold","Cursed Ship","Ice Castle","Forgotten Island","Dark Arena","Sea of Treats"},
    [3] = {"Castle on the Sea","Floating Turtle","Haunted Castle","Sea of Treats","Dragon Island","Leviathan Zone","Kitsune Island","Mammoth Cave","T-Rex Valley"}
}

local FRUITS = {"Bomb","Spike","Chop","Spring","Smoke","Flame","Ice","Sand","Dark","Light","Magma","Rumble","Buddha","Dough","Dragon","Leopard","Venom","Spirit","Shadow","Gravity","Paw","Portal","Quake","String","Phoenix","Control","Mammoth","T-Rex","Kitsune","Gas","Sound","Blizzard","Love","Rubber","Barrier","Falcon"}

local SUB_FARMS = {"Dough King Farm","Elite Hunter Farm","Ship Raid Farm","Sea Beast Farm","Bone Farm","Ectoplasm Farm","Leviathan Farm","Dragon Farm","Kitsune Farm","Mammoth Farm","T-Rex Farm","Gas Farm"}

-- // SETTINGS
local settings = {
    autoFarm = false, autoBoss = false, autoRaid = false, autoEvent = false,
    fruitSniper = false, killAura = false, autoStats = false, autoCollect = false,
    autoHaki = false, bringMob = false, autoSubFarm = false, pvpMode = false,
    selectedBoss = BOSSES[SEA][1], selectedRaid = RAIDS[SEA][1],
    selectedFruit = "Dragon", selectedIsland = ISLANDS[SEA][1],
    selectedEvent = EVENTS[SEA][1], selectedSubFarm = SUB_FARMS[1],
    farmSpeed = 0.08, auraRange = 60, weaponType = "Melee"
}

-- // NOTIFICATION
local function notify(title, text, duration)
    StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 4, Icon = "rbxassetid://7733968805"})
end

-- // FRUIT SPAWN NOTIFICATION
local spawnedFruits = {}
coroutine.wrap(function()
    while task.wait(1) do
        pcall(function()
            for _, item in pairs(Workspace:GetChildren()) do
                if item:IsA("Tool") and item.Name:find("Fruit") and not spawnedFruits[item] then
                    spawnedFruits[item] = true
                    local fruitName = item.Name:gsub(" Fruit",""):gsub("-Fruit","")
                    notify("FRUIT SPAWNED", fruitName .. " has appeared on the map!", 5)
                end
            end
        end)
    end
end)()

-- // PLAYER INFO PANEL
coroutine.wrap(function()
    local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    gui.Name = "PlayerInfo"
    gui.ResetOnSpawn = false
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0, 240, 0, 110)
    frame.Position = UDim2.new(1, -250, 0, 8)
    frame.BackgroundColor3 = Color3.fromRGB(10,10,10)
    frame.BackgroundTransparency = 0.4
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", frame).Color = Color3.fromRGB(80,80,80)
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,22)
    title.Text = "PLAYER STATUS"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.BackgroundTransparency = 1
    local info = Instance.new("TextLabel", frame)
    info.Name = "Info"
    info.Size = UDim2.new(1,-10,0,75)
    info.Position = UDim2.new(0,5,0,25)
    info.Text = "Loading..."
    info.TextColor3 = Color3.fromRGB(200,200,200)
    info.Font = Enum.Font.Gotham
    info.TextSize = 10
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.BackgroundTransparency = 1
    info.RichText = true
    while frame.Parent do
        pcall(function()
            local lv = Player.Data.Level.Value or 0
            local beli = Player.Data.Beli or 0
            local bounty = Player.Data.Bounty or 0
            local fruit = Player.Data.DevilFruit or "None"
            local race = Player.Data.Race or "Human"
            local hp = Player.Character and Player.Character.Humanoid and Player.Character.Humanoid.Health or 0
            local mhp = Player.Character and Player.Character.Humanoid and Player.Character.Humanoid.MaxHealth or 0
            info.Text = string.format("Level: <b>%s</b>\nBeli: <b>%s</b>\nBounty: <b>%s</b>\nFruit: <b>%s</b>\nRace: <b>%s</b>\nHP: <b>%d/%d</b>", lv, beli, bounty, fruit, race, hp, mhp)
        end)
        task.wait(2)
    end
end)()

-- // FUNCTIONS
local function tween(pos)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = Player.Character.HumanoidRootPart
    local dist = (root.Position - pos).Magnitude
    local spd = math.clamp(dist / 200, 0.2, 2)
    TweenService:Create(root, TweenInfo.new(spd, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(pos)}):Play()
end

local function equipBest()
    for _, tool in pairs(Player.Backpack:GetChildren()) do
        if tool:IsA("Tool") then Player.Character.Humanoid:EquipTool(tool); return true end
    end
    return false
end

local function attack(target)
    if not target or not target:FindFirstChild("HumanoidRootPart") then return end
    Player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
    task.wait(0.03)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
end

local function isAlive(enemy)
    return enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart")
end

-- // FARM + BOSS
coroutine.wrap(function()
    while task.wait(0.2) do
        if settings.autoFarm or settings.autoBoss then
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    local shouldAttack = false
                    if settings.autoFarm and isAlive(enemy) then shouldAttack = true end
                    if settings.autoBoss and enemy.Name == settings.selectedBoss and isAlive(enemy) then shouldAttack = true end
                    if shouldAttack then
                        equipBest()
                        if settings.bringMob then
                            enemy.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                            enemy.HumanoidRootPart.Anchored = true; task.wait(0.05); enemy.HumanoidRootPart.Anchored = false
                        end
                        repeat
                            tween(enemy.HumanoidRootPart.Position)
                            attack(enemy)
                            task.wait(settings.farmSpeed)
                        until (not settings.autoFarm and not settings.autoBoss) or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)()

-- // SUB FARM
coroutine.wrap(function()
    while task.wait(0.3) do
        if settings.autoSubFarm then
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    local sf = false
                    local sub = settings.selectedSubFarm
                    if sub:find("Dough") and enemy.Name:find("Dough") and isAlive(enemy) then sf = true
                    elseif sub:find("Elite") and enemy.Name:find("Elite") and isAlive(enemy) then sf = true
                    elseif sub:find("Ship") and enemy.Name:find("Ship") and isAlive(enemy) then sf = true
                    elseif sub:find("Sea Beast") and enemy.Name:find("Sea") and isAlive(enemy) then sf = true
                    elseif sub:find("Bone") and enemy.Name:find("Bone") and isAlive(enemy) then sf = true
                    elseif sub:find("Ectoplasm") and enemy.Name:find("Ecto") and isAlive(enemy) then sf = true
                    elseif sub:find("Leviathan") and enemy.Name:find("Levi") and isAlive(enemy) then sf = true
                    elseif sub:find("Dragon") and enemy.Name:find("Dragon") and isAlive(enemy) then sf = true
                    elseif sub:find("Kitsune") and enemy.Name:find("Kitsune") and isAlive(enemy) then sf = true
                    elseif sub:find("Mammoth") and enemy.Name:find("Mammoth") and isAlive(enemy) then sf = true
                    elseif sub:find("T-Rex") and enemy.Name:find("Rex") and isAlive(enemy) then sf = true
                    elseif sub:find("Gas") and enemy.Name:find("Gas") and isAlive(enemy) then sf = true
                    end
                    if sf then
                        equipBest()
                        repeat
                            tween(enemy.HumanoidRootPart.Position)
                            attack(enemy)
                            task.wait(settings.farmSpeed)
                        until not settings.autoSubFarm or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)()

-- // RAID
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.autoRaid then
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if settings.autoRaid and enemy.Name:find(settings.selectedRaid:gsub(" Raid","")) and isAlive(enemy) then
                        equipBest()
                        repeat
                            tween(enemy.HumanoidRootPart.Position)
                            attack(enemy)
                            task.wait(settings.farmSpeed)
                        until not settings.autoRaid or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)()

-- // KILL AURA
coroutine.wrap(function()
    while task.wait(0.03) do
        if settings.killAura then
            pcall(function()
                for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
                    if isAlive(enemy) then
                        local dist = (Player.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                        if dist <= settings.auraRange then
                            equipBest()
                            attack(enemy)
                        end
                    end
                end
            end)
        end
    end
end)()

-- // FRUIT SNIPER
coroutine.wrap(function()
    while task.wait(1) do
        if settings.fruitSniper then
            pcall(function()
                for _, item in pairs(Workspace:GetChildren()) do
                    if item.Name:lower():find(settings.selectedFruit:lower()) then
                        tween(item:GetPivot().Position)
                        task.wait(0.5)
                    end
                end
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
                    if item:IsA("Tool") or item.Name:lower():find("chest") or item.Name:lower():find("gem") then
                        tween(item:GetPivot().Position)
                        task.wait(0.3)
                    end
                end
            end)
        end
    end
end)()

-- // AUTO STATS
coroutine.wrap(function()
    while task.wait(0.3) do
        if settings.autoStats then
            pcall(function()
                ReplicatedStorage.Remotes.Stats:FireServer(settings.weaponType, "+3")
            end)
        end
    end
end)()

-- // AUTO HAKI
coroutine.wrap(function()
    while task.wait(0.3) do
        if settings.autoHaki then
            pcall(function()
                if not Player.Character:FindFirstChild("Buso") then ReplicatedStorage.Remotes.Haki:FireServer("Buso") end
                if not Player.Character:FindFirstChild("Ken") then ReplicatedStorage.Remotes.Haki:FireServer("Ken") end
            end)
        end
    end
end)()

-- // PVP MODE
coroutine.wrap(function()
    while task.wait(0.5) do
        if settings.pvpMode then
            pcall(function()
                for _, tp in pairs(Players:GetPlayers()) do
                    if tp ~= Player and tp.Character and isAlive(tp.Character) then
                        local tl = tp.Data and tp.Data.Level.Value or 0
                        local ml = Player.Data.Level.Value or 0
                        if math.abs(ml - tl) <= 100 and (tp.Data.Bounty or 0) > 0 then
                            equipBest()
                            repeat
                                tween(tp.Character.HumanoidRootPart.Position)
                                attack(tp.Character)
                                task.wait(0.05)
                            until not settings.pvpMode or not tp.Character or not isAlive(tp.Character)
                        end
                    end
                end
            end)
        end
    end
end)()

-- // ANTI AFK
coroutine.wrap(function()
    while task.wait(20) do
        if settings.autoFarm or settings.pvpMode then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                task.wait(0.1)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
            end)
        end
    end
end)()

-- // LOADING
coroutine.wrap(function()
    local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    gui.Name = "Loading"
    local bg = Instance.new("Frame", gui)
    bg.Size = UDim2.new(1,0,1,0)
    bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
    bg.BackgroundTransparency = 0.6
    local box = Instance.new("Frame", gui)
    box.Size = UDim2.new(0,280,0,90)
    box.Position = UDim2.new(0.5,-140,0.5,-45)
    box.BackgroundColor3 = Color3.fromRGB(15,15,15)
    box.BorderSizePixel = 0
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", box).Color = Color3.fromRGB(255,255,255)
    local t1 = Instance.new("TextLabel", box)
    t1.Size = UDim2.new(1,0,0,30)
    t1.Position = UDim2.new(0,0,0,15)
    t1.Text = "MANTΛX VLY"
    t1.TextColor3 = Color3.fromRGB(255,255,255)
    t1.Font = Enum.Font.GothamBold
    t1.TextSize = 22
    t1.BackgroundTransparency = 1
    local t2 = Instance.new("TextLabel", box)
    t2.Size = UDim2.new(1,0,0,20)
    t2.Position = UDim2.new(0,0,0,50)
    t2.Text = "Initializing..."
    t2.TextColor3 = Color3.fromRGB(150,150,150)
    t2.Font = Enum.Font.Gotham
    t2.TextSize = 11
    t2.BackgroundTransparency = 1
    task.delay(2.5, function() gui:Destroy() notify("MANTΛX VLY", "Script ready! Sea "..SEA, 3) end)
end)()

-- // BOX TOGGLE
coroutine.wrap(function()
    local gui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
    gui.Name = "BoxToggle"
    gui.ResetOnSpawn = false
    local btn = Instance.new("TextButton", gui)
    btn.Size = UDim2.new(0,48,0,48)
    btn.Position = UDim2.new(0,8,0.5,-24)
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 22
    btn.Text = "M"
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", btn).Thickness = 1
    local main = Instance.new("Frame", gui)
    main.Size = UDim2.new(0,0,0,0)
    main.Position = UDim2.new(0,65,0.5,0)
    main.BackgroundColor3 = Color3.fromRGB(18,18,18)
    main.BackgroundTransparency = 0.1
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    Instance.new("UICorner", main).CornerRadius = UDim.new(0,10)
    Instance.new("UIStroke", main).Thickness = 1
    local open = false
    btn.MouseButton1Click:Connect(function()
        open = not open
        if open then TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(0,220,0,320)}):Play()
        else TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = UDim2.new(0,0,0,0)}):Play() end
    end)
    local btns = {
        {"Auto Farm", function() settings.autoFarm = not settings.autoFarm end, 8},
        {"Auto Boss", function() settings.autoBoss = not settings.autoBoss end, 48},
        {"Auto Raid", function() settings.autoRaid = not settings.autoRaid end, 88},
        {"Auto Sub Farm", function() settings.autoSubFarm = not settings.autoSubFarm end, 128},
        {"Fruit Sniper", function() settings.fruitSniper = not settings.fruitSniper end, 168},
        {"PvP Mode", function() settings.pvpMode = not settings.pvpMode end, 208},
        {"Teleport Island", function() for _,v in pairs(Workspace:GetChildren()) do if v.Name:lower():find(settings.selectedIsland:lower()) and v:IsA("Model") then tween(v:GetPivot().Position) break end end end, 248},
        {"Close", function() open = false TweenService:Create(main, TweenInfo.new(0.25), {Size = UDim2.new(0,0,0,0)}):Play() end, 288}
    }
    for _, b in pairs(btns) do
        local tb = Instance.new("TextButton", main)
        tb.Size = UDim2.new(1,-16,0,33)
        tb.Position = UDim2.new(0,8,0,b[3])
        tb.BackgroundColor3 = Color3.fromRGB(30,30,30)
        tb.TextColor3 = Color3.fromRGB(255,255,255)
        tb.Font = Enum.Font.Gotham
        tb.TextSize = 12
        tb.Text = b[1]
        tb.BorderSizePixel = 0
        Instance.new("UICorner", tb).CornerRadius = UDim.new(0,6)
        tb.MouseButton1Click:Connect(b[2])
    end
end)()

-- // MAIN GUI
local Window = Fluent:CreateWindow({
    Title = "MANTΛX VLY",
    SubTitle = "@XyrooXellz | Sea " .. SEA,
    TabWidth = 140,
    Size = UDim2.fromOffset(540, 440),
    Acrylic = false,
    Theme = "Dark"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Farm & Boss", Icon = "swords" }),
    Sub = Window:AddTab({ Title = "Sub Farm", Icon = "target" }),
    Raid = Window:AddTab({ Title = "Raid & Event", Icon = "castle" }),
    Fruit = Window:AddTab({ Title = "Fruit", Icon = "cherry" }),
    PvP = Window:AddTab({ Title = "PvP Mode", Icon = "skull" }),
    Teleport = Window:AddTab({ Title = "Teleport", Icon = "map-pin" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "settings" })
}

-- MAIN
Tabs.Main:AddToggle("AF", {Title = "Auto Farm", Default = false}):OnChanged(function(v) settings.autoFarm = v end)
Tabs.Main:AddToggle("AB", {Title = "Auto Boss", Default = false}):OnChanged(function(v) settings.autoBoss = v end)
Tabs.Main:AddToggle("KA", {Title = "Combat Aura", Default = false}):OnChanged(function(v) settings.killAura = v end)
Tabs.Main:AddToggle("BM", {Title = "Bring Mob", Default = false}):OnChanged(function(v) settings.bringMob = v end)
Tabs.Main:AddSlider("FS", {Title = "Attack Speed", Default = 0.08, Min = 0.03, Max = 0.5, Rounding = 2}):OnChanged(function(v) settings.farmSpeed = v end)
Tabs.Main:AddSlider("AR", {Title = "Combat Range", Default = 60, Min = 10, Max = 100, Rounding = 0}):OnChanged(function(v) settings.auraRange = v end)
Tabs.Main:AddDropdown("BD", {Title = "Select Boss", Values = BOSSES[SEA], Default = BOSSES[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedBoss = v end)

-- SUB FARM
Tabs.Sub:AddToggle("ASF", {Title = "Auto Sub Farm", Default = false}):OnChanged(function(v) settings.autoSubFarm = v end)
Tabs.Sub:AddDropdown("SFD", {Title = "Select Sub Farm", Values = SUB_FARMS, Default = SUB_FARMS[1], Multi = false}):OnChanged(function(v) settings.selectedSubFarm = v end)

-- RAID
Tabs.Raid:AddToggle("ARaid", {Title = "Auto Raid", Default = false}):OnChanged(function(v) settings.autoRaid = v end)
Tabs.Raid:AddToggle("AEvent", {Title = "Auto Event", Default = false}):OnChanged(function(v) settings.autoEvent = v end)
Tabs.Raid:AddDropdown("RD", {Title = "Select Raid", Values = RAIDS[SEA], Default = RAIDS[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedRaid = v end)
Tabs.Raid:AddDropdown("ED", {Title = "Select Event", Values = EVENTS[SEA], Default = EVENTS[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedEvent = v end)

-- FRUIT
Tabs.Fruit:AddToggle("FSn", {Title = "Fruit Sniper", Default = false}):OnChanged(function(v) settings.fruitSniper = v end)
Tabs.Fruit:AddDropdown("FD", {Title = "Select Fruit", Values = FRUITS, Default = "Dragon", Multi = false}):OnChanged(function(v) settings.selectedFruit = v end)

-- PVP
Tabs.PvP:AddToggle("PVP", {Title = "Bounty Hunter", Default = false}):OnChanged(function(v) settings.pvpMode = v end)

-- TELEPORT
Tabs.Teleport:AddDropdown("ID", {Title = "Select Island", Values = ISLANDS[SEA], Default = ISLANDS[SEA][1], Multi = false}):OnChanged(function(v) settings.selectedIsland = v end)
Tabs.Teleport:AddButton({Title = "Teleport Now", Callback = function()
    for _, v in pairs(Workspace:GetChildren()) do
        if v.Name:lower():find(settings.selectedIsland:lower()) and v:IsA("Model") then
            tween(v:GetPivot().Position)
            break
        end
    end
end})

-- MISC
Tabs.Misc:AddToggle("AS", {Title = "Auto Stats", Default = false}):OnChanged(function(v) settings.autoStats = v end)
Tabs.Misc:AddToggle("AC", {Title = "Auto Collect", Default = false}):OnChanged(function(v) settings.autoCollect = v end)
Tabs.Misc:AddToggle("AH", {Title = "Auto Haki", Default = false}):OnChanged(function(v) settings.autoHaki = v end)
Tabs.Misc:AddDropdown("WD", {Title = "Stat Type", Values = {"Melee","Defense","Sword","Gun","Blox Fruit"}, Default = "Melee", Multi = false}):OnChanged(function(v) settings.weaponType = v end)

notify("MANTΛX VLY", "Script fully loaded! Enjoy.", 5)
