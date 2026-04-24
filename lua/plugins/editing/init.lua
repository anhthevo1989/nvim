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
		"echasnovski/mini.ai",
		version = false,
		config = function()
			require("mini.ai").setup()
		end,
	},

	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup()
		end,
	},

	{
		"echasnovski/mini.comment",
		version = false,
		config = function()
			require("mini.comment").setup()
		end,
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		config = function()
			require("mini.indentscope").setup()
		end,
	},

	{
		"echasnovski/mini.cursorword",
		version = false,
		config = function()
			require("mini.cursorword").setup()
		end,
	},

	{
		"echasnovski/mini.move",
		event = "VeryLazy",
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
