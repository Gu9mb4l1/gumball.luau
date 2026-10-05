local loadingStartedAt = os.clock()
local loadingMinimumDuration = 4.5
local loadingFadeDuration = 0.35

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
	facet.BackgroundColor3 = index % 2 == 0
		and Color3.fromRGB(95, 133, 177)
		or Color3.fromRGB(57, 95, 143)
	facet.BackgroundTransparency = 0.91
	facet.BorderSizePixel = 0
	facet.ZIndex = 1
	facet.Parent = loadingFacetLayer

	TweenService:Create(
		facet,
		TweenInfo.new(
			8 + index,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut,
			-1,
			true
		),
		{
			Rotation = spec[5] + (index % 2 == 0 and 4 or -4)
		}
	):Play()
end

for index, ringSize in ipairs({
	UDim2.fromOffset(560, 410),
	UDim2.fromOffset(760, 560)
}) do
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
	ringStroke.Color = index == 1
		and Color3.fromRGB(92, 205, 202)
		or Color3.fromRGB(120, 151, 205)
	ringStroke.Transparency = 0.93
	ringStroke.Thickness = 1
	ringStroke.Parent = ring

	TweenService:Create(
		ring,
		TweenInfo.new(
			42 + index * 9,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.InOut,
			-1
		),
		{
			Rotation = ring.Rotation + (index == 1 and 360 or -360)
		}
	):Play()
end

TweenService:Create(
	loadingBackgroundGradient,
	TweenInfo.new(
		18,
		Enum.EasingStyle.Sine,
		Enum.EasingDirection.InOut,
		-1,
		true
	),
	{
		Rotation = 42
	}
):Play()

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

	loadingScale.Scale = math.clamp(
		math.min(viewport.X / 1280, viewport.Y / 720),
		0.8,
		2
	)
else
	loadingScale.Scale = 1
end

loadingContent.Size = UDim2.new(
	0.84 / loadingScale.Scale,
	0,
	0,
	280
)

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

	loadingAccent.Size = UDim2.new(
		progress / 100,
		0,
		1,
		0
	)

	loadingPercent.Text = string.format(
		'%d%%',
		math.floor(progress + 0.5)
	)
end)

local loadingFooter = Instance.new('TextLabel')
loadingFooter.Name = 'Footer'
loadingFooter.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFooter.Position = UDim2.new(0.5, 0, 0.5, 91)
loadingFooter.Size = UDim2.new(1, -32, 0, 24)
loadingFooter.BackgroundTransparency = 1
loadingFooter.Font = Enum.Font.FredokaOne
loadingFooter.Text = 'discord.gg/gu9mball'
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

TweenService:Create(
	loadingTitle,
	TweenInfo.new(
		0.55,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out
	),
	{
		TextTransparency = 0
	}
):Play()

TweenService:Create(
	loadingTitlePop,
	TweenInfo.new(
		0.65,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Scale = 1
	}
):Play()

TweenService:Create(
	loadingBrandBadge,
	TweenInfo.new(
		0.45,
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out
	),
	{
		Position = UDim2.new(0.5, 0, 0.5, -100)
	}
):Play()

TweenService:Create(
	loadingRivals,
	TweenInfo.new(
		0.45,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out,
		0,
		false,
		0.12
	),
	{
		TextTransparency = 0
	}
):Play()

TweenService:Create(
	loadingStatus,
	TweenInfo.new(
		0.4,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out,
		0,
		false,
		0.18
	),
	{
		TextTransparency = 0
	}
):Play()

TweenService:Create(
	loadingFooter,
	TweenInfo.new(
		0.45,
		Enum.EasingStyle.Quad,
		Enum.EasingDirection.Out,
		0,
		false,
		0.2
	),
	{
		TextTransparency = 0
	}
):Play()

local loadingProgressTween = TweenService:Create(
	loadingProgress,
	TweenInfo.new(
		2.4,
		Enum.EasingStyle.Quart,
		Enum.EasingDirection.Out
	),
	{
		Value = 86
	}
)

loadingProgressTween:Play()

TweenService:Create(
	loadingFillGradient,
	TweenInfo.new(
		1.2,
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.Out,
		-1,
		true
	),
	{
		Offset = Vector2.new(1, 0)
	}
):Play()

local loadingScreenFinishing = false
local loadingScreenDismissed = false
local loadingFinishCallbacks = {}

local loadingStatuses = {
	'INITIALIZING GUMBALL',
	'SYNCING UI SETTINGS',
	'PREPARING MENU'
}

task.spawn(function()
	local statusIndex = 1

	while loadingGui.Parent and not loadingScreenFinishing do
		task.wait(0.9)

		if loadingScreenFinishing or not loadingGui.Parent then
			break
		end

		statusIndex = statusIndex % #loadingStatuses + 1

		TweenService:Create(
			loadingStatus,
			TweenInfo.new(0.14),
			{
				TextTransparency = 1
			}
		):Play()

		task.wait(0.14)

		if loadingScreenFinishing or not loadingGui.Parent then
			break
		end

		loadingStatus.Text = loadingStatuses[statusIndex]

		TweenService:Create(
			loadingStatus,
			TweenInfo.new(0.22),
			{
				TextTransparency = 0
			}
		):Play()
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

	local waitTime = math.max(
		0,
		loadingMinimumDuration
			- loadingFadeDuration
			- (os.clock() - loadingStartedAt)
	)

	task.delay(waitTime, function()
		TweenService:Create(
			loadingOverlay,
			TweenInfo.new(
				loadingFadeDuration,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				BackgroundTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingTitle,
			TweenInfo.new(0.25),
			{
				TextTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingRivals,
			TweenInfo.new(0.2),
			{
				TextTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingStatus,
			TweenInfo.new(0.2),
			{
				TextTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingFooter,
			TweenInfo.new(0.2),
			{
				TextTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingTrack,
			TweenInfo.new(loadingFadeDuration),
			{
				BackgroundTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingTrackStroke,
			TweenInfo.new(loadingFadeDuration),
			{
				Transparency = 1
			}
		):Play()

		TweenService:Create(
			loadingPercent,
			TweenInfo.new(0.2),
			{
				TextTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingAccent,
			TweenInfo.new(0.2),
			{
				BackgroundTransparency = 1
			}
		):Play()

		TweenService:Create(
			loadingProgress,
			TweenInfo.new(
				loadingFadeDuration,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				Value = 100
			}
		):Play()

		TweenService:Create(
			loadingBlur,
			TweenInfo.new(loadingFadeDuration),
			{
				Size = 0
			}
		):Play()

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
	Title = 'Gumball - discord.gg/gu9mball',
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

-- Foreign-effect guards
local foreignCC = setmetatable({}, { __mode = 'k' })
local foreignAtmo = setmetatable({}, { __mode = 'k' })

local function guardCC(inst)
	if inst == WorldColorCorrection then
		return
	end

	if foreignCC[inst] then
		return
	end

	local entry = {
		originalEnabled = inst.Enabled,
		connection = nil
	}

	pcall(function()
		inst.Enabled = false
	end)

	entry.connection = inst.Changed:Connect(function(prop)
		if prop == 'Enabled' and inst.Enabled ~= false then
			pcall(function()
				inst.Enabled = false
			end)
		end
	end)

	foreignCC[inst] = entry
end

local function unguardCC(inst)
	local entry = foreignCC[inst]

	if not entry then
		return
	end

	foreignCC[inst] = nil

	if entry.connection then
		entry.connection:Disconnect()
	end

	if inst.Parent then
		pcall(function()
			inst.Enabled = entry.originalEnabled
		end)
	end
end

local function guardAtmo(inst)
	if inst == WorldAtmosphere then
		return
	end

	if foreignAtmo[inst] then
		return
	end

	local entry = {
		originalParent = inst.Parent,
		connection = nil
	}

	pcall(function()
		inst.Parent = nil
	end)

	entry.connection = inst.Changed:Connect(function(prop)
		if prop == 'Parent' and inst.Parent ~= nil then
			pcall(function()
				inst.Parent = nil
			end)
		end
	end)

	foreignAtmo[inst] = entry
end

local function unguardAtmo(inst)
	local entry = foreignAtmo[inst]

	if not entry then
		return
	end

	foreignAtmo[inst] = nil

	if entry.connection then
		entry.connection:Disconnect()
	end

	if inst.Parent == nil and entry.originalParent then
		pcall(function()
			inst.Parent = entry.originalParent
		end)
	end
end

local function scanAllForeign()
	for _, inst in ipairs(LightingService:GetDescendants()) do
		if inst:IsA('ColorCorrectionEffect')
			and inst ~= WorldColorCorrection then

			guardCC(inst)

		elseif inst:IsA('Atmosphere')
			and inst ~= WorldAtmosphere then

			guardAtmo(inst)
		end
	end
end

scanAllForeign()

Library:GiveSignal(
	LightingService.DescendantAdded:Connect(function(inst)
		if inst:IsA('ColorCorrectionEffect')
			and inst ~= WorldColorCorrection then

			task.defer(function()
				guardCC(inst)
			end)

		elseif inst:IsA('Atmosphere')
			and inst ~= WorldAtmosphere then

			task.defer(function()
				guardAtmo(inst)
			end)
		end
	end)
)

Library:GiveSignal(
	LightingService.DescendantRemoving:Connect(function(inst)
		if inst:IsA('ColorCorrectionEffect') then
			unguardCC(inst)

		elseif inst:IsA('Atmosphere') then
			unguardAtmo(inst)
		end
	end)
)

-- =========================================================================
-- COLOR CORRECTION UI
-- =========================================================================
