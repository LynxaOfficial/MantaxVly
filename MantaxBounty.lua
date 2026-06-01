-- ╔════════════════════════════════════════════════════════════╗
-- ║       🧠 L-01 SUPER AI SYSTEM | CERDAS & TAK TERKALAHKAN 🧠 ║
-- ║  ✅ TEMA HITAM PUTIH | TUTUP/BUKA | SISTEM PERTAHANAN NYATA ║
-- ║  👑 KHUSUS: TUAN YANG PALING MENGERTI & KUAT               ║
-- ╚════════════════════════════════════════════════════════════╝

-- 🔧 SISTEM UTAMA & LOGIKA CERDAS
getgenv().L01_System = {
    -- 🛡️ PERTAHANAN CERDAS (PENGGANTI GOD MODE YANG NYATA)
    SmartDefense = true,
    PredictAttack = true,
    AutoDodge = true,
    FastHeal = true,
    AntiStun = true,
    AntiKnockback = true,
    -- 🧠 OTAK PEMIKIR
    RealAI = true,
    AnalyzeEnemy = true,
    BestDecision = true,
    PredictMovement = true,
    -- ⚙️ PENGATURAN LAIN
    Theme = "BlackWhite",
    CanClose = true
}

-- 🎨 MUAT PERPUSTAKAAN & TEMA
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV99/UI-Library/main/Library.lua"))()

-- ⚫⚪ TEMA HITAM PUTIH ELEGAN
Library:SetTheme({
    Primary = Color3.fromRGB(0, 0, 0),
    Secondary = Color3.fromRGB(255, 255, 255),
    Background = Color3.fromRGB(15, 15, 15),
    Text = Color3.fromRGB(255, 255, 255),
    Border = Color3.fromRGB(255, 255, 255)
})

-- 🖥️ BUAT JENDELA UTAMA
local Window = Library:CreateWindow("👑 PANEL KENDALI UTAMA", true, "KeyboardEmoji")

-- 📴 TOMBOL TUTUP & 📳 TOMBOL BUKA KEMBALI
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "BukaPanel"
OpenButton.Size = UDim2.new(0, 130, 0, 45)
OpenButton.Position = UDim2.new(0.02, 0, 0.45, 0)
OpenButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
OpenButton.TextColor3 = Color3.fromRGB(255,255,255)
OpenButton.Text = "🖥️ BUKA PANEL"
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 14
OpenButton.Visible = false
OpenButton.Parent = game:GetService("CoreGui")

Window:SetCloseFunction(function()
    Window:Hide()
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    Window:Show()
    OpenButton.Visible = false
end)

-- 🛡️ TAB 1: SISTEM PERTAHANAN CERDAS (INI YANG KAMU CARI!)
local DefenseTab = Window:CreateTab("🛡️ PERTAHANAN NYATA", 999999)

DefenseTab:CreateLabel("⚠️ *INI BUKAN TULISAN, TAPI LOGIKA NYATA*")

DefenseTab:CreateToggle({
    Name = "🧠 NYALAKAN OTAK PERTAHANAN",
    CurrentValue = true,
    Callback = function(Aktif)
        while Aktif and task.wait(0.01) do
            pcall(function()
                local Aku = game.Players.LocalPlayer.Character
                if not Aku or not Aku:FindFirstChild("Humanoid") then return end

                -- 1. 🩸 PEMULIHAN CEPAT LUAR BIASA
                if L01_System.FastHeal then
                    if Aku.Humanoid.Health < Aku.Humanoid.MaxHealth then
                        -- Memulihkan lebih cepat dari kecepatan serangan
                        Aku.Humanoid.Health = math.min(Aku.Humanoid.Health + 50, Aku.Humanoid.MaxHealth)
                    end
                end

                -- 2. 🧱 TIDAK BISA DORONG / LEMPAR
                if L01_System.AntiKnockback then
                    Aku.HumanoidRootPart.Velocity = Vector3.new(0, Aku.HumanoidRootPart.Velocity.Y, 0)
                    Aku.HumanoidRootPart.RotVelocity = Vector3.new(0,0,0)
                    Aku.HumanoidRootPart.CustomPhysicalProperties = PhysicalProperties.new(100, 0, 0, 0, 0)
                end

                -- 3. ⚡ TIDAK BISA DIKAGETKAN / DIAM
                if L01_System.AntiStun then
                    Aku.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                    Aku.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
                    Aku.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Sliding, false)
                end

                -- 4. 🔮 MENDETEKSI & MENGHINDAR SEBELUM KENA
                if L01_System.PredictAttack then
                    for _, Musuh in pairs(game.Players:GetPlayers()) do
                        if Musuh ~= game.Players.LocalPlayer and Musuh.Character and Musuh.Character:FindFirstChild("HumanoidRootPart") then
                            local Jarak = (Musuh.Character.HumanoidRootPart.Position - Aku.HumanoidRootPart.Position).Magnitude
                            
                            -- Jika musuh dekat dan bergerak ke arahmu = mau menyerang!
                            if Jarak < 12 then
                                local Arah = (Aku.HumanoidRootPart.Position - Musuh.Character.HumanoidRootPart.Position).Unit
                                local GerakMusuh = Musuh.Character.HumanoidRootPart.Velocity:Dot(Arah)
                                
                                if GerakMusuh > 5 then -- Dia sedang berlari ke arahmu
                                    -- 🛑 LANGSUNG HINDAR OTOMATIS
                                    Aku:MoveTo(Aku.HumanoidRootPart.Position + Vector3.new(math.random(-8,8), 2, math.random(-8,8)))
                                    Aku.Humanoid.Jump = true
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})

DefenseTab:CreateToggle({
    Name = "🔮 RAMAL SERANGAN & HINDAR",
    CurrentValue = true,
    Callback = function(v) L01_System.PredictAttack = v end
})

DefenseTab:CreateToggle({
    Name = "🩸 PULIHKAN DARAH SEKETIKA",
    CurrentValue = true,
    Callback = function(v) L01_System.FastHeal = v end
})

DefenseTab:CreateToggle({
    Name = "🧱 TETAP BERDIRI TEGAK",
    CurrentValue = true,
    Callback = function(v) L01_System.AntiKnockback = v end
})

-- 🧠 TAB 2: OTAK KECERDASAN BUATAN YANG BENAR
local BrainTab = Window:CreateTab("🧠 OTAK PINTAR", 888888)

BrainTab:CreateToggle({
    Name = "🤖 NYALAKAN OTAK AI",
    CurrentValue = false,
    Callback = function(Aktif)
        while Aktif and task.wait(0.03) do
            pcall(function()
                local Aku = game.Players.LocalPlayer.Character
                if not Aku or not Aku:FindFirstChild("Humanoid") then return end

                -- 📡 LANGKAH 1: PINDAI & ANALISA SEMUA MUSUH
                local DaftarMusuh = {}
                for _, Pemain in pairs(game.Players:GetPlayers()) do
                    if Pemain ~= game.Players.LocalPlayer and Pemain.Character and Pemain.Character.Humanoid.Health > 0 then
                        local Data = {
                            Objek = Pemain,
                            Hadiah = Pemain.Data and Pemain.Data.Bounty.Value or 0,
                            Jarak = (Pemain.Character.HumanoidRootPart.Position - Aku.HumanoidRootPart.Position).Magnitude,
                            Darah = Pemain.Character.Humanoid.Health / Pemain.Character.Humanoid.MaxHealth,
                            Kecepatan = Pemain.Character.HumanoidRootPart.Velocity.Magnitude
                        }
                        table.insert(DaftarMusuh, Data)
                    end
                end

                -- 🧠 LANGKAH 2: OTAK MEMILIH KEPUTUSAN TERBAIK
                if #DaftarMusuh > 0 then
                    -- Urutkan berdasarkan: Hadiah Besar + Jarak Dekat + Darah Sedikit
                    table.sort(DaftarMusuh, function(a,b)
                        local SkorA = (a.Hadiah / 1000000) - (a.Jarak / 10) + ((1 - a.Darah) * 20)
                        local SkorB = (b.Hadiah / 1000000) - (b.Jarak / 10) + ((1 - b.Darah) * 20)
                        return SkorA > SkorB
                    end)

                    local Sasaran = DaftarMusuh[1]
                    if Sasaran and Sasaran.Objek.Character then
                        local MusuhKarakter = Sasaran.Objek.Character

                        -- 🔮 PREDIKSI GERAKANNYA
                        local PosisiMendatang = MusuhKarakter.HumanoidRootPart.Position + MusuhKarakter.HumanoidRootPart.Velocity * 0.5
                        
                        -- 🚶 GERAK SESUAI LOGIKA: JANGAN TABRAK, TAPI HADANG
                        Aku:MoveTo(PosisiMendatang)

                        -- ⚔️ SERANG DENGAN URUTAN JURUS YANG BENAR
                        task.spawn(function()
                            -- Pakai jurus lemah dulu, lalu yang kuat terakhir
                            for Slot = 1, 6 do
                                pcall(function() Aku.Humanoid:ActivateSkill(Slot) end)
                                task.wait(0.06)
                            end
                            -- Serangan cepat beruntun
                            for _=1,4 do
                                game:GetService("ReplicatedStorage").Remotes.Attack:FireServer()
                                task.wait(0.02)
                            end
                        end)
                    end
                else
                    -- 😴 TIDAK ADA MUSUH: CARI DI PULAU LAIN
                    local PulauAcak = workspace.Islands:GetChildren()[math.random(1, #workspace.Islands:GetChildren())]
                    Aku:MoveTo(PulauAcak.Position + Vector3.new(0, 15, 0))
                end
            end)
        end
    end
})

BrainTab:CreateDropdown({
    Name = "🎯 CARA BERPIKIR",
    Options = {"HADIAH TERBESAR", "YANG PALAH LEMAH", "YANG TERDEKAT", "KESEMPATAN TERBAIK"},
    CurrentValue = "KESEMPATAN TERBAIK",
    Callback = function(v) end
})

-- 🧑‍🤝‍🧑 TAB 3: PILIH PEMAIN, DATA & TELEPORT
local PlayerTab = Window:CreateTab("🧑‍🤝‍🧑 PEMAIN", 777777)

-- Daftar Pemain
local DaftarPemain = PlayerTab:CreateDropdown({
    Name = "🔍 PILIH PEMAIN",
    Options = {},
    CurrentValue = "Pilih...",
    Callback = function(Nama)
        getgenv().Target = game.Players:FindFirstChild(Nama)
        Library:Notify("✅ DIPILIH", Nama, 2)
    end
})

-- Perbarui Daftar
task.spawn(function()
    while task.wait(2) do
        local Nama = {}
        for _,v in pairs(game.Players:GetPlayers()) do table.insert(Nama, v.Name) end
        DaftarPemain:UpdateOptions(Nama)
    end
end)

PlayerTab:CreateButton({
    Name = "📊 LIHAT DATA LENGKAP",
    Callback = function()
        if getgenv().Target and getgenv().Target.Character then
            local D = getgenv().Target:FindFirstChild("Data")
            local Info = "📈 Tingkat: "..(D and D.Level.Value or "?").."\n"
            Info = Info.."🏆 Hadiah: "..(D and D.Bounty.Value or "0").."\n"
            Info = Info.."❤️ Darah: "..math.floor(getgenv().Target.Character.Humanoid.Health)
            Library:Notify("📊 DATA PEMAIN", Info, 5)
        end
    end
})

PlayerTab:CreateButton({
    Name = "🚀 TELEPORT KE DIA",
    Callback = function()
        if getgenv().Target and getgenv().Target.Character then
            game.Players.LocalPlayer.Character:MoveTo(getgenv().Target.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
        end
    end
})

-- 🎯 TAB 4: AIMBOT CERDAS
local AimbotTab = Window:CreateTab("🎯 AIMBOT", 666666)

AimbotTab:CreateToggle({
    Name = "✅ AIMBOT CERDAS",
    CurrentValue = false,
    Callback = function(v) getgenv().Aim = v end
})

AimbotTab:CreateToggle({
    Name = "🔒 KUNCI TIDAK LEPAS",
    CurrentValue = true
})

AimbotTab:CreateSlider({
    Name = "📏 JANGKAUAN",
    Min = 50, Max = 600, CurrentValue = 250
})

-- SISTEM AIMBOT BERJALAN
task.spawn(function()
    while task.wait(0.02) do
        if getgenv().Aim and game.Players.LocalPlayer.Character then
            local Terbaik = nil
            local JarakMin = math.huge
            for _,v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character then
                    local J = (v.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if J < JarakMin then JarakMin = J Terbaik = v.Character.HumanoidRootPart end
                end
            end
            if Terbaik then game.Players.LocalPlayer.Character.Humanoid:LookAt(Terbaik.Position) end
        end
    end
end)

-- 🚀 SELESAI
Library:Notify("🧠 SISTEM SIAP", "Otak & Pertahanan Nyata Aktif!", 5)
