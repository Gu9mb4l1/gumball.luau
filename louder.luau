
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
Window.Holder.Visible = true

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
local KeybindFilterButtons = {}
local KeybindPopup = Library:Create('Frame', {
	BackgroundColor3 = Library.MainColor,
	BorderColor3 = Library.OutlineColor,
	BorderMode = Enum.BorderMode.Inset,
	Size = UDim2.fromOffset(112, 66),
	Visible = false,
	ZIndex = 250,
	Parent = Library.ScreenGui
})
Library:AddToRegistry(KeybindPopup, {
	BackgroundColor3 = 'MainColor',
	BorderColor3 = 'OutlineColor'
})
Library:Create('UIListLayout', {
	FillDirection = Enum.FillDirection.Vertical,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Parent = KeybindPopup
})

local function ApplyKeybindFilter()
	local visibleCount = 0
	for _, label in ipairs(Library.KeybindContainer:GetChildren()) do
		if label:IsA('TextLabel') then
			local mode = label.Text:match('%(([^()]*)%)$')
			label.Visible = mode ~= nil and (KeybindFilter == 'All' or mode == KeybindFilter)
			if label.Visible then
				visibleCount += 1
			end
		end
	end

	Library.KeybindFrame.Size = UDim2.new(0, Library.KeybindFrame.Size.X.Offset, 0, visibleCount * 18 + 23)
	Library.KeybindFrame.Visible = KeybindDisplayToggle.Value
	for filter, button in pairs(KeybindFilterButtons) do
		button.BackgroundColor3 = filter == KeybindFilter and Library.AccentColor or Library.MainColor
		button.Text = filter == KeybindFilter and ('> ' .. filter) or filter
	end
end

for index, filter in ipairs({ 'All', 'Toggle', 'Hold' }) do
	local selectedFilter = filter
	local button = Library:Create('TextButton', {
		AutoButtonColor = false,
		BackgroundColor3 = Library.MainColor,
		BorderSizePixel = 0,
		Font = Library.Font,
		LayoutOrder = index,
		Size = UDim2.new(1, 0, 0, 22),
		Text = selectedFilter,
		TextColor3 = Library.FontColor,
		TextSize = 14,
		ZIndex = 251,
		Parent = KeybindPopup
	})
	Library:AddToRegistry(button, {
		BackgroundColor3 = 'MainColor',
		TextColor3 = 'FontColor'
	})
	Library:OnHighlight(button, button,
		{ BackgroundColor3 = 'AccentColor' },
		{ BackgroundColor3 = 'MainColor' }
	)
	button.Activated:Connect(function()
		KeybindFilter = selectedFilter
		KeybindPopup.Visible = false
		ApplyKeybindFilter()
	end)
	KeybindFilterButtons[selectedFilter] = button
end

local KeybindCheckmark = KeybindDisplayToggle.TextLabel.Parent
KeybindCheckmark.Active = true
KeybindCheckmark.InputBegan:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseButton2 then
		return
	end

	local mousePosition = UserInputService:GetMouseLocation()
	local viewportSize = workspace.CurrentCamera.ViewportSize
	local popupWidth = KeybindPopup.Size.X.Offset
	local popupHeight = KeybindPopup.Size.Y.Offset
	KeybindPopup.Position = UDim2.fromOffset(
		math.clamp(mousePosition.X, 0, math.max(0, viewportSize.X - popupWidth)),
		math.clamp(mousePosition.Y, 0, math.max(0, viewportSize.Y - popupHeight))
	)
	KeybindPopup.Visible = true
	ApplyKeybindFilter()
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
Library:GiveSignal(UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 or not KeybindPopup.Visible then
		return
	end

	local mousePosition = UserInputService:GetMouseLocation()
	local popupPosition = KeybindPopup.AbsolutePosition
	local popupSize = KeybindPopup.AbsoluteSize
	if mousePosition.X < popupPosition.X or mousePosition.X > popupPosition.X + popupSize.X
		or mousePosition.Y < popupPosition.Y or mousePosition.Y > popupPosition.Y + popupSize.Y then
		KeybindPopup.Visible = false
	end
end))

KeybindDisplayToggle:OnChanged(ApplyKeybindFilter)
KeybindTransparency:OnChanged(function(value)
	local transparency = value / 100
	Library.KeybindFrame.BackgroundTransparency = transparency

	local inner = Library.KeybindFrame:FindFirstChildWhichIsA('Frame')
	if inner then
		inner.BackgroundTransparency = transparency
		local accent = inner:FindFirstChildWhichIsA('Frame')
		if accent then
			accent.BackgroundTransparency = transparency
		end
	end
end)

local desiredMenuVisible = true
local RunService = game:GetService('RunService')

local function MatchesMenuKey(input)
	if input.UserInputType == Enum.UserInputType.Keyboard then
		return input.KeyCode.Name == MenuKey
	end

	return false
end

local function SetMenuVisibility(visible)
	desiredMenuVisible = visible
	Window.Holder.Visible = visible
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
	local mode = Options.MenuBindMode.Value
	if mode == 'Always' then
		SetMenuVisibility(true)
	elseif mode == 'Hold' then
		local held = UserInputService:IsKeyDown(Enum.KeyCode[MenuKey])
		SetMenuVisibility(held)
	end

	Window.Holder.Visible = desiredMenuVisible
end))

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuBindMode', 'ShowKeybinds', 'KeybindTransparency' })

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
