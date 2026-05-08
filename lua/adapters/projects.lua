-- ==========================================================
-- FILE: lua/adapters/projects.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Handle project discovery and project opening workflows.
--
-- WHY IT EXISTS
-- -------------
-- Keeps project-opening logic separate from dashboard UI.
--
-- This allows:
-- - dashboard reuse
-- - cleaner project workflows
-- - easier future dashboard replacement
--
-- HOW IT WORKS
-- ------------
-- Scans the user's project directory for repositories,
-- displays them through Snacks picker,
-- then opens the selected project.
--
-- FLOW
-- ----
-- User presses Projects
-- → project picker opens
-- → user selects project
-- → project files open
-- → IDE layout initializes
--
-- BEGINNER NOTES
-- --------------
-- This adapter only handles project selection.
--
-- Dashboard UI belongs in dashboard.lua
-- Layout transitions belong in layout.lua
-- ==========================================================

local M = {}

------------------------------------------
-- CONFIG
------------------------------------------

local PROJECTS_DIR = vim.fn.expand("~/Projects")

------------------------------------------
-- HELPERS
------------------------------------------

local function get_projects()
	local projects = {}

	local handle = vim.loop.fs_scandir(PROJECTS_DIR)

	if not handle then
		return projects
	end

	while true do
		local name, type = vim.loop.fs_scandir_next(handle)

		if not name then
			break
		end

		if type == "directory" then
			table.insert(projects, {
				name = name,
				path = PROJECTS_DIR .. "/" .. name,
			})
		end
	end

	table.sort(projects, function(a, b)
		return a.name < b.name
	end)

	return projects
end

------------------------------------------
-- PROJECT PICKER
------------------------------------------

function M.open_project_picker()
	local projects = get_projects()

	if #projects == 0 then
		vim.notify("No projects found in ~/Projects", vim.log.levels.WARN)
		return
	end

	Snacks.picker.pick({
		title = "Projects",
		items = projects,

		format = function(item)
			return item.name
		end,

		confirm = function(picker, item)
			picker:close()

			vim.cmd("cd " .. item.path)

			Snacks.picker.files({
				cwd = item.path,
			})

			vim.schedule(function()
				require("adapters.layout").ide_layout()
			end)
		end,
	})
end

return M
