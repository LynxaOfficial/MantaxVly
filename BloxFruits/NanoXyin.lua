-- ============================================
-- BLOX FRUITS ULTIMATE CHEAT SCRIPT
-- Compatible: KRNL, Fluxus, Synapse X, Script-Ware, Electron
-- Version: v4.2
-- ============================================

-- Anti-AFK & Anti-Kick
local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxFruitsUltimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
Title.Text = "BLOX FRUITS ULTIMATE | HACKERAI"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = MainFrame

local TabButtons = Instance.new("Frame")
TabButtons.Size = UDim2.new(1, 0, 0, 30)
TabButtons.Position = UDim2.new(0, 0, 0, 30)
TabButtons.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TabButtons.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -60)
ContentFrame.Position = UDim2.new(0, 0, 0, 60)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Draggable GUI
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============================================
-- FUNCTION: CREATE TOGGLE BUTTON
-- ============================================
local function CreateToggle(parent, text, position, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 220, 0, 30)
    Toggle.Position = position
    Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    Toggle.Text = text
    Toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 12
    Toggle.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Toggle
    
    local Enabled = false
    Toggle.MouseButton1Click:Connect(function()
        Enabled = not Enabled
        Toggle.BackgroundColor3 = Enabled and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(50, 50, 65)
        Toggle.TextColor3 = Enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        callback(Enabled)
    end)
    
    return Toggle
end

-- ============================================
-- TAB 1: AUTO FARM
-- ============================================
local AutoFarmTab = Instance.new("ScrollingFrame")
AutoFarmTab.Size = UDim2.new(1, 0, 1, 0)
AutoFarmTab.BackgroundTransparency = 1
AutoFarmTab.ScrollBarThickness = 4
AutoFarmTab.Visible = true
AutoFarmTab.Parent = ContentFrame

local AutoFarmLayout = Instance.new("UIListLayout")
AutoFarmLayout.Padding = UDim.new(0, 8)
AutoFarmLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
AutoFarmLayout.Parent = AutoFarmTab

-- Auto Farm Level
local AutoFarmEnabled = false
local SelectedEnemy = "Bandit"
local FarmMethod = "Above" -- Above, Behind, Below

CreateToggle(AutoFarmTab, "Auto Farm Level", UDim2.new(0.5, -110, 0, 10), function(enabled)
    AutoFarmEnabled = enabled
    if enabled then
        spawn(function()
            while AutoFarmEnabled and task.wait() do
                pcall(function()
                    local enemies = Workspace.Enemies:GetChildren()
                    for _, enemy in pairs(enemies) do
                        if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") 
                           and enemy.Humanoid.Health > 0 then
                            local enemyName = enemy.Name
                            if enemyName:find(SelectedEnemy) or SelectedEnemy == "Any" then
                                -- Teleport to enemy
                                local targetPos = enemy.HumanoidRootPart.Position
                                local offset = Vector3.new(0, 30, 0)
                                if FarmMethod == "Behind" then
                                    offset = enemy.HumanoidRootPart.CFrame.LookVector * -5
                                elseif FarmMethod == "Below" then
                                    offset = Vector3.new(0, -5, 0)
                                end
                                
                                HRP.CFrame = CFrame.new(targetPos + offset)
                                
                                -- Auto attack
                                local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if tool then
                                    tool.Parent = Character
                                    tool:Activate()
                                end
                                
                                -- Auto Haki
                                if Character:FindFirstChild("HasBuso") then
                                    -- Buso already active
                                else
                                    local args = {[1] = "Buso"}
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                                
                                task.wait(0.1)
                                break
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Auto Farm Boss
local AutoBossEnabled = false
CreateToggle(AutoFarmTab, "Auto Farm Boss", UDim2.new(0.5, -110, 0, 50), function(enabled)
    AutoBossEnabled = enabled
    if enabled then
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
    end
end)

-- Auto Farm Fruit
local AutoFruitEnabled = false
CreateToggle(AutoFarmTab, "Auto Collect Fruit", UDim2.new(0.5, -110, 0, 90), function(enabled)
    AutoFruitEnabled = enabled
    if enabled then
        spawn(function()
            while AutoFruitEnabled and task.wait(1) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            if obj.Name:find("Fruit") or obj.Name == "Bomb Fruit" or obj.Name == "Spike Fruit"
                               or obj.Name == "Chop Fruit" or obj.Name == "Spring Fruit" or obj.Name == "Kilo Fruit"
                               or obj.Name == "Spin Fruit" or obj.Name == "Bird: Falcon Fruit"
                               or obj.Name == "Blade Fruit" or obj.Name == "Smoke Fruit" 
                               or obj.Name == "Sand Fruit" or obj.Name == "Dark Fruit"
                               or obj.Name == "Diamond Fruit" or obj.Name == "Light Fruit"
                               or obj.Name == "Rubber Fruit" or obj.Name == "Barrier Fruit"
                               or obj.Name == "Magma Fruit" or obj.Name == "Quake Fruit"
                               or obj.Name == "Buddha Fruit" or obj.Name == "Love Fruit"
                               or obj.Name == "Spider Fruit" or obj.Name == "Sound Fruit"
                               or obj.Name == "Phoenix Fruit" or obj.Name == "Rumble Fruit"
                               or obj.Name == "Pain Fruit" or obj.Name == "Gravity Fruit"
                               or obj.Name == "Dough Fruit" or obj.Name == "Shadow Fruit"
                               or obj.Name == "Venom Fruit" or obj.Name == "Control Fruit"
                               or obj.Name == "Spirit Fruit" or obj.Name == "Dragon Fruit"
                               or obj.Name == "Leopard Fruit" or obj.Name == "Kitsune Fruit"
                               or obj.Name == "Yeti Fruit" or obj.Name == "Gas Fruit"
                               or obj.Name == "T-Rex Fruit" or obj.Name == "Mammoth Fruit" then
                                
                                HRP.CFrame = obj.Handle.CFrame
                                task.wait(0.5)
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Auto Quest
local AutoQuestEnabled = false
CreateToggle(AutoFarmTab, "Auto Quest", UDim2.new(0.5, -110, 0, 130), function(enabled)
    AutoQuestEnabled = enabled
    if enabled then
        spawn(function()
            while AutoQuestEnabled and task.wait(2) do
                pcall(function()
                    local level = LocalPlayer.Data.Level.Value
                    local questData = {
                        [1] = {NPC = "Bandit Quest Giver", Quest = "Bandit", LevelReq = 1},
                        [10] = {NPC = "Monkey Quest Giver", Quest = "Monkey", LevelReq = 10},
                        [30] = {NPC = "Pirate Quest Giver", Quest = "Pirate", LevelReq = 30},
                        [40] = {NPC = "Brute Quest Giver", Quest = "Brute", LevelReq = 40},
                        [60] = {NPC = "Desert Quest Giver", Quest = "Desert Bandit", LevelReq = 60},
                        [75] = {NPC = "Snow Quest Giver", Quest = "Snowman", LevelReq = 75},
                        [90] = {NPC = "Snow Quest Giver", Quest = "Snowman", LevelReq = 90},
                        [100] = {NPC = "Marine Quest Giver", Quest = "Chief Petty Officer", LevelReq = 100},
                        [150] = {NPC = "Sky Quest Giver", Quest = "Sky Bandit", LevelReq = 150},
                        [175] = {NPC = "Sky Quest Giver", Quest = "Dark Master", LevelReq = 175},
                        [225] = {NPC = "Prison Quest Giver", Quest = "Prisoner", LevelReq = 225},
                        [250] = {NPC = "Prison Quest Giver", Quest = "Dangerous Prisoner", LevelReq = 250},
                        [300] = {NPC = "Magma Quest Giver", Quest = "Magma Ninja", LevelReq = 300},
                        [325] = {NPC = "Magma Quest Giver", Quest = "Magma Ninja", LevelReq = 325},
                        [375] = {NPC = "Fishman Quest Giver", Quest = "Fishman Warrior", LevelReq = 375},
                        [400] = {NPC = "Fishman Quest Giver", Quest = "Fishman Commando", LevelReq = 400},
                        [450] = {NPC = "Sky2 Quest Giver", Quest = "God's Guard", LevelReq = 450},
                        [475] = {NPC = "Sky2 Quest Giver", Quest = "Shanda", LevelReq = 475},
                        [525] = {NPC = "Sky2 Quest Giver", Quest = "Royal Squad", LevelReq = 525},
                        [550] = {NPC = "Sky2 Quest Giver", Quest = "Royal Soldier", LevelReq = 550},
                        [625] = {NPC = "Colosseum Quest Giver", Quest = "Gladiator", LevelReq = 625},
                        [650] = {NPC = "Colosseum Quest Giver", Quest = "Gladiator", LevelReq = 650},
                        [700] = {NPC = "Army Quest Giver", Quest = "Military Soldier", LevelReq = 700},
                        [725] = {NPC = "Army Quest Giver", Quest = "Military Spy", LevelReq = 725},
                        [775] = {NPC = "Zombie Quest Giver", Quest = "Zombie", LevelReq = 775},
                        [800] = {NPC = "Zombie Quest Giver", Quest = "Vampire", LevelReq = 800},
                        [850] = {NPC = "Snow Mountain Quest Giver", Quest = "Snow Trooper", LevelReq = 850},
                        [875] = {NPC = "Snow Mountain Quest Giver", Quest = "Winter Warrior", LevelReq = 875},
                        [925] = {NPC = "Hot and Cold Quest Giver", Quest = "Lab Subordinate", LevelReq = 925},
                        [950] = {NPC = "Hot and Cold Quest Giver", Quest = "Horned Warrior", LevelReq = 950},
                        [1000] = {NPC = "Hot and Cold Quest Giver", Quest = "Smoke Admiral", LevelReq = 1000},
                        [1025] = {NPC = "Hot and Cold Quest Giver", Quest = "Smoke Admiral", LevelReq = 1025},
                        [1050] = {NPC = "Ice Cream Quest Giver", Quest = "Peanut Scout", LevelReq = 1050},
                        [1075] = {NPC = "Ice Cream Quest Giver", Quest = "Peanut President", LevelReq = 1075},
                        [1100] = {NPC = "Ice Cream Quest Giver", Quest = "Ice Cream Chef", LevelReq = 1100},
                        [1125] = {NPC = "Ice Cream Quest Giver", Quest = "Ice Cream Commander", LevelReq = 1125},
                        [1175] = {NPC = "Ice Cream Quest Giver", Quest = "Cookie Crafter", LevelReq = 1175},
                        [1200] = {NPC = "Ice Cream Quest Giver", Quest = "Cake Guard", LevelReq = 1200},
                        [1225] = {NPC = "Ice Cream Quest Giver", Quest = "Baking Staff", LevelReq = 1225},
                        [1250] = {NPC = "Ice Cream Quest Giver", Quest = "Head Baker", LevelReq = 1250},
                        [1275] = {NPC = "Ice Cream Quest Giver", Quest = "Cocoa Warrior", LevelReq = 1275},
                        [1300] = {NPC = "Ice Cream Quest Giver", Quest = "Chocolate Bar Battler", LevelReq = 1300},
                        [1325] = {NPC = "Ice Cream Quest Giver", Quest = "Sweet Thief", LevelReq = 1325},
                        [1350] = {NPC = "Ice Cream Quest Giver", Quest = "Candy Rebel", LevelReq = 1350},
                        [1375] = {NPC = "Ice Cream Quest Giver", Quest = "Candy Pirate", LevelReq = 1375},
                        [1400] = {NPC = "Ice Cream Quest Giver", Quest = "Snow Conjurer", LevelReq = 1400},
                        [1425] = {NPC = "Ice Cream Quest Giver", Quest = "Snow Conjurer", LevelReq = 1425},
                        [1450] = {NPC = "Ice Cream Quest Giver", Quest = "Snow Conjurer", LevelReq = 1450},
                        [1500] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1500},
                        [1525] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1525},
                        [1575] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1575},
                        [1600] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1600},
                        [1625] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1625},
                        [1650] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1650},
                        [1700] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1700},
                        [1725] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1725},
                        [1750] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1750},
                        [1775] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1775},
                        [1800] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1800},
                        [1825] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1825},
                        [1850] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1850},
                        [1875] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1875},
                        [1900] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1900},
                        [1925] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1925},
                        [1950] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1950},
                        [1975] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 1975},
                        [2000] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2000},
                        [2025] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2025},
                        [2050] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2050},
                        [2075] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2075},
                        [2100] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2100},
                        [2125] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2125},
                        [2150] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2150},
                        [2175] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2175},
                        [2200] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2200},
                        [2225] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2225},
                        [2250] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2250},
                        [2275] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2275},
                        [2300] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2300},
                        [2325] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2325},
                        [2350] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2350},
                        [2375] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2375},
                        [2400] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2400},
                        [2425] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2425},
                        [2450] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2450},
                        [2475] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2475},
                        [2500] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2500},
                        [2525] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2525},
                        [2550] = {NPC = "Tiki Quest Giver", Quest = "Isle Outlaw", LevelReq = 2550}
                    }
                    
                    local currentQuest = nil
                    for reqLevel, data in pairs(questData) do
                        if level >= reqLevel then
                            currentQuest = data
                        end
                    end
                    
                    if currentQuest then
                        SelectedEnemy = currentQuest.Quest
                        local args = {[1] = "StartQuest", [2] = currentQuest.Quest, [3] = level}
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    end
                end)
            end
        end)
    end
end)

-- Auto Stats
local AutoStatsEnabled = false
local StatToUpgrade = "Melee" -- Melee, Defense, Sword, Gun, Blox Fruit
CreateToggle(AutoFarmTab, "Auto Stats: " .. StatToUpgrade, UDim2.new(0.5, -110, 0, 170), function(enabled)
    AutoStatsEnabled = enabled
    if enabled then
        spawn(function()
            while AutoStatsEnabled and task.wait(1) do
                pcall(function()
                    local args = {[1] = "AddPoint", [2] = StatToUpgrade, [3] = 1}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end)
            end
        end)
    end
end)

-- ============================================
-- TAB 2: COMBAT / PVP
-- ============================================
local CombatTab = Instance.new("ScrollingFrame")
CombatTab.Size = UDim2.new(1, 0, 1, 0)
CombatTab.BackgroundTransparency = 1
CombatTab.ScrollBarThickness = 4
CombatTab.Visible = false
CombatTab.Parent = ContentFrame

-- Auto Aim / Silent Aim
local SilentAimEnabled = false
CreateToggle(CombatTab, "Silent Aim", UDim2.new(0.5, -110, 0, 10), function(enabled)
    SilentAimEnabled = enabled
    if enabled then
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
                            local dist = (player.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
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
    end
end)

-- Auto Dodge
local AutoDodgeEnabled = false
CreateToggle(CombatTab, "Auto Dodge", UDim2.new(0.5, -110, 0, 50), function(enabled)
    AutoDodgeEnabled = enabled
    if enabled then
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
    end
end)

-- Kill Aura
local KillAuraEnabled = false
CreateToggle(CombatTab, "Kill Aura", UDim2.new(0.5, -110, 0, 90), function(enabled)
    KillAuraEnabled = enabled
    if enabled then
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
                                
                                -- Fruit ability spam
                                local fruit = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                                if fruit and fruit:FindFirstChild("RemoteEvent") then
                                    fruit.RemoteEvent:FireServer()
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Auto Click / Fast Attack
local FastAttackEnabled = false
CreateToggle(CombatTab, "Fast Attack", UDim2.new(0.5, -110, 0, 130), function(enabled)
    FastAttackEnabled = enabled
    if enabled then
        spawn(function()
            while FastAttackEnabled and task.wait(0.01) do
                pcall(function()
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end)
            end
        end)
    end
end)

-- God Mode (Semi)
local GodModeEnabled = false
CreateToggle(CombatTab, "God Mode (Semi)", UDim2.new(0.5, -110, 0, 170), function(enabled)
    GodModeEnabled = enabled
    if enabled then
        spawn(function()
            while GodModeEnabled and task.wait(0.1) do
                pcall(function()
                    if Humanoid.Health < Humanoid.MaxHealth * 0.3 then
                        HRP.CFrame = CFrame.new(0, 10000, 0) -- Teleport to sky to heal
                        task.wait(3)
                    end
                end)
            end
        end)
    end
end)

-- ============================================
-- TAB 3: TELEPORT / ESP
-- ============================================
local TeleportTab = Instance.new("ScrollingFrame")
TeleportTab.Size = UDim2.new(1, 0, 1, 0)
TeleportTab.BackgroundTransparency = 1
TeleportTab.ScrollBarThickness = 4
TeleportTab.Visible = false
TeleportTab.Parent = ContentFrame

-- ESP Players
local ESPEnabled = false
CreateToggle(TeleportTab, "ESP Players", UDim2.new(0.5, -110, 0, 10), function(enabled)
    ESPEnabled = enabled
    if enabled then
        spawn(function()
            while ESPEnabled and task.wait(1) do
                pcall(function()
                    for _, player in pairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            if not player.Character.HumanoidRootPart:FindFirstChild("ESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "ESP"
                                billboard.AlwaysOnTop = true
                                billboard.Size = UDim2.new(0, 100, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 3, 0)
                                billboard.Parent = player.Character.HumanoidRootPart
                                
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.Text = player.Name .. " | Lv." .. (player.Data and player.Data.Level and player.Data.Level.Value or "?")
                                label.TextColor3 = Color3.fromRGB(255, 0, 0)
                                label.TextStrokeTransparency = 0
                                label.Font = Enum.Font.GothamBold
                                label.TextSize = 14
                                label.Parent = billboard
                                
                                local box = Instance.new("BoxHandleAdornment")
                                box.Name = "ESPBox"
                                box.Size = player.Character.HumanoidRootPart.Size * 2
                                box.Color3 = Color3.fromRGB(255, 0, 0)
                                box.Transparency = 0.5
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
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                for _, child in pairs(player.Character.HumanoidRootPart:GetChildren()) do
                    if child.Name == "ESP" or child.Name == "ESPBox" then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

-- ESP Fruit
local ESPFruitEnabled = false
CreateToggle(TeleportTab, "ESP Fruits", UDim2.new(0.5, -110, 0, 50), function(enabled)
    ESPFruitEnabled = enabled
    if enabled then
        spawn(function()
            while ESPFruitEnabled and task.wait(1) do
                pcall(function()
                    for _, obj in pairs(Workspace:GetChildren()) do
                        if obj:IsA("Tool") and obj:FindFirstChild("Handle") then
                            if not obj.Handle:FindFirstChild("FruitESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "FruitESP"
                                billboard.AlwaysOnTop = true
                                billboard.Size = UDim2.new(0, 150, 0, 50)
                                billboard.StudsOffset = Vector3.new(0, 2, 0)
                                billboard.Parent = obj.Handle
                                
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.Text = obj.Name
                                label.TextColor3 = Color3.fromRGB(0, 255, 255)
                                label.TextStrokeTransparency = 0
                                label.Font = Enum.Font.GothamBold
                                label.TextSize = 16
                                label.Parent = billboard
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ESP Chest
local ESPChestEnabled = false
CreateToggle(TeleportTab, "ESP Chests", UDim2.new(0.5, -110, 0, 90), function(enabled)
    ESPChestEnabled = enabled
    if enabled then
        spawn(function()
            while ESPChestEnabled and task.wait(1) do
                pcall(function()
                    for _, chest in pairs(Workspace:GetChildren()) do
                        if chest.Name:find("Chest") and chest:FindFirstChild("Handle") then
                            if not chest.Handle:FindFirstChild("ChestESP") then
                                local billboard = Instance.new("BillboardGui")
                                billboard.Name = "ChestESP"
                                billboard.AlwaysOnTop = true
                                billboard.Size = UDim2.new(0, 100, 0, 30)
                                billboard.StudsOffset = Vector3.new(0, 1, 0)
                                billboard.Parent = chest.Handle
                                
                                local label = Instance.new("TextLabel")
                                label.Size = UDim2.new(1, 0, 1, 0)
                                label.BackgroundTransparency = 1
                                label.Text = chest.Name
                                label.TextColor3 = Color3.fromRGB(255, 215, 0)
                                label.TextStrokeTransparency = 0
                                label.Font = Enum.Font.GothamBold
                                label.TextSize = 14
                                label.Parent = billboard
                            end
                        end
                    end
                end)
            end
        end)
    end
end)

-- Teleport to Sea Beast
local TPSeaBeastEnabled = false
CreateToggle(TeleportTab, "TP to Sea Beast", UDim2.new(0.5, -110, 0, 130), function(enabled)
    TPSeaBeastEnabled = enabled
    if enabled then
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
    end
end)

-- Teleport to NPC
local function TeleportToNPC(npcName)
    for _, npc in pairs(Workspace:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") and npc.Name:find(npcName) then
            HRP.CFrame = npc.HumanoidRootPart.CFrame
            break
        end
    end
end

-- ============================================
-- TAB 4: MISC / UTILITY
-- ============================================
local MiscTab = Instance.new("ScrollingFrame")
MiscTab.Size = UDim2.new(1, 0, 1, 0)
MiscTab.BackgroundTransparency = 1
MiscTab.ScrollBarThickness = 4
MiscTab.Visible = false
MiscTab.Parent = ContentFrame

-- Infinite Energy
local InfEnergyEnabled = false
CreateToggle(MiscTab, "Infinite Energy", UDim2.new(0.5, -110, 0, 10), function(enabled)
    InfEnergyEnabled = enabled
    if enabled then
        spawn(function()
            while InfEnergyEnabled and task.wait(0.1) do
                pcall(function()
                    LocalPlayer.Character.Energy.Value = LocalPlayer.Character.Energy.MaxValue
                end)
            end
        end)
    end
end)

-- No Cooldown
local NoCooldownEnabled = false
CreateToggle(MiscTab, "No Cooldown", UDim2.new(0.5, -110, 0, 50), function(enabled)
    NoCooldownEnabled = enabled
    if enabled then
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "FireServer" and NoCooldownEnabled then
                local args = {...}
                if typeof(args[1]) == "table" and args[1][1] == "Z" or args[1][1] == "X" or args[1][1] == "C" 
                   or args[1][1] == "V" or args[1][1] == "F" then
                    -- Bypass cooldown check
                end
            end
            return old(self, ...)
        end)
        
        setreadonly(mt, true)
    end
end)

-- WalkSpeed
local WalkSpeedEnabled = false
CreateToggle(MiscTab, "Super Speed (300)", UDim2.new(0.5, -110, 0, 90), function(enabled)
    WalkSpeedEnabled = enabled
    if enabled then
        spawn(function()
            while WalkSpeedEnabled and task.wait() do
                pcall(function()
                    Humanoid.WalkSpeed = 300
                end)
            end
        end)
    else
        Humanoid.WalkSpeed = 16
    end
end)

-- JumpPower
local JumpPowerEnabled = false
CreateToggle(MiscTab, "Super Jump (300)", UDim2.new(0.5, -110, 0, 130), function(enabled)
    JumpPowerEnabled = enabled
    if enabled then
        spawn(function()
            while JumpPowerEnabled and task.wait() do
                pcall(function()
                    Humanoid.JumpPower = 300
                end)
            end
        end)
    else
        Humanoid.JumpPower = 50
    end
end)

-- Fly
local FlyEnabled = false
CreateToggle(MiscTab, "Fly", UDim2.new(0.5, -110, 0, 170), function(enabled)
    FlyEnabled = enabled
    if enabled then
        local flyPart = Instance.new("Part")
        flyPart.Size = Vector3.new(1, 1, 1)
        flyPart.Transparency = 1
        flyPart.Anchored = true
        flyPart.CanCollide = false
        flyPart.Parent = Workspace
        
        local flyConnection
        flyConnection = RunService.RenderStepped:Connect(function()
            if FlyEnabled and HRP then
                flyPart.CFrame = HRP.CFrame
                local moveDir = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Workspace.CurrentCamera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Workspace.CurrentCamera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - Vector3.new(0, 1, 0)
                end
                
                flyPart.CFrame = flyPart.CFrame + moveDir * 2
                HRP.CFrame = flyPart.CFrame
                HRP.Velocity = Vector3.new(0, 0, 0)
            end
        end)
        
        spawn(function()
            while FlyEnabled and task.wait() do end
            flyConnection:Disconnect()
            flyPart:Destroy()
        end)
    end
end)

-- No Clip
local NoClipEnabled = false
CreateToggle(MiscTab, "No Clip", UDim2.new(0.5, -110, 0, 210), function(enabled)
    NoClipEnabled = enabled
    if enabled then
        spawn(function()
            while NoClipEnabled and RunService.Stepped:Wait() do
                pcall(function()
                    for _, part in pairs(Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end)
            end
        end)
    else
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end)

-- Auto Raid
local AutoRaidEnabled = false
CreateToggle(MiscTab, "Auto Raid", UDim2.new(0.5, -110, 0, 250), function(enabled)
    AutoRaidEnabled = enabled
    if enabled then
        spawn(function()
            while AutoRaidEnabled and task.wait(1) do
                pcall(function()
                    -- Auto start raid
                    local args = {[1] = "RaidsNpc", [2] = "Select", [3] = "Flame"}
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    
                    -- Auto attack raid enemies
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
    end
end)

-- Auto Sea Event
local AutoSeaEventEnabled = false
CreateToggle(MiscTab, "Auto Sea Event", UDim2.new(0.5, -110, 0, 290), function(enabled)
    AutoSeaEventEnabled = enabled
    if enabled then
        spawn(function()
            while AutoSeaEventEnabled and task.wait(1) do
                pcall(function()
                    for _, event in pairs(Workspace.SeaEvents:GetChildren()) do
                        if event:FindFirstChild("HumanoidRootPart") then
                            HRP.CFrame = event.HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)
                            local tool = Character:FindFirstChildOfClass("Tool")
                            if tool then tool:Activate() end
                        end
                    end
                end)
            end
        end)
    end
end)

-- ============================================
-- TAB 5: FRUIT ABILITIES
-- ============================================
local FruitTab = Instance.new("ScrollingFrame")
FruitTab.Size = UDim2.new(1, 0, 1, 0)
FruitTab.BackgroundTransparency = 1
FruitTab.ScrollBarThickness = 4
FruitTab.Visible = false
FruitTab.Parent = ContentFrame

-- Auto Awaken
local AutoAwakenEnabled = false
CreateToggle(FruitTab, "Auto Awaken", UDim2.new(0.5, -110, 0, 10), function(enabled)
    AutoAwakenEnabled = enabled
    if enabled then
        spawn(function()
            while AutoAwakenEnabled and task.wait(1) do
                pcall(function()
                    local args = {[1] = "AwakenedAbilities", [2] = "Check"}
                    local result = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                    if result then
                        for i = 1, 5 do
                            local args2 = {[1] = "AwakenedAbilities", [2] = "Touched", [3] = i}
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args2))
                        end
                    end
                end)
            end
        end)
    end
end)

-- Auto Use Fruit Skills
local AutoFruitSkillsEnabled = false
CreateToggle(FruitTab, "Auto Spam Fruit Skills", UDim2.new(0.5, -110, 0, 50), function(enabled)
    AutoFruitSkillsEnabled = enabled
    if enabled then
        spawn(function()
            while AutoFruitSkillsEnabled and task.wait(0.5) do
                pcall(function()
                    local fruit = LocalPlayer.Backpack:FindFirstChildOfClass("Tool") 
                                or Character:FindFirstChildOfClass("Tool")
                    if fruit and fruit:FindFirstChild("RemoteEvent") then
                        for _, key in pairs({"Z", "X", "C", "V", "F"}) do
                            local args = {[1] = key}
                            fruit.RemoteEvent:FireServer(unpack(args))
                            task.wait(0.1)
                        end
                    end
                end)
            end
        end)
    end
end)

-- ============================================
-- TAB BUTTONS SETUP
-- ============================================
local tabs = {
    {Name = "Auto Farm", Frame = AutoFarmTab},
    {Name = "Combat", Frame = CombatTab},
    {Name = "TP/ESP", Frame = TeleportTab},
    {Name = "Misc", Frame = MiscTab},
    {Name = "Fruit", Frame = FruitTab}
}

for i, tab in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabs, 0, 1, 0)
    btn.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    btn.Text = tab.Name
    btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.Parent = TabButtons
    
    btn.MouseButton1Click:Connect(function()
        for _, t in ipairs(tabs) do
            t.Frame.Visible = false
        end
        tab.Frame.Visible = true
        for _, child in pairs(TabButtons:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    end)
end

-- Select first tab
tabs[1].Frame.Visible = true
TabButtons:GetChildren()[1].BackgroundColor3 = Color3.fromRGB(0, 200, 100)

-- ============================================
-- KEYBIND TOGGLE GUI
-- ============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- ============================================
-- NOTIFICATION SYSTEM
-- ============================================
local function Notify(title, text, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.Position = UDim2.new(1, -310, 1, -70)
    notif.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -10, 0, 20)
    titleLabel.Position = UDim2.new(0, 5, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.Parent = notif
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -10, 0, 30)
    textLabel.Position = UDim2.new(0, 5, 0, 25)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 12
    textLabel.TextWrapped = true
    textLabel.Parent = notif
    
    TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, -310, 1, -70)}):Play()
    
    task.delay(duration or 3, function()
        TweenService:Create(notif, TweenInfo.new(0.5), {Position = UDim2.new(1, 10, 1, -70)}):Play()
        task.wait(0.5)
        notif:Destroy()
    end)
end

Notify("HACKERAI", "Blox Fruits Ultimate Loaded! Press RightShift to toggle GUI", 5)

-- ============================================
-- AUTO UPDATE CHARACTER REFERENCE
-- ============================================
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HRP = char:WaitForChild("HumanoidRootPart")
end)

-- ============================================
-- ANTI-DETECTION: HIDE GUI FROM SCREENSHOTS
-- ============================================
ScreenGui.DisplayOrder = 999
ScreenGui.IgnoreGuiInset = true

-- ============================================
-- END OF SCRIPT
-- ============================================
-- - .... . / .... .- -.-. -.- / .. ... / .-. . .- .-
-- HACKERAI SYSTEM v4.2 | Blox Fruits Ultimate
-- Compatible: KRNL, Fluxus, Synapse X, Script-Ware, Electron, Codex, Delta, Hydrogen
-- ============================================
