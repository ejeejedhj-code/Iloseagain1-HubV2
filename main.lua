-- 🌟 Vietnam Piece Simple GUI Script 🌟
-- Tác giả: bạn và ChatGPT tạo chung 😎

-- 🧩 Tạo GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "iLoseAgain1_VP_Hub"
ScreenGui.ResetOnSpawn = false

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
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.BorderSizePixel = 0
Title.Text = "⭐ Vietnam Piece Hub ⭐"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextScaled = true

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

-- ⚙️ Auto M1 Cid (tốc độ 0.1s)
getgenv().AutoM1 = false
createButton("🌀 Auto M1 Cid", 45, function()
	getgenv().AutoM1 = not getgenv().AutoM1
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Auto M1",
			Text = getgenv().AutoM1 and "Đã bật!" or "Đã tắt!",
			Duration = 2
		})
	end)

	task.spawn(function()
		while getgenv().AutoM1 do
			task.wait(0.1) -- tốc độ 0.1s
			pcall(function()
				local plr = game.Players.LocalPlayer
				if not plr or not plr.Character then return end
				local tool = plr.Character:FindFirstChildOfClass("Tool")
				if tool then
					for _, obj in pairs(tool:GetDescendants()) do
						if obj:IsA("RemoteEvent") and string.lower(obj.Name):find("hitbox") then
							-- Gọi FireServer(8,1) chỉ với vũ khí Cid
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

-- 🧠 Auto Kaido Quest (ví dụ: gọi remote; thay nếu game khác)
createButton("🐉 Auto Kaido Quest", 85, function()
	pcall(function()
		-- Thay đổi theo Remote thực tế của game nếu khác
		local args = { [1] = "KAIDOUU QUESTTT" }
		local rs = game:GetService("ReplicatedStorage")
		if rs and rs:FindFirstChild("Remotes") and rs.Remotes:FindFirstChild("CommF") then
			rs.Remotes.CommF:FireServer(unpack(args))
		else
			-- fallback: tìm Remote trong workspace nếu khác
			-- print thông báo nếu ko tìm thấy
			warn("Auto Kaido Quest: không tìm thấy Remotes.CommF")
		end
	end)
end)

-- ⚡ Khánh Duy 1 (giữ nguyên loadstring)
createButton("⚔️ Auto Khánh Duy 1", 125, function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/huynhthingocmai/Sikibidi/refs/heads/main/Duyhub"))()
	end)
end)

-- ⚡ Khánh Duy 2 (giữ nguyên loadstring)
createButton("⚔️ Auto Khánh Duy 2", 165, function()
	pcall(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/duysira5/Gozdog/refs/heads/main/obfuscated_script-1754716954988.lua.txt"))()
	end)
end)

-- 🔥 Kill Aura Player (giữ nguyên đoạn từ local whitelist đến hết)
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

	-- Giữ nguyên đoạn kill aura bạn yêu cầu
	local whitelist = {"Hitbox", "Skill", "Z", "X"}
	local enabled = true
	local attackDelay = 0.4

	task.spawn(function()
		while task.wait(attackDelay) do
			if not getgenv().KillAura then break end
			for _, player in pairs(game.Players:GetPlayers()) do
				if player ~= game.Players.LocalPlayer and player.Character then
					local containers = {
						player.Character,
						player:FindFirstChildOfClass("Backpack")
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

-- ❌ Thoát
createButton("❌ Đóng GUI", 260, function()
	ScreenGui:Destroy()
end)
