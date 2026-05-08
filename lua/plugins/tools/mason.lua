-- ==========================================================
-- FILE: lua/plugins/tools/mason.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Manage external tooling for Neovim.
--
-- WHY IT EXISTS
-- -------------
-- Mason installs and manages language servers, formatters,
-- linters, and debug adapters used by the config.
--
-- HOW IT WORKS
-- ------------
-- mason.nvim provides the tool installer UI.
-- mason-lspconfig connects Mason-managed LSP servers to Neovim.
-- mason-tool-installer ensures required tools are installed.
--
-- FLOW
-- ----
-- Neovim starts
-- → Mason loads
-- → required tools are checked
-- → missing tools can be installed automatically
--
-- BEGINNER NOTES
-- --------------
-- Mason installs developer tools for Neovim.
-- It does not replace system package managers.
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"williamboman/mason.nvim",

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mason").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"williamboman/mason-lspconfig.nvim",

		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
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
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		dependencies = {
			"williamboman/mason.nvim",
		},

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
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
