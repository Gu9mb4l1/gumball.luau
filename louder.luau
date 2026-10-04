
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
	Title = ' Gumball - .gg/gu9mball',
	Center = true,
	AutoShow = true,
	TabPadding = 8,
	MenuFadeTime = 0.2
})

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
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
	Default = 'RightShift',
	NoUI = true,
	Text = 'Menu keybind'
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')
local ConfigGroup = Tabs['UI Settings']:AddRightGroupbox('Configuration')
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

SaveManager.AutoloadLabel = ConfigGroup:AddLabel('Current autoload config: none', true)
local autoloadPath = SaveManager.Folder .. '/settings/autoload.txt'
if isfile(autoloadPath) then
	SaveManager.AutoloadLabel:SetText('Current autoload config: ' .. readfile(autoloadPath))
end

ConfigGroup:AddDivider()
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
}):AddButton({
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

SaveManager:SetIgnoreIndexes({ 'SaveManager_ConfigList', 'SaveManager_ConfigName' })

local ThemeGroup = ThemeManager:CreateGroupBox(Tabs['UI Settings'])
ThemeManager:CreateThemeManager(ThemeGroup)
ThemeGroup:AddDivider()
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
