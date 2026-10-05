local loadingStartedAt = os.clock()
local loadingMinimumDuration = 3
local loadingFadeDuration = 0.2
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
loadingOverlay.BackgroundColor3 = Color3.fromRGB(12, 21, 38)
loadingOverlay.BackgroundTransparency = 0
loadingOverlay.BorderSizePixel = 0
loadingOverlay.ZIndex = 1
loadingOverlay.Parent = loadingGui

local loadingBackgroundGradient = Instance.new('UIGradient')
loadingBackgroundGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 46, 76)),
	ColorSequenceKeypoint.new(0.52, Color3.fromRGB(17, 31, 55)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 19, 36))
})
loadingBackgroundGradient.Rotation = 18
loadingBackgroundGradient.Parent = loadingOverlay

local loadingFacetLayer = Instance.new('Frame')
loadingFacetLayer.Name = 'BackgroundFacets'
loadingFacetLayer.Size = UDim2.fromScale(1, 1)
loadingFacetLayer.BackgroundTransparency = 1
loadingFacetLayer.ClipsDescendants = true
loadingFacetLayer.ZIndex = 1
loadingFacetLayer.Parent = loadingOverlay

local loadingFacetSpecs = {
	{ -0.08, 0.12, 0.42, 0.11, -24 },
	{ 0.05, 0.82, 0.48, 0.13, 18 },
	{ 0.94, 0.16, 0.38, 0.10, 22 },
	{ 1.02, 0.78, 0.52, 0.12, -20 },
	{ 0.32, 0.04, 0.28, 0.07, 16 },
	{ 0.70, 0.96, 0.36, 0.08, -17 },
	{ 0.18, 0.46, 0.24, 0.06, -20 },
	{ 0.86, 0.53, 0.30, 0.07, 19 }
}
for index, spec in ipairs(loadingFacetSpecs) do
	local facet = Instance.new('Frame')
	facet.Name = 'Facet' .. index
	facet.AnchorPoint = Vector2.new(0.5, 0.5)
	facet.Position = UDim2.fromScale(spec[1], spec[2])
	facet.Size = UDim2.fromScale(spec[3], spec[4])
	facet.Rotation = spec[5]
	facet.BackgroundColor3 = index % 2 == 0 and Color3.fromRGB(95, 133, 177) or Color3.fromRGB(57, 95, 143)
	facet.BackgroundTransparency = 0.91
	facet.BorderSizePixel = 0
	facet.ZIndex = 1
	facet.Parent = loadingFacetLayer
	TweenService:Create(facet, TweenInfo.new(8 + index, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		Rotation = spec[5] + (index % 2 == 0 and 4 or -4)
	}):Play()
end

for index, ringSize in ipairs({ UDim2.fromOffset(560, 410), UDim2.fromOffset(760, 560) }) do
	local ring = Instance.new('Frame')
	ring.Name = 'OrbitRing' .. index
	ring.AnchorPoint = Vector2.new(0.5, 0.5)
	ring.Position = UDim2.fromScale(0.5, 0.5)
	ring.Size = ringSize
	ring.BackgroundTransparency = 1
	ring.BorderSizePixel = 0
	ring.Rotation = index == 1 and -12 or 14
	ring.ZIndex = 2
	ring.Parent = loadingOverlay
	local ringCorner = Instance.new('UICorner')
	ringCorner.CornerRadius = UDim.new(1, 0)
	ringCorner.Parent = ring
	local ringStroke = Instance.new('UIStroke')
	ringStroke.Color = index == 1 and Color3.fromRGB(92, 205, 202) or Color3.fromRGB(120, 151, 205)
	ringStroke.Transparency = 0.93
	ringStroke.Thickness = 1
	ringStroke.Parent = ring
	TweenService:Create(ring, TweenInfo.new(42 + index * 9, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
		Rotation = ring.Rotation + (index == 1 and 360 or -360)
	}):Play()
end

TweenService:Create(loadingBackgroundGradient, TweenInfo.new(18, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Rotation = 42
}):Play()

local loadingContent = Instance.new('Frame')
loadingContent.Name = 'Content'
loadingContent.AnchorPoint = Vector2.new(0.5, 0.5)
loadingContent.Position = UDim2.fromScale(0.5, 0.5)
loadingContent.Size = UDim2.fromOffset(480, 280)
loadingContent.BackgroundTransparency = 1
loadingContent.ZIndex = 5
loadingContent.Parent = loadingOverlay

local loadingScale = Instance.new('UIScale')
loadingScale.Parent = loadingContent
local loadingCamera = workspace.CurrentCamera
if loadingCamera then
	local viewport = loadingCamera.ViewportSize
	loadingScale.Scale = math.clamp(math.min(viewport.X / 1280, viewport.Y / 720), 0.8, 2)
else
	loadingScale.Scale = 1
end
loadingContent.Size = UDim2.new(0.84 / loadingScale.Scale, 0, 0, 280)

local loadingBrandBadge = Instance.new('Frame')
loadingBrandBadge.Name = 'BrandBadge'
loadingBrandBadge.AnchorPoint = Vector2.new(0.5, 0.5)
loadingBrandBadge.Position = UDim2.new(0.5, 0, 0.5, -103)
loadingBrandBadge.Size = UDim2.fromOffset(142, 30)
loadingBrandBadge.BackgroundColor3 = Color3.fromRGB(70, 218, 192)
loadingBrandBadge.BorderSizePixel = 0
loadingBrandBadge.ZIndex = 6
loadingBrandBadge.Parent = loadingContent
local loadingBrandCorner = Instance.new('UICorner')
loadingBrandCorner.CornerRadius = UDim.new(0, 3)
loadingBrandCorner.Parent = loadingBrandBadge

local loadingTitle = Instance.new('TextLabel')
loadingTitle.Name = 'Title'
loadingTitle.AnchorPoint = Vector2.new(0.5, 0.5)
loadingTitle.Position = UDim2.fromScale(0.5, 0.5)
loadingTitle.Size = UDim2.new(1, -12, 1, -4)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Font = Enum.Font.FredokaOne
loadingTitle.Text = 'GUMBALL'
loadingTitle.TextColor3 = Color3.fromRGB(9, 23, 34)
loadingTitle.TextXAlignment = Enum.TextXAlignment.Center
loadingTitle.TextYAlignment = Enum.TextYAlignment.Center
loadingTitle.TextScaled = true
loadingTitle.TextTransparency = 1
loadingTitle.ZIndex = 7
loadingTitle.ZIndex = 6
loadingTitle.Parent = loadingBrandBadge
local loadingTitleConstraint = Instance.new('UITextSizeConstraint')
loadingTitleConstraint.MinTextSize = 18
loadingTitleConstraint.MaxTextSize = 28
loadingTitleConstraint.Parent = loadingTitle

local loadingRivals = Instance.new('TextLabel')
loadingRivals.Name = 'GameTitle'
loadingRivals.AnchorPoint = Vector2.new(0.5, 0.5)
loadingRivals.Position = UDim2.new(0.5, 0, 0.5, -43)
loadingRivals.Size = UDim2.new(1, -32, 0, 76)
loadingRivals.BackgroundTransparency = 1
loadingRivals.Font = Enum.Font.FredokaOne
loadingRivals.Text = 'RIVALS'
loadingRivals.TextColor3 = Color3.fromRGB(246, 249, 255)
loadingRivals.TextXAlignment = Enum.TextXAlignment.Center
loadingRivals.TextYAlignment = Enum.TextYAlignment.Center
loadingRivals.TextScaled = true
loadingRivals.TextTransparency = 1
loadingRivals.ZIndex = 7
loadingRivals.Parent = loadingContent
local loadingRivalsConstraint = Instance.new('UITextSizeConstraint')
loadingRivalsConstraint.MinTextSize = 40
loadingRivalsConstraint.MaxTextSize = 76
loadingRivalsConstraint.Parent = loadingRivals

local loadingStatus = Instance.new('TextLabel')
loadingStatus.Name = 'Status'
loadingStatus.AnchorPoint = Vector2.new(0.5, 0.5)
loadingStatus.Position = UDim2.new(0.5, 0, 0.5, 9)
loadingStatus.Size = UDim2.new(0.82, 0, 0, 20)
loadingStatus.BackgroundTransparency = 1
loadingStatus.Font = Enum.Font.GothamMedium
loadingStatus.Text = 'CONNECTING TO RIVALS'
loadingStatus.TextColor3 = Color3.fromRGB(185, 203, 222)
loadingStatus.TextSize = 14
loadingStatus.TextTransparency = 1
loadingStatus.TextXAlignment = Enum.TextXAlignment.Left
loadingStatus.ZIndex = 7
loadingStatus.Parent = loadingContent

local loadingTrack = Instance.new('Frame')
loadingTrack.Name = 'ProgressTrack'
loadingTrack.AnchorPoint = Vector2.new(0.5, 0.5)
loadingTrack.Position = UDim2.new(0.5, 0, 0.5, 39)
loadingTrack.Size = UDim2.new(0.82, 0, 0, 14)
loadingTrack.BackgroundColor3 = Color3.fromRGB(31, 43, 62)
loadingTrack.BorderSizePixel = 0
loadingTrack.ClipsDescendants = true
loadingTrack.ZIndex = 6
loadingTrack.Parent = loadingContent
local loadingTrackCorner = Instance.new('UICorner')
loadingTrackCorner.CornerRadius = UDim.new(1, 0)
loadingTrackCorner.Parent = loadingTrack
local loadingTrackStroke = Instance.new('UIStroke')
loadingTrackStroke.Color = Color3.fromRGB(96, 131, 150)
loadingTrackStroke.Transparency = 0.55
loadingTrackStroke.Thickness = 1
loadingTrackStroke.Parent = loadingTrack

local loadingProgress = Instance.new('NumberValue')
loadingProgress.Name = 'Progress'
loadingProgress.Value = 3

local loadingAccent = Instance.new('Frame')
loadingAccent.Name = 'ProgressFill'
loadingAccent.Size = UDim2.new(0.03, 0, 1, 0)
loadingAccent.BackgroundColor3 = Color3.fromRGB(69, 224, 192)
loadingAccent.BorderSizePixel = 0
loadingAccent.ZIndex = 7
loadingAccent.Parent = loadingTrack
local loadingAccentCorner = Instance.new('UICorner')
loadingAccentCorner.CornerRadius = UDim.new(1, 0)
loadingAccentCorner.Parent = loadingAccent
local loadingFillGradient = Instance.new('UIGradient')
loadingFillGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(64, 208, 191)),
	ColorSequenceKeypoint.new(0.55, Color3.fromRGB(99, 240, 207)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(116, 183, 255))
})
loadingFillGradient.Offset = Vector2.new(-1, 0)
loadingFillGradient.Parent = loadingAccent

local loadingPercent = Instance.new('TextLabel')
loadingPercent.Name = 'Percent'
loadingPercent.AnchorPoint = Vector2.new(1, 0.5)
loadingPercent.Position = UDim2.new(1, -10, 0.5, 0)
loadingPercent.Size = UDim2.fromOffset(46, 14)
loadingPercent.BackgroundTransparency = 1
loadingPercent.Font = Enum.Font.GothamBold
loadingPercent.Text = '3%'
loadingPercent.TextColor3 = Color3.fromRGB(248, 250, 255)
loadingPercent.TextSize = 12
loadingPercent.TextXAlignment = Enum.TextXAlignment.Right
loadingPercent.ZIndex = 8
loadingPercent.Parent = loadingTrack

loadingProgress:GetPropertyChangedSignal('Value'):Connect(function()
	local progress = math.clamp(loadingProgress.Value, 0, 100)
	loadingAccent.Size = UDim2.new(progress / 100, 0, 1, 0)
	loadingPercent.Text = string.format('%d%%', math.floor(progress + 0.5))
end)

local loadingFooter = Instance.new('TextLabel')
loadingFooter.Name = 'Footer'
loadingFooter.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFooter.Position = UDim2.new(0.5, 0, 0.5, 91)
loadingFooter.Size = UDim2.new(1, -32, 0, 24)
loadingFooter.BackgroundTransparency = 1
loadingFooter.Font = Enum.Font.FredokaOne
loadingFooter.Text = 'join .gg/gu9mball'
loadingFooter.TextColor3 = Color3.fromRGB(160, 190, 205)
loadingFooter.TextXAlignment = Enum.TextXAlignment.Center
loadingFooter.TextYAlignment = Enum.TextYAlignment.Center
loadingFooter.TextScaled = true
loadingFooter.TextTransparency = 1
loadingFooter.ZIndex = 7
loadingFooter.Parent = loadingContent
local loadingFooterConstraint = Instance.new('UITextSizeConstraint')
loadingFooterConstraint.MinTextSize = 14
loadingFooterConstraint.MaxTextSize = 20
loadingFooterConstraint.Parent = loadingFooter

local loadingTitlePop = Instance.new('UIScale')
loadingTitlePop.Scale = 0.9
loadingTitlePop.Parent = loadingTitle

TweenService:Create(loadingTitle, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	TextTransparency = 0
}):Play()
TweenService:Create(loadingTitlePop, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Scale = 1
}):Play()
TweenService:Create(loadingBrandBadge, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, 0.5, -100)
}):Play()
TweenService:Create(loadingRivals, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.12), {
	TextTransparency = 0
}):Play()
TweenService:Create(loadingStatus, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.18), {
	TextTransparency = 0
}):Play()
TweenService:Create(loadingFooter, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.2), {
	TextTransparency = 0
}):Play()
local loadingProgressTween = TweenService:Create(loadingProgress, TweenInfo.new(2.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
	Value = 86
})
loadingProgressTween:Play()
TweenService:Create(loadingFillGradient, TweenInfo.new(1.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
	Offset = Vector2.new(1, 0)
}):Play()

local loadingScreenFinishing = false
local loadingScreenDismissed = false
local loadingFinishCallbacks = {}
local loadingStatuses = { 'INITIALIZING GUMBALL', 'SYNCING UI SETTINGS', 'PREPARING MENU' }
task.spawn(function()
	local statusIndex = 1
	while loadingGui.Parent and not loadingScreenFinishing do
		task.wait(0.9)
		if loadingScreenFinishing or not loadingGui.Parent then
			break
		end

		statusIndex = statusIndex % #loadingStatuses + 1
		TweenService:Create(loadingStatus, TweenInfo.new(0.14), { TextTransparency = 1 }):Play()
		task.wait(0.14)
		if loadingScreenFinishing or not loadingGui.Parent then
			break
		end
		loadingStatus.Text = loadingStatuses[statusIndex]
		TweenService:Create(loadingStatus, TweenInfo.new(0.22), { TextTransparency = 0 }):Play()
	end
end)

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
		TweenService:Create(loadingRivals, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
			TweenService:Create(loadingStatus, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
		TweenService:Create(loadingFooter, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
		TweenService:Create(loadingTrack, TweenInfo.new(loadingFadeDuration), { BackgroundTransparency = 1 }):Play()
		TweenService:Create(loadingTrackStroke, TweenInfo.new(loadingFadeDuration), { Transparency = 1 }):Play()
			TweenService:Create(loadingPercent, TweenInfo.new(0.2), { TextTransparency = 1 }):Play()
		TweenService:Create(loadingAccent, TweenInfo.new(0.2), { BackgroundTransparency = 1 }):Play()
			TweenService:Create(loadingProgress, TweenInfo.new(loadingFadeDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Value = 100
		}):Play()
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

task.delay(12, function()
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

local Tabs = {}
Tabs.Main = Window:AddTab('main')
Tabs.World = Window:AddTab('world')
Tabs.ESP = Window:AddTab('esp')
Tabs.Visuals = Window:AddTab('visuals')
Tabs.Character = Window:AddTab('character')
Tabs.Misc = Window:AddTab('misc')
Tabs.settings = Window:AddTab('settings')

local MainGroup = Tabs.Main:AddLeftGroupbox('Main')
MainGroup:AddLabel('Gumball')

-- =========================================================================
-- WORLD TAB
-- =========================================================================
local WorldTabbox = Tabs.World:AddLeftTabbox()
local ColorCorrectionTab = WorldTabbox:AddTab('color correction')
local AtmosphereTab = WorldTabbox:AddTab('atmosphere')
local LightingService = game:GetService('Lighting')

local worldEffectsUnloaded = false

-- Our own persistent instances
local WorldColorCorrection = Instance.new('ColorCorrectionEffect')
WorldColorCorrection.Name = 'GumballColorCorrection'
WorldColorCorrection.Enabled = false
WorldColorCorrection.Saturation = 0
WorldColorCorrection.Contrast = 0
WorldColorCorrection.Brightness = 0
WorldColorCorrection.TintColor = Color3.new(1, 1, 1)
WorldColorCorrection.Parent = LightingService

local WorldAtmosphere = Instance.new('Atmosphere')
WorldAtmosphere.Name = 'GumballAtmosphere'
WorldAtmosphere.Density = 0
WorldAtmosphere.Offset = 0
WorldAtmosphere.Haze = 0
WorldAtmosphere.Glare = 0
WorldAtmosphere.Color = Color3.new(1, 1, 1)
WorldAtmosphere.Decay = Color3.new(1, 1, 1)
WorldAtmosphere.Parent = nil

-- Track the game's own effects so we can restore them on unload
local foreignCCState = setmetatable({}, { __mode = 'k' })    -- [inst] = originalEnabled
local foreignAtmoState = setmetatable({}, { __mode = 'k' })  -- [inst] = originalParent

local function HideForeignCC()
	for _, child in ipairs(LightingService:GetChildren()) do
		if child:IsA('ColorCorrectionEffect') and child ~= WorldColorCorrection then
			if foreignCCState[child] == nil then
				foreignCCState[child] = child.Enabled
			end
			if child.Enabled then
				pcall(function() child.Enabled = false end)
			end
		end
	end
end

local function HideForeignAtmo()
	for _, child in ipairs(LightingService:GetChildren()) do
		if child:IsA('Atmosphere') and child ~= WorldAtmosphere then
			if foreignAtmoState[child] == nil then
				foreignAtmoState[child] = child.Parent
			end
			if child.Parent then
				pcall(function() child.Parent = nil end)
			end
		end
	end
end

local function RestoreForeign()
	for child, originalEnabled in next, foreignCCState do
		foreignCCState[child] = nil
		if child.Parent then
			pcall(function() child.Enabled = originalEnabled end)
		end
	end
	for child, originalParent in next, foreignAtmoState do
		foreignAtmoState[child] = nil
		if child.Parent == nil and originalParent ~= nil then
			pcall(function() child.Parent = originalParent end)
		end
	end
end

-- =========================================================================
-- COLOR CORRECTION
-- =========================================================================
local WorldColorCorrectionToggle = ColorCorrectionTab:AddToggle('WorldColorCorrectionEnabled', {
	Text = 'enabled',
	Default = false
})

ColorCorrectionTab:AddDivider()

ColorCorrectionTab:AddLabel('Tint'):AddColorPicker('WorldColorCorrectionTint', {
	Default = Color3.new(1, 1, 1),
	Title = 'Color correction tint'
})
Options.WorldColorCorrectionTint:OnChanged(function(value)
	if value ~= Color3.new(1, 1, 1) and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

ColorCorrectionTab:AddSlider('WorldColorCorrectionSaturation', {
	Text = 'saturation', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	if value ~= 0 and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

ColorCorrectionTab:AddSlider('WorldColorCorrectionContrast', {
	Text = 'contrast', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	if value ~= 0 and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

ColorCorrectionTab:AddSlider('WorldColorCorrectionBrightness', {
	Text = 'brightness', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	if value ~= 0 and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

-- =========================================================================
-- ATMOSPHERE
-- =========================================================================
local WorldAtmosphereToggle = AtmosphereTab:AddToggle('WorldAtmosphereEnabled', {
	Text = 'enabled',
	Default = false
})

AtmosphereTab:AddDivider()

AtmosphereTab:AddSlider('WorldAtmosphereDensity', {
	Text = 'density', Default = 0, Min = 0, Max = 1, Rounding = 2
}):OnChanged(function(value)
	if value ~= 0 and not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end)

AtmosphereTab:AddSlider('WorldAtmosphereOffset', {
	Text = 'offset', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	if value ~= 0 and not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end)

AtmosphereTab:AddSlider('WorldAtmosphereHaze', {
	Text = 'haze', Default = 0, Min = 0, Max = 10, Rounding = 1
}):OnChanged(function(value)
	if value ~= 0 and not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end)

AtmosphereTab:AddSlider('WorldAtmosphereGlare', {
	Text = 'glare', Default = 0, Min = 0, Max = 10, Rounding = 1
}):OnChanged(function(value)
	if value ~= 0 and not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end)

AtmosphereTab:AddDivider()

AtmosphereTab:AddLabel('Color'):AddColorPicker('WorldAtmosphereColor', {
	Default = Color3.new(1, 1, 1),
	Title = 'Atmosphere color'
})
Options.WorldAtmosphereColor:OnChanged(function(value)
	if value ~= Color3.new(1, 1, 1) and not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end)

AtmosphereTab:AddLabel('Decay'):AddColorPicker('WorldAtmosphereDecay', {
	Default = Color3.new(1, 1, 1),
	Title = 'Atmosphere decay'
})
Options.WorldAtmosphereDecay:OnChanged(function(value)
	if value ~= Color3.new(1, 1, 1) and not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end)

-- =========================================================================
-- Sync loop — forces our values + hides the game's, every frame
-- =========================================================================
local function SyncWorldEffects()
	if worldEffectsUnloaded then return end

	-- ===== Our Color Correction =====
	WorldColorCorrection.Enabled = WorldColorCorrectionToggle.Value
	WorldColorCorrection.Saturation = Options.WorldColorCorrectionSaturation.Value
	WorldColorCorrection.Contrast = Options.WorldColorCorrectionContrast.Value
	WorldColorCorrection.Brightness = Options.WorldColorCorrectionBrightness.Value
	WorldColorCorrection.TintColor = Options.WorldColorCorrectionTint.Value

	-- ===== Our Atmosphere =====
	WorldAtmosphere.Density = Options.WorldAtmosphereDensity.Value
	WorldAtmosphere.Offset = Options.WorldAtmosphereOffset.Value
	WorldAtmosphere.Haze = Options.WorldAtmosphereHaze.Value
	WorldAtmosphere.Glare = Options.WorldAtmosphereGlare.Value
	WorldAtmosphere.Color = Options.WorldAtmosphereColor.Value
	WorldAtmosphere.Decay = Options.WorldAtmosphereDecay.Value

	local wantParent = WorldAtmosphereToggle.Value and LightingService or nil
	if WorldAtmosphere.Parent ~= wantParent then
		pcall(function() WorldAtmosphere.Parent = wantParent end)
	end

	-- ===== Hide the game's own =====
	if WorldColorCorrectionToggle.Value then
		HideForeignCC()
	end
	if WorldAtmosphereToggle.Value then
		HideForeignAtmo()
	end
end

Library:GiveSignal(game:GetService('RunService').Heartbeat:Connect(SyncWorldEffects))

local previousWorldUnload = Library.OnUnload
Library:OnUnload(function()
	worldEffectsUnloaded = true
	if previousWorldUnload then previousWorldUnload() end
	RestoreForeign()
	pcall(function() WorldColorCorrection:Destroy() end)
	pcall(function() WorldAtmosphere:Destroy() end)
end)

-- =========================================================================
-- SETTINGS TAB — Menu groupbox
-- =========================================================================
local MenuGroup = Tabs.settings:AddLeftGroupbox('Menu')
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
KeybindHudFrame.Size = UDim2.fromOffset(230, 32)
KeybindHudFrame.BackgroundColor3 = Library.MainColor
KeybindHudFrame.BorderSizePixel = 0
KeybindHudFrame.Visible = false
KeybindHudFrame.ZIndex = 1
KeybindHudFrame.Active = true
KeybindHudFrame.Parent = KeybindHudGui
local KeybindHudCorner = Instance.new('UICorner')
KeybindHudCorner.CornerRadius = UDim.new(0, 4)
KeybindHudCorner.Parent = KeybindHudFrame
Library:AddToRegistry(KeybindHudFrame, { BackgroundColor3 = 'MainColor' })

local KeybindHudStroke = Instance.new('UIStroke')
KeybindHudStroke.Color = Library.OutlineColor
KeybindHudStroke.Thickness = 1.2
KeybindHudStroke.Parent = KeybindHudFrame
Library:AddToRegistry(KeybindHudStroke, { Color = 'OutlineColor' })
Library:OnUnload(function()
	if KeybindHudGui.Parent then
		KeybindHudGui:Destroy()
	end
end)

local KeybindHudHeader = Instance.new('TextLabel')
KeybindHudHeader.Name = 'Header'
KeybindHudHeader.BackgroundTransparency = 1
KeybindHudHeader.Position = UDim2.fromOffset(8, 5)
KeybindHudHeader.Size = UDim2.new(1, -42, 0, 16)
KeybindHudHeader.Font = Library.Font
KeybindHudHeader.Text = 'BINDS'
KeybindHudHeader.TextColor3 = Library.FontColor
KeybindHudHeader.TextSize = 11
KeybindHudHeader.TextXAlignment = Enum.TextXAlignment.Left
KeybindHudHeader.ZIndex = 2
KeybindHudHeader.Parent = KeybindHudFrame
KeybindHudHeader.Active = true
Library:AddToRegistry(KeybindHudHeader, { TextColor3 = 'FontColor' })

local KeybindHudCount = Instance.new('TextLabel')
KeybindHudCount.Name = 'Count'
KeybindHudCount.AnchorPoint = Vector2.new(1, 0)
KeybindHudCount.Position = UDim2.new(1, -8, 0, 5)
KeybindHudCount.Size = UDim2.fromOffset(22, 16)
KeybindHudCount.BackgroundColor3 = Library.AccentColor
KeybindHudCount.BackgroundTransparency = 0.78
KeybindHudCount.BorderSizePixel = 0
KeybindHudCount.Font = Library.Font
KeybindHudCount.Text = '0'
KeybindHudCount.TextColor3 = Library.FontColor
KeybindHudCount.TextSize = 10
KeybindHudCount.ZIndex = 2
KeybindHudCount.Parent = KeybindHudFrame
local KeybindHudCountCorner = Instance.new('UICorner')
KeybindHudCountCorner.CornerRadius = UDim.new(0, 3)
KeybindHudCountCorner.Parent = KeybindHudCount
Library:AddToRegistry(KeybindHudCount, {
	BackgroundColor3 = 'AccentColor',
	TextColor3 = 'FontColor'
})

local KeybindHudAccent = Instance.new('Frame')
KeybindHudAccent.Name = 'Accent'
KeybindHudAccent.BackgroundColor3 = Library.AccentColor
KeybindHudAccent.BorderSizePixel = 0
KeybindHudAccent.Size = UDim2.new(1, 0, 0, 2)
KeybindHudAccent.ZIndex = 2
KeybindHudAccent.Parent = KeybindHudFrame
Library:AddToRegistry(KeybindHudAccent, { BackgroundColor3 = 'AccentColor' })

local draggingKeybindHud = false
local keybindHudGrabOffset
local nativeKeybindHudDrag
local dragDetectorCreated, dragDetector = pcall(function()
	return Instance.new('UIDragDetector')
end)
if dragDetectorCreated then
	nativeKeybindHudDrag = dragDetector
	nativeKeybindHudDrag.Enabled = false
	nativeKeybindHudDrag.Parent = KeybindHudFrame
end

local function SyncKeybindHudDragEnabled()
	local canDragKeybindHud = Window.Holder.Visible and KeybindHudFrame.Visible
	KeybindHudFrame.Active = canDragKeybindHud
	if nativeKeybindHudDrag then
		nativeKeybindHudDrag.Enabled = canDragKeybindHud
	end
	if not canDragKeybindHud then
		draggingKeybindHud = false
	end
end

Window.Holder:GetPropertyChangedSignal('Visible'):Connect(SyncKeybindHudDragEnabled)
KeybindHudFrame:GetPropertyChangedSignal('Visible'):Connect(SyncKeybindHudDragEnabled)

Library:GiveSignal(UserInputService.InputBegan:Connect(function(input)
	if nativeKeybindHudDrag then
		return
	end
	if not Window.Holder.Visible or not KeybindHudFrame.Visible or input.UserInputType ~= Enum.UserInputType.MouseButton1 then
		return
	end

	local mousePosition = UserInputService:GetMouseLocation()
	local framePosition = KeybindHudFrame.AbsolutePosition
	local frameSize = KeybindHudFrame.AbsoluteSize
	if mousePosition.X < framePosition.X or mousePosition.X > framePosition.X + frameSize.X
		or mousePosition.Y < framePosition.Y or mousePosition.Y > framePosition.Y + frameSize.Y then
		return
	end

	draggingKeybindHud = true
	keybindHudGrabOffset = mousePosition - KeybindHudFrame.AbsolutePosition
end))

local function UpdateKeybindHudDrag()
	if nativeKeybindHudDrag then
		SyncKeybindHudDragEnabled()
		return
	end
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
KeybindHudRowsContainer.Position = UDim2.fromOffset(8, 25)
KeybindHudRowsContainer.Size = UDim2.new(1, -16, 1, -29)
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
			label.BackgroundColor3 = Library.AccentColor
			label.BackgroundTransparency = 1
			label.Size = UDim2.new(1, 0, 0, 17)
			label.Font = Library.Font
			label.TextColor3 = Library.FontColor
			label.TextSize = 11
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextYAlignment = Enum.TextYAlignment.Center
			label.ZIndex = 3
			label.Parent = KeybindHudRowsContainer
			local rowCorner = Instance.new('UICorner')
			rowCorner.CornerRadius = UDim.new(0, 3)
			rowCorner.Parent = label
			local rowPadding = Instance.new('UIPadding')
			rowPadding.PaddingLeft = UDim.new(0, 5)
			rowPadding.Parent = label
			Library:AddToRegistry(label, {
				BackgroundColor3 = 'AccentColor',
				TextColor3 = function()
					return label:GetAttribute('GumballActive') and Library.AccentColor or Library.FontColor
				end
			})
			KeybindHudLabels[row.Id] = label
		end
		label.LayoutOrder = order
		label.Text = row.Text
		label:SetAttribute('GumballActive', row.Active)
		label.TextColor3 = row.Active and Library.AccentColor or Library.FontColor
		label.BackgroundTransparency = 1
	end

	for id, label in pairs(KeybindHudLabels) do
		if not visibleRows[id] then
			KeybindHudLabels[id] = nil
			label:Destroy()
		end
	end

	KeybindHudFrame.Size = UDim2.fromOffset(230, 32 + #rows * 19)
	KeybindHudCount.Text = tostring(#rows)
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
	SyncWorldEffects()
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

-- =========================================================================
-- SETTINGS TAB — Configuration groupbox
-- =========================================================================
local ConfigGroup = Tabs.settings:AddRightGroupbox('Configuration')
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

-- =========================================================================
-- SETTINGS TAB — Theme groupbox
-- =========================================================================
local ThemeGroup = ThemeManager:CreateGroupBox(Tabs.settings)
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
