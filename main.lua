-- iLoseAgain1 Hub (PlayerGui-safe)
-- Bản này tạo GUI vào PlayerGui (tránh lỗi không hiện khi parent = CoreGui)
-- Giữ: Auto M1 Cid, Auto Kaido Quest, Khánh Duy 1 & 2, Kill Aura (dùng whitelist)

local player = game.Players.LocalPlayer
if not player then
    warn("[iLoseAgain1] Không tìm thấy player (chạy quá sớm?).")
    return
end

-- Helper: safe Create ScreenGui under PlayerGui
local function newScreenGui(name)
    local sg = Instance.new("ScreenGui")
    sg.Name = name or "iLoseAgain1_Hub"
    -- đảm bảo parent là PlayerGui
    local ok, pg = pcall(function() return player:WaitForChild("PlayerGui", 5) end)
    if ok and pg then
        sg.Parent = pg
    else
        -- fallback
        sg.Parent = game:GetService("CoreGui")
    end
    return sg
end

-- Tạo GUI chính
local ScreenGui = newScreenGui("iLoseAgain1_Hub")
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 230, 0, 310)
Main.Position = UDim2.new(0.5, -115, 0.5, -155)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true
local corner = Instance.new("UICorner", Main)
corner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "⭐ Vietnam Piece Hub ⭐"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local function createButton(text, y, callback)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(1, -20, 0, 32)
    b.Position = UDim2.new(0, 10, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.Text = text
    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 16
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(callback)
    return b
end

-- =========================
-- Chức năng chính
-- =========================

-- Auto M1 Cid
getgenv().AutoM1 = false
createButton("🌀 Auto M1 Cid", 45, function()
    getgenv().AutoM1 = not getgenv().AutoM1
    -- Thông báo
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Auto M1",
            Text = getgenv().AutoM1 and "Đã bật!" or "Đã tắt!",
            Duration = 2
        })
    end)

    -- Spawn loop (nếu đã bật thì chạy, tắt thì loop sẽ tự dừng)
    task.spawn(function()
        while getgenv().AutoM1 do
            task.wait(0.1) -- tốc độ 0.1s như bạn yêu cầu
            pcall(function()
                local char = player.Character
                if not char then return end
                local tool = char:FindFirstChildOfClass("Tool")
                if tool then
                    for _, obj in pairs(tool:GetDescendants()) do
                        if obj:IsA("RemoteEvent") and obj.Name:lower():find("hitbox") then
                            -- chỉ M1 cho Cid dùng args (8,1)
                            if tool.Name == "Cid" then
                                pcall(function() obj:FireServer(8, 1) end)
                            else
                                pcall(function() obj:FireServer() end)
                            end
                        end
                    end
                end
            end)
        end
    end)
end)

-- Auto Kaido Quest
createButton("🐉 Auto Kaido Quest", 85, function()
    -- Gọi cách an toàn: nếu remote không tồn tại sẽ pcall và warn
    local ok, err = pcall(function()
        local reps = game:GetService("ReplicatedStorage")
        if reps and reps:FindFirstChild("Remotes") and reps.Remotes:FindFirstChild("CommF") then
            reps.Remotes.CommF:FireServer("KAIDOUU QUESTTT")
        else
            warn("[Kaido Quest] Không tìm thấy ReplicatedStorage.Remotes.CommF trong game này.")
        end
    end)
    if not ok then warn("[Kaido Quest] Lỗi:", err) end
end)

-- Khánh Duy 1
createButton("⚔️ Khánh Duy 1", 125, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/huynhthingocmai/Sikibidi/refs/heads/main/Duyhub"))()
    end)
end)

-- Khánh Duy 2
createButton("⚔️ Khánh Duy 2", 165, function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/duysira5/Gozdog/refs/heads/main/obfuscated_script-1754716954988.lua.txt"))()
    end)
end)

-- Kill Aura (giữ nguyên từ local whitelist đến hết như bạn yêu cầu)
getgenv().KillAura = false
createButton("💥 Kill Aura Player", 205, function()
    getgenv().KillAura = not getgenv().KillAura
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Kill Aura",
            Text = getgenv().KillAura and "Đã bật!" or "Đã tắt!",
            Duration = 2
        })
    end)

    local whitelist = {"Hitbox", "Skill", "Z", "X"}
    local enabled = true
    local attackDelay = 0.4

    task.spawn(function()
        while task.wait(attackDelay) do
            if not getgenv().KillAura then break end
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local containers = {
                        plr.Character,
                        plr:FindFirstChildOfClass("Backpack")
                    }

                    for _, container in ipairs(containers) do
                        if container then
                            for _, tool in ipairs(container:GetChildren()) do
                                if tool:IsA("Tool") then
                                    for _, v in ipairs(tool:GetChildren()) do
                                        if v:IsA("RemoteEvent") then
                                            for _, keyword in ipairs(whitelist) do
                                                if v.Name:find(keyword) then
                                                    pcall(function()
                                                        v:FireServer()
                                                    end)
                                                    break
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)

-- Đóng GUI
createButton("❌ Đóng GUI", 260, function()
    ScreenGui:Destroy()
end)

print("[iLoseAgain1] GUI đã tạo vào PlayerGui - test xong nếu GUI vẫn không hiện báo lại log console.")
