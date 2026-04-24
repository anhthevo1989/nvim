-- ==========================================================
-- FILE: lua/plugins/ux/snacks.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Snacks UX layer with unified terminal system.
--
-- WHY IT EXISTS
-- -------------
-- Snacks owns small user-facing interaction features.
-- This includes picker, terminal, notifier, input, scope,
-- lazygit terminal workflow, and dashboard entry point.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim loads Snacks.
-- Snacks receives the opts table.
-- The config function initializes Snacks and defines UX keymaps.
--
-- FLOW
-- ----
-- 1. Neovim starts.
-- 2. lazy.nvim loads this plugin spec.
-- 3. Snacks modules are enabled.
-- 4. Dashboard appears as the startup entry point.
-- 5. Terminal and LazyGit keymaps remain available.
--
-- BEGINNER NOTES
-- --------------
-- This file only configures Snacks.nvim.
-- Phase 7 Unit 1 adds the dashboard base only.
-- Dashboard buttons and footer come later.
-- ==========================================================

return {
	{
		"folke/snacks.nvim",

		opts = {
			picker = { enabled = true },
			notifier = { enabled = true },
			input = { enabled = true },
			scope = { enabled = true },

			terminal = {
				enabled = true,
				win = {
					position = "bottom",
					height = 0.3,
				},
			},

			dashboard = {
				enabled = true,

				preset = {
					header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
					]],
				},

				sections = {
					{ section = "header" },
				},
			},
		},

		config = function(_, opts)
			local snacks = require("snacks")
			snacks.setup(opts)

			-- ------------------------------------------------------
			-- TERMINAL TOGGLE (BOTTOM SPLIT)
			-- ------------------------------------------------------
			vim.keymap.set("n", "<leader>tt", function()
				snacks.terminal.toggle()
			end, { desc = "Toggle Terminal" })

			-- ------------------------------------------------------
			-- LAZYGIT IN TERMINAL (FORCED SPLIT)
			-- ------------------------------------------------------
			vim.keymap.set("n", "<leader>gg", function()
				snacks.terminal.open("lazygit", {
					win = {
						position = "bottom",
						height = 0.3,
					},
				})
			end, { desc = "LazyGit (terminal split)" })
		end,
	},
}
