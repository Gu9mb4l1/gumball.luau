--!strict
-- Tabbed menu in pure Luau (runs on Lune: https://lune-org.github.io/docs)
-- Run with:  lune run menu

local stdio = require("@lune/stdio")
local task = require("@lune/task")

---------------------------------------------------------------------
-- Config
---------------------------------------------------------------------
local WIDTH = 56
local TAB_PADDING = 2
local ANIM_FRAMES = 14
local FRAME_TIME = 0.2

type Tab = { name: string, lines: { string } }

local tabs: { Tab } = {
	{ name = "main", lines = { "Welcome back!", "", "Pick a tab above to get started." } },
	{ name = "world", lines = { "> Quick Match", "> Ranked", "> Custom Game" } },
	{ name = "esp", lines = { "Sword      100 coins", "Shield      80 coins", "Potion      25 coins" } },
	{ name = "visuals", lines = { "Level:    12", "Wins:     48", "Playtime: 36h" } },
	{ name = "charcter", lines = { "Music:   ON", "Sound:   ON", "Quality: High" } },
	{ name = "misc", lines = { "Music:   ON", "Sound:   ON", "Quality: High" } },
	{ name = "settings", lines = { "Music:   ON", "Sound:   ON", "Quality: High" } },


}

---------------------------------------------------------------------
-- Colors (ANSI)
---------------------------------------------------------------------
local ESC = "\27["
local RESET = ESC .. "0m"
local BOLD_CYAN = ESC .. "1;96m"
local DIM = ESC .. "90m"
local CYAN = ESC .. "96m"
local DARK_CYAN = ESC .. "36m"
local WHITE = ESC .. "97m"

---------------------------------------------------------------------
-- Layout: where each tab sits on the row
---------------------------------------------------------------------
local positions: { { start: number, width: number } } = {}
do
	local x = 2
	for i, tab in tabs do
		local w = #tab.name + TAB_PADDING * 2
		positions[i] = { start = x, width = w }
		x += w + 1
	end
end

---------------------------------------------------------------------
-- Helpers
---------------------------------------------------------------------
local function easeOutCubic(t: number): number
	return 1 - (1 - t) ^ 3
end

local function lerp(a: number, b: number, t: number): number
	return a + (b - a) * t
end

local function round(n: number): number
	return math.floor(n + 0.5)
end

---------------------------------------------------------------------
-- Rendering
---------------------------------------------------------------------
local function render(active: number, barStart: number, barWidth: number)
	local out: { string } = {}

	table.insert(out, ESC .. "2J" .. ESC .. "H") -- clear screen
	table.insert(out, "")
	table.insert(out, " " .. WHITE .. "Gu9mball - .gg/gu9mball" .. RESET)
	table.insert(out, "")

	-- Tab names row
	local row = " "
	for i, tab in tabs do
		local label = string.rep(" ", TAB_PADDING) .. tab.name .. string.rep(" ", TAB_PADDING)
		row ..= (if i == active then BOLD_CYAN else DIM) .. label .. RESET .. " "
	end
	table.insert(out, row)

	-- Glow row (soft light under the active tab)
	local s = round(barStart)
	local e = round(barStart + barWidth) - 1
	local glow = ""
	for c = 1, WIDTH do
		glow ..= (if c >= s and c <= e then DARK_CYAN .. "░" else " ")
	end
	table.insert(out, glow .. RESET)

	-- Line row (sliding bright indicator on a dim track)
	local line = ""
	for c = 1, WIDTH do
		if c >= s and c <= e then
			line ..= CYAN .. "━"
		else
			line ..= DIM .. "─"
		end
	end
	table.insert(out, line .. RESET)
	table.insert(out, "")

	-- Content
	for _, text in tabs[active].lines do
		table.insert(out, "   " .. WHITE .. text .. RESET)
	end

	table.insert(out, "")
	table.insert(out, DIM .. string.rep("─", WIDTH) .. RESET)
	table.insert(out, DIM .. " 1-5 jump to tab   a/d prev/next   q quit" .. RESET)

	stdio.write(table.concat(out, "\n") .. "\n")
end

---------------------------------------------------------------------
-- Smooth tab switching
---------------------------------------------------------------------
local current = 1

local function switchTo(target: number)
	if target == current then
		return
	end

	local from = positions[current]
	local to = positions[target]

	for frame = 1, ANIM_FRAMES do
		local t = easeOutCubic(frame / ANIM_FRAMES)
		-- name highlight flips halfway through the slide
		local shown = if t < 0.5 then current else target
		render(shown, lerp(from.start, to.start, t), lerp(from.width, to.width, t))
		task.wait(FRAME_TIME)
	end

	current = target
	render(current, to.start, to.width)
end

---------------------------------------------------------------------
-- Main loop
---------------------------------------------------------------------
render(current, positions[current].start, positions[current].width)

while true do
	local input = string.lower(stdio.prompt("text", "Tab"))

	if input == "q" then
		break
	elseif input == "d" then
		switchTo(if current == #tabs then 1 else current + 1)
	elseif input == "a" then
		switchTo(if current == 1 then #tabs else current - 1)
	else
		local n = tonumber(input)
		if n and n >= 1 and n <= #tabs and n == math.floor(n) then
			switchTo(n)
		end
	end
end

stdio.write(ESC .. "2J" .. ESC .. "H")
