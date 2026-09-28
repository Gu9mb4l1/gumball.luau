local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Gumball | .gg/gu9mball | Rivals",
   LoadingTitle = "Gumball Enhancement Suite",
   LoadingSubtitle = "by Rivals Research",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "GumballRivals", 
      FileName = "Config"
   },
   Discord = {
      Enabled = true,
      Invite = "gu9mball", -- Discord invite suffix
      RememberJoins = true 
   },
   KeySystem = false -- Set to true if you want a key system later
})

-- [[ COMBAT TAB ]]
local CombatTab = Window:CreateTab("Combat", 4483362458) -- Sword icon

CombatTab:CreateSection("Aimbot Settings")

CombatTab:CreateToggle({
   Name = "Enabled Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value) end,
})

CombatTab:CreateDropdown({
   Name = "Target Part",
   Options = {"Head", "HumanoidRootPart", "Torso"},
   CurrentOption = {"Head"},
   MultipleOptions = false,
   Flag = "TargetPart",
   Callback = function(Option) end,
})

CombatTab:CreateSlider({
   Name = "Aimbot Smoothness",
   Range = {1, 20},
   Increment = 1,
   Suffix = "Smooth",
   CurrentValue = 5,
   Flag = "AimSmooth",
   Callback = function(Value) end,
})

CombatTab:CreateSection("Silent Aim")

CombatTab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Flag = "SilentAim",
   Callback = function(Value) end,
})

CombatTab:CreateSlider({
   Name = "Field of View (FOV)",
   Range = {0, 800},
   Increment = 10,
   Suffix = "px",
   CurrentValue = 150,
   Flag = "FOVSize",
   Callback = function(Value) end,
})

-- [[ VISUALS TAB ]]
local VisualsTab = Window:CreateTab("Visuals", 4483345998) -- Eye icon

VisualsTab:CreateSection("ESP Players")

VisualsTab:CreateToggle({
   Name = "Box ESP",
   CurrentValue = false,
   Flag = "BoxESP",
   Callback = function(Value) end,
})

VisualsTab:CreateToggle({
   Name = "Tracers",
   CurrentValue = false,
   Flag = "Tracers",
   Callback = function(Value) end,
})

VisualsTab:CreateToggle({
   Name = "Name Tags",
   CurrentValue = false,
   Flag = "Names",
   Callback = function(Value) end,
})

VisualsTab:CreateColorPicker({
    Name = "ESP Color",
    Color = Color3.fromRGB(255, 0, 0),
    Flag = "ESPColor",
    Callback = function(Value) end
})

-- [[ MOVEMENT TAB ]]
local MoveTab = Window:CreateTab("Movement", 4483362175) -- Walk icon

MoveTab:CreateSection("Local Player")

MoveTab:CreateSlider({
   Name = "WalkSpeed Multiplier",
   Range = {16, 150},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WS",
   Callback = function(Value) end,
})

MoveTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 250},
   Increment = 5,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JP",
   Callback = function(Value) end,
})

MoveTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value) end,
})

-- [[ MISC / SETTINGS TAB ]]
local SettingsTab = Window:CreateTab("Settings", 4483362748) -- Gear icon

SettingsTab:CreateSection("Menu Config")

SettingsTab:CreateKeybind({
   Name = "Menu Bind",
   CurrentKeybind = "RightShift",
   HoldToInteract = false,
   Flag = "MenuBind",
   Callback = function(Keybind)
      Rayfield:Notify({
         Title = "Menu Keybind",
         Content = "Menu bind changed to: " .. Keybind,
         Duration = 3,
         Image = 4483362748,
      })
   end,
})

SettingsTab:CreateButton({
   Name = "Destroy Menu",
   Callback = function()
      Rayfield:Destroy()
   end,
})

Rayfield:LoadConfiguration()
