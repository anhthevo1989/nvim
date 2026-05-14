-- ==========================================================
-- FILE: lua/plugins/formatting/init.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Code formatting system using conform.nvim.
--
-- WHY IT EXISTS
-- -------------
-- Formatting should happen automatically and consistently
-- without requiring users to manually run formatter commands.
--
-- This file centralizes all formatter configuration.
--
-- HOW IT WORKS
-- ------------
-- - Conform runs before files are written
-- - Filetypes are mapped to their correct formatter
-- - Falls back to LSP formatting when needed
--
-- SUPPORTED FORMATTERS
-- --------------------
-- Lua:
-- - stylua
--
-- Python:
-- - ruff_format
--
-- Shell:
-- - shfmt
--
-- BEGINNER NOTES
-- --------------
-- Saving a file should automatically format it.
--
-- Use:
--
-- :ConformInfo
--
-- to inspect active formatters.
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"stevearc/conform.nvim",

		event = { "BufWritePre" },
		cmd = { "ConformInfo" },

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },

					python = { "ruff_format" },

					sh = { "shfmt" },
					bash = { "shfmt" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
