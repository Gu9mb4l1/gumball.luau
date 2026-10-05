local loadingStartedAt = os.clock()
local loadingMinimumDuration = 3
local loadingFadeDuration = 0.45
local TweenService = game:GetService('TweenService')
local Lighting = game:GetService('Lighting')
local RunService = game:GetService('RunService')
local loadingParent = game:GetService('CoreGui')
if type(gethui) == 'function' then
	local success, hiddenGui = pcall(gethui)
	if success and hiddenGui then
		loadingParent = hiddenGui
	end
end

local oldLoadingGui = loadingParent:FindFirstChild('GumballLoadingScreen')
if oldLoadingGui then oldLoadingGui:Destroy() end
local oldLoadingBlur = Lighting:FindFirstChild('GumballLoadingBlur')
if oldLoadingBlur then oldLoadingBlur:Destroy() end

-- Blur
local loadingBlur = Instance.new('BlurEffect')
loadingBlur.Name = 'GumballLoadingBlur'
loadingBlur.Size = 24
loadingBlur.Parent = Lighting

-- Root GUI
local loadingGui = Instance.new('ScreenGui')
loadingGui.Name = 'GumballLoadingScreen'
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false
loadingGui.DisplayOrder = 10000
loadingGui.Parent = loadingParent

-- Background overlay
local loadingOverlay = Instance.new('Frame')
loadingOverlay.Name = 'Overlay'
loadingOverlay.Size = UDim2.fromScale(1, 1)
loadingOverlay.BackgroundColor3 = Color3.fromRGB(8, 14, 26)
loadingOverlay.BackgroundTransparency = 0
loadingOverlay.BorderSizePixel = 0
loadingOverlay.ZIndex = 1
loadingOverlay.Parent = loadingGui

-- Deep background gradient
local loadingBackgroundGradient = Instance.new('UIGradient')
loadingBackgroundGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,    Color3.fromRGB(18, 38, 72)),
	ColorSequenceKeypoint.new(0.45, Color3.fromRGB(10, 22, 44)),
	ColorSequenceKeypoint.new(1,    Color3.fromRGB(6,  12, 24)),
})
loadingBackgroundGradient.Rotation = 22
loadingBackgroundGradient.Parent = loadingOverlay
TweenService:Create(loadingBackgroundGradient, TweenInfo.new(20, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Rotation = 58
}):Play()

-- Decorative facets
local loadingFacetLayer = Instance.new('Frame')
loadingFacetLayer.Name = 'BackgroundFacets'
loadingFacetLayer.Size = UDim2.fromScale(1, 1)
loadingFacetLayer.BackgroundTransparency = 1
loadingFacetLayer.ClipsDescendants = true
loadingFacetLayer.ZIndex = 1
loadingFacetLayer.Parent = loadingOverlay

local loadingFacetSpecs = {
	{ -0.08, 0.12, 0.44, 0.11, -24 },
	{ 0.05,  0.82, 0.50, 0.13,  18 },
	{ 0.94,  0.16, 0.40, 0.10,  22 },
	{ 1.02,  0.78, 0.54, 0.12, -20 },
	{ 0.32,  0.04, 0.30, 0.07,  16 },
	{ 0.70,  0.96, 0.38, 0.08, -17 },
	{ 0.18,  0.46, 0.26, 0.06, -20 },
	{ 0.86,  0.53, 0.32, 0.07,  19 },
}
for index, spec in ipairs(loadingFacetSpecs) do
	local facet = Instance.new('Frame')
	facet.Name = 'Facet' .. index
	facet.AnchorPoint = Vector2.new(0.5, 0.5)
	facet.Position = UDim2.fromScale(spec[1], spec[2])
	facet.Size = UDim2.fromScale(spec[3], spec[4])
	facet.Rotation = spec[5]
	facet.BackgroundColor3 = index % 2 == 0
		and Color3.fromRGB(70, 210, 195)
		or  Color3.fromRGB(45, 130, 210)
	facet.BackgroundTransparency = 0.93
	facet.BorderSizePixel = 0
	facet.ZIndex = 1
	facet.Parent = loadingFacetLayer
	TweenService:Create(facet, TweenInfo.new(9 + index, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		Rotation = spec[5] + (index % 2 == 0 and 5 or -5)
	}):Play()
end

-- Orbit rings (3 now, original had 2)
local ringDefs = {
	{ UDim2.fromOffset(480, 350), -14, Color3.fromRGB(72, 220, 210), 0.90, 46 },
	{ UDim2.fromOffset(680, 500),  16, Color3.fromRGB(100, 160, 255), 0.91, 62 },
	{ UDim2.fromOffset(880, 650), -8,  Color3.fromRGB(60, 180, 240), 0.93, 78 },
}
for index, def in ipairs(ringDefs) do
	local ring = Instance.new('Frame')
	ring.Name = 'OrbitRing' .. index
	ring.AnchorPoint = Vector2.new(0.5, 0.5)
	ring.Position = UDim2.fromScale(0.5, 0.5)
	ring.Size = def[1]
	ring.BackgroundTransparency = 1
	ring.BorderSizePixel = 0
	ring.Rotation = def[2]
	ring.ZIndex = 2
	ring.Parent = loadingOverlay
	local rc = Instance.new('UICorner')
	rc.CornerRadius = UDim.new(1, 0)
	rc.Parent = ring
	local rs = Instance.new('UIStroke')
	rs.Color = def[3]
	rs.Transparency = def[4]
	rs.Thickness = 1.2
	rs.Parent = ring
	TweenService:Create(ring, TweenInfo.new(def[5], Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
		Rotation = def[2] + (index % 2 == 0 and 360 or -360)
	}):Play()
end

-- Scanline sweep (subtle horizontal shimmer line)
local scanLine = Instance.new('Frame')
scanLine.Name = 'ScanLine'
scanLine.Size = UDim2.new(1, 0, 0, 2)
scanLine.Position = UDim2.fromScale(0, -0.01)
scanLine.BackgroundColor3 = Color3.fromRGB(90, 230, 220)
scanLine.BackgroundTransparency = 0.7
scanLine.BorderSizePixel = 0
scanLine.ZIndex = 3
scanLine.Parent = loadingOverlay
local scanGrad = Instance.new('UIGradient')
scanGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,    Color3.new(0,0,0)),
	ColorSequenceKeypoint.new(0.35, Color3.new(1,1,1)),
	ColorSequenceKeypoint.new(0.65, Color3.new(1,1,1)),
	ColorSequenceKeypoint.new(1,    Color3.new(0,0,0)),
})
scanGrad.Parent = scanLine
local function loopScanLine()
	scanLine.Position = UDim2.fromScale(0, -0.01)
	TweenService:Create(scanLine, TweenInfo.new(3.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		Position = UDim2.fromScale(0, 1.01)
	}):Play()
	task.delay(3.8, loopScanLine)
end
task.spawn(loopScanLine)

-- Content frame
local loadingContent = Instance.new('Frame')
loadingContent.Name = 'Content'
loadingContent.AnchorPoint = Vector2.new(0.5, 0.5)
loadingContent.Position = UDim2.fromScale(0.5, 0.5)
loadingContent.Size = UDim2.fromOffset(520, 300)
loadingContent.BackgroundTransparency = 1
loadingContent.ZIndex = 5
loadingContent.Parent = loadingOverlay

local loadingScale = Instance.new('UIScale')
loadingScale.Parent = loadingContent
local loadingCamera = workspace.CurrentCamera
if loadingCamera then
	local vp = loadingCamera.ViewportSize
	loadingScale.Scale = math.clamp(math.min(vp.X / 1280, vp.Y / 720), 0.75, 2)
else
	loadingScale.Scale = 1
end
loadingContent.Size = UDim2.new(0.84 / loadingScale.Scale, 0, 0, 300)

-- Brand badge — starts offset, pops in
local loadingBrandBadge = Instance.new('Frame')
loadingBrandBadge.Name = 'BrandBadge'
loadingBrandBadge.AnchorPoint = Vector2.new(0.5, 0.5)
loadingBrandBadge.Position = UDim2.new(0.5, 0, 0.5, -120)  -- animated to -106
loadingBrandBadge.Size = UDim2.fromOffset(158, 34)
loadingBrandBadge.BackgroundColor3 = Color3.fromRGB(50, 210, 185)
loadingBrandBadge.BorderSizePixel = 0
loadingBrandBadge.ZIndex = 6
loadingBrandBadge.Parent = loadingContent
local loadingBrandCorner = Instance.new('UICorner')
loadingBrandCorner.CornerRadius = UDim.new(0, 4)
loadingBrandCorner.Parent = loadingBrandBadge
local badgeGlow = Instance.new('UIStroke')
badgeGlow.Color = Color3.fromRGB(80, 240, 210)
badgeGlow.Transparency = 0.6
badgeGlow.Thickness = 1.5
badgeGlow.Parent = loadingBrandBadge
-- Badge gradient shimmer
local badgeGrad = Instance.new('UIGradient')
badgeGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,    Color3.fromRGB(40, 195, 175)),
	ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(85, 245, 215)),
	ColorSequenceKeypoint.new(1,    Color3.fromRGB(40, 195, 175)),
})
badgeGrad.Rotation = 90
badgeGrad.Parent = loadingBrandBadge
TweenService:Create(badgeGrad, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Offset = Vector2.new(0.6, 0)
}):Play()

-- GUMBALL label inside badge
local loadingTitle = Instance.new('TextLabel')
loadingTitle.Name = 'Title'
loadingTitle.AnchorPoint = Vector2.new(0.5, 0.5)
loadingTitle.Position = UDim2.fromScale(0.5, 0.5)
loadingTitle.Size = UDim2.new(1, -12, 1, -4)
loadingTitle.BackgroundTransparency = 1
loadingTitle.Font = Enum.Font.FredokaOne
loadingTitle.Text = 'GUMBALL'
loadingTitle.TextColor3 = Color3.fromRGB(6, 18, 28)
loadingTitle.TextXAlignment = Enum.TextXAlignment.Center
loadingTitle.TextYAlignment = Enum.TextYAlignment.Center
loadingTitle.TextScaled = true
loadingTitle.TextTransparency = 1
loadingTitle.ZIndex = 7
loadingTitle.Parent = loadingBrandBadge
local loadingTitleConstraint = Instance.new('UITextSizeConstraint')
loadingTitleConstraint.MinTextSize = 18
loadingTitleConstraint.MaxTextSize = 30
loadingTitleConstraint.Parent = loadingTitle
local loadingTitlePop = Instance.new('UIScale')
loadingTitlePop.Scale = 0.82
loadingTitlePop.Parent = loadingTitle

-- RIVALS — big hero text, slides up from below + fades
local loadingRivals = Instance.new('TextLabel')
loadingRivals.Name = 'GameTitle'
loadingRivals.AnchorPoint = Vector2.new(0.5, 0.5)
loadingRivals.Position = UDim2.new(0.5, 0, 0.5, -28)  -- animated up from -10
loadingRivals.Size = UDim2.new(1, -20, 0, 88)
loadingRivals.BackgroundTransparency = 1
loadingRivals.Font = Enum.Font.FredokaOne
loadingRivals.Text = 'RIVALS'
loadingRivals.TextColor3 = Color3.fromRGB(240, 248, 255)
loadingRivals.TextXAlignment = Enum.TextXAlignment.Center
loadingRivals.TextYAlignment = Enum.TextYAlignment.Center
loadingRivals.TextScaled = true
loadingRivals.TextTransparency = 1
loadingRivals.ZIndex = 7
loadingRivals.Parent = loadingContent
local loadingRivalsConstraint = Instance.new('UITextSizeConstraint')
loadingRivalsConstraint.MinTextSize = 44
loadingRivalsConstraint.MaxTextSize = 88
loadingRivalsConstraint.Parent = loadingRivals
-- Gradient on RIVALS text
local rivalsGrad = Instance.new('UIGradient')
rivalsGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,    Color3.fromRGB(200, 235, 255)),
	ColorSequenceKeypoint.new(0.48, Color3.fromRGB(255, 255, 255)),
	ColorSequenceKeypoint.new(1,    Color3.fromRGB(160, 210, 245)),
})
rivalsGrad.Rotation = 90
rivalsGrad.Parent = loadingRivals
-- Subtle scale pop on RIVALS
local rivalsPop = Instance.new('UIScale')
rivalsPop.Scale = 0.88
rivalsPop.Parent = loadingRivals

-- Status text
local loadingStatus = Instance.new('TextLabel')
loadingStatus.Name = 'Status'
loadingStatus.AnchorPoint = Vector2.new(0.5, 0.5)
loadingStatus.Position = UDim2.new(0.5, 0, 0.5, 24)
loadingStatus.Size = UDim2.new(0.82, 0, 0, 20)
loadingStatus.BackgroundTransparency = 1
loadingStatus.Font = Enum.Font.GothamMedium
loadingStatus.Text = 'CONNECTING TO RIVALS'
loadingStatus.TextColor3 = Color3.fromRGB(160, 200, 225)
loadingStatus.TextSize = 13
loadingStatus.TextTransparency = 1
loadingStatus.TextXAlignment = Enum.TextXAlignment.Left
loadingStatus.ZIndex = 7
loadingStatus.Parent = loadingContent

-- Blinking cursor after status text
local loadingCursor = Instance.new('TextLabel')
loadingCursor.Name = 'Cursor'
loadingCursor.AnchorPoint = Vector2.new(0, 0.5)
loadingCursor.Position = UDim2.new(0.09, 0, 0.5, 24)
loadingCursor.Size = UDim2.fromOffset(14, 20)
loadingCursor.BackgroundTransparency = 1
loadingCursor.Font = Enum.Font.GothamBold
loadingCursor.Text = '|'
loadingCursor.TextColor3 = Color3.fromRGB(70, 220, 195)
loadingCursor.TextSize = 14
loadingCursor.TextTransparency = 1
loadingCursor.ZIndex = 7
loadingCursor.Parent = loadingContent
-- Cursor blink loop
task.spawn(function()
	while loadingGui.Parent do
		TweenService:Create(loadingCursor, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			TextTransparency = 0
		}):Play()
		task.wait(0.45)
		TweenService:Create(loadingCursor, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			TextTransparency = 1
		}):Play()
		task.wait(0.45)
	end
end)

-- Progress bar track
local loadingTrack = Instance.new('Frame')
loadingTrack.Name = 'ProgressTrack'
loadingTrack.AnchorPoint = Vector2.new(0.5, 0.5)
loadingTrack.Position = UDim2.new(0.5, 0, 0.5, 56)
loadingTrack.Size = UDim2.new(0.82, 0, 0, 14)
loadingTrack.BackgroundColor3 = Color3.fromRGB(22, 34, 52)
loadingTrack.BorderSizePixel = 0
loadingTrack.ClipsDescendants = true
loadingTrack.ZIndex = 6
loadingTrack.Parent = loadingContent
local loadingTrackCorner = Instance.new('UICorner')
loadingTrackCorner.CornerRadius = UDim.new(1, 0)
loadingTrackCorner.Parent = loadingTrack
local loadingTrackStroke = Instance.new('UIStroke')
loadingTrackStroke.Color = Color3.fromRGB(80, 120, 150)
loadingTrackStroke.Transparency = 0.5
loadingTrackStroke.Thickness = 1
loadingTrackStroke.Parent = loadingTrack

-- Progress value
local loadingProgress = Instance.new('NumberValue')
loadingProgress.Name = 'Progress'
loadingProgress.Value = 3

-- Progress fill
local loadingAccent = Instance.new('Frame')
loadingAccent.Name = 'ProgressFill'
loadingAccent.Size = UDim2.new(0.03, 0, 1, 0)
loadingAccent.BackgroundColor3 = Color3.fromRGB(60, 215, 185)
loadingAccent.BorderSizePixel = 0
loadingAccent.ZIndex = 7
loadingAccent.Parent = loadingTrack
local loadingAccentCorner = Instance.new('UICorner')
loadingAccentCorner.CornerRadius = UDim.new(1, 0)
loadingAccentCorner.Parent = loadingAccent
local loadingFillGradient = Instance.new('UIGradient')
loadingFillGradient.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0,    Color3.fromRGB(50, 200, 180)),
	ColorSequenceKeypoint.new(0.5,  Color3.fromRGB(90, 245, 210)),
	ColorSequenceKeypoint.new(1,    Color3.fromRGB(100, 175, 255)),
})
loadingFillGradient.Offset = Vector2.new(-1, 0)
loadingFillGradient.Parent = loadingAccent

-- Glint on progress fill
local fillGlint = Instance.new('Frame')
fillGlint.Name = 'Glint'
fillGlint.Size = UDim2.new(0, 28, 1.6, 0)
fillGlint.AnchorPoint = Vector2.new(0.5, 0.5)
fillGlint.Position = UDim2.new(1, -4, 0.5, 0)
fillGlint.BackgroundColor3 = Color3.new(1, 1, 1)
fillGlint.BackgroundTransparency = 0.6
fillGlint.BorderSizePixel = 0
fillGlint.ZIndex = 8
fillGlint.ClipsDescendants = false
fillGlint.Parent = loadingAccent
local glintCorner = Instance.new('UICorner')
glintCorner.CornerRadius = UDim.new(1, 0)
glintCorner.Parent = fillGlint
local glintGrad = Instance.new('UIGradient')
glintGrad.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),
	ColorSequenceKeypoint.new(0.5, Color3.new(1,1,1)),
	ColorSequenceKeypoint.new(1, Color3.new(0,0,0)),
})
glintGrad.Rotation = 90
glintGrad.Parent = fillGlint

-- Percent label
local loadingPercent = Instance.new('TextLabel')
loadingPercent.Name = 'Percent'
loadingPercent.AnchorPoint = Vector2.new(1, 0.5)
loadingPercent.Position = UDim2.new(1, -10, 0.5, 0)
loadingPercent.Size = UDim2.fromOffset(46, 14)
loadingPercent.BackgroundTransparency = 1
loadingPercent.Font = Enum.Font.GothamBold
loadingPercent.Text = '3%'
loadingPercent.TextColor3 = Color3.fromRGB(248, 252, 255)
loadingPercent.TextSize = 11
loadingPercent.TextXAlignment = Enum.TextXAlignment.Right
loadingPercent.ZIndex = 8
loadingPercent.Parent = loadingTrack

loadingProgress:GetPropertyChangedSignal('Value'):Connect(function()
	local progress = math.clamp(loadingProgress.Value, 0, 100)
	loadingAccent.Size = UDim2.new(progress / 100, 0, 1, 0)
	loadingPercent.Text = string.format('%d%%', math.floor(progress + 0.5))
	-- glint follows leading edge
	fillGlint.Position = UDim2.new(1, -4, 0.5, 0)
end)

-- Footer
local loadingFooter = Instance.new('TextLabel')
loadingFooter.Name = 'Footer'
loadingFooter.AnchorPoint = Vector2.new(0.5, 0.5)
loadingFooter.Position = UDim2.new(0.5, 0, 0.5, 108)
loadingFooter.Size = UDim2.new(1, -32, 0, 24)
loadingFooter.BackgroundTransparency = 1
loadingFooter.Font = Enum.Font.FredokaOne
loadingFooter.Text = 'join .gg/gu9mball'
loadingFooter.TextColor3 = Color3.fromRGB(130, 170, 195)
loadingFooter.TextXAlignment = Enum.TextXAlignment.Center
loadingFooter.TextYAlignment = Enum.TextYAlignment.Center
loadingFooter.TextScaled = true
loadingFooter.TextTransparency = 1
loadingFooter.ZIndex = 7
loadingFooter.Parent = loadingContent
local loadingFooterConstraint = Instance.new('UITextSizeConstraint')
loadingFooterConstraint.MinTextSize = 13
loadingFooterConstraint.MaxTextSize = 19
loadingFooterConstraint.Parent = loadingFooter

-- ─── ENTRY ANIMATIONS ────────────────────────────────────────────────────────

-- Badge: drop in + pop scale
TweenService:Create(loadingBrandBadge,
	TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
	Position = UDim2.new(0.5, 0, 0.5, -106)
}):Play()

-- GUMBALL label inside badge fades + scales up
TweenService:Create(loadingTitle,
	TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {
	TextTransparency = 0
}):Play()
TweenService:Create(loadingTitlePop,
	TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.1), {
	Scale = 1
}):Play()

-- RIVALS: slides up from Y=-10 → -28 + scale pop + fade
TweenService:Create(loadingRivals,
	TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.15), {
	TextTransparency = 0,
	Position = UDim2.new(0.5, 0, 0.5, -38)
}):Play()
TweenService:Create(rivalsPop,
	TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0.15), {
	Scale = 1
}):Play()

-- Continuous subtle RIVALS float
task.delay(0.8, function()
	TweenService:Create(loadingRivals, TweenInfo.new(3.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		Position = UDim2.new(0.5, 0, 0.5, -42)
	}):Play()
end)

-- Status fades in
TweenService:Create(loadingStatus,
	TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.22), {
	TextTransparency = 0
}):Play()

-- Footer fades in
TweenService:Create(loadingFooter,
	TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.28), {
	TextTransparency = 0
}):Play()

-- Progress bar fill gradient sweep
TweenService:Create(loadingFillGradient,
	TweenInfo.new(1.4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true), {
	Offset = Vector2.new(1, 0)
}):Play()

-- Progress value tween (86% idle cap, same as original)
local loadingProgressTween = TweenService:Create(loadingProgress,
	TweenInfo.new(2.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
	Value = 86
})
loadingProgressTween:Play()

-- ─── STATUS CYCLE ─────────────────────────────────────────────────────────────

local loadingScreenFinishing = false
local loadingScreenDismissed = false
local loadingFinishCallbacks = {}
local loadingStatuses = {
	'INITIALIZING GUMBALL',
	'SYNCING UI SETTINGS',
	'LOADING MODULES',
	'PREPARING MENU',
	'VERIFYING ASSETS',
}

task.spawn(function()
	local statusIndex = 1
	while loadingGui.Parent and not loadingScreenFinishing do
		task.wait(0.85)
		if loadingScreenFinishing or not loadingGui.Parent then break end
		statusIndex = statusIndex % #loadingStatuses + 1

		-- Slide out left + fade
		TweenService:Create(loadingStatus, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			TextTransparency = 1,
			Position = UDim2.new(0.5, -18, 0.5, 24)
		}):Play()
		task.wait(0.2)
		if loadingScreenFinishing or not loadingGui.Parent then break end

		loadingStatus.Text = loadingStatuses[statusIndex]
		loadingStatus.Position = UDim2.new(0.5, 18, 0.5, 24)

		-- Slide in right + fade in
		TweenService:Create(loadingStatus, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			TextTransparency = 0,
			Position = UDim2.new(0.5, 0, 0.5, 24)
		}):Play()
	end
end)

-- ─── FINISH ───────────────────────────────────────────────────────────────────

local function FinishLoadingScreen(onFinished)
	if onFinished then
		if loadingScreenDismissed then
			onFinished()
		else
			table.insert(loadingFinishCallbacks, onFinished)
		end
	end

	if loadingScreenFinishing then return end
	loadingScreenFinishing = true

	local waitTime = math.max(0, loadingMinimumDuration - loadingFadeDuration - (os.clock() - loadingStartedAt))
	task.delay(waitTime, function()
		-- Progress snaps to 100
		TweenService:Create(loadingProgress,
			TweenInfo.new(loadingFadeDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Value = 100
		}):Play()

		task.wait(0.18)

		-- Everything fades out together
		local fadeInfo = TweenInfo.new(loadingFadeDuration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		TweenService:Create(loadingOverlay,    fadeInfo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(loadingTitle,      fadeInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(loadingRivals,     fadeInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(loadingStatus,     fadeInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(loadingFooter,     fadeInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(loadingCursor,     fadeInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(loadingTrack,      fadeInfo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(loadingTrackStroke,fadeInfo, { Transparency = 1 }):Play()
		TweenService:Create(loadingPercent,    fadeInfo, { TextTransparency = 1 }):Play()
		TweenService:Create(loadingAccent,     fadeInfo, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(loadingBlur,       fadeInfo, { Size = 0 }):Play()

		task.delay(loadingFadeDuration, function()
			if loadingGui.Parent  then loadingGui:Destroy()  end
			if loadingBlur.Parent then loadingBlur:Destroy() end
			loadingScreenDismissed = true
			for _, cb in ipairs(loadingFinishCallbacks) do cb() end
			table.clear(loadingFinishCallbacks)
		end)
	end)
end

task.delay(45, function()
	FinishLoadingScreen()
end)
