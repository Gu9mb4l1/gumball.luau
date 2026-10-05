local WorldTabbox = Tabs.World:AddLeftTabbox()
local ColorCorrectionTab = WorldTabbox:AddTab('color correction')
local AtmosphereTab = WorldTabbox:AddTab('atmosphere')
local LightingService = game:GetService('Lighting')

-- =========================================================================
-- Guarded-instance helpers (Kicia Rebuild technique)
-- =========================================================================
local function GuardedInstance(instance)
	local originalByProperty = {}
	local overrideByProperty = {}
	local dead = false
	local conn = instance.Changed:Connect(function(property)
		if dead then return end
		local override = overrideByProperty[property]
		if override == nil then return end
		local current = instance[property]
		if current == override then return end
		originalByProperty[property] = current
		instance[property] = override
	end)
	return {
		Instance = instance,
		SetOverride = function(self, property, value)
			if originalByProperty[property] == nil then
				originalByProperty[property] = instance[property]
			end
			overrideByProperty[property] = value
			instance[property] = value
		end,
		ClearOverride = function(self, property)
			local original = originalByProperty[property]
			if original ~= nil then
				originalByProperty[property] = nil
				overrideByProperty[property] = nil
				instance[property] = original
			end
		end,
		ClearAllOverrides = function(self)
			for property in next, overrideByProperty do
				local original = originalByProperty[property]
				originalByProperty[property] = nil
				overrideByProperty[property] = nil
				pcall(function() instance[property] = original end)
			end
		end,
		Destroy = function(self)
			dead = true
			conn:Disconnect()
			for property, original in next, originalByProperty do
				pcall(function() instance[property] = original end)
			end
		end,
	}
end

-- Keeps ONE of our own `className` in `parent`, disables every foreign one,
-- and auto-recreates ours if the game nukes it.
local function EffectGuard(parent, className, namePrefix)
	namePrefix = namePrefix or 'Gumball'
	local foreign = {}
	local ourInstance
	local destroyed = false

	local function isOurs(child)
		return child:IsA(className) and child.Name:sub(1, #namePrefix) == namePrefix
	end

	local function findOurs()
		for _, child in ipairs(parent:GetChildren()) do
			if isOurs(child) then return child end
		end
		return nil
	end

	local function ensureOurs()
		ourInstance = findOurs()
		if ourInstance == nil then
			local ours = Instance.new(className)
			ours.Name = namePrefix .. className
			ours.Parent = parent
			ourInstance = ours
		end
	end

	local function disableForeign()
		for _, child in ipairs(parent:GetChildren()) do
			if child:IsA(className) and not isOurs(child) then
				if foreign[child] == nil then
					local g = GuardedInstance(child)
					g:SetOverride('Enabled', false)
					foreign[child] = g
				end
			end
		end
	end

	ensureOurs()
	local ourGuard = GuardedInstance(ourInstance)

	local connAdded = parent.ChildAdded:Connect(function(child)
		if destroyed then return end
		if child:IsA(className) then
			task.defer(function()
				if not destroyed then
					disableForeign()
					if not isOurs(child) then
						-- our instance might have been removed; make sure ours exists
						ensureOurs()
					end
				end
			end)
		end
	end)

	disableForeign()

	return {
		Instance = function() return ourInstance end,
		SetOverride = function(_, property, value)
			ourGuard:SetOverride(property, value)
		end,
		ClearOverride = function(_, property)
			ourGuard:ClearOverride(property)
		end,
		Destroy = function(_)
			destroyed = true
			connAdded:Disconnect()
			for _, g in next, foreign do g:Destroy() end
			table.clear(foreign)
			ourGuard:Destroy()
			if ourInstance and ourInstance.Parent then
				pcall(function() ourInstance:Destroy() end)
			end
		end,
	}
end

-- =========================================================================
-- Color Correction (guarded)
-- =========================================================================
local ColorCorrectionGuard = EffectGuard(LightingService, 'ColorCorrectionEffect')

local WorldColorCorrectionToggle = ColorCorrectionTab:AddToggle('WorldColorCorrectionEnabled', {
	Text = 'enabled',
	Default = false
})
WorldColorCorrectionToggle:OnChanged(function(value)
	if not ColorCorrectionGuard.Instance() then return end
	ColorCorrectionGuard:SetOverride('Enabled', value)
end)

ColorCorrectionTab:AddLabel('Tint'):AddColorPicker('WorldColorCorrectionTint', {
	Default = Color3.new(1, 1, 1),
	Title = 'Color correction tint'
})
Options.WorldColorCorrectionTint:OnChanged(function(value)
	ColorCorrectionGuard:SetOverride('TintColor', value)
	if value ~= Color3.new(1, 1, 1) and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

ColorCorrectionTab:AddSlider('WorldColorCorrectionSaturation', {
	Text = 'saturation', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	ColorCorrectionGuard:SetOverride('Saturation', value)
	if value ~= 0 and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

ColorCorrectionTab:AddSlider('WorldColorCorrectionContrast', {
	Text = 'contrast', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	ColorCorrectionGuard:SetOverride('Contrast', value)
	if value ~= 0 and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

ColorCorrectionTab:AddSlider('WorldColorCorrectionBrightness', {
	Text = 'brightness', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	ColorCorrectionGuard:SetOverride('Brightness', value)
	if value ~= 0 and not WorldColorCorrectionToggle.Value then
		WorldColorCorrectionToggle:SetValue(true)
	end
end)

-- =========================================================================
-- Atmosphere (guarded)
-- =========================================================================
local AtmosphereGuard = EffectGuard(LightingService, 'Atmosphere')

local WorldAtmosphereToggle = AtmosphereTab:AddToggle('WorldAtmosphereEnabled', {
	Text = 'enabled',
	Default = false
})

local function ApplyAtmosphereEnabled()
	-- We can't "enable" an Atmosphere, so we suppress foreign ones
	-- and swap our own instance's Enabled state via parent.
	local ours = AtmosphereGuard.Instance()
	if not ours then return end
	if WorldAtmosphereToggle.Value then
		ours.Parent = LightingService
	else
		-- move ours out of Lighting so only the game's is rendered
		ours.Parent = nil
	end
end

WorldAtmosphereToggle:OnChanged(function(value)
	if worldEffectsUnloaded then return end
	ApplyAtmosphereEnabled()
end)

local function EnableWorldAtmosphereForEdit()
	if not worldEffectsUnloaded and not WorldAtmosphereToggle.Value then
		WorldAtmosphereToggle:SetValue(true)
	end
end

AtmosphereTab:AddSlider('WorldAtmosphereDensity', {
	Text = 'density', Default = 0, Min = 0, Max = 1, Rounding = 2
}):OnChanged(function(value)
	AtmosphereGuard:SetOverride('Density', value)
	if value ~= 0 then EnableWorldAtmosphereForEdit() end
end)

AtmosphereTab:AddSlider('WorldAtmosphereOffset', {
	Text = 'offset', Default = 0, Min = -1, Max = 1, Rounding = 2
}):OnChanged(function(value)
	AtmosphereGuard:SetOverride('Offset', value)
	if value ~= 0 then EnableWorldAtmosphereForEdit() end
end)

AtmosphereTab:AddSlider('WorldAtmosphereHaze', {
	Text = 'haze', Default = 0, Min = 0, Max = 10, Rounding = 1
}):OnChanged(function(value)
	AtmosphereGuard:SetOverride('Haze', value)
	if value ~= 0 then EnableWorldAtmosphereForEdit() end
end)

AtmosphereTab:AddSlider('WorldAtmosphereGlare', {
	Text = 'glare', Default = 0, Min = 0, Max = 10, Rounding = 1
}):OnChanged(function(value)
	AtmosphereGuard:SetOverride('Glare', value)
	if value ~= 0 then EnableWorldAtmosphereForEdit() end
end)

AtmosphereTab:AddLabel('Color'):AddColorPicker('WorldAtmosphereColor', {
	Default = Color3.new(1, 1, 1),
	Title = 'Atmosphere color'
})
Options.WorldAtmosphereColor:OnChanged(function(value)
	AtmosphereGuard:SetOverride('Color', value)
	if value ~= Color3.new(1, 1, 1) then EnableWorldAtmosphereForEdit() end
end)

AtmosphereTab:AddLabel('Decay'):AddColorPicker('WorldAtmosphereDecay', {
	Default = Color3.new(1, 1, 1),
	Title = 'Atmosphere decay'
})
Options.WorldAtmosphereDecay:OnChanged(function(value)
	AtmosphereGuard:SetOverride('Decay', value)
	if value ~= Color3.new(1, 1, 1) then EnableWorldAtmosphereForEdit() end
end)

-- =========================================================================
-- Sync loop: runs every frame and makes sure:
--   * our CC is still in Lighting, still Enabled=true when toggle is on,
--     and every value is what the user picked
--   * our Atmosphere is parented where it should be and has our values
--   * any newly-parented foreign Atmosphere/ColorCorrectionEffect is disabled
-- =========================================================================
local worldEffectsUnloaded = false

local function SyncWorldEffects()
	if worldEffectsUnloaded then return end

	-- ===== Color Correction =====
	local cc = ColorCorrectionGuard.Instance()
	if cc then
		cc.Enabled = WorldColorCorrectionToggle.Value
		cc.Saturation = Options.WorldColorCorrectionSaturation.Value
		cc.Contrast = Options.WorldColorCorrectionContrast.Value
		cc.Brightness = Options.WorldColorCorrectionBrightness.Value
		cc.TintColor = Options.WorldColorCorrectionTint.Value
	end

	-- ===== Atmosphere =====
	local atmo = AtmosphereGuard.Instance()
	if atmo then
		atmo.Density = Options.WorldAtmosphereDensity.Value
		atmo.Offset = Options.WorldAtmosphereOffset.Value
		atmo.Haze = Options.WorldAtmosphereHaze.Value
		atmo.Glare = Options.WorldAtmosphereGlare.Value
		atmo.Color = Options.WorldAtmosphereColor.Value
		atmo.Decay = Options.WorldAtmosphereDecay.Value

		local wantParent = WorldAtmosphereToggle.Value and LightingService or nil
		if atmo.Parent ~= wantParent then
			pcall(function() atmo.Parent = wantParent end)
		end
	end
end

-- Extra heartbeat pass so we run twice per frame
Library:GiveSignal(game:GetService('RunService').Heartbeat:Connect(SyncWorldEffects))

-- Cleanup on unload
local previousWorldUnload = Library.OnUnload
Library:OnUnload(function()
	worldEffectsUnloaded = true
	if previousWorldUnload then previousWorldUnload() end
	ColorCorrectionGuard:Destroy()
	AtmosphereGuard:Destroy()
end)
