-- ==========================================================
-- FILE: lua/theme/high_contrast.lua
-- ==========================================================

local palette = require("theme.palette")

local M = {}

function M.get()
	return {
		bg = "#000000",
		bg_alt = "#0a0a0a",
		bg_dark = "#000000",

		fg = "#ffffff",
		fg_alt = "#e0e0e0",
		fg_dark = "#b0b0b0",

		border = "#ffffff",
		cursorline = "#111111",
		selection = "#333333",
		float_bg = "#000000",

		accent = {
			blue = "#00aaff",
			cyan = "#00ffff",
			green = "#00ff00",
			yellow = "#ffff00",
			orange = "#ff8800",
			red = "#ff0000",
			purple = "#ff00ff",
		},

		diag = {
			error = "#ff0000",
			warn = "#ffff00",
			info = "#00aaff",
			hint = "#00ffff",
		},

		git = {
			add = "#00ff00",
			change = "#00aaff",
			delete = "#ff0000",
		},
	}
end

return M
