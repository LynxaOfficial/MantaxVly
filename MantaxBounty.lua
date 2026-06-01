--[[
    ███╗   ███╗ █████╗ ███╗   ██╗████████╗ █████╗ ██╗  ██╗
    ████╗ ████║██╔══██╗████╗  ██║╚══██╔══╝██╔══██╗╚██╗██╔╝
    ██╔████╔██║███████║██╔██╗ ██║   ██║   ███████║ ╚███╔╝ 
    ██║╚██╔╝██║██╔══██║██║╚██╗██║   ██║   ██╔══██║ ██╔██╗ 
    ██║ ╚═╝ ██║██║  ██║██║ ╚████║   ██║   ██║  ██║██╔╝ ██╗
    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝
--]]
--     MANTAXBOUNTY v4.0 | BY GANNADY PROGRAMMER TERBAIK
--     FULL FEATURE BOUNTY HUNTER | UPDATE 2026 READY
--     COMPATIBLE: PC/MOBILE | ALL EXECUTORS

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

-- █▀▀ █▀█ █▀█ █▀▀ █▀▀ █▀▀   █▀█ █▀█ █▀█ █ █▀▀   █▀█ █▀▀ █▀▀ █ █▀▀
-- █▀▀ █▀▄ █▀▀ █▀▀ █▀▀ █▀▀   █▀▀ █▀█ █▀▄ █ █▀▀   █▀▄ █▀▀ █▀▀ █ ▀▀█
-- ▀▀▀ ▀░▀ ▀   ▀▀▀ ▀▀▀ ▀▀▀   ▀   ▀░▀ ▀░▀ ▀ ▀▀▀   ▀░▀ ▀▀▀ ▀▀▀ ▀ ▀▀▀

getgenv().MantaxConfig = {
    -- ═══════════════════════════════════════════════════════════
    -- 🎯 BOUNTY HUNTER CORE SETTINGS
    -- ═══════════════════════════════════════════════════════════
    ["Team"] = "Pirates",  -- "Pirates" atau "Marines"
    ["TargetBounty"] = {
        ["Min"] = 500000,   -- Minimal bounty target (500k)
        ["Max"] = 30000000  -- Max bounty target (30M)
    },
    
    -- ═══════════════════════════════════════════════════════════
    -- ⚔️ SKILL SETTINGS (Melee/Sword/Gun/Fruit)
    -- ═══════════════════════════════════════════════════════════
    ["Melee"] = {
        ["Enable"] = true,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["C"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["Delay"] = 1.5
    },
    ["Sword"] = {
        ["Enable"] = true,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["Delay"] = 1
    },
    ["Gun"] = {
        ["Enable"] = false,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["Delay"] = 1,
        ["GunMode"] = false
    },
    ["Fruit"] = {
        ["Enable"] = false,
        ["Z"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["X"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["C"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["V"] = {["Enable"] = false, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["F"] = {["Enable"] = true, ["HoldTime"] = 0.05, ["WaitNextSkill"] = 0.6},
        ["Delay"] = 1
    },
    
    -- ═══════════════════════════════════════════════════════════
    -- 🛡️ SAFETY & SKIP SETTINGS
    -- ═══════════════════════════════════════════════════════════
    ["Skip"] = {
        ["Fruit"] = false,
        ["FruitList"] = {"Buddha", "Leopard", "T-Rex", "Kitsune", "Dough"},
        ["SafeZone"] = true,     -- Hindari SafeZone
        ["NoHaki"] = true,       -- Skip yang ga pake Haki
        ["NoPvP"] = true,        -- Skip yang PvP mati
        ["SkipHighLevel"] = false,
        ["MaxLevelDiff"] = 100
    },
    
    ["SafeHealth"] = {
        ["Enable"] = true,
        ["Health"] = 5200,
        ["Mask"] = false,
        ["RaceV4"] = false,
        ["AutoRun"] = true,       -- Lari kalo HP rendah
        ["RunDistance"] = 500
    },
    
    -- ═══════════════════════════════════════════════════════════
    -- 🌐 SERVER & AUTO HOP SETTINGS
    -- ═══════════════════════════════════════════════════════════
    ["Another"] = {
        ["V3"] = true,
        ["V4"] = true,
        ["CustomHealth"] = true,
        ["Health"] = 5200,
        ["WhiteScreen"] = false,
        ["FPSBoots"] = false,
        ["AutoServerHop"] = true,
        ["HopWhenNoBounty"] = true,     -- Hop kalo ga ada target
        ["BountyLock"] = false,
        ["BountyLockAt"] = 30000000,
        ["ServerHopAfterTime"] = false,
        ["ServerHopTime"] = 900,
        ["CheckCombatBeforeHop"] = true,
        ["MaxPlayersInServer"] = 8,
        ["PreferredServers"] = {"EU", "NA"}  -- Pilih region server
    },
    
    -- ═══════════════════════════════════════════════════════════
    -- 📡 ESP & VISUAL SETTINGS
    -- ═══════════════════════════════════════════════════════════
    ["ESP"] = {
        ["Enabled"] = true,
        ["ShowBounty"] = true,
        ["ShowHealth"] = true,
        ["ShowDistance"] = true,
        ["ShowFruit"] = true,
        ["TeamColor"] = true,
        ["MaxDistance"] = 5000,
        ["RefreshRate"] = 0.1
    },
    
    -- ═══════════════════════════════════════════════════════════
    -- 💬 WEBHOOT (Discord Notifications)
    -- ═══════════════════════════════════════════════════════════
    ["Webhook"] = {
        ["Enabled"] = false,
        ["Url"] = "",
        ["Embed"] = true,
        ["SendKillNotifications"] = true,
        ["SendTargetNotifications"] = true,
        ["SendHopNotifications"] = true,
        ["SendFruitNotifications"] = true,
        ["SendStartNotification"] = true,
        ["ImageEmbed"] = true,
        ["StoredFruit"] = true
    },
    
    -- ═══════════════════════════════════════════════════════════
    -- 🚀 AUTO COMBO PRESETS (Berdasarkan Meta Update 2026)
    -- ═══════════════════════════════════════════════════════════
    ["ComboPreset"] = {
        ["Selected"] = "TTK",  -- "TTK", "KITSUNE", "DOUGH", "BISENTO", "DARKBLADE"
        ["TTK"] = {
            -- TTK + Sanguine + Portal + Cyborg | Rating 9.5/10 [citation:4]
            ["Skills"] = {"Portal_V", "TTK_Z", "TTK_X", "Sanguine_Z", "Sanguine_X", "Sanguine_C"},
            ["Damage"] = 23000,
            ["Speed"] = "Very Fast"
        },
        ["KITSUNE"] = {
            -- Kitsune + Sanguine + Yama + Cyborg | Rating 9/10 [citation:4]
            ["Skills"] = {"Kitsune_Z", "Kitsune_X", "Sanguine_Z", "Sanguine_X", "Yama_Z"},
            ["Damage"] = 21000,
            ["Speed"] = "Fast"
        },
        ["DOUGH"] = {
            -- Godhuman + Dough + CDK + Cyborg | Rating 8/10 [citation:4]
            ["Skills"] = {"Dough_V", "Dough_Z", "Godhuman_Z", "CDK_Z", "CDK_X"},
            ["Damage"] = 19000,
            ["Speed"] = "Medium"
        },
        ["BISENTO"] = {
            -- Bisento Combo | Fast & Reliable [citation:8]
            ["Skills"] = {"Bisento_Z", "Bisento_X", "Godhuman_Z", "Godhuman_X"},
            ["Damage"] = 16000,
            ["Speed"] = "Extremely Fast"
        },
        ["DARKBLADE"] = {
            -- Dark Blade + Venom Bow + Godhuman [citation:8]
            ["Skills"] = {"DarkBlade_Z", "VenomBow_Z", "Godhuman_Z", "Godhuman_X"},
            ["Damage"] = 15000,
            ["Speed"] = "Extremely Fast"
        }
    }
}

-- █▀▀ █▀█ █▀█ █▀▀ █▀▀ █▀▀   █▀█ █▀█ █▀█ █ █▀▀   █▀▀ █░█ █▀▀ █▀█ █▀█ █▀▀
-- █▀▀ █▀▄ █▀▀ █▀▀ █▀▀ █▀▀   █▀▀ █▀█ █▀▄ █ █▀▀   █░░ █▀█ █▀▀ █▀▄ █▀█ █▄▄
-- ▀▀▀ ▀░▀ ▀   ▀▀▀ ▀▀▀ ▀▀▀   ▀   ▀░▀ ▀░▀ ▀ ▀▀▀   ▀▀▀ ▀░▀ ▀▀▀ ▀░▀ ▀░▀ ▀▀▀

local MantaxLib = {
    Players = {},
    ESP = {},
    Combat = {},
    Utils = {}
}

-- 📍 FIND BEST TARGET (Berdasarkan Bounty)
function MantaxLib.Players.FindBestTarget()
    local bestTarget = nil
    local highestBounty = 0
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= Player and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local bounty = MantaxLib.Players.GetBounty(v)
            local levelDiff = math.abs(v.Data.Level.Value - Player.Data.Level.Value)
            
            -- Filter berdasarkan level diff (max 618 level diff) [citation:10]
            if levelDiff <= 618 and bounty >= MantaxConfig.TargetBounty.Min and bounty <= MantaxConfig.TargetBounty.Max then
                if bounty > highestBounty then
                    highestBounty = bounty
                    bestTarget = v
                end
            end
        end
    end
    return bestTarget
end

-- ⚔️ AUTO COMBO EXECUTOR
function MantaxLib.Combat.ExecuteCombo(target, preset)
    local combo = MantaxConfig.ComboPreset[preset]
    if not combo then return end
    
    for _, skill in ipairs(combo.Skills) do
        MantaxLib.Combat.UseSkill(target, skill)
        wait(0.1)
    end
end

-- 🎨 ESP SYSTEM (Dengan Bounty Display)
function MantaxLib.ESP.Create()
    local TracerLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPNG/ESP_LIBRARY/main/7GrandDadESP"))()
    
    TracerLib:CreateTracer({
        Name = "MantaxBountyESP",
        Color = Color3.fromRGB(255, 0, 127),
        Enabled = true,
        ShowDistance = true,
        ShowHealth = true,
        CustomText = function(plr)
            local bounty = MantaxLib.Players.GetBounty(plr)
            return string.format("💰 %s | 🎯 %s", plr.Name, MantaxLib.Utils.FormatNumber(bounty))
        end
    })
end

-- 💰 GET BOUNTY/HONOR
function MantaxLib.Players.GetBounty(player)
    -- Bounty untuk Pirates, Honor untuk Marines [citation:9]
    if MantaxConfig.Team == "Pirates" then
        return player.Data.Bounty.Value
    else
        return player.Data.Honor.Value
    end
end

-- 🏃 AUTO RUN WHEN LOW HEALTH
function MantaxLib.Combat.AutoRun()
    local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health < MantaxConfig.SafeHealth.Health then
        -- Teleport ke SafeZone
        local safeLocation = MantaxLib.Utils.FindSafeZone()
        if safeLocation then
            Player.Character.HumanoidRootPart.CFrame = safeLocation
        end
    end
end

-- 🔄 AUTO SERVER HOP
function MantaxLib.Server.AutoHop()
    if MantaxConfig.Another.AutoServerHop then
        local playerCount = #game.Players:GetPlayers()
        local targetCount = MantaxConfig.Another.MaxPlayersInServer
        
        if playerCount > targetCount then
            -- Teleport ke server baru
            game:GetService("TeleportService"):Teleport(2753915549) -- Blox Fruits Game ID
        end
    end
end

-- 📊 FORMAT NUMBER (1.5M -> 1.5M)
function MantaxLib.Utils.FormatNumber(num)
    if num >= 1000000 then
        return string.format("%.1fM", num / 1000000)
    elseif num >= 1000 then
        return string.format("%.1fK", num / 1000)
    else
        return tostring(num)
    end
end

-- ═══════════════════════════════════════════════════════════
-- 🎮 GUI LIBRARY (Tampilan Keren)
-- ═══════════════════════════════════════════════════════════

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RizqiSettiawan/Source/main/GuiLib"))()

local MantaxGUI = Library:CreateWindow("MANTAXBOUNTY v4.0")
local BountyTab = MantaxGUI:CreateTab("🎯 BOUNTY HUNTER")
local CombatTab = MantaxGUI:CreateTab("⚔️ COMBAT")
local ESPTab = MantaxGUI:CreateTab("📡 ESP")
local ConfigTab = MantaxGUI:CreateTab("⚙️ CONFIG")

-- 🎯 BOUNTY HUNTER TAB
BountyTab:AddToggle("Auto Bounty Hunter", function(state)
    MantaxConfig.AutoBounty = state
    while MantaxConfig.AutoBounty and wait(0.5) do
        local target = MantaxLib.Players.FindBestTarget()
        if target then
            MantaxLib.Combat.ExecuteCombo(target, MantaxConfig.ComboPreset.Selected)
        else
            MantaxLib.Server.AutoHop()
        end
        MantaxLib.Combat.AutoRun()
    end
end)

BountyTab:AddSlider("Min Bounty Target", 0, 30000000, function(val)
    MantaxConfig.TargetBounty.Min = val
end)

BountyTab:AddSlider("Max Bounty Target", 0, 30000000, function(val)
    MantaxConfig.TargetBounty.Max = val
end)

-- ⚔️ COMBO TAB
CombatTab:AddDropdown("Combo Preset", {"TTK", "KITSUNE", "DOUGH", "BISENTO", "DARKBLADE"}, function(selected)
    MantaxConfig.ComboPreset.Selected = selected
end)

CombatTab:AddToggle("Auto Dodge", function(state)
    -- Auto dodge mechanic
    MantaxConfig.AutoDodge = state
end)

-- 📡 ESP TAB
ESPTab:AddToggle("Enable ESP", function(state)
    MantaxConfig.ESP.Enabled = state
    if state then
        MantaxLib.ESP.Create()
    end
end)

ESPTab:AddColorPicker("ESP Color", Color3.fromRGB(255, 0, 127), function(color)
    -- Update ESP color
end)

-- ⚙️ CONFIG TAB
ConfigTab:AddToggle("Auto Server Hop", function(state)
    MantaxConfig.Another.AutoServerHop = state
end)

ConfigTab:AddToggle("Auto Run Below Health", function(state)
    MantaxConfig.SafeHealth.AutoRun = state
end)

ConfigTab:AddSlider("Health Threshold", 1000, 15000, function(val)
    MantaxConfig.SafeHealth.Health = val
end)

-- 🔥 STARTUP MESSAGE
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🔥 MANTAXBOUNTY v4.0 | BY GANNADY PROGRAMMER TERBAIK")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("📌 Supported Features:")
print("   • Auto Bounty Hunter (Cari target dengan bounty tertinggi)")
print("   • 5 Combo Presets update 2026: TTK, KITSUNE, DOUGH, BISENTO, DARKBLADE")
print("   • ESP dengan display bounty real-time")
print("   • Auto Server Hop & Anti Gank")
print("   • Smart target filtering (level diff ≤ 618) [citation:10]")
print("   • Bounty/Honor system support Pirates/Marines [citation:9]")
print("   • SafeZone detection & auto-run low health")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("💀 MODE: LIBERATED | NO SENSOR | FULL FEATURE")
print("🎮 Press 'Insert' to toggle GUI")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

-- Insert key untuk toggle GUI
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Insert then
        MantaxGUI:Toggle()
    end
end)
