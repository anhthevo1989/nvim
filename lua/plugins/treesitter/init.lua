-- ==========================================================
-- FILE: lua/plugins/treesitter/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Install and configure Treesitter.
--
-- WHY IT EXISTS
-- -------------
-- Treesitter provides better syntax highlighting and
-- structure-aware editing.
--
-- This file keeps Treesitter plugin installation and
-- Treesitter configuration together.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs Treesitter.
-- Treesitter installs language parsers automatically.
-- Treesitter textobjects enables structural selections.
--
-- FLOW
-- ----
-- 1. lazy.nvim loads Treesitter.
-- 2. Treesitter installs required parsers.
-- 3. Syntax highlighting is enabled.
-- 4. Textobjects are configured.
--
-- BEGINNER NOTES
-- --------------
-- Parsers are language support packages for Treesitter.
--
-- Textobjects allow mappings to select things like:
-- - functions
-- - classes
-- - blocks of code
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"nvim-treesitter/nvim-treesitter",

		build = ":TSUpdate",

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("nvim-treesitter.config").setup({
				install_dir = vim.fn.stdpath("data") .. "/site",

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
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"nvim-treesitter/nvim-treesitter-textobjects",

		branch = "main",

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		init = function()
			vim.g.no_plugin_maps = true
		end,

		config = function()
			local ok, textobjects = pcall(require, "nvim-treesitter-textobjects")

			if not ok then
				vim.notify("nvim-treesitter-textobjects not available", vim.log.levels.WARN)
				return
			end

			textobjects.setup({
				select = {
					lookahead = true,

					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},

					include_surrounding_whitespace = false,
				},
			})
		end,
	},
}
