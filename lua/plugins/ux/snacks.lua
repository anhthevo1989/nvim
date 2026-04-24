-- ==========================================================
-- FILE: lua/plugins/ux/snacks.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Register Snacks.nvim with lazy.nvim.
--
-- WHY IT EXISTS
-- -------------
-- This file should only define the plugin spec.
-- Snacks feature details live in lua/config/snacks/.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim loads this plugin.
-- The opts table comes from config.snacks.dashboard.
-- The config function initializes Snacks and loads keymaps.
--
-- FLOW
-- ----
-- 1. lazy.nvim loads Snacks.nvim.
-- 2. Dashboard options are applied.
-- 3. Snacks setup runs.
-- 4. Snacks keymaps are registered.
--
-- BEGINNER NOTES
-- --------------
-- Keep this file small.
-- Do not put dashboard layout, project scanning, or keymaps here.
-- ==========================================================

local dashboard = require("config.snacks.dashboard")
local keymaps = require("config.snacks.keymaps")

return {
	{
		"folke/snacks.nvim",

		opts = dashboard.get_options(),

		config = function(_, opts)
			local snacks = require("snacks")

			snacks.setup(opts)
			keymaps.setup(snacks)
		end,
	},
}
