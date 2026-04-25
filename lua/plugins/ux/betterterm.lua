-- ==========================================================
-- FILE: lua/plugins/ux/betterterm.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Provide tabbed terminal workspace.
--
-- WHY IT EXISTS
-- -------------
-- betterTerm owns terminal workflow.
-- It replaces ToggleTerm so terminals can behave more like
-- IDE-style terminal tabs.
--
-- HOW IT WORKS
-- ------------
-- betterTerm creates a terminal area with internal terminal tabs.
-- Shell, Run, and LazyGit are predefined terminal targets.
--
-- FLOW
-- ----
-- 1. <leader>tt opens/refocuses the terminal workspace.
-- 2. betterTerm manages terminal tabs internally.
-- 3. Other plugins do not manage terminal state.
--
-- BEGINNER NOTES
-- --------------
-- Snacks owns picker/dashboard.
-- betterTerm owns terminals.
-- Edgy is left untouched for this test.
-- ==========================================================

return {
	{
		"CRAG666/betterTerm.nvim",

		event = "VeryLazy",

		opts = {
			prefix = "Terminal",
			position = "bot",
			size = 15,
			startInserted = true,
			show_tabs = true,
			index_base = 0,

			predefined = {
				{ index = 0, name = "Shell" },
				{ index = 1, name = "Run" },
				{ index = 2, name = "LazyGit" },
			},
		},

		config = function(_, opts)
			local better_term = require("betterTerm")

			better_term.setup(opts)

			vim.keymap.set("n", "<leader>tt", function()
				better_term.open(0)
			end, {
				desc = "Terminal Shell",
			})

			vim.keymap.set("n", "<leader>tr", function()
				better_term.open(1)
			end, {
				desc = "Terminal Run",
			})

			vim.keymap.set("n", "<leader>tg", function()
				better_term.open(2)
				better_term.send("lazygit", 2)
			end, {
				desc = "Terminal LazyGit",
			})
		end,
	},
}
