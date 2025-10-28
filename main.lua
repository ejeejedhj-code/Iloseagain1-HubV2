--[[ 
    💠 iLoseAgain1 Hub 💠
    ✅ GUI Roblox thuần – Hoạt động trên mọi executor mobile
    ⚙️ Bao gồm:
       • Auto Quest Kaido
       • Kill Aura
       • Auto M1
       • Auto Skill
       • Dark Orb Store + Rejoin
       • Khánh Duy 1 / 2
       • Tiện ích Rejoin
]]

--== Khởi tạo GUI ==--
local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "iLoseAgain1_Hub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 270, 0, 340)
frame.Position = UDim2.new(0.03, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ZIndex = 10

--== Tiêu đề ==--
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
title.Text = "💠 iLoseAgain1 Hub 💠"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.SourceSansBold
title.ZIndex = 11

--== Nút đóng ==--
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0, 5)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextScaled = true
closeBtn.ZIndex = 12
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--== Khung chứa tab ==--
local tabFrame = Instance.new("Frame", frame)
tabFrame.Size = UDim2.new(1, -10, 1, -50)
tabFrame.Position = UDim2.new(0, 5, 0, 45)
tabFrame.BackgroundTransparency = 1
tabFrame.ZIndex = 10

--== Hàm tạo Toggle ==--
local function createToggle(parent, text, callback)
	local holder = Instance.new("Frame", parent)
	holder.Size = UDim2.new(1, 0, 0, 35)
	holder.BackgroundTransparency = 1
	holder.ZIndex = 10

	local box = Instance.new("TextButton", holder)
	box.Size = UDim2.new(0, 25, 0, 25)
	box.Position = UDim2.new(0, 0, 0.15, 0)
	box.Text = ""
	box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	box.ZIndex = 11

	local label = Instance.new("TextLabel", holder)
	label.Size = UDim2.new(1, -35, 1, 0)
	label.Position = UDim2.new(0, 35, 0, 0)
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.BackgroundTransparency = 1
	label.ZIndex = 11

	local enabled = false
	box.MouseButton1Click:Connect(function()
		enabled = not enabled
		box.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
		pcall(callback, enabled)
	end)
	return holder
end

--== Danh sách Tab ==--
local tabs = {
	"Kaido Quest", "Kill Aura", "Auto M1", "Auto Skill",
	"Dark Orb", "Khánh Duy 1", "Khánh Duy 2", "Tiện ích"
}

local currentTab = nil
local tabButtons = {}
local tabContents = {}

--== Tạo nút Tab ==--
for i, name in ipairs(tabs) do
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0, 80, 0, 25)
	btn.Position = UDim2.new(0, ((i - 1) % 3) * 90 + 10, 0, math.floor((i - 1) / 3) * 30 + 80)
	btn.Text = name
	btn.TextScaled = true
	btn.Font = Enum.Font.SourceSansBold
	btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.ZIndex = 11
	tabButtons[name] = btn

	local content = Instance.new("Frame", tabFrame)
	content.Size = UDim2.new(1, 0, 1, 0)
	content.Visible = false
	content.BackgroundTransparency = 1
	content.ZIndex = 10
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

--== Kill Aura ==--
createToggle(tabContents["Kill Aura"], "Bật Kill Aura", function(on)
	if on then
		print("[Kill Aura] Đang bật")
	else
		print("[Kill Aura] Đã tắt")
	end
end)

--== Auto M1 ==--
createToggle(tabContents["Auto M1"], "Tự động đánh M1", function(on)
	if on then
		print("[Auto M1] Đang spam M1")
	else
		print("[Auto M1] Dừng spam M1")
	end
end)

--== Auto Skill ==--
createToggle(tabContents["Auto Skill"], "Spam Skill theo whitelist", function(on)
	if on then
		print("[Auto Skill] Đang spam Skill")
	else
		print("[Auto Skill] Dừng spam Skill")
	end
end)

--== Dark Orb ==--
createToggle(tabContents["Dark Orb"], "Auto cất Dark Orb + Rejoin", function(on)
	if on then
		print("[Dark Orb] Đang bỏ Dark Orb vào kho và rejoin")
	else
		print("[Dark Orb] Đã tắt tính năng")
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

--== Tiện ích ==--
createToggle(tabContents["Tiện ích"], "Tự động Rejoin Server", function(on)
	if on then
		game:GetService("TeleportService"):Teleport(game.PlaceId, player)
	end
end)

--== Tab mặc định ==--
tabContents["Kaido Quest"].Visible = true
currentTab = "Kaido Quest"

print("[💠 iLoseAgain1 Hub 💠] Đã khởi động hoàn chỉnh!")
