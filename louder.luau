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
    Size = UDim2.fromOffset(620, 500),
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local DefaultWidth = 620
local DefaultHeight = 500
local MinimumWidth = DefaultWidth - 150
local MinimumHeight = DefaultHeight - 150
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
        local ResizeHandle = Instance.new('TextButton')
        local UserInputService = game:GetService('UserInputService')
        local Resizing = false
        local StartMousePosition
        local StartWindowSize
        local ResizeChangedConnection
        local ResizeEndedConnection
        local SizeConnection

        ResizeHandle.Active = true
        ResizeHandle.AutoButtonColor = true
        ResizeHandle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ResizeHandle.BackgroundTransparency = 0.1
        ResizeHandle.BorderSizePixel = 0
        ResizeHandle.Size = UDim2.new(0, 14, 0, 14)
        ResizeHandle.Position = UDim2.new(1, -14, 1, -14)
        ResizeHandle.Text = ''
        ResizeHandle.ZIndex = 10
        ResizeHandle.Parent = WindowFrame

        local ResizeStroke = Instance.new('UIStroke')
        ResizeStroke.Color = Library.AccentColor
        ResizeStroke.Thickness = 1
        ResizeStroke.Transparency = 0.2
        ResizeStroke.Parent = ResizeHandle

        local ResizeLineA = Instance.new('Frame')
        ResizeLineA.BackgroundColor3 = Library.AccentColor
        ResizeLineA.BorderSizePixel = 0
        ResizeLineA.Position = UDim2.new(1, -4, 1, -8)
        ResizeLineA.Size = UDim2.new(0, 2, 0, 8)
        ResizeLineA.Rotation = 45
        ResizeLineA.ZIndex = 11
        ResizeLineA.Parent = ResizeHandle

        local ResizeLineB = Instance.new('Frame')
        ResizeLineB.BackgroundColor3 = Library.AccentColor
        ResizeLineB.BorderSizePixel = 0
        ResizeLineB.Position = UDim2.new(1, -7, 1, -8)
        ResizeLineB.Size = UDim2.new(0, 2, 0, 8)
        ResizeLineB.Rotation = 45
        ResizeLineB.ZIndex = 11
        ResizeLineB.Parent = ResizeHandle

        local ResizeLineC = Instance.new('Frame')
        ResizeLineC.BackgroundColor3 = Library.AccentColor
        ResizeLineC.BorderSizePixel = 0
        ResizeLineC.Position = UDim2.new(1, -10, 1, -8)
        ResizeLineC.Size = UDim2.new(0, 2, 0, 8)
        ResizeLineC.Rotation = 45
        ResizeLineC.ZIndex = 11
        ResizeLineC.Parent = ResizeHandle

        ResizeHandle.MouseEnter:Connect(function()
            ResizeHandle.BackgroundColor3 = Color3.fromRGB(0, 75, 85)
        end)

        ResizeHandle.MouseLeave:Connect(function()
            ResizeHandle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        end)

        ResizeHandle.MouseButton1Down:Connect(function()
            if not WindowFrame.Parent then
                return
            end

            Resizing = true
            StartMousePosition = UserInputService:GetMouseLocation()
            StartWindowSize = Vector2.new(
                math.clamp(WindowFrame.AbsoluteSize.X, MinimumWidth, DefaultWidth),
                math.clamp(WindowFrame.AbsoluteSize.Y, MinimumHeight, DefaultHeight)
            )
        end)

        ResizeChangedConnection = UserInputService.InputChanged:Connect(function(Input)
            if Resizing and Input.UserInputType == Enum.UserInputType.MouseMovement then
                if not WindowFrame.Parent then
                    Resizing = false
                    return
                end

                local MousePosition = UserInputService:GetMouseLocation()
                local Width = math.clamp(StartWindowSize.X + MousePosition.X - StartMousePosition.X, MinimumWidth, DefaultWidth)
                local Height = math.clamp(StartWindowSize.Y + MousePosition.Y - StartMousePosition.Y, MinimumHeight, DefaultHeight)

                pcall(function()
                    WindowFrame.Size = UDim2.fromOffset(Width, Height)
                end)
            end
        end)

        SizeConnection = WindowFrame:GetPropertyChangedSignal('Size'):Connect(function()
            local Width = WindowFrame.Size.X.Offset
            local Height = WindowFrame.Size.Y.Offset
            local LimitedWidth = math.clamp(Width, MinimumWidth, DefaultWidth)
            local LimitedHeight = math.clamp(Height, MinimumHeight, DefaultHeight)

            if Width ~= LimitedWidth or Height ~= LimitedHeight then
                WindowFrame.Size = UDim2.fromOffset(LimitedWidth, LimitedHeight)
            end
        end)

        ResizeEndedConnection = UserInputService.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                Resizing = false
            end
        end)

        WindowFrame.AncestryChanged:Connect(function(_, Parent)
            if not Parent then
                Resizing = false
                ResizeChangedConnection:Disconnect()
                ResizeEndedConnection:Disconnect()
                SizeConnection:Disconnect()
            end
        end)

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

for _, Frame in next, WindowFrame:GetDescendants() do
    if Frame:IsA('Frame') then
        local Layout = Frame:FindFirstChildOfClass('UIListLayout')

        if Layout and Layout.FillDirection == Enum.FillDirection.Horizontal and Frame.AbsoluteSize.Y <= 25 and Layout.AbsoluteContentSize.X > 0 then
            Frame.ClipsDescendants = true
            DefaultWidth = Layout.AbsoluteContentSize.X + 58
            MinimumWidth = DefaultWidth - 150
            WindowFrame.Size = UDim2.fromOffset(DefaultWidth, DefaultHeight)

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
