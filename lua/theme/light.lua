-- ==========================================================
-- FILE: lua/theme/light.lua
-- ==========================================================

local palette = require("theme.palette")

local M = {}

function M.get()
	return {
		bg = "#ffffff",
		bg_alt = "#f2f2f2",
		bg_dark = "#e5e5e5",

		fg = "#2e3440",
		fg_alt = "#4c566a",
		fg_dark = "#6b7280",

		border = "#d0d0d0",
		cursorline = "#eeeeee",
		selection = "#d6e4ff",
		float_bg = "#ffffff",

		accent = palette.accent,
		diag = palette.diag,
		git = palette.git,
	}
end

return M
