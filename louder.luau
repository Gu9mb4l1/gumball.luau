-- Gumball UI
-- Gumball - .gg/gu9mball

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

Library.MainColor = Color3.fromRGB(25, 28, 34)
Library.BackgroundColor = Color3.fromRGB(15, 17, 21)
Library.AccentColor = Color3.fromRGB(0, 190, 220)
Library.FontColor = Color3.fromRGB(235, 240, 245)
Library.Font = Enum.Font.Gotham

local Window = Library:CreateWindow({
    Title = 'Gumball - .gg/gu9mball',
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(620, 720),
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local DefaultWidth = 620
local DefaultHeight = 720
local WindowFrame

for _, Object in next, Library.ScreenGui:GetDescendants() do
    if Object:IsA('TextLabel') and Object.Text == 'Gumball - .gg/gu9mball' then
        Object.Position = UDim2.new(0, 0, 0, 0)
        Object.Size = UDim2.new(1, 0, 0, 25)
        Object.Font = Enum.Font.GothamBold
        Object.TextSize = 16
        Object.TextColor3 = Color3.fromRGB(245, 250, 255)
        Object.TextXAlignment = Enum.TextXAlignment.Center

        WindowFrame = Object.Parent.Parent
        WindowFrame.ClipsDescendants = true
        Object.Parent.ClipsDescendants = true
        break
    end
end

local Tabs = {
    Main = Window:AddTab('Main'),
    World = Window:AddTab('World'),
    ESP = Window:AddTab('ESP'),
    visuals = Window:AddTab('visuals'),
    character = Window:AddTab('character'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local SilentAimGroup = Tabs.Main:AddLeftGroupbox('Silent aim')
SilentAimGroup:AddToggle('SilentAimEnabled', { Text = 'Enabled', Callback = function(Value) end })
SilentAimGroup:AddToggle('SilentAimManipulation', { Text = 'Manipulation', Callback = function(Value) end })
SilentAimGroup:AddToggle('SilentAimClosestPart', { Text = 'Closest part', Callback = function(Value) end })
SilentAimGroup:AddToggle('SilentAimVisualize', { Text = 'Visualize', Callback = function(Value) end })
SilentAimGroup:AddToggle('SilentAimShowFov', { Text = 'Show fov', Callback = function(Value) end })
SilentAimGroup:AddToggle('SilentAimOutline', { Text = 'Outline', Callback = function(Value) end })
SilentAimGroup:AddToggle('SilentAimFill', { Text = 'Fill', Callback = function(Value) end })
SilentAimGroup:AddSlider('SilentAimFov', { Text = 'Fov', Default = 1, Min = 0, Max = 10, Rounding = 1, Suffix = 'x', Callback = function(Value) end })
SilentAimGroup:AddSlider('SilentAimRadius', { Text = 'Radius', Default = 85, Min = 0, Max = 300, Rounding = 0, Suffix = 'px', Callback = function(Value) end })
SilentAimGroup:AddSlider('SilentAimHitChance', { Text = 'Hit chance', Default = 100, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })

local TargetingGroup = Tabs.Main:AddLeftGroupbox('Targeting')
TargetingGroup:AddToggle('TargetVisibleOnly', { Text = 'Visible only', Callback = function(Value) end })
TargetingGroup:AddToggle('TargetIgnoreProtected', { Text = 'Ignore protected', Callback = function(Value) end })
TargetingGroup:AddDropdown('TargetIgnoreIf', { Text = 'Ignore if', Values = { 'Katana deflecting', 'Invulnerable', 'Teammate' }, Default = 1, Callback = function(Value) end })
TargetingGroup:AddToggle('TargetDisableFlash', { Text = 'Disable on flash', Callback = function(Value) end })
TargetingGroup:AddSlider('TargetReactionTime', { Text = 'Reaction time', Default = 0, Min = 0, Max = 500, Rounding = 0, Suffix = 'ms', Callback = function(Value) end })
TargetingGroup:AddSlider('TargetForgetTime', { Text = 'Forget time', Default = 10, Min = 0, Max = 60, Rounding = 0, Suffix = 's', Callback = function(Value) end })
TargetingGroup:AddDropdown('TargetPart', { Text = 'Target part', Values = { 'Head', 'HumanoidRootPart', 'UpperTorso' }, Default = 1, Callback = function(Value) end })

local AimbotGroup = Tabs.Main:AddRightGroupbox('Aimbot')
AimbotGroup:AddToggle('AimbotEnabled', { Text = 'Enabled', Callback = function(Value) end })
AimbotGroup:AddToggle('AimbotManipulation', { Text = 'Manipulation', Callback = function(Value) end })
AimbotGroup:AddToggle('AimbotClosestPart', { Text = 'Closest part', Callback = function(Value) end })
AimbotGroup:AddToggle('AimbotVisualize', { Text = 'Visualize', Callback = function(Value) end })
AimbotGroup:AddSlider('AimbotSmoothing', { Text = 'Smoothing', Default = 0.5, Min = 0, Max = 10, Rounding = 1, Callback = function(Value) end })
AimbotGroup:AddSlider('AimbotFov', { Text = 'Fov', Default = 70, Min = 0, Max = 180, Rounding = 0, Callback = function(Value) end })

local TriggerbotGroup = Tabs.Main:AddRightGroupbox('Triggerbot')
TriggerbotGroup:AddToggle('TriggerbotEnabled', { Text = 'Enabled', Callback = function(Value) end })
TriggerbotGroup:AddSlider('TriggerReactionTime', { Text = 'Reaction time', Default = 0, Min = 0, Max = 500, Rounding = 0, Suffix = 'ms', Callback = function(Value) end })
TriggerbotGroup:AddSlider('TriggerReactionOffset', { Text = 'Reaction time offset', Default = 0, Min = 0, Max = 500, Rounding = 0, Suffix = 'ms', Callback = function(Value) end })
TriggerbotGroup:AddSlider('TriggerForgetTime', { Text = 'Forget time', Default = 10, Min = 0, Max = 60, Rounding = 0, Suffix = 's', Callback = function(Value) end })
TriggerbotGroup:AddSlider('TriggerMaxDistance', { Text = 'Max distance', Default = 500, Min = 0, Max = 1000, Rounding = 0, Suffix = 's', Callback = function(Value) end })
TriggerbotGroup:AddDropdown('TriggerPartBlacklist', { Text = 'Part blacklist', Values = { 'HumanoidRootPart, UpperTorso', 'Head', 'Legs' }, Default = 1, Callback = function(Value) end })
TriggerbotGroup:AddDropdown('TriggerSettings', { Text = 'Settings', Values = { 'No delay between targets', 'Default' }, Default = 1, Callback = function(Value) end })

local WeaponsGroup = Tabs.Main:AddRightGroupbox('Weapons')
WeaponsGroup:AddToggle('NoSpread', { Text = 'No spread', Callback = function(Value) end })
WeaponsGroup:AddToggle('FullAuto', { Text = 'Full auto', Callback = function(Value) end })
WeaponsGroup:AddToggle('AlwaysBackstab', { Text = 'Always backstab', Callback = function(Value) end })
WeaponsGroup:AddDropdown('GrenadeOptions', { Text = 'Grenade options', Values = { 'Explode on throw', 'Default' }, Default = 1, Callback = function(Value) end })
WeaponsGroup:AddSlider('FireRate', { Text = 'Firerate', Default = 10, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })
WeaponsGroup:AddDropdown('RagebotPriority', { Text = 'Ragebot priority', Values = { 'Distance', 'Health', 'Crosshair' }, Default = 1, Callback = function(Value) end })

local ColorCorrectionGroup = Tabs.World:AddLeftGroupbox('Color correction')
ColorCorrectionGroup:AddToggle('ColorCorrectionEnabled', { Text = 'Enabled', Callback = function(Value) end })
ColorCorrectionGroup:AddSlider('Saturation', { Text = 'Saturation', Default = 0.5, Min = -1, Max = 1, Rounding = 1, Callback = function(Value) end })
ColorCorrectionGroup:AddSlider('Contrast', { Text = 'Contrast', Default = 0.2, Min = -1, Max = 1, Rounding = 1, Callback = function(Value) end })
ColorCorrectionGroup:AddSlider('Brightness', { Text = 'Brightness', Default = 0.1, Min = -1, Max = 1, Rounding = 1, Callback = function(Value) end })

local LightingGroup = Tabs.World:AddLeftGroupbox('Lighting')
LightingGroup:AddToggle('Ambient', { Text = 'Ambient', Callback = function(Value) end })
LightingGroup:AddToggle('ColorShiftBottom', { Text = 'ColorShift_Bottom', Callback = function(Value) end })
LightingGroup:AddToggle('ColorShiftTop', { Text = 'ColorShift_Top', Callback = function(Value) end })
LightingGroup:AddToggle('FogColor', { Text = 'FogColor', Callback = function(Value) end })
LightingGroup:AddToggle('FogEnd', { Text = 'FogEnd', Callback = function(Value) end })
LightingGroup:AddToggle('FogStart', { Text = 'FogStart', Callback = function(Value) end })
LightingGroup:AddToggle('ExposureCompensation', { Text = 'ExposureCompensation', Callback = function(Value) end })
LightingGroup:AddSlider('ExposureValue', { Text = 'ExposureCompensation', Default = -1, Min = -5, Max = 5, Rounding = 0, Callback = function(Value) end })
LightingGroup:AddToggle('GlobalShadows', { Text = 'GlobalShadows', Callback = function(Value) end })

local SkyboxGroup = Tabs.World:AddRightGroupbox('Skybox')
SkyboxGroup:AddToggle('SkyboxEnabled', { Text = 'Enabled', Callback = function(Value) end })
SkyboxGroup:AddDropdown('SkyboxSelected', { Text = 'Selected', Values = { 'Galaxy', 'Default' }, Default = 1, Callback = function(Value) end })
SkyboxGroup:AddDropdown('SkyboxDisable', { Text = 'Disable', Values = { 'Sun, moon', 'None' }, Default = 1, Callback = function(Value) end })

local BloomGroup = Tabs.World:AddRightGroupbox('Bloom')
BloomGroup:AddToggle('BloomEnabled', { Text = 'Enable', Callback = function(Value) end })
BloomGroup:AddSlider('BloomIntensity', { Text = 'Intensity', Default = 1, Min = 0, Max = 10, Rounding = 0, Callback = function(Value) end })
BloomGroup:AddSlider('BloomSize', { Text = 'Size', Default = 26, Min = 0, Max = 100, Rounding = 0, Callback = function(Value) end })
BloomGroup:AddSlider('BloomThreshold', { Text = 'Threshold', Default = 0.5, Min = 0, Max = 1, Rounding = 1, Callback = function(Value) end })

local CameraGroup = Tabs.World:AddRightGroupbox('Camera')
CameraGroup:AddToggle('AntiFlashbang', { Text = 'Anti flashbang', Callback = function(Value) end })
CameraGroup:AddToggle('FovChanger', { Text = 'Fov changer', Callback = function(Value) end })
CameraGroup:AddSlider('CameraFov', { Text = 'Fov', Default = 70, Min = 30, Max = 120, Rounding = 0, Callback = function(Value) end })
CameraGroup:AddToggle('AspectRatio', { Text = 'Aspect ratio', Callback = function(Value) end })
CameraGroup:AddSlider('RatioX', { Text = 'Ratio X', Default = 1, Min = 0.1, Max = 2, Rounding = 2, Callback = function(Value) end })
CameraGroup:AddSlider('RatioY', { Text = 'Ratio Y', Default = 0.98, Min = 0.1, Max = 2, Rounding = 2, Callback = function(Value) end })
CameraGroup:AddSlider('CameraBlur', { Text = 'Blur', Default = 2, Min = 0, Max = 20, Rounding = 0, Callback = function(Value) end })

local EspOptionsGroup = Tabs.ESP:AddLeftGroupbox('Options')
EspOptionsGroup:AddToggle('EspBox', { Text = 'Box', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspMovingRotation', { Text = 'Moving rotation', Callback = function(Value) end })
EspOptionsGroup:AddSlider('EspRotation', { Text = 'Rotation', Default = 0, Min = 0, Max = 360, Rounding = 0, Suffix = ' deg', Callback = function(Value) end })
EspOptionsGroup:AddSlider('EspRotationSpeed', { Text = 'Speed', Default = 0.1, Min = 0, Max = 5, Rounding = 1, Suffix = 'rps', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspFill', { Text = 'Fill', Callback = function(Value) end })
EspOptionsGroup:AddDropdown('EspFillImage', { Text = 'Fill image', Values = { 'Default', 'Gradient' }, Default = 1, Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspSkeleton', { Text = 'Skeleton', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspOutline', { Text = 'Outline', Callback = function(Value) end })
EspOptionsGroup:AddSlider('EspThickness', { Text = 'Thickness', Default = 1, Min = 0, Max = 5, Rounding = 0, Suffix = 'px', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspName', { Text = 'Name', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspWeapon', { Text = 'Weapon', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspDistance', { Text = 'Distance', Callback = function(Value) end })
EspOptionsGroup:AddToggle('EspHealthbar', { Text = 'Healthbar', Callback = function(Value) end })

local EspAppearanceGroup = Tabs.ESP:AddRightGroupbox('Override appearance')
EspAppearanceGroup:AddToggle('EspAppearanceEnabled', { Text = 'Enabled', Callback = function(Value) end })
EspAppearanceGroup:AddToggle('EspColor', { Text = 'Color', Callback = function(Value) end })
EspAppearanceGroup:AddDropdown('EspMaterial', { Text = 'Material', Values = { 'ForceField', 'Neon', 'Plastic' }, Default = 1, Callback = function(Value) end })
EspAppearanceGroup:AddDropdown('EspDisable', { Text = 'Disable', Values = { 'None', 'Team check' }, Default = 1, Callback = function(Value) end })
EspAppearanceGroup:AddSlider('EspTransparency', { Text = 'Transparency', Default = 100, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })

local HighlightGroup = Tabs.ESP:AddRightGroupbox('Highlight')
HighlightGroup:AddToggle('HighlightEnabled', { Text = 'Enabled', Callback = function(Value) end })
HighlightGroup:AddSlider('HighlightFillTransparency', { Text = 'Fill transparency', Default = 2, Min = 0, Max = 100, Rounding = 0, Callback = function(Value) end })
HighlightGroup:AddSlider('HighlightOutlineTransparency', { Text = 'Outline transparency', Default = 1, Min = 0, Max = 100, Rounding = 0, Callback = function(Value) end })

local EspCustomizationGroup = Tabs.ESP:AddRightGroupbox('Customization')
EspCustomizationGroup:AddToggle('IncludeTeammates', { Text = 'Include teammates', Callback = function(Value) end })
EspCustomizationGroup:AddDropdown('BoundingMode', { Text = 'Bounding mode', Values = { 'Dynamic', 'Static' }, Default = 1, Callback = function(Value) end })
EspCustomizationGroup:AddSlider('FixedWidthScale', { Text = 'Fixed width scale', Default = 100, Min = 0, Max = 200, Rounding = 0, Suffix = '%', Callback = function(Value) end })
EspCustomizationGroup:AddDropdown('EspFont', { Text = 'Font', Values = { 'Monocraft', 'Gotham', 'Code' }, Default = 1, Callback = function(Value) end })
EspCustomizationGroup:AddInput('NameType', { Text = 'Name type', Default = 'Name' })

local ViewmodelGroup = Tabs.visuals:AddLeftGroupbox('Viewmodel')
ViewmodelGroup:AddToggle('ShowCosmeticsChanger', { Text = 'Show cosmetics changer', Callback = function(Value) end })
ViewmodelGroup:AddDropdown('MuzzleFlash', { Text = 'Muzzle flash', Values = { 'Default', 'Disabled' }, Default = 1, Callback = function(Value) end })
ViewmodelGroup:AddToggle('OverrideFps', { Text = 'Override fps', Callback = function(Value) end })
ViewmodelGroup:AddSlider('RecoilPercent', { Text = 'Recoil percent', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })
ViewmodelGroup:AddToggle('ViewmodelChams', { Text = 'Chams', Callback = function(Value) end })
ViewmodelGroup:AddSlider('ViewmodelFillTransparency', { Text = 'Fill transparency', Default = 10, Min = 0, Max = 100, Rounding = 0, Callback = function(Value) end })
ViewmodelGroup:AddSlider('ViewmodelOutlineTransparency', { Text = 'Outline transparency', Default = 1, Min = 0, Max = 100, Rounding = 0, Callback = function(Value) end })
ViewmodelGroup:AddDropdown('ThroughWalls', { Text = 'Through walls', Values = { 'Default', 'Enabled' }, Default = 1, Callback = function(Value) end })
ViewmodelGroup:AddSlider('ViewmodelOffsetX', { Text = 'Offset X', Default = 0, Min = -2, Max = 2, Rounding = 1, Callback = function(Value) end })
ViewmodelGroup:AddSlider('ViewmodelOffsetY', { Text = 'Offset Y', Default = 0, Min = -2, Max = 2, Rounding = 1, Callback = function(Value) end })
ViewmodelGroup:AddSlider('ViewmodelOffsetZ', { Text = 'Offset Z', Default = -0.9, Min = -2, Max = 2, Rounding = 1, Callback = function(Value) end })

local HitEffectsGroup = Tabs.visuals:AddRightGroupbox('Hit effects')
HitEffectsGroup:AddToggle('HitEffectsEnabled', { Text = 'Enabled', Callback = function(Value) end })
HitEffectsGroup:AddToggle('WeldToPlayer', { Text = 'Weld to player', Callback = function(Value) end })
HitEffectsGroup:AddDropdown('FortniteDamage', { Text = 'Fortnite damage', Values = { 'Slashes', 'Numbers', 'Default' }, Default = 1, Callback = function(Value) end })
HitEffectsGroup:AddDropdown('HitEffectSettings', { Text = 'Effect settings', Values = { 'Default', 'Custom' }, Default = 1, Callback = function(Value) end })
HitEffectsGroup:AddDropdown('PreferredMaterial', { Text = 'Preferred material', Values = { 'ForceField', 'Neon', 'Plastic' }, Default = 1, Callback = function(Value) end })
HitEffectsGroup:AddToggle('DisableHitMarker', { Text = 'Disable hit marker', Callback = function(Value) end })
HitEffectsGroup:AddToggle('DisableDamageNumbers', { Text = 'Disable damage numbers', Callback = function(Value) end })

local TargetHudGroup = Tabs.visuals:AddRightGroupbox('Target hud')
TargetHudGroup:AddToggle('TargetHudEnabled', { Text = 'Enabled', Callback = function(Value) end })
TargetHudGroup:AddSlider('TargetHudOffsetX', { Text = 'Offset X', Default = 50, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })
TargetHudGroup:AddSlider('TargetHudOffsetY', { Text = 'Offset Y', Default = 15, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })
TargetHudGroup:AddSlider('TargetHudItemScale', { Text = 'Item scale', Default = 180, Min = 0, Max = 300, Rounding = 0, Suffix = '%', Callback = function(Value) end })
TargetHudGroup:AddSlider('TargetHudUiScale', { Text = 'UI scale', Default = 50, Min = 0, Max = 100, Rounding = 0, Suffix = '%', Callback = function(Value) end })
TargetHudGroup:AddDropdown('TargetHudShowTargets', { Text = 'Show targets', Values = { 'Ragebot', 'Aimbot', 'All' }, Default = 1, Callback = function(Value) end })

local AutoLoadGroup = Tabs.Misc:AddLeftGroupbox('Auto load')
AutoLoadGroup:AddToggle('AutoLoadEnabled', { Text = 'Enabled', Callback = function(Value) end })
AutoLoadGroup:AddToggle('SilentMode', { Text = 'Silent mode', Callback = function(Value) end })

local LoadoutGroup = Tabs.Misc:AddLeftGroupbox('Loadout')
LoadoutGroup:AddToggle('AutoSelect', { Text = 'Auto select', Callback = function(Value) end })
LoadoutGroup:AddDropdown('PrimaryWeapon', { Text = 'Primary', Values = { 'Shotgun', 'Rifle', 'Sniper' }, Default = 1, Callback = function(Value) end })
LoadoutGroup:AddDropdown('SecondaryWeapon', { Text = 'Secondary', Values = { 'Shorty', 'Pistol', 'Revolver' }, Default = 1, Callback = function(Value) end })
LoadoutGroup:AddDropdown('MeleeWeapon', { Text = 'Melee', Values = { 'Knife', 'Katana' }, Default = 1, Callback = function(Value) end })
LoadoutGroup:AddDropdown('UtilityWeapon', { Text = 'Utility', Values = { 'Medkit', 'Grenade' }, Default = 1, Callback = function(Value) end })

local ChatSpamGroup = Tabs.Misc:AddLeftGroupbox('Chat spam')
ChatSpamGroup:AddToggle('ChatSpamEnabled', { Text = 'Enabled', Callback = function(Value) end })
ChatSpamGroup:AddToggle('ChatSpamInOrder', { Text = 'In order', Callback = function(Value) end })
ChatSpamGroup:AddDropdown('ChatMode', { Text = 'Chat mode', Values = { 'Custom', 'Random' }, Default = 1, Callback = function(Value) end })
ChatSpamGroup:AddInput('ChatText', { Text = 'Random custom text', Default = '' })
ChatSpamGroup:AddInput('AdditionalChatText', { Text = 'Add custom text', Default = '' })

local QueueGroup = Tabs.Misc:AddRightGroupbox('Auto queue')
QueueGroup:AddToggle('AutoQueueEnabled', { Text = 'Enabled', Callback = function(Value) end })
QueueGroup:AddDropdown('GameMode', { Text = 'Game Mode', Values = { 'ranked 1v1', 'ranked 2v2', 'casual' }, Default = 1, Callback = function(Value) end })

local NameSpooferGroup = Tabs.Misc:AddRightGroupbox('Name spoofer')
NameSpooferGroup:AddToggle('NameSpooferLocal', { Text = 'Local', Callback = function(Value) end })
NameSpooferGroup:AddInput('SpoofedName', { Text = 'Name', Default = '' })
NameSpooferGroup:AddToggle('NameSpooferOther', { Text = 'Other', Callback = function(Value) end })
NameSpooferGroup:AddInput('OtherName', { Text = 'Name', Default = '' })

local ArcadeGroup = Tabs.Misc:AddRightGroupbox('Arcade servers')
ArcadeGroup:AddToggle('AutomaticallyGrabDrops', { Text = 'Automatically grab drops', Callback = function(Value) end })
ArcadeGroup:AddToggle('AutoRespawn', { Text = 'Auto respawn', Callback = function(Value) end })

local NotifyHitGroup = Tabs.Misc:AddRightGroupbox('Notify hit')
NotifyHitGroup:AddToggle('NotifyHitEnabled', { Text = 'Enabled', Callback = function(Value) end })
NotifyHitGroup:AddSlider('NotifyDuration', { Text = 'Notify duration', Default = 2, Min = 0, Max = 10, Rounding = 0, Suffix = 's', Callback = function(Value) end })
NotifyHitGroup:AddInput('RandomNotifyText', { Text = 'Random notify text', Default = 'Hit {NAME} for {DMG} in the {PART}' })
NotifyHitGroup:AddInput('CustomNotifyText', { Text = 'Add custom text', Default = '' })

local MovementGroup = Tabs.character:AddLeftGroupbox('Movement')

MovementGroup:AddToggle('Velocity', {
    Text = 'Velocity',
    Callback = function(Value) end
}):AddKeyPicker('VelocityKeybind', { Default = 'Q', NoUI = true, Text = 'Velocity keybind' })

MovementGroup:AddSlider('VelocitySpeed', {
    Text = 'Velocity speed',
    Default = 50,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

MovementGroup:AddToggle('SlideBoost', {
    Text = 'Slide boost',
    Callback = function(Value) end
}):AddKeyPicker('SlideBoostKeybind', { Default = 'X', NoUI = true, Text = 'Slide boost keybind' })

MovementGroup:AddSlider('SlideBoostAmount', {
    Text = 'Slide boost',
    Default = 2.5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

MovementGroup:AddToggle('DoubleJump', {
    Text = 'Double jump',
    Callback = function(Value) end
}):AddKeyPicker('DoubleJumpKeybind', { Default = 'Space', NoUI = true, Text = 'Double jump keybind' })

MovementGroup:AddSlider('DoubleJumpHeight', {
    Text = 'Double jump height',
    Default = 1.5,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

MovementGroup:AddToggle('MaulSlamMultiplier', {
    Text = 'Maul slam multiplier',
    Callback = function(Value) end
}):AddKeyPicker('MaulSlamKeybind', { Default = 'M', NoUI = true, Text = 'Maul slam keybind' })

MovementGroup:AddSlider('MaulSlamAmount', {
    Text = 'Maul slam multiplier',
    Default = 3.5,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

MovementGroup:AddToggle('InfiniteDoubleJump', {
    Text = 'Infinite double jump',
    Callback = function(Value) end
}):AddKeyPicker('InfiniteDoubleJumpKeybind', { Default = 'J', NoUI = true, Text = 'Infinite jump keybind' })

local AnimationGroup = Tabs.character:AddLeftGroupbox('Animation player')

AnimationGroup:AddToggle('AnimationPlayer', {
    Text = 'Enabled',
    Callback = function(Value) end
}):AddKeyPicker('AnimationPlayerKeybind', { Default = 'P', NoUI = true, Text = 'Animation player keybind' })

AnimationGroup:AddDropdown('AnimationType', {
    Text = 'Animation',
    Values = { 'Custom' },
    Default = 1,
    Callback = function(Value) end
})

AnimationGroup:AddInput('CustomAnimation', {
    Text = 'Custom animation',
    Default = ''
})

AnimationGroup:AddSlider('AnimationSpeed', {
    Text = 'Speed',
    Default = 9.9,
    Min = 0,
    Max = 20,
    Rounding = 1,
    Callback = function(Value) end
})

AnimationGroup:AddSlider('AnimationStart', {
    Text = 'Start',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

AnimationGroup:AddSlider('AnimationEnd', {
    Text = 'End',
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

local CharacterGroup = Tabs.character:AddRightGroupbox('Character')

CharacterGroup:AddToggle('Noclip', {
    Text = 'Noclip',
    Callback = function(Value) end
}):AddKeyPicker('NoclipKeybind', { Default = 'N', NoUI = true, Text = 'Noclip keybind' })

CharacterGroup:AddToggle('Fly', {
    Text = 'Fly',
    Callback = function(Value) end
}):AddKeyPicker('FlyKeybind', { Default = 'F', NoUI = true, Text = 'Fly keybind' })

CharacterGroup:AddSlider('FlySpeed', {
    Text = 'Fly speed',
    Default = 199,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value) end
})

local ThirdPersonGroup = Tabs.character:AddRightGroupbox('Third person')

ThirdPersonGroup:AddToggle('ThirdPerson', {
    Text = 'Enabled',
    Callback = function(Value) end
}):AddKeyPicker('ThirdPersonKeybind', { Default = 'T', NoUI = true, Text = 'Third person keybind' })

local AntiAimGroup = Tabs.character:AddRightGroupbox('Anti aim')

AntiAimGroup:AddToggle('AntiAim', {
    Text = 'Enabled',
    Callback = function(Value) end
}):AddKeyPicker('AntiAimKeybind', { Default = 'Z', NoUI = true, Text = 'Anti aim keybind' })

AntiAimGroup:AddDropdown('AntiAimPitch', {
    Text = 'Pitch',
    Values = { 'Random', 'Up', 'Down', 'Extended' },
    Default = 1,
    Callback = function(Value) end
})

AntiAimGroup:AddDropdown('AntiAimYaw', {
    Text = 'Yaw',
    Values = { 'Random', 'Spin', 'Backward' },
    Default = 1,
    Callback = function(Value) end
})

AntiAimGroup:AddToggle('Underground', {
    Text = 'Underground',
    Callback = function(Value) end
}):AddKeyPicker('UndergroundKeybind', { Default = 'U', NoUI = true, Text = 'Underground keybind' })

for _, Label in next, WindowFrame:GetDescendants() do
    if Label:IsA('TextLabel') and Label:FindFirstChildOfClass('UIListLayout') and Label:FindFirstChildWhichIsA('Frame') then
        Label.Size = UDim2.new(0, 180, 1, 0)
    end
end

for Idx, Option in next, Options do
    if Option.Type == 'KeyPicker' and Idx ~= 'MenuKeybind' then
        Option:SetValue({ 'None', Option.Mode or 'Toggle' })
    end
end

for _, Label in next, WindowFrame:GetDescendants() do
    if Label:IsA('TextLabel') and Label.Text == 'None' then
        Label.Text = '...'
    end
end

local KeybindInputService = game:GetService('UserInputService')
KeybindInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.Escape then
        for Idx, Option in next, Options do
            if Option.Type == 'KeyPicker' and Option.Value == 'Escape' then
                Option:SetValue({ 'None', Option.Mode or 'Toggle' })

                for _, Label in next, WindowFrame:GetDescendants() do
                    if Label:IsA('TextLabel') and Label.Text == 'None' then
                        Label.Text = '...'
                    end
                end
            end
        end
    end
end)

for _, Frame in next, WindowFrame:GetDescendants() do
    if Frame:IsA('Frame') then
        local Layout = Frame:FindFirstChildOfClass('UIListLayout')

        if Layout and Layout.FillDirection == Enum.FillDirection.Horizontal and Frame.AbsoluteSize.Y <= 25 and Layout.AbsoluteContentSize.X > 0 then
            Frame.ClipsDescendants = true

            local TabButtons = {}

            for _, Button in next, Frame:GetChildren() do
                if Button:IsA('Frame') then
                    local ButtonLabel = Button:FindFirstChildWhichIsA('TextLabel')

                    if ButtonLabel then
                        local Indicator = Instance.new('Frame')
                        Indicator.BackgroundColor3 = Library.AccentColor
                        Indicator.BorderSizePixel = 0
                        Indicator.Position = UDim2.new(0, 0, 1, -2)
                        Indicator.Size = UDim2.new(1, 0, 0, 2)
                        Indicator.Visible = false
                        Indicator.ZIndex = 10
                        Indicator.Parent = Button

                        table.insert(TabButtons, { Button = Button, Indicator = Indicator })

                        Button.InputBegan:Connect(function(Input)
                            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                for _, TabButton in next, TabButtons do
                                    TabButton.Indicator.Visible = TabButton.Button == Button
                                end
                            end
                        end)
                    end
                end
            end

            if TabButtons[1] then
                TabButtons[1].Indicator.Visible = true
            end

            break
        end
    end
end

for _, Frame in next, WindowFrame:GetDescendants() do
    if Frame:IsA('Frame') and Frame.Name == 'TabFrame' then
        Frame.ClipsDescendants = true

        if Frame.Parent then
            Frame.Parent.ClipsDescendants = true
        end
    end
end

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton({
    Text = 'Unload',
    Func = function()
        Library:Unload()
    end
})

MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {
    Default = 'RightShift',
    NoUI = true,
    Text = 'Menu keybind'
})

MenuGroup:AddSlider('MenuTransparency', {
    Text = 'Menu transparency',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value)
        WindowFrame.BackgroundTransparency = Value / 100
    end
})

MenuGroup:AddDropdown('MenuKeybindMode', {
    Text = 'Keybind menu mode',
    Values = { 'Toggle', 'Hold' },
    Default = 1,
    Callback = function(Value)
        Options.MenuKeybind.Mode = Value
    end
})

local NotificationsGroup = Tabs['UI Settings']:AddRightGroupbox('Notifications')

NotificationsGroup:AddInput('NotificationText', {
    Text = 'Notification text',
    Default = 'Gumball UI loaded.'
})

NotificationsGroup:AddButton({
    Text = 'Test notification',
    Func = function()
        Library:Notify(Options.NotificationText.Value, 3)
    end
})

local CommunityGroup = Tabs['UI Settings']:AddLeftGroupbox('Community configs')
CommunityGroup:AddLabel('No community configs configured.', true)

Library.ToggleKeybind = Options.MenuKeybind

-- Theme & Config managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')

SaveManager:BuildConfigSection(Tabs['UI Settings'])

ThemeManager.BuiltInThemes['Gumball'] = { 9, {
    FontColor = 'EBF0F5',
    MainColor = '191C22',
    AccentColor = '00BEDC',
    BackgroundColor = '0F1115',
    OutlineColor = '323A44'
} }

ThemeManager.BuiltInThemes['Midnight'] = { 10, {
    FontColor = 'E8F1FF',
    MainColor = '182235',
    AccentColor = '4B8DFF',
    BackgroundColor = '0D1422',
    OutlineColor = '2C405F'
} }

ThemeManager.BuiltInThemes['Crimson'] = { 11, {
    FontColor = 'FFF0F0',
    MainColor = '2A171B',
    AccentColor = 'E34B5F',
    BackgroundColor = '160D10',
    OutlineColor = '573039'
} }

ThemeManager.BuiltInThemes['Emerald'] = { 12, {
    FontColor = 'EEFFF7',
    MainColor = '142820',
    AccentColor = '36D399',
    BackgroundColor = '0B1511',
    OutlineColor = '2D5A49'
} }

ThemeManager.BuiltInThemes['Violet'] = { 13, {
    FontColor = 'F7F1FF',
    MainColor = '241B35',
    AccentColor = 'B27CFF',
    BackgroundColor = '120E1C',
    OutlineColor = '4D3A6B'
} }

ThemeManager.DefaultTheme = 'Gumball'
ThemeManager:ApplyToTab(Tabs['UI Settings'])
ThemeManager:ApplyTheme(Options.ThemeManager_ThemeList.Value)

print('Gumball UI loaded.')
