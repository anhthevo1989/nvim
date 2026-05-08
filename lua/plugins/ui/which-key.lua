-- ==========================================================
-- FILE: lua/plugins/ui/which-key.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure which-key for keymap discovery.
--
-- WHY IT EXISTS
-- -------------
-- Makes large keybinding systems easier to remember by showing
-- grouped leader mappings.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs which-key.
-- This file defines high-level keymap groups.
--
-- INSTALLATION
-- ------------
-- Installs:
-- - folke/which-key.nvim
--
-- CONFIGURATION
-- -------------
-- Defines leader key namespaces for:
-- - selection
-- - terminals
-- - explorer
-- - run
-- - debug
-- - buffers
-- - git
-- - layout
--
-- FLOW
-- ----
-- User presses leader key
-- → which-key opens
-- → available grouped mappings appear
--
-- BEGINNER NOTES
-- --------------
-- This file should only define keymap groups.
--
-- Actual key implementations belong in core/ or adapters/.
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"folke/which-key.nvim",

		event = "VeryLazy",

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		opts = {
			preset = "modern",

			spec = {
				{ "<leader>s", group = "Select" },
				{ "<leader>t", group = "Terminal" },
				{ "<leader>e", group = "Explorer" },
				{ "<leader>r", group = "Run" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "Layout" },
			},
		},
	},
}
