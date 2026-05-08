-- ==========================================================
-- FILE: lua/plugins/editing/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Mini.nvim modules for editing enhancements
--
-- MODULES
-- -------
-- - mini.ai           → textobjects
-- - mini.surround     → surrounding text
-- - mini.comment      → commenting
-- - mini.indentscope  → indent guides
-- - mini.cursorword   → highlight word under cursor
-- - mini.move         → move lines / selections
--
-- ADDITIONAL
-- ----------
-- - nvim-autopairs    → automatic bracket pairing
--
-- FLOW
-- ----
-- Loaded by lazy.nvim during plugin initialization
--
-- BEGINNER NOTES
-- --------------
-- Each plugin is configured with a minimal setup.
-- Keybindings are mostly defaults unless overridden.
-- ==========================================================

return {

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"echasnovski/mini.ai",

		version = false,

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mini.ai").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"echasnovski/mini.surround",

		version = false,

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mini.surround").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"echasnovski/mini.comment",

		version = false,

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mini.comment").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"windwp/nvim-autopairs",

		event = "InsertEnter",

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"echasnovski/mini.indentscope",

		version = false,

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mini.indentscope").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"echasnovski/mini.cursorword",

		version = false,

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mini.cursorword").setup()
		end,
	},

	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"echasnovski/mini.move",

		event = "VeryLazy",

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("mini.move").setup({
				mappings = {
					-- Move selection (visual mode)
					left = "<M-h>",
					right = "<M-l>",
					down = "<M-j>",
					up = "<M-k>",

					-- Move line (normal mode)
					line_left = "<M-h>",
					line_right = "<M-l>",
					line_down = "<M-j>",
					line_up = "<M-k>",
				},
			})
		end,
	},
}
