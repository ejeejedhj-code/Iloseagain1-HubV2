-- ⚙️ Tải Rayfield UI (Bản tương thích Delta)
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- 🪄 Tạo cửa sổ
local Window = Rayfield:CreateWindow({
    Name = "Iloseagain1 Hub V2 | Vietnam Piece",
    LoadingTitle = "Đang khởi động...",
    LoadingSubtitle = "by Khánh Duy",
    ConfigurationSaving = { Enabled = false },
    Discord = { Enabled = false },
    KeySystem = false
})

-- 🧩 Tab chính
local MainTab = Window:CreateTab("⚔️ Main", 4483362458)
local AutoSection = MainTab:CreateSection("Auto Farm & Combat")

-- 🧠 Biến lưu
getgenv().AutoM1 = false
getgenv().KillAura = false
getgenv().AutoQuest = false
getgenv().TargetPlayer = ""
getgenv().AttackDelay = 0.1

----------------------------------------------------
-- 🌀 Auto M1 Cid
----------------------------------------------------
MainTab:CreateToggle({
	Name = "🌀 Auto M1 (Cid)",
	CurrentValue = false,
	Flag = "AutoM1",
	Callback = function(v)
		getgenv().AutoM1 = v
		task.spawn(function()
			while getgenv().AutoM1 do
				task.wait(getgenv().AttackDelay)
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

----------------------------------------------------
-- 🎯 Kill Aura Player
----------------------------------------------------
MainTab:CreateInput({
	Name = "🎯 Nhập tên người chơi mục tiêu",
	PlaceholderText = "Ví dụ: LongLong123",
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		getgenv().TargetPlayer = Text
	end
})

MainTab:CreateToggle({
	Name = "⚡ Kill Aura Player",
	CurrentValue = false,
	Flag = "KillAura",
	Callback = function(v)
		getgenv().KillAura = v
		task.spawn(function()
			local whitelist = {"Hitbox", "Skill", "Z", "X"}
			while getgenv().KillAura do
				task.wait(0.4)
				local player = game.Players:FindFirstChild(getgenv().TargetPlayer)
				if player and player.Character then
					for _, container in ipairs({player.Character, player:FindFirstChildOfClass("Backpack")}) do
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
		end)
	end
})

----------------------------------------------------
-- 📜 Auto Quest (Khánh Duy 1, 2, Kaido)
----------------------------------------------------
MainTab:CreateToggle({
	Name = "📜 Auto Quest (Khánh Duy 1, 2, Kaido)",
	CurrentValue = false,
	Flag = "AutoQuest",
	Callback = function(v)
		getgenv().AutoQuest = v
		task.spawn(function()
			while getgenv().AutoQuest do
				task.wait(1)
				pcall(function()
					for _, npcName in ipairs({"KHANH DUY QUEST1", "KHANH DUY QUEST2", "KAIDOUU QUESTTT"}) do
						local npc = workspace:FindFirstChild(npcName)
						if npc and npc:FindFirstChild("Head") then
							fireclickdetector(npc.Head.ClickDetector)
							wait(0.2)
							fireclickdetector(npc.Head.ClickDetector)
						end
					end
				end)
			end
		end)
	end
})

----------------------------------------------------
Rayfield:Notify({
	Title = "✅ Iloseagain1 Hub V2 Loaded",
	Content = "Giao diện Rayfield đã sẵn sàng!",
	Duration = 6
})
