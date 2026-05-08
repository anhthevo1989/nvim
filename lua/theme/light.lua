-- ==========================================================
-- FILE: lua/theme/light.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Define the light Pulse theme variant.
--
-- WHY IT EXISTS
-- -------------
-- Provides a light-mode version of Pulse while keeping the same
-- theme table structure used by the other variants.
--
-- HOW IT WORKS
-- ------------
-- Returns light-specific color values and shared palette groups
-- in the format expected by theme.apply.
--
-- FLOW
-- ----
-- theme.apply loads light
-- → light returns colors
-- → highlights are applied
--
-- BEGINNER NOTES
-- --------------
-- This file only returns color values.
-- It does not apply highlights directly.
-- ==========================================================

local palette = require("theme.palette")

local M = {}

function M.get()
	return {
		------------------------------------------
		-- BACKGROUNDS
		------------------------------------------

		bg = "#ffffff",
		bg_alt = "#f2f2f2",
		bg_dark = "#e5e5e5",

		------------------------------------------
		-- FOREGROUNDS
		------------------------------------------

		fg = "#2e3440",
		fg_alt = "#4c566a",
		fg_dark = "#6b7280",

		------------------------------------------
		-- UI
		------------------------------------------

		border = "#d0d0d0",
		cursorline = "#eeeeee",
		selection = "#d6e4ff",
		float_bg = "#ffffff",

		------------------------------------------
		-- SHARED GROUPS
		------------------------------------------

		accent = palette.accent,
		diag = palette.diag,
		git = palette.git,
	}
end

return M
