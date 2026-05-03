-- ==========================================================
-- FILE: lua/theme/apply.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Apply Pulse theme highlights across Neovim.
--
-- WHY IT EXISTS
-- -------------
-- A palette alone does not theme Neovim. This file connects Pulse colors to
-- real highlight groups used by the editor and plugins.
--
-- HOW IT WORKS
-- ------------
-- Loads the selected Pulse variant, checks transparency state, then applies
-- highlight groups for core UI, syntax, diagnostics, search, git, popups, and
-- common plugins.
--
-- FLOW
-- ----
-- Theme state loads -> theme colors are selected -> highlights are applied ->
-- Neovim displays the Pulse theme consistently.
--
-- BEGINNER NOTES
-- --------------
-- The palette defines colors. This file decides where those colors appear.
-- ==========================================================

local state = require("theme.state")

local M = {}

local function get_theme(name)
	return require("theme." .. name).get()
end

local function set(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

function M.apply(theme_name)
	local saved = state.load()

	local active_theme = theme_name or saved.theme or "dark"
	local theme = get_theme(active_theme)

	local transparent = saved.transparent

	local normal_bg = transparent and "NONE" or theme.bg
	local float_bg = transparent and "NONE" or theme.float_bg
	local alt_bg = transparent and "NONE" or theme.bg_alt

	-- ======================================================
	-- CORE EDITOR UI
	-- ======================================================

	set("Normal", { fg = theme.fg, bg = normal_bg })
	set("NormalNC", { fg = theme.fg, bg = normal_bg })
	set("NormalFloat", { fg = theme.fg, bg = theme.bg })
	set("FloatBorder", { fg = theme.border, bg = theme.bg })
	set("WinSeparator", { fg = theme.border, bg = normal_bg })
	set("VertSplit", { fg = theme.border, bg = normal_bg })

	set("CursorLine", { bg = theme.cursorline })
	set("Visual", { bg = theme.selection })
	set("LineNr", { fg = theme.fg_dark, bg = normal_bg })
	set("CursorLineNr", { fg = theme.accent.yellow, bg = theme.cursorline, bold = true })
	set("SignColumn", { bg = normal_bg })
	set("FoldColumn", { fg = theme.fg_dark, bg = normal_bg })
	set("Folded", { fg = theme.fg_alt, bg = alt_bg })

	set("StatusLine", { fg = theme.fg, bg = theme.bg_alt })
	set("StatusLineNC", { fg = theme.fg_dark, bg = normal_bg })

	-- ======================================================
	-- SEARCH
	-- ======================================================

	set("Search", { fg = theme.bg, bg = theme.accent.yellow })
	set("IncSearch", { fg = theme.bg, bg = theme.accent.orange })
	set("CurSearch", { fg = theme.bg, bg = theme.accent.orange })

	-- ======================================================
	-- SYNTAX
	-- ======================================================

	set("Comment", { fg = theme.fg_dark, italic = true })
	set("String", { fg = theme.accent.green })
	set("Character", { fg = theme.accent.green })
	set("Number", { fg = theme.accent.orange })
	set("Boolean", { fg = theme.accent.orange })
	set("Float", { fg = theme.accent.orange })

	set("Identifier", { fg = theme.fg })
	set("Function", { fg = theme.accent.blue })
	set("Statement", { fg = theme.accent.purple })
	set("Keyword", { fg = theme.accent.purple })
	set("Conditional", { fg = theme.accent.purple })
	set("Repeat", { fg = theme.accent.purple })
	set("Operator", { fg = theme.accent.cyan })

	set("Type", { fg = theme.accent.yellow })
	set("Structure", { fg = theme.accent.yellow })
	set("Constant", { fg = theme.accent.orange })
	set("Special", { fg = theme.accent.cyan })
	set("PreProc", { fg = theme.accent.purple })

	-- ======================================================
	-- DIAGNOSTICS
	-- ======================================================

	set("DiagnosticError", { fg = theme.diag.error })
	set("DiagnosticWarn", { fg = theme.diag.warn })
	set("DiagnosticInfo", { fg = theme.diag.info })
	set("DiagnosticHint", { fg = theme.diag.hint })

	set("DiagnosticVirtualTextError", { fg = theme.diag.error, bg = alt_bg })
	set("DiagnosticVirtualTextWarn", { fg = theme.diag.warn, bg = alt_bg })
	set("DiagnosticVirtualTextInfo", { fg = theme.diag.info, bg = alt_bg })
	set("DiagnosticVirtualTextHint", { fg = theme.diag.hint, bg = alt_bg })

	set("DiagnosticSignError", { fg = theme.diag.error, bg = normal_bg })
	set("DiagnosticSignWarn", { fg = theme.diag.warn, bg = normal_bg })
	set("DiagnosticSignInfo", { fg = theme.diag.info, bg = normal_bg })
	set("DiagnosticSignHint", { fg = theme.diag.hint, bg = normal_bg })

	-- ======================================================
	-- POPUP MENU
	-- ======================================================

	set("Pmenu", { fg = theme.fg, bg = theme.bg })
	set("PmenuSel", { fg = theme.bg, bg = theme.accent.blue })
	set("PmenuSbar", { bg = theme.bg_alt })
	set("PmenuThumb", { bg = theme.border })

	-- ======================================================
	-- GIT / DIFF
	-- ======================================================

	set("DiffAdd", { fg = theme.git.add, bg = alt_bg })
	set("DiffChange", { fg = theme.git.change, bg = alt_bg })
	set("DiffDelete", { fg = theme.git.delete, bg = alt_bg })
	set("DiffText", { fg = theme.accent.yellow, bg = alt_bg })

	set("GitSignsAdd", { fg = theme.git.add, bg = normal_bg })
	set("GitSignsChange", { fg = theme.git.change, bg = normal_bg })
	set("GitSignsDelete", { fg = theme.git.delete, bg = normal_bg })

	-- ======================================================
	-- COMPLETION
	-- ======================================================

	set("CmpItemAbbr", { fg = theme.fg })
	set("CmpItemAbbrDeprecated", { fg = theme.fg_dark, strikethrough = true })
	set("CmpItemAbbrMatch", { fg = theme.accent.blue, bold = true })
	set("CmpItemAbbrMatchFuzzy", { fg = theme.accent.cyan, bold = true })
	set("CmpItemKind", { fg = theme.accent.purple })
	set("CmpItemMenu", { fg = theme.fg_dark })

	-- ======================================================
	-- WHICH-KEY
	-- ======================================================

	set("WhichKey", { fg = theme.accent.cyan })
	set("WhichKeyGroup", { fg = theme.accent.blue })
	set("WhichKeyDesc", { fg = theme.fg })
	set("WhichKeySeparator", { fg = theme.fg_dark })
	set("WhichKeyFloat", { bg = theme.bg })
	set("WhichKeyBorder", { fg = theme.border, bg = theme.bg })

	-- ======================================================
	-- DASHBOARD
	-- ======================================================

	set("DashboardHeader", { fg = theme.accent.blue })
	set("DashboardCenter", { fg = theme.fg })
	set("DashboardShortcut", { fg = theme.accent.yellow })
	set("DashboardFooter", { fg = theme.fg_dark })

	-- ======================================================
	-- NVIM-TREE
	-- ======================================================

	set("NvimTreeNormal", { fg = theme.fg, bg = normal_bg })
	set("NvimTreeNormalNC", { fg = theme.fg, bg = normal_bg })
	set("NvimTreeRootFolder", { fg = theme.accent.blue, bold = true })
	set("NvimTreeFolderName", { fg = theme.accent.blue })
	set("NvimTreeOpenedFolderName", { fg = theme.accent.cyan })
	set("NvimTreeFileName", { fg = theme.fg })
	set("NvimTreeGitDirty", { fg = theme.git.change })
	set("NvimTreeGitNew", { fg = theme.git.add })
	set("NvimTreeGitDeleted", { fg = theme.git.delete })
	set("NvimTreeIndentMarker", { fg = theme.border })

	-- ======================================================
	-- NOICE / NOTIFICATIONS
	-- ======================================================

	set("NoiceCmdlinePopup", { fg = theme.fg, bg = theme.bg })
	set("NoiceCmdlinePopupBorder", { fg = theme.accent.cyan, bg = theme.bg })
	set("NoiceCmdlineIcon", { fg = theme.accent.cyan })
	set("NoicePopup", { fg = theme.fg, bg = theme.bg })
	set("NoicePopupBorder", { fg = theme.border, bg = theme.bg })

	set("NotifyBackground", { bg = theme.bg })
	set("NotifyERRORBorder", { fg = theme.diag.error, bg = theme.bg })
	set("NotifyWARNBorder", { fg = theme.diag.warn, bg = theme.bg })
	set("NotifyINFOBorder", { fg = theme.diag.info, bg = theme.bg })
	set("NotifyDEBUGBorder", { fg = theme.fg_dark, bg = theme.bg })
	set("NotifyTRACEBorder", { fg = theme.accent.purple, bg = theme.bg })

	-- ======================================================
	-- DAP
	-- ======================================================

	set("DapBreakpoint", { fg = theme.diag.error })
	set("DapStopped", { fg = theme.diag.warn })

	-- ======================================================
	-- TERMINAL COLORS
	-- ======================================================

	vim.g.terminal_color_0 = theme.bg_dark
	vim.g.terminal_color_1 = theme.accent.red
	vim.g.terminal_color_2 = theme.accent.green
	vim.g.terminal_color_3 = theme.accent.yellow
	vim.g.terminal_color_4 = theme.accent.blue
	vim.g.terminal_color_5 = theme.accent.purple
	vim.g.terminal_color_6 = theme.accent.cyan
	vim.g.terminal_color_7 = theme.fg_alt
	vim.g.terminal_color_8 = theme.fg_dark
	vim.g.terminal_color_9 = theme.accent.red
	vim.g.terminal_color_10 = theme.accent.green
	vim.g.terminal_color_11 = theme.accent.yellow
	vim.g.terminal_color_12 = theme.accent.blue
	vim.g.terminal_color_13 = theme.accent.purple
	vim.g.terminal_color_14 = theme.accent.cyan
	vim.g.terminal_color_15 = theme.fg

	vim.g.colors_name = "pulse-" .. active_theme
end

return M
