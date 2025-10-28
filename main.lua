--// 💠 iLoseAgain1 Hub - Orion Edition 💠

local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

local Window = OrionLib:MakeWindow({
    Name = "💠 iLoseAgain1 Hub 💠",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "iLoseAgain1Hub"
})

-- 🌋 TAB: Kaido Quest
local kaidoTab = Window:MakeTab({
    Name = "Kaido Quest",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

kaidoTab:AddToggle({
    Name = "Tự động nhận nhiệm vụ Kaido",
    Default = false,
    Callback = function(Value)
        getgenv().AutoKaido = Value
        while getgenv().AutoKaido do task.wait(1)
            pcall(function()
                print("[Kaido Quest] Đang auto nhận nhiệm vụ...")
                -- 🟩 Thay thế phần này bằng code nhận quest thực tế
            end)
        end
    end
})

-- ⚔️ TAB: Kill Aura Player
local killTab = Window:MakeTab({
    Name = "Kill Aura Player",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

local targetName = "TênNgườiChơi"
killTab:AddTextbox({
    Name = "Tên người chơi mục tiêu",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        targetName = Value
    end
})

killTab:AddToggle({
    Name = "Bật Kill Aura (tấn công player bằng RemoteEvent)",
    Default = false,
    Callback = function(Value)
        getgenv().KillAura = Value
        task.spawn(function()
            while task.wait(0.4) do
                if not getgenv().KillAura then break end
                local player = game.Players:FindFirstChild(targetName)
                if player and player.Character then
                    local containers = {
                        player.Character,
                        player:FindFirstChildOfClass("Backpack")
                    }

                    for _, container in ipairs(containers) do
                        if container then
                            for _, tool in ipairs(container:GetChildren()) do
                                if tool:IsA("Tool") then
                                    for _, v in ipairs(tool:GetChildren()) do
                                        if v:IsA("RemoteEvent") and v.Name:match("Hitbox") then
                                            pcall(function()
                                                v:FireServer()
                                                print("🎯 Gây sát thương tới:", player.Name)
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
})

-- ⚡ TAB: Auto M1 Cid
local m1Tab = Window:MakeTab({
    Name = "Auto M1 Cid",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

m1Tab:AddToggle({
    Name = "Tự động đánh M1 (vũ khí Cid)",
    Default = false,
    Callback = function(Value)
        getgenv().AutoM1 = Value
        task.spawn(function()
            while getgenv().AutoM1 do
                task.wait(0.1) -- tốc độ đánh 0.1s
                pcall(function()
                    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if tool then
                        for _, obj in pairs(tool:GetDescendants()) do
                            if obj:IsA("RemoteEvent") and obj.Name:lower():find("hitbox") then
                                if tool.Name == "Cid" then
                                    obj:FireServer(8, 1)
                                else
                                    obj:FireServer()
                                end
                            end
                        end
                    end
                end)
            end
        end)
    end
})

-- 🌌 TAB: Khánh Duy
local duyTab = Window:MakeTab({
    Name = "Khánh Duy Scripts",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

duyTab:AddButton({
    Name = "Chạy script Khánh Duy 1",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/huynhthingocmai/Sikibidi/refs/heads/main/Duyhub"))()
    end
})

duyTab:AddButton({
    Name = "Chạy script Khánh Duy 2",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/duysira5/Gozdog/refs/heads/main/obfuscated_script-1754716954988.lua.txt"))()
    end
})

-- 🔁 TAB: Tiện ích
local utilsTab = Window:MakeTab({
    Name = "Tiện ích",
    Icon = "rbxassetid://4483362458",
    PremiumOnly = false
})

utilsTab:AddButton({
    Name = "Tự động Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
})

OrionLib:Init()

print("[💠 iLoseAgain1 Hub 💠] Đã khởi động hoàn chỉnh (Orion UI)")
