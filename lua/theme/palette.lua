-- ==========================================================
-- FILE: lua/theme/palette.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Define the global color palette for the entire config.
--
-- WHY IT EXISTS
-- -------------
-- All UI elements (highlights, statusline, plugins) should
-- pull from a single source of truth.
--
-- HOW IT WORKS
-- ------------
-- Returns a table of named colors grouped by purpose.
--
-- BEGINNER NOTES
-- --------------
-- Do NOT use hex colors anywhere else in the config.
-- Always reference colors from this file.
-- ==========================================================

local palette = {}

-- ==========================================================
-- BASE
-- ==========================================================

palette.base = {
	bg = "#0f1117",
	bg_alt = "#1a1d25",
	bg_dark = "#0b0d12",

	fg = "#c6d0f5",
	fg_alt = "#a5adce",
	fg_dark = "#737994",
}

-- ==========================================================
-- ACCENTS
-- ==========================================================

palette.accent = {
	blue = "#8caaee",
	cyan = "#99d1db",
	green = "#a6d189",
	yellow = "#e5c890",
	orange = "#ef9f76",
	red = "#e78284",
	purple = "#ca9ee6",
}

-- ==========================================================
-- UI
-- ==========================================================

palette.ui = {
	border = "#303446",
	separator = "#232634",
	cursorline = "#1e2030",
	selection = "#414559",
	float_bg = "#181926",
}

-- ==========================================================
-- DIAGNOSTICS
-- ==========================================================

palette.diag = {
	error = palette.accent.red,
	warn = palette.accent.yellow,
	info = palette.accent.blue,
	hint = palette.accent.cyan,
}

-- ==========================================================
-- GIT
-- ==========================================================

palette.git = {
	add = palette.accent.green,
	change = palette.accent.blue,
	delete = palette.accent.red,
}

-- ==========================================================
-- TERMINAL
-- ==========================================================

palette.term = {
	black = "#51576d",
	red = palette.accent.red,
	green = palette.accent.green,
	yellow = palette.accent.yellow,
	blue = palette.accent.blue,
	magenta = palette.accent.purple,
	cyan = palette.accent.cyan,
	white = palette.base.fg,
}

return palette
