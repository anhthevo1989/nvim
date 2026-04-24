-- ==========================================================
-- FILE: lua/plugins/formatting/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Code formatting system using conform.nvim
--
-- WHAT THIS DOES
-- --------------
-- - Formats code on save
-- - Uses external formatters when available
-- - Falls back to LSP if needed
-- ==========================================================

return {
	{
		"stevearc/conform.nvim",

		event = { "BufWritePre" },
		cmd = { "ConformInfo" },

		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					lua = { "stylua" },
					bash = { "shfmt" },
					python = { "black" },
				},

				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
}
