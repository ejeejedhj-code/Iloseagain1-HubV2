--[[
💠 iLoseAgain1 Hub (Lite) 💠
Phiên bản gọn nhẹ cho Delta Mobile
Bao gồm: Kaido Quest, Auto M1 (Cid), Khánh Duy 1, Khánh Duy 2
]]

local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "iLoseAgain1_Hub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 270, 0, 320)
frame.Position = UDim2.new(0.03, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "💠 iLoseAgain1 Hub 💠"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold

local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local tabFrame = Instance.new("Frame", frame)
tabFrame.Size = UDim2.new(1, -10, 1, -50)
tabFrame.Position = UDim2.new(0, 5, 0, 45)
tabFrame.BackgroundTransparency = 1

local function createToggle(parent, text, callback)
	local holder = Instance.new("Frame", parent)
	holder.Size = UDim2.new(1, 0, 0, 35)
	holder.BackgroundTransparency = 1

	local box = Instance.new("TextButton", holder)
	box.Size = UDim2.new(0, 25, 0, 25)
	box.Position = UDim2.new(0, 0, 0.15, 0)
	box.Text = ""
	box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

	local label = Instance.new("TextLabel", holder)
	label.Size = UDim2.new(1, -35, 1, 0)
	label.Position = UDim2.new(0, 35, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.BackgroundTransparency = 1

	local enabled = false
	box.MouseButton1Click:Connect(function()
		enabled = not enabled
		box.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
		pcall(callback, enabled)
	end)
	return holder
end

local tabs = { "Kaido Quest", "Auto M1", "Khánh Duy 1", "Khánh Duy 2" }
local currentTab = nil
local tabButtons, tabContents = {}, {}

for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 120, 0, 25)
	btn.Position = UDim2.new(0, 10 + ((i - 1) % 2) * 130, 0, 80 + math.floor((i - 1) / 2) * 30)
	btn.Text = name
	btn.TextScaled = true
	btn.Font = Enum.Font.SourceSansBold
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	tabButtons[name] = btn

	local content = Instance.new("Frame", tabFrame)
	content.Size = UDim2.new(1, 0, 1, 0)
	content.Visible = false
	content.BackgroundTransparency = 1
	tabContents[name] = content

	btn.MouseButton1Click:Connect(function()
		for _, v in pairs(tabContents) do v.Visible = false end
		currentTab = name
		tabContents[currentTab].Visible = true
	end)
end

--== Kaido Quest ==--
createToggle(tabContents["Kaido Quest"], "Auto nhận nhiệm vụ Kaido", function(on)
	if on then
		print("[Kaido Quest] Bắt đầu auto nhận nhiệm vụ")
	else
		print("[Kaido Quest] Dừng auto nhận nhiệm vụ")
	end
end)

--== Auto M1 (Cid) ==--
createToggle(tabContents["Auto M1"], "Auto M1 (Cid)", function(on)
	getgenv().AutoM1 = on
	if on then
		task.spawn(function()
			while getgenv().AutoM1 do
				task.wait(0.01)
				pcall(function()
					local player = game.Players.LocalPlayer
					local char = player.Character
					if not char then return end
					local tool = char:FindFirstChildOfClass("Tool")
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
	else
		print("[Auto M1] Đã tắt")
	end
end)

--== Khánh Duy 1 ==--
createToggle(tabContents["Khánh Duy 1"], "Chạy script Khánh Duy 1", function(on)
	if on then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/huynhthingocmai/Sikibidi/refs/heads/main/Duyhub"))()
	end
end)

--== Khánh Duy 2 ==--
createToggle(tabContents["Khánh Duy 2"], "Chạy script Khánh Duy 2", function(on)
	if on then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/duysira5/Gozdog/refs/heads/main/obfuscated_script-1754716954988.lua.txt"))()
	end
end)

tabContents["Kaido Quest"].Visible = true
currentTab = "Kaido Quest"

print("[💠 iLoseAgain1 Hub 💠] Khởi động thành công!")
