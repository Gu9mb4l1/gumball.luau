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
    Size = UDim2.fromOffset(560, 450),
    TabPadding = 6,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    World = Window:AddTab('World'),
    ESP = Window:AddTab('ESP'),
    visuals = Window:AddTab('visuals'),
    character = Window:AddTab('character'),
    Misc = Window:AddTab('Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local function findWindowFrame()
    if not Library.ScreenGui then
        return nil
    end

    for _, Object in next, Library.ScreenGui:GetDescendants() do
        if Object:IsA('TextLabel') and Object.Text == 'Gumball - .gg/gu9mball' then
            return Object.Parent and Object.Parent.Parent or nil
        end
    end

    return nil
end

local function styleTitle()
    if not Library.ScreenGui then
        return
    end

    for _, Object in next, Library.ScreenGui:GetDescendants() do
        if Object:IsA('TextLabel') and Object.Text == 'Gumball - .gg/gu9mball' then
            Object.Position = UDim2.new(0, 0, 0, 0)
            Object.Size = UDim2.new(1, 0, 0, 25)
            Object.Font = Enum.Font.GothamBold
            Object.TextSize = 16
            Object.TextXAlignment = Enum.TextXAlignment.Center
            Object.TextColor3 = Color3.fromRGB(245, 250, 255)
            break
        end
    end
end

local function addResizeGrip(targetFrame)
    if not targetFrame or targetFrame:FindFirstChild('GumballResizeGrip') then
        return
    end

    local grip = Instance.new('Frame')
    grip.Name = 'GumballResizeGrip'
    grip.AnchorPoint = Vector2.new(1, 1)
    grip.Position = UDim2.new(1, -8, 1, -8)
    grip.Size = UDim2.new(0, 18, 0, 18)
    grip.BackgroundColor3 = Color3.fromRGB(35, 40, 48)
    grip.BorderSizePixel = 0
    grip.Parent = targetFrame

    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(0, 5)
    corner.Parent = grip

    local button = Instance.new('TextButton')
    button.Size = UDim2.new(1, 0, 1, 0)
    button.AutoButtonColor = false
    button.BackgroundTransparency = 1
    button.Text = ''
    button.Parent = grip

    local dragging = false
    local startMouse = Vector2.zero
    local startSize = targetFrame.Size

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startMouse = input.Position
            startSize = targetFrame.Size
        end
    end)

    button.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    button.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startMouse
            local newWidth = startSize.X.Offset + delta.X
            local newHeight = startSize.Y.Offset + delta.Y
            newWidth = math.clamp(newWidth, 540, 900)
            newHeight = math.clamp(newHeight, 380, 760)
            targetFrame.Size = UDim2.new(startSize.X.Scale, newWidth, startSize.Y.Scale, newHeight)
        end
    end)
end

local function fixScrollFrames(root)
    if not root then
        return
    end

    for _, Scrolling in next, root:GetDescendants() do
        if Scrolling:IsA('ScrollingFrame') then
            Scrolling.Active = true
            Scrolling.ScrollingEnabled = true
            Scrolling.ScrollBarThickness = 4
            Scrolling.ScrollBarImageColor3 = Library.AccentColor
            Scrolling.ClipsDescendants = true

            local Layout = Scrolling:FindFirstChildOfClass('UIListLayout')
            if Layout then
                local function UpdateCanvas()
                    Scrolling.CanvasSize = UDim2.fromOffset(0, Layout.AbsoluteContentSize.Y + 20)
                end

                Layout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(UpdateCanvas)
                task.defer(UpdateCanvas)
            end
        end
    end
end

task.defer(function()
    local frame = findWindowFrame()
    if frame then
        frame.ClipsDescendants = true
        styleTitle()
        addResizeGrip(frame)
        fixScrollFrames(frame)
    end
end)

local SilentAimGroup = Tabs.Main:AddLeftGroupbox('Silent aim')
SilentAimGroup:AddToggle('SilentAimEnabled', { Text = 'Enabled' })
SilentAimGroup:AddToggle('SilentAimManipulation', { Text = 'Manipulation' })
SilentAimGroup:AddToggle('SilentAimClosestPart', { Text = 'Closest part' })
SilentAimGroup:AddToggle('SilentAimVisualize', { Text = 'Visualize' })
SilentAimGroup:AddToggle('SilentAimShowFov', { Text = 'Show fov' })
SilentAimGroup:AddToggle('SilentAimOutline', { Text = 'Outline' })
SilentAimGroup:AddToggle('SilentAimFill', { Text = 'Fill' })
SilentAimGroup:AddSlider('SilentAimFov', { Text = 'Fov', Default = 0, Min = 0, Max = 10, Rounding = 1, Suffix = 'x' })
SilentAimGroup:AddSlider('SilentAimRadius', { Text = 'Radius', Default = 0, Min = 0, Max = 300, Rounding = 0, Suffix = 'px' })
SilentAimGroup:AddSlider('SilentAimHitChance', { Text = 'Hit chance', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })

local TargetingGroup = Tabs.Main:AddLeftGroupbox('Targeting')
TargetingGroup:AddToggle('TargetVisibleOnly', { Text = 'Visible only' })
TargetingGroup:AddToggle('TargetIgnoreProtected', { Text = 'Ignore protected' })
TargetingGroup:AddDropdown('TargetIgnoreIf', { Text = 'Ignore if', Values = { 'Katana deflecting', 'Invulnerable', 'Teammate' }, Default = 1 })
TargetingGroup:AddToggle('TargetDisableFlash', { Text = 'Disable on flash' })
TargetingGroup:AddSlider('TargetReactionTime', { Text = 'Reaction time', Default = 0, Min = 0, Max = 500, Rounding = 0, Suffix = 'ms' })
TargetingGroup:AddSlider('TargetForgetTime', { Text = 'Forget time', Default = 0, Min = 0, Max = 60, Rounding = 0, Suffix = 's' })
TargetingGroup:AddDropdown('TargetPart', { Text = 'Target part', Values = { 'Head', 'HumanoidRootPart', 'UpperTorso' }, Default = 1 })

local AimbotGroup = Tabs.Main:AddRightGroupbox('Aimbot')
AimbotGroup:AddToggle('AimbotEnabled', { Text = 'Enabled' })
AimbotGroup:AddToggle('AimbotManipulation', { Text = 'Manipulation' })
AimbotGroup:AddToggle('AimbotClosestPart', { Text = 'Closest part' })
AimbotGroup:AddToggle('AimbotVisualize', { Text = 'Visualize' })
AimbotGroup:AddSlider('AimbotSmoothing', { Text = 'Smoothing', Default = 0, Min = 0, Max = 10, Rounding = 1 })
AimbotGroup:AddSlider('AimbotFov', { Text = 'Fov', Default = 0, Min = 0, Max = 180, Rounding = 0 })

local TriggerbotGroup = Tabs.Main:AddRightGroupbox('Triggerbot')
TriggerbotGroup:AddToggle('TriggerbotEnabled', { Text = 'Enabled' })
TriggerbotGroup:AddSlider('TriggerReactionTime', { Text = 'Reaction time', Default = 0, Min = 0, Max = 500, Rounding = 0, Suffix = 'ms' })
TriggerbotGroup:AddSlider('TriggerReactionOffset', { Text = 'Reaction time offset', Default = 0, Min = 0, Max = 500, Rounding = 0, Suffix = 'ms' })
TriggerbotGroup:AddSlider('TriggerForgetTime', { Text = 'Forget time', Default = 0, Min = 0, Max = 60, Rounding = 0, Suffix = 's' })
TriggerbotGroup:AddSlider('TriggerMaxDistance', { Text = 'Max distance', Default = 0, Min = 0, Max = 1000, Rounding = 0, Suffix = 's' })
TriggerbotGroup:AddDropdown('TriggerPartBlacklist', { Text = 'Part blacklist', Values = { 'HumanoidRootPart, UpperTorso', 'Head', 'Legs' }, Default = 1 })
TriggerbotGroup:AddDropdown('TriggerSettings', { Text = 'Settings', Values = { 'No delay between targets', 'Default' }, Default = 1 })

local WeaponsGroup = Tabs.Main:AddRightGroupbox('Weapons')
WeaponsGroup:AddToggle('NoSpread', { Text = 'No spread' })
WeaponsGroup:AddToggle('FullAuto', { Text = 'Full auto' })
WeaponsGroup:AddToggle('AlwaysBackstab', { Text = 'Always backstab' })
WeaponsGroup:AddDropdown('GrenadeOptions', { Text = 'Grenade options', Values = { 'Explode on throw', 'Default' }, Default = 1 })
WeaponsGroup:AddSlider('FireRate', { Text = 'Firerate', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
WeaponsGroup:AddDropdown('RagebotPriority', { Text = 'Ragebot priority', Values = { 'Distance', 'Health', 'Crosshair' }, Default = 1 })

local ColorCorrectionGroup = Tabs.World:AddLeftGroupbox('Color correction')
ColorCorrectionGroup:AddToggle('ColorCorrectionEnabled', { Text = 'Enabled' })
ColorCorrectionGroup:AddSlider('Saturation', { Text = 'Saturation', Default = 0, Min = -1, Max = 1, Rounding = 1 })
ColorCorrectionGroup:AddSlider('Contrast', { Text = 'Contrast', Default = 0, Min = -1, Max = 1, Rounding = 1 })
ColorCorrectionGroup:AddSlider('Brightness', { Text = 'Brightness', Default = 0, Min = -1, Max = 1, Rounding = 1 })

local LightingGroup = Tabs.World:AddLeftGroupbox('Lighting')
LightingGroup:AddToggle('Ambient', { Text = 'Ambient' })
LightingGroup:AddToggle('ColorShiftBottom', { Text = 'ColorShift_Bottom' })
LightingGroup:AddToggle('ColorShiftTop', { Text = 'ColorShift_Top' })
LightingGroup:AddToggle('FogColor', { Text = 'FogColor' })
LightingGroup:AddToggle('FogEnd', { Text = 'FogEnd' })
LightingGroup:AddToggle('FogStart', { Text = 'FogStart' })
LightingGroup:AddToggle('ExposureCompensation', { Text = 'ExposureCompensation' })
LightingGroup:AddSlider('ExposureValue', { Text = 'ExposureCompensation', Default = 0, Min = -5, Max = 5, Rounding = 0 })
LightingGroup:AddToggle('GlobalShadows', { Text = 'GlobalShadows' })

local SkyboxGroup = Tabs.World:AddRightGroupbox('Skybox')
SkyboxGroup:AddToggle('SkyboxEnabled', { Text = 'Enabled' })
SkyboxGroup:AddDropdown('SkyboxSelected', { Text = 'Selected', Values = { 'Galaxy', 'Default' }, Default = 1 })
SkyboxGroup:AddDropdown('SkyboxDisable', { Text = 'Disable', Values = { 'Sun, moon', 'None' }, Default = 1 })

local BloomGroup = Tabs.World:AddRightGroupbox('Bloom')
BloomGroup:AddToggle('BloomEnabled', { Text = 'Enable' })
BloomGroup:AddSlider('BloomIntensity', { Text = 'Intensity', Default = 0, Min = 0, Max = 10, Rounding = 0 })
BloomGroup:AddSlider('BloomSize', { Text = 'Size', Default = 0, Min = 0, Max = 100, Rounding = 0 })
BloomGroup:AddSlider('BloomThreshold', { Text = 'Threshold', Default = 0, Min = 0, Max = 1, Rounding = 1 })

local CameraGroup = Tabs.World:AddRightGroupbox('Camera')
CameraGroup:AddToggle('AntiFlashbang', { Text = 'Anti flashbang' })
CameraGroup:AddToggle('FovChanger', { Text = 'Fov changer' })
CameraGroup:AddSlider('CameraFov', { Text = 'Fov', Default = 30, Min = 30, Max = 120, Rounding = 0 })
CameraGroup:AddToggle('AspectRatio', { Text = 'Aspect ratio' })
CameraGroup:AddSlider('RatioX', { Text = 'Ratio X', Default = 0.1, Min = 0.1, Max = 2, Rounding = 2 })
CameraGroup:AddSlider('RatioY', { Text = 'Ratio Y', Default = 0.1, Min = 0.1, Max = 2, Rounding = 2 })
CameraGroup:AddSlider('CameraBlur', { Text = 'Blur', Default = 0, Min = 0, Max = 20, Rounding = 0 })

local EspOptionsGroup = Tabs.ESP:AddLeftGroupbox('Options')
EspOptionsGroup:AddToggle('EspBox', { Text = 'Box' })
EspOptionsGroup:AddToggle('EspMovingRotation', { Text = 'Moving rotation' })
EspOptionsGroup:AddSlider('EspRotation', { Text = 'Rotation', Default = 0, Min = 0, Max = 360, Rounding = 0, Suffix = ' deg' })
EspOptionsGroup:AddSlider('EspRotationSpeed', { Text = 'Speed', Default = 0, Min = 0, Max = 5, Rounding = 1, Suffix = 'rps' })
EspOptionsGroup:AddToggle('EspFill', { Text = 'Fill' })
EspOptionsGroup:AddDropdown('EspFillImage', { Text = 'Fill image', Values = { 'Default', 'Gradient' }, Default = 1 })
EspOptionsGroup:AddToggle('EspSkeleton', { Text = 'Skeleton' })
EspOptionsGroup:AddToggle('EspOutline', { Text = 'Outline' })
EspOptionsGroup:AddSlider('EspThickness', { Text = 'Thickness', Default = 0, Min = 0, Max = 5, Rounding = 0, Suffix = 'px' })
EspOptionsGroup:AddToggle('EspName', { Text = 'Name' })
EspOptionsGroup:AddToggle('EspWeapon', { Text = 'Weapon' })
EspOptionsGroup:AddToggle('EspDistance', { Text = 'Distance' })
EspOptionsGroup:AddToggle('EspHealthbar', { Text = 'Healthbar' })

local EspAppearanceGroup = Tabs.ESP:AddRightGroupbox('Override appearance')
EspAppearanceGroup:AddToggle('EspAppearanceEnabled', { Text = 'Enabled' })
EspAppearanceGroup:AddToggle('EspColor', { Text = 'Color' })
EspAppearanceGroup:AddDropdown('EspMaterial', { Text = 'Material', Values = { 'ForceField', 'Neon', 'Plastic' }, Default = 1 })
EspAppearanceGroup:AddDropdown('EspDisable', { Text = 'Disable', Values = { 'None', 'Team check' }, Default = 1 })
EspAppearanceGroup:AddSlider('EspTransparency', { Text = 'Transparency', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })

local HighlightGroup = Tabs.ESP:AddRightGroupbox('Highlight')
HighlightGroup:AddToggle('HighlightEnabled', { Text = 'Enabled' })
HighlightGroup:AddSlider('HighlightFillTransparency', { Text = 'Fill transparency', Default = 0, Min = 0, Max = 100, Rounding = 0 })
HighlightGroup:AddSlider('HighlightOutlineTransparency', { Text = 'Outline transparency', Default = 0, Min = 0, Max = 100, Rounding = 0 })

local EspCustomizationGroup = Tabs.ESP:AddRightGroupbox('Customization')
EspCustomizationGroup:AddToggle('IncludeTeammates', { Text = 'Include teammates' })
EspCustomizationGroup:AddDropdown('BoundingMode', { Text = 'Bounding mode', Values = { 'Dynamic', 'Static' }, Default = 1 })
EspCustomizationGroup:AddSlider('FixedWidthScale', { Text = 'Fixed width scale', Default = 0, Min = 0, Max = 200, Rounding = 0, Suffix = '%' })
EspCustomizationGroup:AddDropdown('EspFont', { Text = 'Font', Values = { 'Monocraft', 'Gotham', 'Code' }, Default = 1 })
EspCustomizationGroup:AddInput('NameType', { Text = 'Name type', Default = 'Name' })

local ViewmodelGroup = Tabs.visuals:AddLeftGroupbox('Viewmodel')
ViewmodelGroup:AddToggle('ShowCosmeticsChanger', { Text = 'Show cosmetics changer' })
ViewmodelGroup:AddDropdown('MuzzleFlash', { Text = 'Muzzle flash', Values = { 'Default', 'Disabled' }, Default = 1 })
ViewmodelGroup:AddToggle('OverrideFps', { Text = 'Override fps' })
ViewmodelGroup:AddSlider('RecoilPercent', { Text = 'Recoil percent', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
ViewmodelGroup:AddToggle('ViewmodelChams', { Text = 'Chams' })
ViewmodelGroup:AddSlider('ViewmodelFillTransparency', { Text = 'Fill transparency', Default = 0, Min = 0, Max = 100, Rounding = 0 })
ViewmodelGroup:AddSlider('ViewmodelOutlineTransparency', { Text = 'Outline transparency', Default = 0, Min = 0, Max = 100, Rounding = 0 })
ViewmodelGroup:AddDropdown('ThroughWalls', { Text = 'Through walls', Values = { 'Default', 'Enabled' }, Default = 1 })
ViewmodelGroup:AddSlider('ViewmodelOffsetX', { Text = 'Offset X', Default = 0, Min = -2, Max = 2, Rounding = 1 })
ViewmodelGroup:AddSlider('ViewmodelOffsetY', { Text = 'Offset Y', Default = 0, Min = -2, Max = 2, Rounding = 1 })
ViewmodelGroup:AddSlider('ViewmodelOffsetZ', { Text = 'Offset Z', Default = 0, Min = -2, Max = 2, Rounding = 1 })

local HitEffectsGroup = Tabs.visuals:AddRightGroupbox('Hit effects')
HitEffectsGroup:AddToggle('HitEffectsEnabled', { Text = 'Enabled' })
HitEffectsGroup:AddToggle('WeldToPlayer', { Text = 'Weld to player' })
HitEffectsGroup:AddDropdown('FortniteDamage', { Text = 'Fortnite damage', Values = { 'Slashes', 'Numbers', 'Default' }, Default = 1 })
HitEffectsGroup:AddDropdown('HitEffectSettings', { Text = 'Effect settings', Values = { 'Default', 'Custom' }, Default = 1 })
HitEffectsGroup:AddDropdown('PreferredMaterial', { Text = 'Preferred material', Values = { 'ForceField', 'Neon', 'Plastic' }, Default = 1 })
HitEffectsGroup:AddToggle('DisableHitMarker', { Text = 'Disable hit marker' })
HitEffectsGroup:AddToggle('DisableDamageNumbers', { Text = 'Disable damage numbers' })

local TargetHudGroup = Tabs.visuals:AddRightGroupbox('Target hud')
TargetHudGroup:AddToggle('TargetHudEnabled', { Text = 'Enabled' })
TargetHudGroup:AddSlider('TargetHudOffsetX', { Text = 'Offset X', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
TargetHudGroup:AddSlider('TargetHudOffsetY', { Text = 'Offset Y', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
TargetHudGroup:AddSlider('TargetHudItemScale', { Text = 'Item scale', Default = 0, Min = 0, Max = 300, Rounding = 0, Suffix = '%' })
TargetHudGroup:AddSlider('TargetHudUiScale', { Text = 'UI scale', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
TargetHudGroup:AddDropdown('TargetHudShowTargets', { Text = 'Show targets', Values = { 'Ragebot', 'Aimbot', 'All' }, Default = 1 })

local AutoLoadGroup = Tabs.Misc:AddLeftGroupbox('Auto load')
AutoLoadGroup:AddToggle('AutoLoadEnabled', { Text = 'Enabled' })
AutoLoadGroup:AddToggle('SilentMode', { Text = 'Silent mode' })

local LoadoutGroup = Tabs.Misc:AddLeftGroupbox('Loadout')
LoadoutGroup:AddToggle('AutoSelect', { Text = 'Auto select' })
LoadoutGroup:AddDropdown('PrimaryWeapon', { Text = 'Primary', Values = { 'Shotgun', 'Rifle', 'Sniper' }, Default = 1 })
LoadoutGroup:AddDropdown('SecondaryWeapon', { Text = 'Secondary', Values = { 'Shorty', 'Pistol', 'Revolver' }, Default = 1 })
LoadoutGroup:AddDropdown('MeleeWeapon', { Text = 'Melee', Values = { 'Knife', 'Katana' }, Default = 1 })
LoadoutGroup:AddDropdown('UtilityWeapon', { Text = 'Utility', Values = { 'Medkit', 'Grenade' }, Default = 1 })

local ChatSpamGroup = Tabs.Misc:AddLeftGroupbox('Chat spam')
ChatSpamGroup:AddToggle('ChatSpamEnabled', { Text = 'Enabled' })
ChatSpamGroup:AddToggle('ChatSpamInOrder', { Text = 'In order' })
ChatSpamGroup:AddDropdown('ChatMode', { Text = 'Chat mode', Values = { 'Custom', 'Random' }, Default = 1 })
ChatSpamGroup:AddInput('ChatText', { Text = 'Random custom text', Default = '' })
ChatSpamGroup:AddInput('AdditionalChatText', { Text = 'Add custom text', Default = '' })

local QueueGroup = Tabs.Misc:AddRightGroupbox('Auto queue')
QueueGroup:AddToggle('AutoQueueEnabled', { Text = 'Enabled' })
QueueGroup:AddDropdown('GameMode', { Text = 'Game Mode', Values = { 'ranked 1v1', 'ranked 2v2', 'casual' }, Default = 1 })

local NameSpooferGroup = Tabs.Misc:AddRightGroupbox('Name spoofer')
NameSpooferGroup:AddToggle('NameSpooferLocal', { Text = 'Local' })
NameSpooferGroup:AddInput('SpoofedName', { Text = 'Name', Default = '' })
NameSpooferGroup:AddToggle('NameSpooferOther', { Text = 'Other' })
NameSpooferGroup:AddInput('OtherName', { Text = 'Name', Default = '' })

local ArcadeGroup = Tabs.Misc:AddRightGroupbox('Arcade servers')
ArcadeGroup:AddToggle('AutomaticallyGrabDrops', { Text = 'Automatically grab drops' })
ArcadeGroup:AddToggle('AutoRespawn', { Text = 'Auto respawn' })

local NotifyHitGroup = Tabs.Misc:AddRightGroupbox('Notify hit')
NotifyHitGroup:AddToggle('NotifyHitEnabled', { Text = 'Enabled' })
NotifyHitGroup:AddSlider('NotifyDuration', { Text = 'Notify duration', Default = 0, Min = 0, Max = 10, Rounding = 0, Suffix = 's' })
NotifyHitGroup:AddInput('RandomNotifyText', { Text = 'Random notify text', Default = 'Hit {NAME} for {DMG} in the {PART}' })
NotifyHitGroup:AddInput('CustomNotifyText', { Text = 'Add custom text', Default = '' })

local MovementGroup = Tabs.character:AddLeftGroupbox('Movement')
MovementGroup:AddToggle('Velocity', { Text = 'Velocity' }):AddKeyPicker('VelocityKeybind', { Default = 'Q', NoUI = true, Text = 'Velocity keybind' })
MovementGroup:AddSlider('VelocitySpeed', { Text = 'Velocity speed', Default = 0, Min = 0, Max = 200, Rounding = 0, Suffix = 's' })
MovementGroup:AddToggle('SlideBoost', { Text = 'Slide boost' }):AddKeyPicker('SlideBoostKeybind', { Default = 'X', NoUI = true, Text = 'Slide boost keybind' })
MovementGroup:AddSlider('SlideBoostAmount', { Text = 'Slide boost', Default = 0, Min = 0, Max = 10, Rounding = 1, Suffix = 'x' })
MovementGroup:AddToggle('DoubleJump', { Text = 'Double jump' }):AddKeyPicker('DoubleJumpKeybind', { Default = 'Space', NoUI = true, Text = 'Double jump keybind' })
MovementGroup:AddSlider('DoubleJumpHeight', { Text = 'Double jump height', Default = 0, Min = 0, Max = 5, Rounding = 1, Suffix = 'x' })
MovementGroup:AddToggle('MaulSlamMultiplier', { Text = 'Maul slam multiplier' }):AddKeyPicker('MaulSlamKeybind', { Default = 'M', NoUI = true, Text = 'Maul slam keybind' })
MovementGroup:AddSlider('MaulSlamAmount', { Text = 'Maul slam multiplier', Default = 0, Min = 0, Max = 10, Rounding = 1, Suffix = 'x' })
MovementGroup:AddToggle('InfiniteDoubleJump', { Text = 'Infinite double jump' }):AddKeyPicker('InfiniteDoubleJumpKeybind', { Default = 'J', NoUI = true, Text = 'Infinite jump keybind' })

local AnimationGroup = Tabs.character:AddLeftGroupbox('Animation player')
AnimationGroup:AddToggle('AnimationPlayer', { Text = 'Enabled' }):AddKeyPicker('AnimationPlayerKeybind', { Default = 'P', NoUI = true, Text = 'Animation player keybind' })
AnimationGroup:AddDropdown('AnimationType', { Text = 'Animation', Values = { 'Custom' }, Default = 1 })
AnimationGroup:AddInput('CustomAnimation', { Text = 'Custom animation', Default = '' })
AnimationGroup:AddSlider('AnimationSpeed', { Text = 'Speed', Default = 0, Min = 0, Max = 20, Rounding = 1 })
AnimationGroup:AddSlider('AnimationStart', { Text = 'Start', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
AnimationGroup:AddSlider('AnimationEnd', { Text = 'End', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })

local CharacterGroup = Tabs.character:AddRightGroupbox('Character')
CharacterGroup:AddToggle('Noclip', { Text = 'Noclip' }):AddKeyPicker('NoclipKeybind', { Default = 'N', NoUI = true, Text = 'Noclip keybind' })
CharacterGroup:AddToggle('Fly', { Text = 'Fly' }):AddKeyPicker('FlyKeybind', { Default = 'F', NoUI = true, Text = 'Fly keybind' })
CharacterGroup:AddSlider('FlySpeed', { Text = 'Fly speed', Default = 0, Min = 0, Max = 200, Rounding = 0 })

local ThirdPersonGroup = Tabs.character:AddRightGroupbox('Third person')
ThirdPersonGroup:AddToggle('ThirdPerson', { Text = 'Enabled' }):AddKeyPicker('ThirdPersonKeybind', { Default = 'T', NoUI = true, Text = 'Third person keybind' })

local AntiAimGroup = Tabs.character:AddRightGroupbox('Anti aim')
AntiAimGroup:AddToggle('AntiAim', { Text = 'Enabled' }):AddKeyPicker('AntiAimKeybind', { Default = 'Z', NoUI = true, Text = 'Anti aim keybind' })
AntiAimGroup:AddDropdown('AntiAimPitch', { Text = 'Pitch', Values = { 'Random', 'Up', 'Down', 'Extended' }, Default = 1 })
AntiAimGroup:AddDropdown('AntiAimYaw', { Text = 'Yaw', Values = { 'Random', 'Spin', 'Backward' }, Default = 1 })
AntiAimGroup:AddToggle('Underground', { Text = 'Underground' }):AddKeyPicker('UndergroundKeybind', { Default = 'U', NoUI = true, Text = 'Underground keybind' })

-- UI Settings
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton({ Text = 'Unload', Func = function() Library:Unload() end })
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'RightShift', NoUI = true, Text = 'Menu keybind' })
MenuGroup:AddSlider('MenuTransparency', { Text = 'Menu transparency', Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = '%' })
MenuGroup:AddDropdown('MenuKeybindMode', { Text = 'Keybind menu mode', Values = { 'Toggle', 'Hold' }, Default = 1 })

local NotificationsGroup = Tabs['UI Settings']:AddRightGroupbox('Notifications')
NotificationsGroup:AddInput('NotificationText', { Text = 'Notification text', Default = 'Gumball UI loaded.' })
NotificationsGroup:AddButton({
    Text = 'Test notification',
    Func = function()
        Library:Notify(Options.NotificationText.Value, 3)
    end
})

local ThemeGroup = Tabs['UI Settings']:AddRightGroupbox('Theme')
ThemeGroup:AddDropdown('ThemePreset', { Text = 'Theme', Default = 1, Values = { 'Gumball', 'Midnight', 'Crimson', 'Emerald', 'Violet' } })
ThemeGroup:AddInput('CustomThemeName', { Text = 'Theme name', Default = 'MyTheme', Placeholder = 'custom theme name' })
ThemeGroup:AddButton({ Text = 'Create theme', Func = function() print('Create theme') end })
ThemeGroup:AddButton({ Text = 'Load theme', Func = function() print('Load theme') end })
ThemeGroup:AddButton({ Text = 'Delete theme', Func = function() print('Delete theme') end })

local ConfigGroup = Tabs['UI Settings']:AddRightGroupbox('Config')
ConfigGroup:AddButton({ Text = 'Save config', Func = function() print('Save config') end })
ConfigGroup:AddButton({ Text = 'Load config', Func = function() print('Load config') end })
ConfigGroup:AddButton({ Text = 'Delete config', Func = function() print('Delete config') end })

Library.ToggleKeybind = Options.MenuKeybind
Library.KeybindFrame.Visible = true
Library:SetWatermarkVisibility(true)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

ThemeManager.BuiltInThemes = ThemeManager.BuiltInThemes or {}
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

Library:OnUnload(function()
    print('Gumball UI unloaded')
end)

print('Gumball UI loaded.')
