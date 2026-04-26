-- ==========================================================
-- FILE: lua/theme/apply.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Apply the active theme variant.
--
-- WHY IT EXISTS
-- -------------
-- Theme variants define colors.
-- This file applies those colors to Neovim highlight groups.
--
-- HOW IT WORKS
-- ------------
-- The active variant is selected by name.
-- The variant returns semantic colors.
-- Those colors are applied with vim.api.nvim_set_hl.
--
-- BEGINNER NOTES
-- --------------
-- Do not hardcode plugin colors here unless they come from
-- the selected theme table.
-- ==========================================================

local M = {}

local active_theme = "dark"

local function set(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

local function get_theme(theme_name)
	if theme_name == "light" then
		return require("theme.light").get()
	end

	if theme_name == "high_contrast" then
		return require("theme.high_contrast").get()
	end

	return require("theme.dark").get()
end

function M.apply(theme_name)
	active_theme = theme_name or active_theme

	local theme = get_theme(active_theme)

	-- ======================================================
	-- CORE
	-- ======================================================

	set("Normal", { fg = theme.fg, bg = theme.bg })
	set("NormalFloat", { fg = theme.fg, bg = theme.float_bg })
	set("NormalNC", { fg = theme.fg, bg = theme.bg })
	set("NormalFloatNC", { fg = theme.fg, bg = theme.float_bg })

	set("CursorLine", { bg = theme.cursorline })
	set("Visual", { bg = theme.selection })

	set("LineNr", { fg = theme.fg_dark })
	set("CursorLineNr", { fg = theme.accent.yellow })

	set("VertSplit", { fg = theme.border })
	set("WinSeparator", { fg = theme.border })

	set("SignColumn", { bg = theme.bg })
	set("EndOfBuffer", { fg = theme.bg })

	-- ======================================================
	-- SYNTAX
	-- ======================================================

	set("Comment", { fg = theme.fg_dark, italic = true })

	set("String", { fg = theme.accent.green })
	set("Number", { fg = theme.accent.orange })
	set("Boolean", { fg = theme.accent.orange })

	set("Identifier", { fg = theme.fg })
	set("Function", { fg = theme.accent.blue })

	set("Keyword", { fg = theme.accent.purple })
	set("Type", { fg = theme.accent.yellow })

	-- ======================================================
	-- DIAGNOSTICS
	-- ======================================================

	set("DiagnosticError", { fg = theme.diag.error })
	set("DiagnosticWarn", { fg = theme.diag.warn })
	set("DiagnosticInfo", { fg = theme.diag.info })
	set("DiagnosticHint", { fg = theme.diag.hint })

	set("DiagnosticUnderlineError", { undercurl = true, sp = theme.diag.error })
	set("DiagnosticUnderlineWarn", { undercurl = true, sp = theme.diag.warn })
	set("DiagnosticUnderlineInfo", { undercurl = true, sp = theme.diag.info })
	set("DiagnosticUnderlineHint", { undercurl = true, sp = theme.diag.hint })

	-- ======================================================
	-- SEARCH
	-- ======================================================

	set("Search", { fg = theme.bg, bg = theme.accent.yellow })
	set("IncSearch", { fg = theme.bg, bg = theme.accent.orange })

	-- ======================================================
	-- COMPLETION MENU
	-- ======================================================

	set("Pmenu", { fg = theme.fg, bg = theme.float_bg })
	set("PmenuSel", { fg = theme.bg, bg = theme.accent.blue })
	set("PmenuSbar", { bg = theme.bg_alt })
	set("PmenuThumb", { bg = theme.border })

	-- ======================================================
	-- BARBAR (ACTIVE = CYAN TEXT)
	-- ======================================================

	set("BufferCurrent", {
		fg = theme.accent.cyan,
		bg = theme.bg,
		bold = true,
	})

	set("BufferCurrentMod", {
		fg = theme.accent.orange,
		bg = theme.bg,
	})

	set("BufferCurrentSign", {
		fg = theme.accent.cyan,
		bg = theme.bg,
	})

	set("BufferInactive", {
		fg = theme.fg_dark,
		bg = theme.bg,
	})

	set("BufferInactiveMod", {
		fg = theme.accent.orange,
		bg = theme.bg,
	})

	set("BufferInactiveSign", {
		fg = theme.border,
		bg = theme.bg,
	})

	-- ======================================================
	-- CMP (POPUP POLISH)
	-- ======================================================

	set("Pmenu", {
		fg = theme.fg,
		bg = theme.float_bg,
	})

	set("PmenuSel", {
		fg = theme.bg,
		bg = theme.accent.cyan,
		bold = true,
	})

	set("PmenuSbar", {
		bg = theme.bg_alt,
	})

	set("PmenuThumb", {
		bg = theme.border,
	})

	-- optional but recommended (better grouping clarity)

	set("CmpItemAbbr", {
		fg = theme.fg,
	})

	set("CmpItemAbbrMatch", {
		fg = theme.accent.cyan,
		bold = true,
	})

	set("CmpItemAbbrMatchFuzzy", {
		fg = theme.accent.cyan,
		italic = true,
	})

	set("CmpItemMenu", {
		fg = theme.fg_dark,
	})

	set("CmpItemKind", {
		fg = theme.accent.blue,
	})
end

function M.current()
	return active_theme
end

return M
