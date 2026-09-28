local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Gumball — .gg/gu9mball | Rivals',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- Define Tabs
local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    Movement = Window:AddTab('Movement'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

-- [[ COMBAT SECTION ]]
local AimbotGroup = Tabs.Combat:AddLeftGroupbox('Aimbot')

AimbotGroup:AddToggle('AimbotEnabled', {
    Text = 'Enable Aimbot',
    Default = false,
    Tooltip = 'Automatically locks onto enemies',
})

AimbotGroup:AddToggle('SilentAim', {
    Text = 'Silent Aim',
    Default = false,
    Tooltip = 'Hits targets without moving your camera',
})

AimbotGroup:AddDropdown('AimPart', {
    Values = { 'Head', 'HumanoidRootPart' },
    Default = 1,
    Text = 'Target Part',
})

AimbotGroup:AddSlider('AimSmoothness', {
    Text = 'Smoothness',
    Default = 1,
    Min = 1,
    Max = 10,
    Rounding = 1,
})

local FovGroup = Tabs.Combat:AddRightGroupbox('FOV Settings')

FovGroup:AddToggle('ShowFOV', {
    Text = 'Show FOV Circle',
    Default = false,
})

FovGroup:AddSlider('FOVRadius', {
    Text = 'FOV Radius',
    Default = 150,
    Min = 0,
    Max = 800,
    Rounding = 0,
})

FovGroup:AddLabel('FOV Color'):AddColorPicker('FOVColor', {
    Default = Color3.new(1, 1, 1),
})

-- [[ VISUALS SECTION ]]
local ESPGroup = Tabs.Visuals:AddLeftGroupbox('ESP (Extra Sensory Perception)')

ESPGroup:AddToggle('BoxESP', {
    Text = 'Box ESP',
    Default = false,
})

ESPGroup:AddToggle('TracerESP', {
    Text = 'Snaplines / Tracers',
    Default = false,
})

ESPGroup:AddToggle('NameESP', {
    Text = 'Player Names',
    Default = false,
})

ESPGroup:AddLabel('Enemy Color'):AddColorPicker('EnemyColor', {
    Default = Color3.fromRGB(255, 0, 0),
})

-- [[ MOVEMENT SECTION ]]
local MoveGroup = Tabs.Movement:AddLeftGroupbox('Enhancements')

MoveGroup:AddSlider('WalkSpeed', {
    Text = 'WalkSpeed Multiplier',
    Default = 16,
    Min = 16,
    Max = 150,
    Rounding = 0,
})

MoveGroup:AddToggle('InfJump', {
    Text = 'Infinite Jump',
    Default = false,
})

-- [[ UI SETTINGS / CONFIG ]]
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind 

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('GumballScript')
SaveManager:SetFolder('GumballScript/Rivals')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()

-- Watermark Logic
Library:SetWatermarkVisibility(true)

local FrameTimer = tick()
local FrameCounter = 0;
local FPS = 60;

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1;
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter;
        FrameTimer = tick();
        FrameCounter = 0;
    end;

    Library:SetWatermark(('Gumball | .gg/gu9mball | %s FPS | %s MS'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ));
end);

Library:OnUnload(function()
    WatermarkConnection:Disconnect()
    Library.Unloaded = true
end)
