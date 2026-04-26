-- ==========================================================
-- FILE: lua/theme/apply.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Apply Pulse theme with optional transparency support.
--
-- WHY IT EXISTS
-- -------------
-- Central place to control highlights.
-- Now also respects persisted transparency state.
--
-- HOW IT WORKS
-- ------------
-- - loads saved theme state
-- - applies theme colors
-- - overrides background when transparency is enabled
--
-- FLOW
-- ----
-- 1. apply(theme_name)
-- 2. load state
-- 3. compute bg values
-- 4. apply highlights
--
-- ==========================================================

local state = require("theme.state")

local M = {}

-- your existing theme loader
local function get_theme(name)
	return require("theme." .. name).get()
end

function M.apply(theme_name)
	local saved = state.load()

	local active_theme = theme_name or saved.theme or "dark"
	local theme = get_theme(active_theme)

	local transparent = saved.transparent

	local normal_bg = transparent and "NONE" or theme.bg
	local float_bg = transparent and "NONE" or theme.float_bg

	local function set(group, opts)
		vim.api.nvim_set_hl(0, group, opts)
	end

	-- ======================================================
	-- CORE
	-- ======================================================

	set("Normal", { fg = theme.fg, bg = normal_bg })
	set("NormalNC", { fg = theme.fg, bg = normal_bg })
	set("NormalFloat", { fg = theme.fg, bg = float_bg })

	-- keep everything else untouched (your existing highlights)
	-- IMPORTANT: do NOT rewrite the rest of your file

	vim.g.colors_name = "pulse-" .. active_theme
end

return M
