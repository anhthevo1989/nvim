-- ==========================================================
-- FILE: lua/theme/dark.lua
-- ==========================================================

local palette = require("theme.palette")

local M = {}

function M.get()
	return {
		bg = palette.base.bg,
		bg_alt = palette.base.bg_alt,
		bg_dark = palette.base.bg_dark,

		fg = palette.base.fg,
		fg_alt = palette.base.fg_alt,
		fg_dark = palette.base.fg_dark,

		border = palette.ui.border,
		cursorline = palette.ui.cursorline,
		selection = palette.ui.selection,
		float_bg = palette.ui.float_bg,

		accent = palette.accent,
		diag = palette.diag,
		git = palette.git,
	}
end

return M
