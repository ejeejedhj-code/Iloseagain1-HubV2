-- 🧠 Cấu hình chung
getgenv().AutoM1 = true
getgenv().AttackDelay = 0.1
getgenv().KillAura = true
getgenv().TargetPlayer = "TênNgườiChơi" -- ⚠️ đổi tên người chơi mục tiêu ở đây

-- ⚙️ Auto M1 cho vũ khí Cid
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

-- ⚔️ Kill Aura Player (spam mọi đòn từ whitelist)
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

-- 🧾 Auto Quest Khánh Duy 1, 2, Kaido
task.spawn(function()
	while task.wait(1) do
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
