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
    Size = UDim2.fromOffset(720, 600),
    TabPadding = 5,
    MenuFadeTime = 0.2
})

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

        ResizeHandle.Active = true
        ResizeHandle.AutoButtonColor = true
        ResizeHandle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ResizeHandle.BackgroundTransparency = 0.1
        ResizeHandle.BorderSizePixel = 0
        ResizeHandle.Size = UDim2.new(0, 14, 0, 14)
        ResizeHandle.Position = UDim2.new(1, -14, 1, -14)
        ResizeHandle.Font = Enum.Font.SourceSansBold
        ResizeHandle.Text = '+'
        ResizeHandle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ResizeHandle.TextSize = 13
        ResizeHandle.TextStrokeTransparency = 0.5
        ResizeHandle.ZIndex = 10
        ResizeHandle.Parent = WindowFrame

        ResizeHandle.MouseButton1Down:Connect(function()
            if not WindowFrame.Parent then
                return
            end

            Resizing = true
            StartMousePosition = UserInputService:GetMouseLocation()
            StartWindowSize = WindowFrame.AbsoluteSize
        end)

        ResizeChangedConnection = UserInputService.InputChanged:Connect(function(Input)
            if Resizing and Input.UserInputType == Enum.UserInputType.MouseMovement then
                if not WindowFrame.Parent then
                    Resizing = false
                    return
                end

                local MousePosition = UserInputService:GetMouseLocation()
                local Width = math.clamp(StartWindowSize.X + MousePosition.X - StartMousePosition.X, 400, 1000)
                local Height = math.clamp(StartWindowSize.Y + MousePosition.Y - StartMousePosition.Y, 300, 800)

                pcall(function()
                    WindowFrame.Size = UDim2.fromOffset(Width, Height)
                end)
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

for _, Frame in next, WindowFrame:GetDescendants() do
    if Frame:IsA('Frame') then
        local Layout = Frame:FindFirstChildOfClass('UIListLayout')

        if Layout and Layout.FillDirection == Enum.FillDirection.Horizontal and Frame.AbsoluteSize.Y <= 25 then
            Frame.ClipsDescendants = true
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

Library.ToggleKeybind = Options.MenuKeybind

-- Theme & Config managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('Gumball')
SaveManager:SetFolder('Gumball')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

print('Gumball UI loaded.')
