-- ==========================================================
-- FILE: lua/plugins/tools/mason.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Manage external tooling (LSPs, linters, formatters, DAP).
-- ==========================================================

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"bashls",
				},
			})
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Lua
					"lua-language-server",
					"stylua",
					"luacheck",

					-- Python
					"pyright",
					"ruff",
					"debugpy",

					-- Shell
					"bash-language-server",
					"shfmt",
					"shellcheck",
				},
			})
		end,
	},
}
