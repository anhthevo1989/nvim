-- ==========================================================
-- FILE: lua/config/snacks/dashboard.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure the Snacks dashboard layout.
--
-- WHY IT EXISTS
-- -------------
-- Provides a centered dashboard with actions and shortcuts.
--
-- HOW IT WORKS
-- ------------
-- Uses Snacks built-in "keys" section for actions.
-- Formatting keeps icons + labels clean and readable.
--
-- FLOW
-- ----
-- 1. Dashboard renders
-- 2. Keys section displays actions
-- 3. User presses shortcut to trigger action
--
-- BEGINNER NOTES
-- --------------
-- Format:
-- ICON [ ACTION ]   SHORTCUT
-- ==========================================================

local projects = require("config.snacks.projects")

local M = {}

function M.get_options()
	return {
		picker = { enabled = true },
		notifier = { enabled = true },
		input = { enabled = true },
		scope = { enabled = true },

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

				keys = {
					{
						icon = " ",
						key = "p",
						desc = "[ PROJECTS ]",
						action = projects.open_project_picker,
					},
					{
						icon = " ",
						key = "e",
						desc = "[ EXPLORER ]",
						action = ":lua Snacks.picker.files()",
					},
					{
						icon = " ",
						key = "n",
						desc = "[ NEW FILE ]",
						action = ":ene | startinsert",
					},
					{
						icon = " ",
						key = "r",
						desc = "[ RECENT FILES ]",
						action = ":lua Snacks.picker.recent()",
					},
					{
						icon = " ",
						key = "c",
						desc = "[ CONFIG ]",
						action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
					},
					{
						icon = " ",
						key = "q",
						desc = "[ QUIT ]",
						action = ":qa",
					},
				},
			},

			sections = {
				{
					section = "header",
					align = "center",
					padding = 2,
				},

				{
					text = {
						{
							"────────────────────────────",
							hl = "SnacksDashboardFooter",
						},
					},
					align = "center",
					padding = 1,
				},

				{
					section = "keys",
					align = "center",
					gap = 1,
					padding = 1,
				},

				{
					text = {
						{
							"────────────────────────────",
							hl = "SnacksDashboardFooter",
						},
					},
					align = "center",
					padding = 1,
				},

				{
					text = {
						{ "󰒲  LAZY.NVIM PLUG-IN STATUS", hl = "SnacksDashboardFooter" },
					},
					align = "center",
					padding = 1,
				},

				{
					section = "startup",
					align = "center",
				},
			},
		},
	}
end

return M
