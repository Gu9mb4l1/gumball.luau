-- Gumball UI
-- Gumball - .gg/gu9mball

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

--==============================================================
-- LIBRARY COLORS
--==============================================================

Library.MainColor = Color3.fromRGB(25, 28, 34)
Library.BackgroundColor = Color3.fromRGB(15, 17, 21)
Library.AccentColor = Color3.fromRGB(0, 190, 220)
Library.FontColor = Color3.fromRGB(235, 240, 245)
Library.Font = Enum.Font.Gotham

--==============================================================
-- WINDOW
--==============================================================

local DefaultWidth = 520
local DefaultHeight = 450

local Window = Library:CreateWindow({
    Title = 'Gumball - .gg/gu9mball',
    Center = true,
    AutoShow = true,
    Size = UDim2.fromOffset(DefaultWidth, DefaultHeight),
    TabPadding = 6,
    MenuFadeTime = 0.2
})

local WindowFrame

--==============================================================
-- FIND WINDOW FRAME / TITLE
--==============================================================

for _, Object in next, Library.ScreenGui:GetDescendants() do
    if Object:IsA('TextLabel')
        and Object.Text == 'Gumball - .gg/gu9mball' then

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

--==============================================================
-- TABS
--==============================================================

local Tabs = {
    Main = Window:AddTab('Main'),
    World = Window:AddTab('World'),
    ESP = Window:AddTab('ESP'),
    visuals = Window:AddTab('visuals'),
    character = Window:AddTab('character'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

--==============================================================
-- MAIN
--==============================================================

local SilentAimGroup = Tabs.Main:AddLeftGroupbox('Silent aim')

SilentAimGroup:AddToggle('SilentAimEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

SilentAimGroup:AddToggle('SilentAimManipulation', {
    Text = 'Manipulation',
    Callback = function(Value) end
})

SilentAimGroup:AddToggle('SilentAimClosestPart', {
    Text = 'Closest part',
    Callback = function(Value) end
})

SilentAimGroup:AddToggle('SilentAimVisualize', {
    Text = 'Visualize',
    Callback = function(Value) end
})

SilentAimGroup:AddToggle('SilentAimShowFov', {
    Text = 'Show fov',
    Callback = function(Value) end
})

SilentAimGroup:AddToggle('SilentAimOutline', {
    Text = 'Outline',
    Callback = function(Value) end
})

SilentAimGroup:AddToggle('SilentAimFill', {
    Text = 'Fill',
    Callback = function(Value) end
})

SilentAimGroup:AddSlider('SilentAimFov', {
    Text = 'Fov',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

SilentAimGroup:AddSlider('SilentAimRadius', {
    Text = 'Radius',
    Default = 0,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Suffix = 'px',
    Callback = function(Value) end
})

SilentAimGroup:AddSlider('SilentAimHitChance', {
    Text = 'Hit chance',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

--==============================================================
-- TARGETING
--==============================================================

local TargetingGroup = Tabs.Main:AddLeftGroupbox('Targeting')

TargetingGroup:AddToggle('TargetVisibleOnly', {
    Text = 'Visible only',
    Callback = function(Value) end
})

TargetingGroup:AddToggle('TargetIgnoreProtected', {
    Text = 'Ignore protected',
    Callback = function(Value) end
})

TargetingGroup:AddDropdown('TargetIgnoreIf', {
    Text = 'Ignore if',
    Values = {
        'Katana deflecting',
        'Invulnerable',
        'Teammate'
    },
    Default = 1,
    Callback = function(Value) end
})

TargetingGroup:AddToggle('TargetDisableFlash', {
    Text = 'Disable on flash',
    Callback = function(Value) end
})

TargetingGroup:AddSlider('TargetReactionTime', {
    Text = 'Reaction time',
    Default = 0,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Suffix = 'ms',
    Callback = function(Value) end
})

TargetingGroup:AddSlider('TargetForgetTime', {
    Text = 'Forget time',
    Default = 0,
    Min = 0,
    Max = 60,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

TargetingGroup:AddDropdown('TargetPart', {
    Text = 'Target part',
    Values = {
        'Head',
        'HumanoidRootPart',
        'UpperTorso'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- AIMBOT
--==============================================================

local AimbotGroup = Tabs.Main:AddRightGroupbox('Aimbot')

AimbotGroup:AddToggle('AimbotEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

AimbotGroup:AddToggle('AimbotManipulation', {
    Text = 'Manipulation',
    Callback = function(Value) end
})

AimbotGroup:AddToggle('AimbotClosestPart', {
    Text = 'Closest part',
    Callback = function(Value) end
})

AimbotGroup:AddToggle('AimbotVisualize', {
    Text = 'Visualize',
    Callback = function(Value) end
})

AimbotGroup:AddSlider('AimbotSmoothing', {
    Text = 'Smoothing',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(Value) end
})

AimbotGroup:AddSlider('AimbotFov', {
    Text = 'Fov',
    Default = 0,
    Min = 0,
    Max = 180,
    Rounding = 0,
    Callback = function(Value) end
})

--==============================================================
-- TRIGGERBOT
--==============================================================

local TriggerbotGroup = Tabs.Main:AddRightGroupbox('Triggerbot')

TriggerbotGroup:AddToggle('TriggerbotEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

TriggerbotGroup:AddSlider('TriggerReactionTime', {
    Text = 'Reaction time',
    Default = 0,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Suffix = 'ms',
    Callback = function(Value) end
})

TriggerbotGroup:AddSlider('TriggerReactionOffset', {
    Text = 'Reaction time offset',
    Default = 0,
    Min = 0,
    Max = 500,
    Rounding = 0,
    Suffix = 'ms',
    Callback = function(Value) end
})

TriggerbotGroup:AddSlider('TriggerForgetTime', {
    Text = 'Forget time',
    Default = 0,
    Min = 0,
    Max = 60,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

TriggerbotGroup:AddSlider('TriggerMaxDistance', {
    Text = 'Max distance',
    Default = 0,
    Min = 0,
    Max = 1000,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

TriggerbotGroup:AddDropdown('TriggerPartBlacklist', {
    Text = 'Part blacklist',
    Values = {
        'HumanoidRootPart, UpperTorso',
        'Head',
        'Legs'
    },
    Default = 1,
    Callback = function(Value) end
})

TriggerbotGroup:AddDropdown('TriggerSettings', {
    Text = 'Settings',
    Values = {
        'No delay between targets',
        'Default'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- WEAPONS
--==============================================================

local WeaponsGroup = Tabs.Main:AddRightGroupbox('Weapons')

WeaponsGroup:AddToggle('NoSpread', {
    Text = 'No spread',
    Callback = function(Value) end
})

WeaponsGroup:AddToggle('FullAuto', {
    Text = 'Full auto',
    Callback = function(Value) end
})

WeaponsGroup:AddToggle('AlwaysBackstab', {
    Text = 'Always backstab',
    Callback = function(Value) end
})

WeaponsGroup:AddDropdown('GrenadeOptions', {
    Text = 'Grenade options',
    Values = {
        'Explode on throw',
        'Default'
    },
    Default = 1,
    Callback = function(Value) end
})

WeaponsGroup:AddSlider('FireRate', {
    Text = 'Firerate',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

WeaponsGroup:AddDropdown('RagebotPriority', {
    Text = 'Ragebot priority',
    Values = {
        'Distance',
        'Health',
        'Crosshair'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- WORLD
--==============================================================

local ColorCorrectionGroup =
    Tabs.World:AddLeftGroupbox('Color correction')

ColorCorrectionGroup:AddToggle('ColorCorrectionEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

ColorCorrectionGroup:AddSlider('Saturation', {
    Text = 'Saturation',
    Default = 0,
    Min = -1,
    Max = 1,
    Rounding = 1,
    Callback = function(Value) end
})

ColorCorrectionGroup:AddSlider('Contrast', {
    Text = 'Contrast',
    Default = 0,
    Min = -1,
    Max = 1,
    Rounding = 1,
    Callback = function(Value) end
})

ColorCorrectionGroup:AddSlider('Brightness', {
    Text = 'Brightness',
    Default = 0,
    Min = -1,
    Max = 1,
    Rounding = 1,
    Callback = function(Value) end
})

--==============================================================
-- LIGHTING
--==============================================================

local LightingGroup = Tabs.World:AddLeftGroupbox('Lighting')

LightingGroup:AddToggle('Ambient', {
    Text = 'Ambient',
    Callback = function(Value) end
})

LightingGroup:AddToggle('ColorShiftBottom', {
    Text = 'ColorShift_Bottom',
    Callback = function(Value) end
})

LightingGroup:AddToggle('ColorShiftTop', {
    Text = 'ColorShift_Top',
    Callback = function(Value) end
})

LightingGroup:AddToggle('FogColor', {
    Text = 'FogColor',
    Callback = function(Value) end
})

LightingGroup:AddToggle('FogEnd', {
    Text = 'FogEnd',
    Callback = function(Value) end
})

LightingGroup:AddToggle('FogStart', {
    Text = 'FogStart',
    Callback = function(Value) end
})

LightingGroup:AddToggle('ExposureCompensation', {
    Text = 'ExposureCompensation',
    Callback = function(Value) end
})

LightingGroup:AddSlider('ExposureValue', {
    Text = 'ExposureCompensation',
    Default = 0,
    Min = -5,
    Max = 5,
    Rounding = 0,
    Callback = function(Value) end
})

LightingGroup:AddToggle('GlobalShadows', {
    Text = 'GlobalShadows',
    Callback = function(Value) end
})

--==============================================================
-- SKYBOX
--==============================================================

local SkyboxGroup = Tabs.World:AddRightGroupbox('Skybox')

SkyboxGroup:AddToggle('SkyboxEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

SkyboxGroup:AddDropdown('SkyboxSelected', {
    Text = 'Selected',
    Values = {
        'Galaxy',
        'Default'
    },
    Default = 1,
    Callback = function(Value) end
})

SkyboxGroup:AddDropdown('SkyboxDisable', {
    Text = 'Disable',
    Values = {
        'Sun, moon',
        'None'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- BLOOM
--==============================================================

local BloomGroup = Tabs.World:AddRightGroupbox('Bloom')

BloomGroup:AddToggle('BloomEnabled', {
    Text = 'Enable',
    Callback = function(Value) end
})

BloomGroup:AddSlider('BloomIntensity', {
    Text = 'Intensity',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(Value) end
})

BloomGroup:AddSlider('BloomSize', {
    Text = 'Size',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Callback = function(Value) end
})

BloomGroup:AddSlider('BloomThreshold', {
    Text = 'Threshold',
    Default = 0,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Callback = function(Value) end
})

--==============================================================
-- CAMERA
--==============================================================

local CameraGroup = Tabs.World:AddRightGroupbox('Camera')

CameraGroup:AddToggle('AntiFlashbang', {
    Text = 'Anti flashbang',
    Callback = function(Value) end
})

CameraGroup:AddToggle('FovChanger', {
    Text = 'Fov changer',
    Callback = function(Value) end
})

CameraGroup:AddSlider('CameraFov', {
    Text = 'Fov',
    Default = 30,
    Min = 30,
    Max = 120,
    Rounding = 0,
    Callback = function(Value) end
})

CameraGroup:AddToggle('AspectRatio', {
    Text = 'Aspect ratio',
    Callback = function(Value) end
})

CameraGroup:AddSlider('RatioX', {
    Text = 'Ratio X',
    Default = 0.1,
    Min = 0.1,
    Max = 2,
    Rounding = 2,
    Callback = function(Value) end
})

CameraGroup:AddSlider('RatioY', {
    Text = 'Ratio Y',
    Default = 0.1,
    Min = 0.1,
    Max = 2,
    Rounding = 2,
    Callback = function(Value) end
})

CameraGroup:AddSlider('CameraBlur', {
    Text = 'Blur',
    Default = 0,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(Value) end
})

--==============================================================
-- ESP
--==============================================================

local EspOptionsGroup =
    Tabs.ESP:AddLeftGroupbox('Options')

EspOptionsGroup:AddToggle('EspBox', {
    Text = 'Box',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspMovingRotation', {
    Text = 'Moving rotation',
    Callback = function(Value) end
})

EspOptionsGroup:AddSlider('EspRotation', {
    Text = 'Rotation',
    Default = 0,
    Min = 0,
    Max = 360,
    Rounding = 0,
    Suffix = ' deg',
    Callback = function(Value) end
})

EspOptionsGroup:AddSlider('EspRotationSpeed', {
    Text = 'Speed',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Suffix = 'rps',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspFill', {
    Text = 'Fill',
    Callback = function(Value) end
})

EspOptionsGroup:AddDropdown('EspFillImage', {
    Text = 'Fill image',
    Values = {
        'Default',
        'Gradient'
    },
    Default = 1,
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspSkeleton', {
    Text = 'Skeleton',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspOutline', {
    Text = 'Outline',
    Callback = function(Value) end
})

EspOptionsGroup:AddSlider('EspThickness', {
    Text = 'Thickness',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 0,
    Suffix = 'px',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspName', {
    Text = 'Name',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspWeapon', {
    Text = 'Weapon',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspDistance', {
    Text = 'Distance',
    Callback = function(Value) end
})

EspOptionsGroup:AddToggle('EspHealthbar', {
    Text = 'Healthbar',
    Callback = function(Value) end
})

--==============================================================
-- ESP APPEARANCE
--==============================================================

local EspAppearanceGroup =
    Tabs.ESP:AddRightGroupbox('Override appearance')

EspAppearanceGroup:AddToggle('EspAppearanceEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

EspAppearanceGroup:AddToggle('EspColor', {
    Text = 'Color',
    Callback = function(Value) end
})

EspAppearanceGroup:AddDropdown('EspMaterial', {
    Text = 'Material',
    Values = {
        'ForceField',
        'Neon',
        'Plastic'
    },
    Default = 1,
    Callback = function(Value) end
})

EspAppearanceGroup:AddDropdown('EspDisable', {
    Text = 'Disable',
    Values = {
        'None',
        'Team check'
    },
    Default = 1,
    Callback = function(Value) end
})

EspAppearanceGroup:AddSlider('EspTransparency', {
    Text = 'Transparency',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

--==============================================================
-- HIGHLIGHT
--==============================================================

local HighlightGroup =
    Tabs.ESP:AddRightGroupbox('Highlight')

HighlightGroup:AddToggle('HighlightEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

HighlightGroup:AddSlider('HighlightFillTransparency', {
    Text = 'Fill transparency',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

HighlightGroup:AddSlider('HighlightOutlineTransparency', {
    Text = 'Outline transparency',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

--==============================================================
-- ESP CUSTOMIZATION
--==============================================================

local EspCustomizationGroup =
    Tabs.ESP:AddRightGroupbox('Customization')

EspCustomizationGroup:AddToggle('IncludeTeammates', {
    Text = 'Include teammates',
    Callback = function(Value) end
})

EspCustomizationGroup:AddDropdown('BoundingMode', {
    Text = 'Bounding mode',
    Values = {
        'Dynamic',
        'Static'
    },
    Default = 1,
    Callback = function(Value) end
})

EspCustomizationGroup:AddSlider('FixedWidthScale', {
    Text = 'Fixed width scale',
    Default = 0,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

EspCustomizationGroup:AddDropdown('EspFont', {
    Text = 'Font',
    Values = {
        'Monocraft',
        'Gotham',
        'Code'
    },
    Default = 1,
    Callback = function(Value) end
})

EspCustomizationGroup:AddInput('NameType', {
    Text = 'Name type',
    Default = 'Name'
})

--==============================================================
-- VISUALS / VIEWMODEL
--==============================================================

local ViewmodelGroup =
    Tabs.visuals:AddLeftGroupbox('Viewmodel')

ViewmodelGroup:AddToggle('ShowCosmeticsChanger', {
    Text = 'Show cosmetics changer',
    Callback = function(Value) end
})

ViewmodelGroup:AddDropdown('MuzzleFlash', {
    Text = 'Muzzle flash',
    Values = {
        'Default',
        'Disabled'
    },
    Default = 1,
    Callback = function(Value) end
})

ViewmodelGroup:AddToggle('OverrideFps', {
    Text = 'Override fps',
    Callback = function(Value) end
})

ViewmodelGroup:AddSlider('RecoilPercent', {
    Text = 'Recoil percent',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

ViewmodelGroup:AddToggle('ViewmodelChams', {
    Text = 'Chams',
    Callback = function(Value) end
})

ViewmodelGroup:AddSlider('ViewmodelFillTransparency', {
    Text = 'Fill transparency',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

ViewmodelGroup:AddSlider('ViewmodelOutlineTransparency', {
    Text = 'Outline transparency',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

ViewmodelGroup:AddDropdown('ThroughWalls', {
    Text = 'Through walls',
    Values = {
        'Default',
        'Enabled'
    },
    Default = 1,
    Callback = function(Value) end
})

ViewmodelGroup:AddSlider('ViewmodelOffsetX', {
    Text = 'Offset X',
    Default = 0,
    Min = -2,
    Max = 2,
    Rounding = 1,
    Callback = function(Value) end
})

ViewmodelGroup:AddSlider('ViewmodelOffsetY', {
    Text = 'Offset Y',
    Default = 0,
    Min = -2,
    Max = 2,
    Rounding = 1,
    Callback = function(Value) end
})

ViewmodelGroup:AddSlider('ViewmodelOffsetZ', {
    Text = 'Offset Z',
    Default = 0,
    Min = -2,
    Max = 2,
    Rounding = 1,
    Callback = function(Value) end
})

--==============================================================
-- HIT EFFECTS
--==============================================================

local HitEffectsGroup =
    Tabs.visuals:AddRightGroupbox('Hit effects')

HitEffectsGroup:AddToggle('HitEffectsEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

HitEffectsGroup:AddToggle('WeldToPlayer', {
    Text = 'Weld to player',
    Callback = function(Value) end
})

HitEffectsGroup:AddDropdown('FortniteDamage', {
    Text = 'Fortnite damage',
    Values = {
        'Slashes',
        'Numbers',
        'Default'
    },
    Default = 1,
    Callback = function(Value) end
})

HitEffectsGroup:AddDropdown('HitEffectSettings', {
    Text = 'Effect settings',
    Values = {
        'Default',
        'Custom'
    },
    Default = 1,
    Callback = function(Value) end
})

HitEffectsGroup:AddDropdown('PreferredMaterial', {
    Text = 'Preferred material',
    Values = {
        'ForceField',
        'Neon',
        'Plastic'
    },
    Default = 1,
    Callback = function(Value) end
})

HitEffectsGroup:AddToggle('DisableHitMarker', {
    Text = 'Disable hit marker',
    Callback = function(Value) end
})

HitEffectsGroup:AddToggle('DisableDamageNumbers', {
    Text = 'Disable damage numbers',
    Callback = function(Value) end
})

--==============================================================
-- TARGET HUD
--==============================================================

local TargetHudGroup =
    Tabs.visuals:AddRightGroupbox('Target hud')

TargetHudGroup:AddToggle('TargetHudEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

TargetHudGroup:AddSlider('TargetHudOffsetX', {
    Text = 'Offset X',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

TargetHudGroup:AddSlider('TargetHudOffsetY', {
    Text = 'Offset Y',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

TargetHudGroup:AddSlider('TargetHudItemScale', {
    Text = 'Item scale',
    Default = 0,
    Min = 0,
    Max = 300,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

TargetHudGroup:AddSlider('TargetHudUiScale', {
    Text = 'UI scale',
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

TargetHudGroup:AddDropdown('TargetHudShowTargets', {
    Text = 'Show targets',
    Values = {
        'Ragebot',
        'Aimbot',
        'All'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- MISC
--==============================================================

local AutoLoadGroup =
    Tabs.Misc:AddLeftGroupbox('Auto load')

AutoLoadGroup:AddToggle('AutoLoadEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

AutoLoadGroup:AddToggle('SilentMode', {
    Text = 'Silent mode',
    Callback = function(Value) end
})

--==============================================================
-- LOADOUT
--==============================================================

local LoadoutGroup =
    Tabs.Misc:AddLeftGroupbox('Loadout')

LoadoutGroup:AddToggle('AutoSelect', {
    Text = 'Auto select',
    Callback = function(Value) end
})

LoadoutGroup:AddDropdown('PrimaryWeapon', {
    Text = 'Primary',
    Values = {
        'Shotgun',
        'Rifle',
        'Sniper'
    },
    Default = 1,
    Callback = function(Value) end
})

LoadoutGroup:AddDropdown('SecondaryWeapon', {
    Text = 'Secondary',
    Values = {
        'Shorty',
        'Pistol',
        'Revolver'
    },
    Default = 1,
    Callback = function(Value) end
})

LoadoutGroup:AddDropdown('MeleeWeapon', {
    Text = 'Melee',
    Values = {
        'Knife',
        'Katana'
    },
    Default = 1,
    Callback = function(Value) end
})

LoadoutGroup:AddDropdown('UtilityWeapon', {
    Text = 'Utility',
    Values = {
        'Medkit',
        'Grenade'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- CHAT SPAM
--==============================================================

local ChatSpamGroup =
    Tabs.Misc:AddLeftGroupbox('Chat spam')

ChatSpamGroup:AddToggle('ChatSpamEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

ChatSpamGroup:AddToggle('ChatSpamInOrder', {
    Text = 'In order',
    Callback = function(Value) end
})

ChatSpamGroup:AddDropdown('ChatMode', {
    Text = 'Chat mode',
    Values = {
        'Custom',
        'Random'
    },
    Default = 1,
    Callback = function(Value) end
})

ChatSpamGroup:AddInput('ChatText', {
    Text = 'Random custom text',
    Default = ''
})

ChatSpamGroup:AddInput('AdditionalChatText', {
    Text = 'Add custom text',
    Default = ''
})

--==============================================================
-- AUTO QUEUE
--==============================================================

local QueueGroup =
    Tabs.Misc:AddRightGroupbox('Auto queue')

QueueGroup:AddToggle('AutoQueueEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

QueueGroup:AddDropdown('GameMode', {
    Text = 'Game Mode',
    Values = {
        'ranked 1v1',
        'ranked 2v2',
        'casual'
    },
    Default = 1,
    Callback = function(Value) end
})

--==============================================================
-- NAME SPOOFER
--==============================================================

local NameSpooferGroup =
    Tabs.Misc:AddRightGroupbox('Name spoofer')

NameSpooferGroup:AddToggle('NameSpooferLocal', {
    Text = 'Local',
    Callback = function(Value) end
})

NameSpooferGroup:AddInput('SpoofedName', {
    Text = 'Name',
    Default = ''
})

NameSpooferGroup:AddToggle('NameSpooferOther', {
    Text = 'Other',
    Callback = function(Value) end
})

NameSpooferGroup:AddInput('OtherName', {
    Text = 'Name',
    Default = ''
})

--==============================================================
-- ARCADE
--==============================================================

local ArcadeGroup =
    Tabs.Misc:AddRightGroupbox('Arcade servers')

ArcadeGroup:AddToggle('AutomaticallyGrabDrops', {
    Text = 'Automatically grab drops',
    Callback = function(Value) end
})

ArcadeGroup:AddToggle('AutoRespawn', {
    Text = 'Auto respawn',
    Callback = function(Value) end
})

--==============================================================
-- NOTIFY HIT
--==============================================================

local NotifyHitGroup =
    Tabs.Misc:AddRightGroupbox('Notify hit')

NotifyHitGroup:AddToggle('NotifyHitEnabled', {
    Text = 'Enabled',
    Callback = function(Value) end
})

NotifyHitGroup:AddSlider('NotifyDuration', {
    Text = 'Notify duration',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

NotifyHitGroup:AddInput('RandomNotifyText', {
    Text = 'Random notify text',
    Default = 'Hit {NAME} for {DMG} in the {PART}'
})

NotifyHitGroup:AddInput('CustomNotifyText', {
    Text = 'Add custom text',
    Default = ''
})

--==============================================================
-- CHARACTER / MOVEMENT
--==============================================================

local MovementGroup =
    Tabs.character:AddLeftGroupbox('Movement')

MovementGroup:AddToggle('Velocity', {
    Text = 'Velocity',
    Callback = function(Value) end
}):AddKeyPicker('VelocityKeybind', {
    Default = 'Q',
    NoUI = true,
    Text = 'Velocity keybind'
})

MovementGroup:AddSlider('VelocitySpeed', {
    Text = 'Velocity speed',
    Default = 0,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

MovementGroup:AddToggle('SlideBoost', {
    Text = 'Slide boost',
    Callback = function(Value) end
}):AddKeyPicker('SlideBoostKeybind', {
    Default = 'X',
    NoUI = true,
    Text = 'Slide boost keybind'
})

MovementGroup:AddSlider('SlideBoostAmount', {
    Text = 'Slide boost',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

MovementGroup:AddToggle('DoubleJump', {
    Text = 'Double jump',
    Callback = function(Value) end
}):AddKeyPicker('DoubleJumpKeybind', {
    Default = 'Space',
    NoUI = true,
    Text = 'Double jump keybind'
})

MovementGroup:AddSlider('DoubleJumpHeight', {
    Text = 'Double jump height',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

MovementGroup:AddToggle('MaulSlamMultiplier', {
    Text = 'Maul slam multiplier',
    Callback = function(Value) end
}):AddKeyPicker('MaulSlamKeybind', {
    Default = 'M',
    NoUI = true,
    Text = 'Maul slam keybind'
})

MovementGroup:AddSlider('MaulSlamAmount', {
    Text = 'Maul slam multiplier',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Suffix = 'x',
    Callback = function(Value) end
})

MovementGroup:AddToggle('InfiniteDoubleJump', {
    Text = 'Infinite double jump',
    Callback = function(Value) end
}):AddKeyPicker('InfiniteDoubleJumpKeybind', {
    Default = 'J',
    NoUI = true,
    Text = 'Infinite jump keybind'
})

--==============================================================
-- ANIMATION
--==============================================================

local AnimationGroup =
    Tabs.character:AddLeftGroupbox('Animation player')

AnimationGroup:AddToggle('AnimationPlayer', {
    Text = 'Enabled',
    Callback = function(Value) end
}):AddKeyPicker('AnimationPlayerKeybind', {
    Default = 'P',
    NoUI = true,
    Text = 'Animation player keybind'
})

AnimationGroup:AddDropdown('AnimationType', {
    Text = 'Animation',
    Values = {
        'Custom'
    },
    Default = 1,
    Callback = function(Value) end
})

AnimationGroup:AddInput('CustomAnimation', {
    Text = 'Custom animation',
    Default = ''
})

AnimationGroup:AddSlider('AnimationSpeed', {
    Text = 'Speed',
    Default = 0,
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
    Default = 0,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = '%',
    Callback = function(Value) end
})

--==============================================================
-- CHARACTER
--==============================================================

local CharacterGroup =
    Tabs.character:AddRightGroupbox('Character')

CharacterGroup:AddToggle('Noclip', {
    Text = 'Noclip',
    Callback = function(Value) end
}):AddKeyPicker('NoclipKeybind', {
    Default = 'N',
    NoUI = true,
    Text = 'Noclip keybind'
})

CharacterGroup:AddToggle('Fly', {
    Text = 'Fly',
    Callback = function(Value) end
}):AddKeyPicker('FlyKeybind', {
    Default = 'F',
    NoUI = true,
    Text = 'Fly keybind'
})

CharacterGroup:AddSlider('FlySpeed', {
    Text = 'Fly speed',
    Default = 0,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Callback = function(Value) end
})

--==============================================================
-- THIRD PERSON
--==============================================================

local ThirdPersonGroup =
    Tabs.character:AddRightGroupbox('Third person')

ThirdPersonGroup:AddToggle('ThirdPerson', {
    Text = 'Enabled',
    Callback = function(Value) end
}):AddKeyPicker('ThirdPersonKeybind', {
    Default = 'T',
    NoUI = true,
    Text = 'Third person keybind'
})

--==============================================================
-- ANTI AIM
--==============================================================

local AntiAimGroup =
    Tabs.character:AddRightGroupbox('Anti aim')

AntiAimGroup:AddToggle('AntiAim', {
    Text = 'Enabled',
    Callback = function(Value) end
}):AddKeyPicker('AntiAimKeybind', {
    Default = 'Z',
    NoUI = true,
    Text = 'Anti aim keybind'
})

AntiAimGroup:AddDropdown('AntiAimPitch', {
    Text = 'Pitch',
    Values = {
        'Random',
        'Up',
        'Down',
        'Extended'
    },
    Default = 1,
    Callback = function(Value) end
})

AntiAimGroup:AddDropdown('AntiAimYaw', {
    Text = 'Yaw',
    Values = {
        'Random',
        'Spin',
        'Backward'
    },
    Default = 1,
    Callback = function(Value) end
})

AntiAimGroup:AddToggle('Underground', {
    Text = 'Underground',
    Callback = function(Value) end
}):AddKeyPicker('UndergroundKeybind', {
    Default = 'U',
    NoUI = true,
    Text = 'Underground keybind'
})

--==============================================================
-- UI SETTINGS
--==============================================================

local MenuGroup =
    Tabs['UI Settings']:AddLeftGroupbox('Menu')

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
        if WindowFrame then
            WindowFrame.BackgroundTransparency = Value / 100
        end
    end
})

MenuGroup:AddDropdown('MenuKeybindMode', {
    Text = 'Keybind menu mode',
    Values = {
        'Toggle',
        'Hold'
    },
    Default = 1,
    Callback = function(Value)
        if Options.MenuKeybind then
            Options.MenuKeybind.Mode = Value
        end
    end
})

MenuGroup:AddSlider('MenuWidth', {
    Text = 'Menu width',
    Default = DefaultWidth,
    Min = 460,
    Max = 620,
    Rounding = 0,
    Suffix = 'px',
    Callback = function(Value)
        if WindowFrame then
            WindowFrame.Size = UDim2.fromOffset(
                Value,
                WindowFrame.Size.Y.Offset
            )
        end
    end
})

MenuGroup:AddSlider('MenuHeight', {
    Text = 'Menu height',
    Default = DefaultHeight,
    Min = 380,
    Max = 600,
    Rounding = 0,
    Suffix = 'px',
    Callback = function(Value)
        if WindowFrame then
            WindowFrame.Size = UDim2.fromOffset(
                WindowFrame.Size.X.Offset,
                Value
            )
        end
    end
})

--==============================================================
-- UI QUALITY
--==============================================================

local UIQualityGroup =
    Tabs['UI Settings']:AddLeftGroupbox('UI quality')

UIQualityGroup:AddToggle('CompactUI', {
    Text = 'Compact UI',
    Callback = function(Value)
        if not WindowFrame then
            return
        end

        if Value then
            WindowFrame.Size = UDim2.fromOffset(500, 420)
        else
            WindowFrame.Size = UDim2.fromOffset(
                DefaultWidth,
                DefaultHeight
            )
        end
    end
})

UIQualityGroup:AddToggle('SmoothScrolling', {
    Text = 'Smooth scrolling',
    Default = true,
    Callback = function(Value)
        for _, Scrolling in next, WindowFrame:GetDescendants() do
            if Scrolling:IsA('ScrollingFrame') then
                if Value then
                    Scrolling.ElasticBehavior =
                        Enum.ElasticBehavior.WhenScrollable
                else
                    Scrolling.ElasticBehavior =
                        Enum.ElasticBehavior.Never
                end
            end
        end
    end
})

UIQualityGroup:AddSlider('ScrollBarSize', {
    Text = 'Scrollbar size',
    Default = 4,
    Min = 2,
    Max = 8,
    Rounding = 0,
    Suffix = 'px',
    Callback = function(Value)
        for _, Scrolling in next, WindowFrame:GetDescendants() do
            if Scrolling:IsA('ScrollingFrame') then
                Scrolling.ScrollBarThickness = Value
            end
        end
    end
})

--==============================================================
-- NOTIFICATIONS
--==============================================================

local NotificationsGroup =
    Tabs['UI Settings']:AddRightGroupbox('Notifications')

NotificationsGroup:AddToggle('NotificationsEnabled', {
    Text = 'Enabled',
    Default = true,
    Callback = function(Value) end
})

NotificationsGroup:AddSlider('NotificationDuration', {
    Text = 'Duration',
    Default = 3,
    Min = 1,
    Max = 10,
    Rounding = 0,
    Suffix = 's',
    Callback = function(Value) end
})

NotificationsGroup:AddInput('NotificationText', {
    Text = 'Notification text',
    Default = 'Gumball UI loaded.'
})

NotificationsGroup:AddButton({
    Text = 'Test notification',
    Func = function()
        if Options.NotificationsEnabled
            and not Options.NotificationsEnabled.Value then
            return
        end

        local Duration = 3

        if Options.NotificationDuration then
            Duration = Options.NotificationDuration.Value
        end

        Library:Notify(
            Options.NotificationText.Value,
            Duration
        )
    end
})

--==============================================================
-- COMMUNITY
--==============================================================

local CommunityGroup =
    Tabs['UI Settings']:AddRightGroupbox('Community')

CommunityGroup:AddLabel(
    'Gumball Community',
    true
)

CommunityGroup:AddLabel(
    'discord.gg/gu9mball',
    true
)

CommunityGroup:AddButton({
    Text = 'Copy Discord invite',
    Func = function()
        if setclipboard then
            setclipboard('https://discord.gg/gu9mball')
            Library:Notify(
                'Discord invite copied.',
                3
            )
        else
            Library:Notify(
                'Clipboard is unavailable.',
                3
            )
        end
    end
})

--==============================================================
-- THEME / CONFIG MANAGERS
--==============================================================

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({
    'MenuKeybind'
})

ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')

--==============================================================
-- BUILT-IN THEMES
--==============================================================

ThemeManager.BuiltInThemes['Gumball'] = {
    9,
    {
        FontColor = 'EBF0F5',
        MainColor = '191C22',
        AccentColor = '00BEDC',
        BackgroundColor = '0F1115',
        OutlineColor = '323A44'
    }
}

ThemeManager.BuiltInThemes['Midnight'] = {
    10,
    {
        FontColor = 'E8F1FF',
        MainColor = '182235',
        AccentColor = '4B8DFF',
        BackgroundColor = '0D1422',
        OutlineColor = '2C405F'
    }
}

ThemeManager.BuiltInThemes['Crimson'] = {
    11,
    {
        FontColor = 'FFF0F0',
        MainColor = '2A171B',
        AccentColor = 'E34B5F',
        BackgroundColor = '160D10',
        OutlineColor = '573039'
    }
}

ThemeManager.BuiltInThemes['Emerald'] = {
    12,
    {
        FontColor = 'EEFFF7',
        MainColor = '142820',
        AccentColor = '36D399',
        BackgroundColor = '0B1511',
        OutlineColor = '2D5A49'
    }
}

ThemeManager.BuiltInThemes['Violet'] = {
    13,
    {
        FontColor = 'F7F1FF',
        MainColor = '241B35',
        AccentColor = 'B27CFF',
        BackgroundColor = '120E1C',
        OutlineColor = '4D3A6B'
    }
}

ThemeManager.BuiltInThemes['Carbon'] = {
    14,
    {
        FontColor = 'F2F2F2',
        MainColor = '202020',
        AccentColor = 'A8A8A8',
        BackgroundColor = '101010',
        OutlineColor = '3A3A3A'
    }
}

ThemeManager.BuiltInThemes['Ocean'] = {
    15,
    {
        FontColor = 'EAFBFF',
        MainColor = '13242B',
        AccentColor = '24B7E6',
        BackgroundColor = '091419',
        OutlineColor = '28515F'
    }
}

ThemeManager.BuiltInThemes['Rose'] = {
    16,
    {
        FontColor = 'FFF1F7',
        MainColor = '2B1924',
        AccentColor = 'F06AA6',
        BackgroundColor = '160D12',
        OutlineColor = '58364A'
    }
}

ThemeManager.DefaultTheme = 'Gumball'

--==============================================================
-- CONFIG SECTION
--==============================================================

SaveManager:BuildConfigSection(
    Tabs['UI Settings']
)

--==============================================================
-- THEME SECTION
--==============================================================

ThemeManager:ApplyToTab(
    Tabs['UI Settings']
)

--==============================================================
-- CUSTOM THEME EDITOR
--==============================================================

local ThemeEditor =
    Tabs['UI Settings']:AddLeftGroupbox('Theme editor')

ThemeEditor:AddLabel(
    'Customize the Gumball menu theme.',
    true
)

ThemeEditor:AddLabel('Background'):AddColorPicker(
    'GumballEditorBackground',
    {
        Default = Color3.fromRGB(15, 17, 21),
        Callback = function(Color)
            if Options.BackgroundColor then
                Options.BackgroundColor:SetValueRGB(Color)
            end
        end
    }
)

ThemeEditor:AddLabel('Main'):AddColorPicker(
    'GumballEditorMain',
    {
        Default = Color3.fromRGB(25, 28, 34),
        Callback = function(Color)
            if Options.MainColor then
                Options.MainColor:SetValueRGB(Color)
            end
        end
    }
)

ThemeEditor:AddLabel('Accent'):AddColorPicker(
    'GumballEditorAccent',
    {
        Default = Color3.fromRGB(0, 190, 220),
        Callback = function(Color)
            if Options.AccentColor then
                Options.AccentColor:SetValueRGB(Color)
            end
        end
    }
)

ThemeEditor:AddLabel('Outline'):AddColorPicker(
    'GumballEditorOutline',
    {
        Default = Color3.fromRGB(50, 58, 68),
        Callback = function(Color)
            if Options.OutlineColor then
                Options.OutlineColor:SetValueRGB(Color)
            end
        end
    }
)

ThemeEditor:AddLabel('Font'):AddColorPicker(
    'GumballEditorFont',
    {
        Default = Color3.fromRGB(235, 240, 245),
        Callback = function(Color)
            if Options.FontColor then
                Options.FontColor:SetValueRGB(Color)
            end
        end
    }
)

ThemeEditor:AddInput('GumballThemeName', {
    Text = 'Theme name',
    Default = 'MyTheme'
})

ThemeEditor:AddButton({
    Text = 'Save current theme',
    Func = function()
        local Name = Options.GumballThemeName.Value

        if not Name
            or Name:gsub('%s+', '') == '' then

            return Library:Notify(
                'Enter a theme name first.',
                3
            )
        end

        ThemeManager:SaveCustomTheme(Name)

        if Options.ThemeManager_CustomThemeList then
            Options.ThemeManager_CustomThemeList:SetValues(
                ThemeManager:ReloadCustomThemes()
            )
        end

        Library:Notify(
            'Saved custom theme: ' .. Name,
            3
        )
    end
})

ThemeEditor:AddButton({
    Text = 'Apply Gumball default',
    Func = function()
        ThemeManager:ApplyTheme('Gumball')

        Library:Notify(
            'Gumball theme applied.',
            3
        )
    end
})

--==============================================================
-- CUSTOM THEME ACTIONS
--==============================================================

local CustomThemeActions =
    Tabs['UI Settings']:AddRightGroupbox(
        'Custom theme actions'
    )

CustomThemeActions:AddLabel(
    'Manage saved custom themes.',
    true
)

CustomThemeActions:AddButton({
    Text = 'Refresh themes',
    Func = function()
        if Options.ThemeManager_CustomThemeList then
            Options.ThemeManager_CustomThemeList:SetValues(
                ThemeManager:ReloadCustomThemes()
            )

            Options.ThemeManager_CustomThemeList:SetValue(nil)
        end

        Library:Notify(
            'Custom themes refreshed.',
            2
        )
    end
})

CustomThemeActions:AddButton({
    Text = 'Load selected theme',
    Func = function()
        local ThemeName =
            Options.ThemeManager_CustomThemeList
            and Options.ThemeManager_CustomThemeList.Value

        if not ThemeName or ThemeName == '' then
            return Library:Notify(
                'Select a custom theme first.',
                3
            )
        end

        ThemeManager:ApplyTheme(ThemeName)

        Library:Notify(
            'Loaded theme: ' .. ThemeName,
            3
        )
    end
})

CustomThemeActions:AddButton({
    Text = 'Delete selected theme',
    Func = function()
        local ThemeName =
            Options.ThemeManager_CustomThemeList
            and Options.ThemeManager_CustomThemeList.Value

        if not ThemeName or ThemeName == '' then
            return Library:Notify(
                'Select a custom theme first.',
                3
            )
        end

        -- ReloadCustomThemes() returns the filename,
        -- so don't append another ".json".
        local ThemePath =
            ThemeManager.Folder ..
            '/themes/' ..
            ThemeName

        if isfile(ThemePath) then
            delfile(ThemePath)

            Options.ThemeManager_CustomThemeList:SetValues(
                ThemeManager:ReloadCustomThemes()
            )

            Options.ThemeManager_CustomThemeList:SetValue(nil)

            Library:Notify(
                'Deleted theme: ' .. ThemeName,
                3
            )
        else
            Library:Notify(
                'Theme file not found.',
                3
            )
        end
    end
})

--==============================================================
-- KEYBINDS
--==============================================================

for Idx, Option in next, Options do
    if Option.Type == 'KeyPicker'
        and Idx ~= 'MenuKeybind' then

        Option:SetValue({
            'None',
            Option.Mode or 'Toggle'
        })
    end
end

for _, Label in next, WindowFrame:GetDescendants() do
    if Label:IsA('TextLabel')
        and Label.Text == 'None' then

        Label.Text = '...'
    end
end

--==============================================================
-- ROBUST SCROLLING SYSTEM
--==============================================================

local function SetupScrolling(Scrolling)
    if not Scrolling
        or not Scrolling:IsA('ScrollingFrame') then
        return
    end

    Scrolling.Active = true
    Scrolling.Selectable = true
    Scrolling.ScrollingEnabled = true

    -- THIS IS THE IMPORTANT FIX.
    --
    -- The old code manually calculated CanvasSize from one
    -- UIListLayout. That can stop the scrollbar before the
    -- final nested setting.
    --
    -- AutomaticSize lets Roblox calculate the full content.
    Scrolling.AutomaticCanvasSize =
        Enum.AutomaticSize.Y

    Scrolling.CanvasSize =
        UDim2.new(0, 0, 0, 0)

    Scrolling.ScrollingDirection =
        Enum.ScrollingDirection.Y

    Scrolling.ScrollBarThickness = 4
    Scrolling.ScrollBarImageColor3 =
        Library.AccentColor
    Scrolling.ScrollBarImageTransparency = 0.15

    Scrolling.ElasticBehavior =
        Enum.ElasticBehavior.WhenScrollable

    Scrolling.ClipsDescendants = true

    local Layout =
        Scrolling:FindFirstChildOfClass(
            'UIListLayout'
        )

    if Layout then
        Layout:GetPropertyChangedSignal(
            'AbsoluteContentSize'
        ):Connect(function()

            task.defer(function()
                if not Scrolling
                    or not Scrolling.Parent then
                    return
                end

                Scrolling.AutomaticCanvasSize =
                    Enum.AutomaticSize.Y
            end)
        end)
    end
end

local function SetupAllScrolling()
    if not WindowFrame then
        return
    end

    for _, Object in next,
        WindowFrame:GetDescendants() do

        if Object:IsA('ScrollingFrame') then
            SetupScrolling(Object)
        end
    end
end

-- Initial setup
SetupAllScrolling()

-- Handle scrolling frames created later.
if WindowFrame then
    WindowFrame.DescendantAdded:Connect(
        function(Object)

            if Object:IsA('ScrollingFrame') then
                task.defer(function()
                    SetupScrolling(Object)
                end)
            end
        end
    )
end

--==============================================================
-- SCROLL REFRESH
--==============================================================

local function RefreshScrolling()
    if not WindowFrame then
        return
    end

    for _, Scrolling in next,
        WindowFrame:GetDescendants() do

        if Scrolling:IsA('ScrollingFrame') then
            Scrolling.AutomaticCanvasSize =
                Enum.AutomaticSize.Y

            Scrolling.CanvasSize =
                UDim2.new(0, 0, 0, 0)

            Scrolling.ScrollBarThickness = 4

            Scrolling.ScrollBarImageColor3 =
                Library.AccentColor
        end
    end
end

--==============================================================
-- ESCAPE = CLEAR KEYBIND
--==============================================================

local KeybindInputService =
    game:GetService('UserInputService')

KeybindInputService.InputBegan:Connect(
    function(Input, GameProcessed)

        if GameProcessed then
            return
        end

        if Input.KeyCode == Enum.KeyCode.Escape then

            for Idx, Option in next, Options do
                if Option.Type == 'KeyPicker'
                    and Option.Value == 'Escape' then

                    Option:SetValue({
                        'None',
                        Option.Mode or 'Toggle'
                    })
                end
            end

            for _, Label in next,
                WindowFrame:GetDescendants() do

                if Label:IsA('TextLabel')
                    and Label.Text == 'None' then

                    Label.Text = '...'
                end
            end
        end
    end
)

--==============================================================
-- TAB INDICATORS
--==============================================================

for _, Frame in next,
    WindowFrame:GetDescendants() do

    if Frame:IsA('Frame') then

        local Layout =
            Frame:FindFirstChildOfClass(
                'UIListLayout'
            )

        if Layout
            and Layout.FillDirection ==
                Enum.FillDirection.Horizontal
            and Frame.AbsoluteSize.Y <= 30
            and Layout.AbsoluteContentSize.X > 0 then

            Frame.ClipsDescendants = true

            local TabButtons = {}

            for _, Button in next,
                Frame:GetChildren() do

                if Button:IsA('Frame') then

                    local ButtonLabel =
                        Button:FindFirstChildWhichIsA(
                            'TextLabel'
                        )

                    if ButtonLabel then

                        local Indicator =
                            Instance.new('Frame')

                        Indicator.Name =
                            'GumballTabIndicator'

                        Indicator.BackgroundColor3 =
                            Library.AccentColor

                        Indicator.BorderSizePixel = 0

                        Indicator.Position =
                            UDim2.new(
                                0,
                                0,
                                1,
                                -2
                            )

                        Indicator.Size =
                            UDim2.new(
                                1,
                                0,
                                0,
                                2
                            )

                        Indicator.Visible = false
                        Indicator.ZIndex = 10
                        Indicator.Parent = Button

                        table.insert(
                            TabButtons,
                            {
                                Button = Button,
                                Indicator = Indicator
                            }
                        )

                        Button.InputBegan:Connect(
                            function(Input)

                                if Input.UserInputType ==
                                    Enum.UserInputType.MouseButton1 then

                                    for _, TabButton in next,
                                        TabButtons do

                                        TabButton.Indicator.Visible =
                                            TabButton.Button ==
                                            Button
                                    end
                                end
                            end
                        )
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

--==============================================================
-- TAB CLIPPING
--==============================================================

for _, Frame in next,
    WindowFrame:GetDescendants() do

    if Frame:IsA('Frame')
        and Frame.Name == 'TabFrame' then

        Frame.ClipsDescendants = true

        if Frame.Parent then
            Frame.Parent.ClipsDescendants = true
        end
    end
end

--==============================================================
-- WINDOW LABEL WIDTH
--==============================================================

for _, Label in next,
    WindowFrame:GetDescendants() do

    if Label:IsA('TextLabel')
        and Label:FindFirstChildOfClass(
            'UIListLayout'
        )
        and Label:FindFirstChildWhichIsA('Frame') then

        Label.Size =
            UDim2.new(
                0,
                180,
                1,
                0
            )
    end
end

--==============================================================
-- FINAL UI REFRESH
--==============================================================

task.defer(function()

    task.wait(0.15)

    SetupAllScrolling()
    RefreshScrolling()

    for _, Scrolling in next,
        WindowFrame:GetDescendants() do

        if Scrolling:IsA('ScrollingFrame') then
            Scrolling.ScrollBarImageColor3 =
                Library.AccentColor
        end
    end
end)

--==============================================================
-- LIBRARY TOGGLE
--==============================================================

Library.ToggleKeybind =
    Options.MenuKeybind

--==============================================================
-- FINISHED
--==============================================================

print('Gumball UI loaded successfully.')
