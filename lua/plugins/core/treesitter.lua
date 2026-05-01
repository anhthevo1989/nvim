-- ==========================================================
-- FILE: lua/plugins/core/treesitter.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Declare and configure Treesitter plugins.
--
-- WHY IT EXISTS
-- -------------
-- Treesitter provides better syntax highlighting and structure-aware editing.
--
-- HOW IT WORKS
-- ------------
-- nvim-treesitter installs parsers automatically.
-- nvim-treesitter-textobjects is configured separately.
--
-- FLOW
-- ----
-- 1. lazy.nvim loads Treesitter.
-- 2. Required parsers are installed.
-- 3. Textobjects are enabled through config.treesitter.
--
-- BEGINNER NOTES
-- --------------
-- Parsers are language support packages for Treesitter.
-- ==========================================================

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		config = function()
			require("nvim-treesitter.config").setup({
				ensure_installed = {
					"lua",
					"python",
					"bash",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"query",
				},

				sync_install = false,
				auto_install = true,

				highlight = {
					enable = true,
				},

				indent = {
					enable = true,
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},

		init = function()
			vim.g.no_plugin_maps = true
		end,

		config = function()
			require("config.treesitter").setup_textobjects()
		end,
	},
}
