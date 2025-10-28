-- 🌟 Vietnam Piece Simple GUI Script 🌟
-- Tác giả: bạn và ChatGPT tạo chung 😎

-- 🧩 Tạo GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
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

-- ⚙️ Auto M1 Cid
getgenv().AutoM1 = false
createButton("🌀 Auto M1 Cid", 45, function()
	getgenv().AutoM1 = not getgenv().AutoM1
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Auto M1",
		Text = getgenv().AutoM1 and "Đã bật!" or "Đã tắt!",
		Duration = 2
	})
	task.spawn(function()
		while getgenv().AutoM1 do
			task.wait(0.1)
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
end)

-- 🧠 Auto Kaido Quest
createButton("🐉 Auto Kaido Quest", 85, function()
	local args = { [1] = "KAIDOUU QUESTTT" }
	game:GetService("ReplicatedStorage").Remotes.CommF:FireServer(unpack(args))
end)

-- ⚡ Khánh Duy 1
createButton("⚔️ Auto Khánh Duy 1", 125, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/huynhthingocmai/Sikibidi/refs/heads/main/Duyhub"))()
end)

-- ⚡ Khánh Duy 2
createButton("⚔️ Auto Khánh Duy 2", 165, function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/duysira5/Gozdog/refs/heads/main/obfuscated_script-1754716954988.lua.txt"))()
end)

-- 🔥 Kill Aura Player (giữ nguyên yêu cầu)
getgenv().KillAura = false
createButton("💥 Kill Aura Player", 205, function()
	getgenv().KillAura = not getgenv().KillAura
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "Kill Aura",
		Text = getgenv().KillAura and "Đã bật!" or "Đã tắt!",
		Duration = 2
	})

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
