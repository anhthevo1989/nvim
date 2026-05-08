-- ==========================================================
-- FILE: lua/theme/high_contrast.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Define the high contrast Pulse theme variant.
--
-- WHY IT EXISTS
-- -------------
-- Provides a higher-contrast accessibility-focused version
-- of Pulse while preserving the same theme structure.
--
-- HOW IT WORKS
-- ------------
-- Returns high-contrast color values in the format expected
-- by theme.apply.
--
-- FLOW
-- ----
-- theme.apply loads high_contrast
-- → high_contrast returns colors
-- → highlights are applied
--
-- BEGINNER NOTES
-- --------------
-- This variant intentionally prioritizes visibility over subtlety.
-- ==========================================================

local palette = require("theme.palette")

local M = {}

function M.get()
	return {
		------------------------------------------
		-- BACKGROUNDS
		------------------------------------------

		bg = "#000000",
		bg_alt = "#0a0a0a",
		bg_dark = "#000000",

		------------------------------------------
		-- FOREGROUNDS
		------------------------------------------

		fg = "#ffffff",
		fg_alt = "#e0e0e0",
		fg_dark = "#b0b0b0",

		------------------------------------------
		-- UI
		------------------------------------------

		border = "#ffffff",
		cursorline = "#111111",
		selection = "#333333",
		float_bg = "#000000",

		------------------------------------------
		-- ACCENTS
		------------------------------------------

		accent = {
			blue = "#00aaff",
			cyan = "#00ffff",
			green = "#00ff00",
			yellow = "#ffff00",
			orange = "#ff8800",
			red = "#ff0000",
			purple = "#ff00ff",
		},

		------------------------------------------
		-- DIAGNOSTICS
		------------------------------------------

		diag = {
			error = "#ff0000",
			warn = "#ffff00",
			info = "#00aaff",
			hint = "#00ffff",
		},

		------------------------------------------
		-- GIT
		------------------------------------------

		git = {
			add = "#00ff00",
			change = "#00aaff",
			delete = "#ff0000",
		},
	}
end

return M
