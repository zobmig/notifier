local TextChatService = game:GetService("TextChatService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local channel = TextChatService.TextChannels:WaitForChild("RBXGeneral", 10)

-- toggle state (on by default)
local isEnabled = true

local watchList = {
	["Angler"] = "angryler (angler)",
	["Pinkie"] = "plez stop screaming (pinkie)",
	["Froger"] = "i dont like frogs (froger)",
	["Blitz"] = "oh my god get in a locker right now (blitz)",
	["Chainsmoker"] = "evil green guy (chain)",
	["Pipsqueak"] = "why is this even spawned (pipsqueak but no srs why is this here)",
	["Pandemonium"] = "500 minigames (pandemonium)",
	["RidgeAngler"] = "evil angler",
	["RidgeBlitz"] = "the scaryier blitz",
	["RidgeFroger"] = "i still dont like frogs",
	["RidgePinkie"] = "bro plz its hurts my ears when you scream",
}

-- create GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnnouncerToggleGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local isMinimized = false

-- main container frame
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0, 10, 0.5, -40)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

-- draggable header tab
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 28)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 8)
headerCorner.Parent = header

-- fix bottom corners of header
local headerFix = Instance.new("Frame")
headerFix.Name = "HeaderFix"
headerFix.Size = UDim2.new(1, 0, 0, 14)
headerFix.Position = UDim2.new(0, 0, 1, -14)
headerFix.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
headerFix.BorderSizePixel = 0
headerFix.Parent = header

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "monster notif!"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- make title not block input
local titleDrag = Instance.new("TextButton")
titleDrag.Name = "DragArea"
titleDrag.Size = UDim2.new(1, -35, 1, 0)
titleDrag.Position = UDim2.new(0, 0, 0, 0)
titleDrag.BackgroundTransparency = 1
titleDrag.Text = ""
titleDrag.ZIndex = 10
titleDrag.Parent = header

-- settings button (leftmost)
local settingsBtn = Instance.new("TextButton")
settingsBtn.Name = "SettingsButton"
settingsBtn.Size = UDim2.new(0, 24, 0, 24)
settingsBtn.Position = UDim2.new(1, -84, 0.5, -12)
settingsBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
settingsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
settingsBtn.Text = "⚙"
settingsBtn.Font = Enum.Font.GothamBold
settingsBtn.TextSize = 14
settingsBtn.BorderSizePixel = 0
settingsBtn.ZIndex = 15
settingsBtn.Parent = header

local settingsBtnCorner = Instance.new("UICorner")
settingsBtnCorner.CornerRadius = UDim.new(0, 4)
settingsBtnCorner.Parent = settingsBtn

-- minimize button (middle)
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeButton"
minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
minimizeBtn.Position = UDim2.new(1, -56, 0.5, -12)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Text = "_"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14
minimizeBtn.BorderSizePixel = 0
minimizeBtn.ZIndex = 15
minimizeBtn.Parent = header

local minBtnCorner = Instance.new("UICorner")
minBtnCorner.CornerRadius = UDim.new(0, 4)
minBtnCorner.Parent = minimizeBtn

-- close button (rightmost, pink)
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseButton"
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -28, 0.5, -12)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 139, 245)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.BorderSizePixel = 0
closeBtn.ZIndex = 15
closeBtn.Parent = header

local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 4)
closeBtnCorner.Parent = closeBtn

-- content frame (toggle button)
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -20, 1, -38)
content.Position = UDim2.new(0, 10, 0, 32)
content.BackgroundTransparency = 1
content.Parent = frame

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(1, 0, 0, 36)
toggleButton.Position = UDim2.new(0, 0, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.Text = "on"
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.BorderSizePixel = 0
toggleButton.Parent = content

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = toggleButton

-- Settings content (inside main frame)
local settingsContent = Instance.new("Frame")
settingsContent.Name = "SettingsContent"
settingsContent.Size = UDim2.new(1, -20, 1, -38)
settingsContent.Position = UDim2.new(0, 10, 0, 32)
settingsContent.BackgroundTransparency = 1
settingsContent.Visible = false
settingsContent.Parent = frame

-- Scrolling frame for nicknames
local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "NicknameList"
scrollingFrame.Size = UDim2.new(1, 0, 1, -46)
scrollingFrame.Position = UDim2.new(0, 0, 0, 0)
scrollingFrame.BackgroundTransparency = 1
scrollingFrame.ScrollBarThickness = 6
scrollingFrame.Parent = settingsContent

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.Padding = UDim.new(0, 6)
uiListLayout.Parent = scrollingFrame

-- Create text boxes for each monster
local textBoxes = {}
local monsterOrder = {"Angler", "Pinkie", "Froger", "Blitz", "Chainsmoker", "Pipsqueak", "Pandemonium", "RidgeAngler", "RidgeBlitz", "RidgeFroger", "RidgePinkie"}

for _, monsterName in ipairs(monsterOrder) do
	local entryFrame = Instance.new("Frame")
	entryFrame.Name = monsterName .. "Entry"
	entryFrame.Size = UDim2.new(1, 0, 0, 44)
	entryFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	entryFrame.BorderSizePixel = 0
	entryFrame.Parent = scrollingFrame

	local entryCorner = Instance.new("UICorner")
	entryCorner.CornerRadius = UDim.new(0, 6)
	entryCorner.Parent = entryFrame

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Name = "MonsterName"
	nameLabel.Size = UDim2.new(1, -10, 0, 18)
	nameLabel.Position = UDim2.new(0, 8, 0, 3)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = monsterName
	nameLabel.TextColor3 = Color3.fromRGB(255, 139, 245)
	nameLabel.TextSize = 12
	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.Parent = entryFrame

	local nicknameBox = Instance.new("TextBox")
	nicknameBox.Name = "NicknameInput"
	nicknameBox.Size = UDim2.new(1, -16, 0, 20)
	nicknameBox.Position = UDim2.new(0, 8, 0, 22)
	nicknameBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	nicknameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	nicknameBox.Text = watchList[monsterName] or ""
	nicknameBox.Font = Enum.Font.Gotham
	nicknameBox.TextSize = 11
	nicknameBox.BorderSizePixel = 0
	nicknameBox.PlaceholderText = "Enter nickname..."
	nicknameBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
	nicknameBox.ClearTextOnFocus = false
	nicknameBox.Parent = entryFrame

	local boxCorner = Instance.new("UICorner")
	boxCorner.CornerRadius = UDim.new(0, 4)
	boxCorner.Parent = nicknameBox

	textBoxes[monsterName] = nicknameBox
end

-- Save button
local saveBtn = Instance.new("TextButton")
saveBtn.Name = "SaveButton"
saveBtn.Size = UDim2.new(1, 0, 0, 32)
saveBtn.Position = UDim2.new(0, 0, 1, -36)
saveBtn.BackgroundColor3 = Color3.fromRGB(240, 109, 244)
saveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
saveBtn.Text = "save changes :?"
saveBtn.Font = Enum.Font.GothamBold
saveBtn.TextSize = 14
saveBtn.BorderSizePixel = 0
saveBtn.Parent = settingsContent

local saveBtnCorner = Instance.new("UICorner")
saveBtnCorner.CornerRadius = UDim.new(0, 6)
saveBtnCorner.Parent = saveBtn

-- Save button functionality
saveBtn.MouseButton1Click:Connect(function()
	for monsterName, textBox in pairs(textBoxes) do
		if textBox.Text ~= "" then
			watchList[monsterName] = textBox.Text
		else
			watchList[monsterName] = monsterName
		end
	end
	print("nicknames saved! :3333")
end)

-- Settings view toggle
local isSettingsView = false

settingsBtn.MouseButton1Click:Connect(function()
	isSettingsView = not isSettingsView
	if isSettingsView then
		content.Visible = false
		settingsContent.Visible = true
		settingsBtn.Text = "←"
		frame.Size = UDim2.new(0, 280, 0, 350)
	else
		content.Visible = true
		settingsContent.Visible = false
		settingsBtn.Text = "⚙"
		frame.Size = UDim2.new(0, 200, 0, 80)
	end
end)



-- Close button functionality
closeBtn.MouseButton1Click:Connect(function()
	screenGui:Destroy()
	print("monster notif closed! bye bye :3")
end)

-- dragging logic
local dragging = false
local dragStart, frameStart

local dragArea = header:FindFirstChild("DragArea")

dragArea.MouseButton1Down:Connect(function()
	dragging = true
	dragStart = game:GetService("UserInputService"):GetMouseLocation()
	frameStart = frame.Position
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mousePos = game:GetService("UserInputService"):GetMouseLocation()
		local delta = mousePos - dragStart
		frame.Position = UDim2.new(frameStart.X.Scale, frameStart.X.Offset + delta.X, frameStart.Y.Scale, frameStart.Y.Offset + delta.Y)
	end
end)

-- minimize/maximize logic
local function updateMinimize()
	if isMinimized then
		frame.Size = UDim2.new(0, 200, 0, 28)
		content.Visible = false
		settingsContent.Visible = false
		minimizeBtn.Text = "+"
	else
		if isSettingsView then
			frame.Size = UDim2.new(0, 280, 0, 350)
			settingsContent.Visible = true
		else
			frame.Size = UDim2.new(0, 200, 0, 80)
			content.Visible = true
		end
		minimizeBtn.Text = "_"
	end
end

minimizeBtn.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	updateMinimize()
end)

-- update button appearance
local function updateButton()
	if isEnabled then
		toggleButton.BackgroundColor3 = Color3.fromRGB(255, 139, 245)
		toggleButton.Text = "on"
	else
		toggleButton.BackgroundColor3 = Color3.fromRGB(206, 170, 207)
		toggleButton.Text = "off"
	end
end

-- handle button click
toggleButton.MouseButton1Click:Connect(function()
	isEnabled = not isEnabled
	updateButton()
	print("monster notif toggled: " .. (isEnabled and "on! :3" or "off 3:"))
end)

-- watch for parts
if channel then
	local function onDescendantAdded(descendant)
		if isEnabled and descendant:IsA("BasePart") and watchList[descendant.Name] then
			local nickname = watchList[descendant.Name]
			print("Part appeared: " .. descendant.Name .. " (" .. nickname .. ")")
			channel:SendAsync(nickname)
		end
	end

	Workspace.DescendantAdded:Connect(onDescendantAdded)
	print("wooho the script loaded successfully!")
else
	warn("could not find RBXGeneral chat channel :(")
end

-- yes this was made with the HELP of ai, waht ar u gonna dew? sue me? --
