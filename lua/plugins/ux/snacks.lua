-- ==========================================================
-- FILE: lua/plugins/ux/snacks.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Snacks.nvim UX systems.
--
-- WHY IT EXISTS
-- -------------
-- Snacks handles lightweight UX features used throughout
-- the config.
--
-- This file owns:
-- - file picker
-- - grep picker
-- - buffer picker
-- - help picker
-- - input UI
-- - terminal integration
--
-- This file intentionally does NOT handle:
-- - dashboard UI (handled by alpha/dashboard plugin)
-- - notifications (handled by Noice)
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs Snacks.
-- Snacks enables selected modules only.
-- Keymaps are registered here.
--
-- FLOW
-- ----
-- Neovim starts
-- → Snacks loads
-- → picker/input/terminal become available
-- → keymaps trigger picker workflows
--
-- BEGINNER NOTES
-- --------------
-- Snacks is intentionally limited to specific features.
--
-- We explicitly disable features already handled by:
-- - dashboard plugin
-- - Noice
-- - mini.indentscope
-- ==========================================================

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,

		opts = {
			-- ==========================================================
			-- ENABLED MODULES
			-- ==========================================================

			picker = {
				enabled = true,
			},

			input = {
				enabled = true,
			},

			terminal = {
				enabled = true,
			},

			-- ==========================================================
			-- DISABLED MODULES
			-- ==========================================================

			dashboard = {
				enabled = false,
			},

			notifier = {
				enabled = false,
			},

			indent = {
				enabled = false,
			},

			scope = {
				enabled = false,
			},
		},

		config = function(_, opts)
			local snacks = require("snacks")

			snacks.setup(opts)

			-- ==========================================================
			-- PICKER KEYMAPS
			-- ==========================================================

			vim.keymap.set("n", "<leader>ff", function()
				snacks.picker.files({
					hidden = true,
				})
			end, {
				desc = "[F]ind [F]iles",
			})

			vim.keymap.set("n", "<leader>fg", function()
				snacks.picker.grep()
			end, {
				desc = "[F]ind by [G]rep",
			})

			vim.keymap.set("n", "<leader>fb", function()
				snacks.picker.buffers()
			end, {
				desc = "[F]ind [B]uffers",
			})

			vim.keymap.set("n", "<leader>fh", function()
				snacks.picker.help()
			end, {
				desc = "[F]ind [H]elp",
			})
		end,
	},
}
