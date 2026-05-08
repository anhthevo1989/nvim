-- ==========================================================
-- FILE: lua/theme/dark.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Define the default dark Pulse theme variant.
--
-- WHY IT EXISTS
-- -------------
-- Provides the default Pulse theme used across the editor.
--
-- HOW IT WORKS
-- ------------
-- Pulls shared values from theme.palette and returns them
-- in the format expected by theme.apply.
--
-- FLOW
-- ----
-- theme.apply loads dark
-- → dark returns colors
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

		bg = palette.base.bg,
		bg_alt = palette.base.bg_alt,
		bg_dark = palette.base.bg_dark,

		------------------------------------------
		-- FOREGROUNDS
		------------------------------------------

		fg = palette.base.fg,
		fg_alt = palette.base.fg_alt,
		fg_dark = palette.base.fg_dark,

		------------------------------------------
		-- UI
		------------------------------------------

		border = palette.ui.border,
		cursorline = palette.ui.cursorline,
		selection = palette.ui.selection,
		float_bg = palette.ui.float_bg,

		------------------------------------------
		-- SHARED GROUPS
		------------------------------------------

		accent = palette.accent,
		diag = palette.diag,
		git = palette.git,
	}
end

return M
