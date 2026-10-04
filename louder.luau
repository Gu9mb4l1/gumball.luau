
local loadingStartedAt = os.clock()
local loadingMinimumDuration = 3
local loadingFadeDuration = 0.35
local TweenService = game:GetService('TweenService')
local Lighting = game:GetService('Lighting')
local loadingParent = game:GetService('CoreGui')
if type(gethui) == 'function' then
	local success, hiddenGui = pcall(gethui)
	if success and hiddenGui then
		loadingParent = hiddenGui
	end
end

local oldLoadingGui = loadingParent:FindFirstChild('GumballLoadingScreen')
if oldLoadingGui then
	oldLoadingGui:Destroy()
end

local oldLoadingBlur = Lighting:FindFirstChild('GumballLoadingBlur')
if oldLoadingBlur then
	oldLoadingBlur:Destroy()
end

local loadingBlur = Instance.new('BlurEffect')
loadingBlur.Name = 'GumballLoadingBlur'
loadingBlur.Size = 18
loadingBlur.Parent = Lighting

local loadingGui = Instance.new('ScreenGui')
loadingGui.Name = 'GumballLoadingScreen'
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false
loadingGui.DisplayOrder = 10000
loadingGui.Parent = loadingParent

local loadingOverlay = Instance.new('Frame')
loadingOverlay.Name = 'Overlay'
loadingOverlay.Size = UDim2.fromScale(1, 1)
loadingOverlay.BackgroundColor3 = Color3.fromRGB(8, 12, 18)
loadingOverlay.BackgroundTransparency = 0.16
loadingOverlay.BorderSizePixel = 0
loadingOverlay.Parent = loadingGui

local loadingTitle = Instance.new('TextLabel')
loadingTitle.Name = 'Title'
loadingTitle.AnchorPoint = Vector2.new(0.5, 0.5)
loadingTitle.Position = UDim2.new(0.5, 0, 0.5, -38)
loadingTitle.Size = UDim2.new(1, -32, 0, 48)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Font = Enum.Font.FredokaOne
loadingTitle.Text = 'Gumball Louding'
loadingTitle.TextColor3 = Color3.fromRGB(245, 250, 255)
loadingTitle.TextXAlignment = Enum.TextXAlignment.Center
loadingTitle.TextYAlignment = Enum.TextYAlignment.Center
loadingTitle.TextSize = 36
loadingTitle.TextTransparency = 1
loadingTitle.Parent = loadingOverlay

local loadingAccent = Instance.new('Frame')
loadingAccent.Name = 'Accent'
loadingAccent.AnchorPoint = Vector2.new(0.5, 0.5)
loadingAccent.Position = UDim2.new(0.5, 0, 0.5, 4)
loadingAccent.Size = UDim2.fromOffset(0, 3)
loadingAccent.BackgroundColor3 = Color3.fromRGB(80, 220, 190)
loadingAccent.BorderSizePixel = 0
loadingAccent.Parent = loadingOverlay

local loadingFooter = Instance.new('TextLabel')
loadingFooter.Name = 'Footer'
loadingFooter.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFooter.Position = UDim2.new(0.5, 0, 0.5, 32)
loadingFooter.Size = UDim2.new(1, -32, 0, 30)
loadingFooter.BackgroundTransparency = 1
loadingFooter.Font = Enum.Font.FredokaOne
loadingFooter.Text = 'join .gg/gu9mball'
loadingFooter.TextColor3 = Color3.fromRGB(160, 190, 205)
loadingFooter.TextXAlignment = Enum.TextXAlignment.Center
loadingFooter.TextYAlignment = Enum.TextYAlignment.Center
loadingFooter.TextSize = 18
loadingFooter.TextTransparency = 1
loadingFooter.Parent = loadingOverlay

local loadingScale = Instance.new('UIScale')
loadingScale.Scale = 0.92
loadingScale.Parent = loadingTitle

TweenService:Create(loadingTitle, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	TextTransparency = 0
}):Play()
TweenService:Create(loadingScale, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Scale = 1
}):Play()
TweenService:Create(loadingFooter, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.12), {
	TextTransparency = 0
}):Play()
TweenService:Create(loadingAccent, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, false, 0.12), {
	Size = UDim2.fromOffset(176, 3)
}):Play()

local loadingScreenFinishing = false
local loadingScreenDismissed = false
local loadingFinishCallbacks = {}
local function FinishLoadingScreen(onFinished)
	if onFinished then
		if loadingScreenDismissed then
			onFinished()
		else
			table.insert(loadingFinishCallbacks, onFinished)
		end
	end

	if loadingScreenFinishing then
		return
	end
	loadingScreenFinishing = true

	local waitTime = math.max(0, loadingMinimumDuration - loadingFadeDuration - (os.clock() - loadingStartedAt))
	task.delay(waitTime, function()
		TweenService:Create(loadingOverlay, TweenInfo.new(loadingFadeDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundTransparency = 1
		}):Play()
		TweenService:Create(loadingTitle, TweenInfo.new(0.25), { TextTransparency = 1 }):Play()
		TweenService:Create(loadingFooter, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
		TweenService:Create(loadingAccent, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
		TweenService:Create(loadingBlur, TweenInfo.new(loadingFadeDuration), { Size = 0 }):Play()
		task.delay(loadingFadeDuration, function()
			if loadingGui.Parent then
				loadingGui:Destroy()
			end
			if loadingBlur.Parent then
				loadingBlur:Destroy()
			end

			loadingScreenDismissed = true
			for _, callback in ipairs(loadingFinishCallbacks) do
				callback()
			end
			table.clear(loadingFinishCallbacks)
		end)
	end)
end

task.delay(45, function()
	FinishLoadingScreen()
end)

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
	Title = ' Gumball - .gg/gu9mball',
	Center = true,
	AutoShow = false,
	TabPadding = 8,
	MenuFadeTime = 0.2
})

local TitleLabel = Window.Holder:FindFirstChildWhichIsA('TextLabel', true)
if TitleLabel then
	TitleLabel.Size = UDim2.new(1, -14, 0, 25)
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
end
Window.Holder.Visible = false

local Tabs = {
	Main = Window:AddTab('Main'),
	['UI Settings'] = Window:AddTab('UI Settings')
}

local MainGroup = Tabs.Main:AddLeftGroupbox('Main')
MainGroup:AddLabel('Gumball')

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function()
	Library:Unload()
end)
local UserInputService = game:GetService('UserInputService')
local MenuKey = 'RightShift'
local waitingForMenuKey = false
local MenuBindLabel = MenuGroup:AddLabel('Menu bind: ' .. MenuKey, true)
MenuGroup:AddButton('Change menu key', function()
	waitingForMenuKey = true
	Library:Notify('Press a keyboard key. Escape cancels.', 3)
end)
MenuGroup:AddDropdown('MenuBindMode', {
	Text = 'Menu key mode',
	Values = { 'Toggle', 'Hold', 'Always' },
	Default = 'Toggle'
})

local KeybindDisplayToggle = MenuGroup:AddToggle('ShowKeybinds', {
	Text = 'Keybinds',
	Default = false,
	Tooltip = 'Show active keybinds on the left side of the screen'
})

local KeybindTransparency = MenuGroup:AddSlider('KeybindTransparency', {
	Text = 'Keybind transparency',
	Default = 0,
	Min = 0,
	Max = 100,
	Rounding = 0,
	Suffix = '%',
	Tooltip = '0 is opaque; 100 is fully transparent'
})

local KeybindFilter = 'All'
local KeybindFilterDropdown = MenuGroup:AddDropdown('KeybindFilter', {
	Text = 'Keybind filter',
	Values = { 'All', 'Toggle', 'Hold' },
	Default = 'All'
})

local KeybindHudGui = Instance.new('ScreenGui')
KeybindHudGui.Name = 'GumballKeybindHud'
KeybindHudGui.IgnoreGuiInset = true
KeybindHudGui.ResetOnSpawn = false
KeybindHudGui.DisplayOrder = Library.ScreenGui.DisplayOrder + 1
KeybindHudGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
KeybindHudGui.Parent = Library.ScreenGui.Parent

local KeybindHudFrame = Instance.new('Frame')
KeybindHudFrame.Name = 'Panel'
KeybindHudFrame.AnchorPoint = Vector2.new(0, 0.5)
KeybindHudFrame.Position = UDim2.new(0, 10, 0.5, 0)
KeybindHudFrame.Size = UDim2.fromOffset(240, 32)
KeybindHudFrame.BackgroundColor3 = Library.MainColor
KeybindHudFrame.BorderSizePixel = 0
KeybindHudFrame.Visible = false
KeybindHudFrame.ZIndex = 1
KeybindHudFrame.Active = true
KeybindHudFrame.Parent = KeybindHudGui
local KeybindHudCorner = Instance.new('UICorner')
KeybindHudCorner.CornerRadius = UDim.new(0, 4)
KeybindHudCorner.Parent = KeybindHudFrame

local KeybindHudStroke = Instance.new('UIStroke')
KeybindHudStroke.Color = Library.OutlineColor
KeybindHudStroke.Thickness = 1.2
KeybindHudStroke.Parent = KeybindHudFrame
Library:OnUnload(function()
	if KeybindHudGui.Parent then
		KeybindHudGui:Destroy()
	end
end)

local KeybindHudHeader = Instance.new('TextLabel')
KeybindHudHeader.Name = 'Header'
KeybindHudHeader.BackgroundTransparency = 1
KeybindHudHeader.Position = UDim2.fromOffset(8, 5)
KeybindHudHeader.Size = UDim2.new(1, -16, 0, 18)
KeybindHudHeader.Font = Library.Font
KeybindHudHeader.Text = 'KEYBINDS'
KeybindHudHeader.TextColor3 = Library.AccentColor
KeybindHudHeader.TextSize = 14
KeybindHudHeader.TextXAlignment = Enum.TextXAlignment.Left
KeybindHudHeader.ZIndex = 2
KeybindHudHeader.Parent = KeybindHudFrame
KeybindHudHeader.Active = true

local KeybindHudAccent = Instance.new('Frame')
KeybindHudAccent.Name = 'Accent'
KeybindHudAccent.BackgroundColor3 = Library.AccentColor
KeybindHudAccent.BorderSizePixel = 0
KeybindHudAccent.Size = UDim2.new(1, 0, 0, 2)
KeybindHudAccent.ZIndex = 2
KeybindHudAccent.Parent = KeybindHudFrame

local KeybindHudDragHint = Instance.new('TextLabel')
KeybindHudDragHint.Name = 'DragHint'
KeybindHudDragHint.BackgroundTransparency = 1
KeybindHudDragHint.AnchorPoint = Vector2.new(1, 0)
KeybindHudDragHint.Position = UDim2.new(1, -8, 0, 5)
KeybindHudDragHint.Size = UDim2.fromOffset(42, 18)
KeybindHudDragHint.Font = Library.Font
KeybindHudDragHint.Text = 'MOVE'
KeybindHudDragHint.TextColor3 = Library.FontColor
KeybindHudDragHint.TextTransparency = 0.35
KeybindHudDragHint.TextSize = 10
KeybindHudDragHint.TextXAlignment = Enum.TextXAlignment.Right
KeybindHudDragHint.ZIndex = 2
KeybindHudDragHint.Parent = KeybindHudFrame

local draggingKeybindHud = false
local keybindHudGrabOffset
Library:GiveSignal(UserInputService.InputBegan:Connect(function(input)
	if not Window.Holder.Visible or not KeybindHudFrame.Visible or input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end

	local mousePosition = UserInputService:GetMouseLocation()
	local handlePosition = KeybindHudHeader.AbsolutePosition
	local handleSize = KeybindHudHeader.AbsoluteSize
	if mousePosition.X < handlePosition.X or mousePosition.X > handlePosition.X + handleSize.X
		or mousePosition.Y < handlePosition.Y or mousePosition.Y > handlePosition.Y + handleSize.Y then
		return
	end

	draggingKeybindHud = true
	keybindHudGrabOffset = mousePosition - KeybindHudFrame.AbsolutePosition
end))

local function UpdateKeybindHudDrag()
	if not draggingKeybindHud then
		return
	end
	if not Window.Holder.Visible or not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
		draggingKeybindHud = false
		return
	end

	local mousePosition = UserInputService:GetMouseLocation()
	local viewportSize = workspace.CurrentCamera.ViewportSize
	local size = KeybindHudFrame.AbsoluteSize
	local x = math.clamp(mousePosition.X - keybindHudGrabOffset.X, 0, math.max(0, viewportSize.X - size.X))
	local y = math.clamp(mousePosition.Y - keybindHudGrabOffset.Y, 0, math.max(0, viewportSize.Y - size.Y))
	KeybindHudFrame.Position = UDim2.fromOffset(
		x + size.X * KeybindHudFrame.AnchorPoint.X,
		y + size.Y * KeybindHudFrame.AnchorPoint.Y
	)
end

local KeybindHudRowsContainer = Instance.new('Frame')
KeybindHudRowsContainer.Name = 'Rows'
KeybindHudRowsContainer.BackgroundTransparency = 1
KeybindHudRowsContainer.Position = UDim2.fromOffset(8, 27)
KeybindHudRowsContainer.Size = UDim2.new(1, -16, 1, -32)
KeybindHudRowsContainer.ZIndex = 2
KeybindHudRowsContainer.Parent = KeybindHudFrame

local KeybindHudRowsLayout = Instance.new('UIListLayout')
KeybindHudRowsLayout.Padding = UDim.new(0, 2)
KeybindHudRowsLayout.SortOrder = Enum.SortOrder.LayoutOrder
KeybindHudRowsLayout.Parent = KeybindHudRowsContainer

local KeybindHudLabels = {}

local function IsKeyHeld(key)
	if key == 'MB1' then
		return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
	elseif key == 'MB2' then
		return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
	end

	local keyCode = Enum.KeyCode[key]
	return keyCode ~= nil and UserInputService:IsKeyDown(keyCode)
end

local function IsKeybindVisibleInFilter(key, mode)
	if KeybindFilter == 'All' then
		return true
	elseif KeybindFilter == 'Toggle' then
		return mode == 'Toggle'
	end

	return mode == 'Hold' and IsKeyHeld(key)
end

local function IsKeybindActive(key, mode)
	for _, option in pairs(Options) do
		if type(option) == 'table' and option.Type == 'KeyPicker'
			and option.Value == key and option.Mode == mode then
			local success, active = pcall(option.GetState, option)
			if success and active then
				return true
			end
		end
	end

	return false
end

local function UpdateKeybindHudRows()
	local rows = {}
	local menuMode = Options.MenuBindMode.Value
	if IsKeybindVisibleInFilter(MenuKey, menuMode) then
		local menuActive = menuMode == 'Always'
			or menuMode == 'Hold' and IsKeyHeld(MenuKey)
			or menuMode == 'Toggle' and Window.Holder.Visible
		table.insert(rows, {
			Id = 'Menu',
			Text = string.format('[%s] Menu (%s)', MenuKey, menuMode),
			Active = menuActive
		})
	end

	for _, label in ipairs(Library.KeybindContainer:GetChildren()) do
		if label:IsA('TextLabel') then
			local key, name, mode = label.Text:match('^%[([^%]]+)%]%s+(.-)%s+%(([^()]*)%)$')
			if key and IsKeybindVisibleInFilter(key, mode) then
				table.insert(rows, {
					Id = label,
					Text = label.Text,
					Active = IsKeybindActive(key, mode)
				})
			end
		end
	end

	if KeybindFilter == 'All' and type(Toggles) == 'table' then
		for name, toggle in pairs(Toggles) do
			local hasAssignedKey = false
			for _, addon in ipairs(toggle.Addons or {}) do
				if addon.Type == 'KeyPicker' and addon.Value and addon.Value ~= 'None' then
					hasAssignedKey = true
					break
				end
			end

			if toggle.Value and not hasAssignedKey then
				local text = toggle.TextLabel and toggle.TextLabel.Text or tostring(name)
				table.insert(rows, { Id = toggle, Text = text .. ' (On)', Active = true })
			end
		end
	end

	local visibleRows = {}
	for order, row in ipairs(rows) do
		visibleRows[row.Id] = true
		local label = KeybindHudLabels[row.Id]
		if not label or not label.Parent then
			label = Instance.new('TextLabel')
			label.Name = 'KeybindRow'
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 0, 18)
			label.Font = Library.Font
			label.TextColor3 = Library.FontColor
			label.TextSize = 13
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextYAlignment = Enum.TextYAlignment.Center
			label.ZIndex = 3
			label.Parent = KeybindHudRowsContainer
			label.BackgroundColor3 = Library.AccentColor
			KeybindHudLabels[row.Id] = label
		end
		label.LayoutOrder = order
		label.Text = row.Active and ('> ' .. row.Text) or row.Text
		label.TextColor3 = row.Active and Library.AccentColor or Library.FontColor
		label.BackgroundTransparency = row.Active and 0.88 or 1
	end

	for id, label in pairs(KeybindHudLabels) do
		if not visibleRows[id] then
			KeybindHudLabels[id] = nil
			label:Destroy()
		end
	end

	KeybindHudFrame.Size = UDim2.fromOffset(240, 34 + #rows * 20)
	KeybindHudFrame.Visible = KeybindDisplayToggle.Value
	Library.KeybindFrame.Visible = false
end

local function ApplyKeybindFilter()
	UpdateKeybindHudRows()
end

local function UpdateMenuKeybindHud()
	ApplyKeybindFilter()
end

KeybindFilterDropdown:OnChanged(function(value)
	KeybindFilter = value or 'All'
	ApplyKeybindFilter()
end)
Options.MenuBindMode:OnChanged(UpdateMenuKeybindHud)

local KeybindCheckmark = KeybindDisplayToggle.TextLabel.Parent
KeybindCheckmark.Active = true
KeybindCheckmark.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		KeybindFilterDropdown:OpenDropdown()
	end
end)

local function WatchKeybindLabel(label)
	if not label:IsA('TextLabel') then
		return
	end

	label:GetPropertyChangedSignal('Text'):Connect(function()
		task.defer(ApplyKeybindFilter)
	end)
	label:GetPropertyChangedSignal('Visible'):Connect(function()
		task.defer(ApplyKeybindFilter)
	end)
end

for _, label in ipairs(Library.KeybindContainer:GetChildren()) do
	WatchKeybindLabel(label)
end
Library.KeybindContainer.ChildAdded:Connect(WatchKeybindLabel)
Library.KeybindContainer.ChildRemoved:Connect(ApplyKeybindFilter)

KeybindDisplayToggle:OnChanged(function()
	ApplyKeybindFilter()
end)
KeybindTransparency:OnChanged(function(value)
	local transparency = value / 100
	KeybindHudFrame.BackgroundTransparency = transparency
	KeybindHudStroke.Transparency = transparency
end)

local desiredMenuVisible = true
local menuReady = false
local RunService = game:GetService('RunService')

local function MatchesMenuKey(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		return input.KeyCode.Name == MenuKey
	end

	return false
end

local function SetMenuVisibility(visible)
	desiredMenuVisible = visible
	if menuReady then
		Window.Holder.Visible = visible
	end
end

Library.ToggleKeybind = { Type = 'KeyPicker', Value = 'None' }
Library:GiveSignal(UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if waitingForMenuKey then
		if input.UserInputType ~= Enum.UserInputType.Keyboard then
			return
		end

		local keyName = input.KeyCode.Name
		if keyName == 'Escape' then
			waitingForMenuKey = false
			Library:Notify('Menu key unchanged', 2)
		elseif keyName ~= 'Unknown' then
			MenuKey = keyName
			waitingForMenuKey = false
			MenuBindLabel:SetText('Menu bind: ' .. MenuKey)
			UpdateMenuKeybindHud()
			Library:Notify('Menu key set to ' .. MenuKey, 2)
		end
		return
	end

	if not MatchesMenuKey(input) then
		return
	end

	local mode = Options.MenuBindMode.Value
	if mode == 'Toggle' then
		SetMenuVisibility(not desiredMenuVisible)
	elseif mode == 'Hold' then
		SetMenuVisibility(true)
	end
end))

Library:GiveSignal(UserInputService.InputEnded:Connect(function(input)
	if Options.MenuBindMode.Value == 'Hold' and MatchesMenuKey(input) then
		SetMenuVisibility(false)
	end
end))

Library:GiveSignal(RunService.RenderStepped:Connect(function()
	UpdateKeybindHudDrag()
	local mode = Options.MenuBindMode.Value
	if mode == 'Always' then
		SetMenuVisibility(true)
	elseif mode == 'Hold' then
		local held = UserInputService:IsKeyDown(Enum.KeyCode[MenuKey])
		SetMenuVisibility(held)
	end

	if menuReady then
		Window.Holder.Visible = desiredMenuVisible
	end

	if KeybindDisplayToggle.Value then
		ApplyKeybindFilter()
	end
end))

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuBindMode', 'KeybindFilter', 'ShowKeybinds', 'KeybindTransparency' })

for _, parser in next, SaveManager.Parser do
	local loadOption = parser.Load
	parser.Load = function(index, data)
		if SaveManager.Ignore[index] then
			return
		end

		return loadOption(index, data)
	end
end

ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')
local ConfigGroup = Tabs['UI Settings']:AddRightGroupbox('Configuration')
local autoloadPath = SaveManager.Folder .. '/settings/autoload.txt'
ConfigGroup:AddInput('SaveManager_ConfigName', { Text = 'Config name' })
ConfigGroup:AddDropdown('SaveManager_ConfigList', {
	Text = 'Config list',
	Values = SaveManager:RefreshConfigList(),
	AllowNull = true
})

ConfigGroup:AddDivider()
ConfigGroup:AddButton('Create config', function()
	local name = Options.SaveManager_ConfigName.Value
	if name:gsub(' ', '') == '' then
		return Library:Notify('Invalid config name (empty)', 2)
	end

	local success, err = SaveManager:Save(name)
	if not success then
		return Library:Notify('Failed to save config: ' .. err, 2)
	end

	Library:Notify(string.format('Created config %q', name), 2)
	Options.SaveManager_ConfigList:SetValues(SaveManager:RefreshConfigList())
	Options.SaveManager_ConfigList:SetValue(nil)
end):AddButton('Load config', function()
	local name = Options.SaveManager_ConfigList.Value
	local success, err = SaveManager:Load(name)
	if not success then
		return Library:Notify('Failed to load config: ' .. err, 2)
	end

	Library:Notify(string.format('Loaded config %q', name), 2)
end)

ConfigGroup:AddButton('Overwrite config', function()
	local name = Options.SaveManager_ConfigList.Value
	local success, err = SaveManager:Save(name)
	if not success then
		return Library:Notify('Failed to overwrite config: ' .. err, 2)
	end

	Library:Notify(string.format('Overwrote config %q', name), 2)
end)

ConfigGroup:AddButton({
	Text = 'Delete selected config',
	DoubleClick = true,
	Tooltip = 'Permanently delete the selected config',
	Func = function()
		local name = Options.SaveManager_ConfigList.Value
		if not name then
			return Library:Notify('Select a config first', 2)
		end

		local configPath = SaveManager.Folder .. '/settings/' .. name .. '.json'
		if not isfile(configPath) then
			return Library:Notify('Selected config was not found', 2)
		end

		delfile(configPath)
		if isfile(autoloadPath) and readfile(autoloadPath) == name then
			delfile(autoloadPath)
			SaveManager.AutoloadLabel:SetText('Current autoload config: none')
		end

		Options.SaveManager_ConfigList:SetValues(SaveManager:RefreshConfigList())
		Options.SaveManager_ConfigList:SetValue(nil)
		Library:Notify(string.format('Deleted config %q', name), 2)
	end
})

ConfigGroup:AddButton('Refresh list', function()
	Options.SaveManager_ConfigList:SetValues(SaveManager:RefreshConfigList())
	Options.SaveManager_ConfigList:SetValue(nil)
end)

ConfigGroup:AddButton('Set as autoload', function()
	local name = Options.SaveManager_ConfigList.Value
	if not name then
		return Library:Notify('Select a config first', 2)
	end

	writefile(SaveManager.Folder .. '/settings/autoload.txt', name)
	SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. name)
	Library:Notify(string.format('Set %q to auto load', name), 2)
end)

ConfigGroup:AddButton({
	Text = 'Clear autoload config',
	DoubleClick = true,
	Tooltip = 'Stop loading a config automatically when the script starts',
	Func = function()
		if isfile(autoloadPath) then
			delfile(autoloadPath)
		end

		SaveManager.AutoloadLabel:SetText('Current autoload config: none')
		Library:Notify('Cleared autoload config', 2)
	end
})

SaveManager.AutoloadLabel = ConfigGroup:AddLabel('Current autoload config: none', true)
if isfile(autoloadPath) then
	SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. readfile(autoloadPath))
end

SaveManager:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName' })

local ThemeGroup = ThemeManager:CreateGroupBox(Tabs['UI Settings'])
ThemeManager:CreateThemeManager(ThemeGroup)
ThemeGroup:AddDivider()
ThemeGroup:AddButton({
	Text = 'Overwrite selected theme',
	DoubleClick = true,
	Tooltip = 'Save the current colors over the selected custom theme',
	Func = function()
		local name = Options.ThemeManager_CustomThemeList.Value
		if not name then
			return Library:Notify('Select a custom theme first', 2)
		end

		ThemeManager:SaveCustomTheme(name:gsub('%.json$', ''))
		Library:Notify(string.format('Overwrote custom theme %q', name), 2)
	end
})

ThemeGroup:AddButton({
	Text = 'Delete selected theme',
	DoubleClick = true,
	Tooltip = 'Permanently delete the selected custom theme',
	Func = function()
		local name = Options.ThemeManager_CustomThemeList.Value
		if not name then
			return Library:Notify('Select a custom theme first', 2)
		end

		local themePath = ThemeManager.Folder .. '/themes/' .. name
		if not isfile(themePath) then
			return Library:Notify('Selected theme was not found', 2)
		end

		delfile(themePath)
		local defaultPath = ThemeManager.Folder .. '/themes/default.txt'
		if isfile(defaultPath) and readfile(defaultPath) == name then
			delfile(defaultPath)
			Options.ThemeManager_ThemeList:SetValue('Default')
		end

		Options.ThemeManager_CustomThemeList:SetValues(ThemeManager:ReloadCustomThemes())
		Options.ThemeManager_CustomThemeList:SetValue(nil)
		Library:Notify(string.format('Deleted custom theme %q', name), 2)
	end
})

SaveManager:LoadAutoloadConfig()
FinishLoadingScreen(function()
	menuReady = true
	desiredMenuVisible = true
	Window.Holder.Visible = true
end)
