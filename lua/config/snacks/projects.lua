-- ==========================================================
-- FILE: lua/config/snacks/projects.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Provide project selection for the Snacks dashboard.
--
-- WHY IT EXISTS
-- -------------
-- The dashboard needs a PROJECTS action that lists folders
-- from ~/Projects and changes into the selected project.
--
-- HOW IT WORKS
-- ------------
-- This file scans ~/Projects.
-- It shows the folders with vim.ui.select().
-- When a project is selected, Neovim changes directory into it
-- and opens the Snacks file picker there.
--
-- FLOW
-- ----
-- 1. User selects PROJECTS from dashboard.
-- 2. This file scans ~/Projects.
-- 3. User chooses a project folder.
-- 4. Neovim changes directory into that folder.
-- 5. Snacks file picker opens inside that project.
--
-- BEGINNER NOTES
-- --------------
-- This file only handles project discovery and project opening.
-- ==========================================================

local M = {}

local projects_directory = vim.fn.expand("~/Projects")

local function get_project_directories()
	local project_directories = {}
	local scan_handle = vim.loop.fs_scandir(projects_directory)

	if not scan_handle then
		vim.notify("Projects directory not found: " .. projects_directory, vim.log.levels.WARN)
		return project_directories
	end

	while true do
		local name, item_type = vim.loop.fs_scandir_next(scan_handle)

		if not name then
			break
		end

		if item_type == "directory" then
			table.insert(project_directories, {
				name = name,
				path = projects_directory .. "/" .. name,
			})
		end
	end

	table.sort(project_directories, function(left_project, right_project)
		return left_project.name:lower() < right_project.name:lower()
	end)

	return project_directories
end

function M.open_project_picker()
	local project_directories = get_project_directories()

	if #project_directories == 0 then
		vim.notify("No projects found in " .. projects_directory, vim.log.levels.WARN)
		return
	end

	vim.ui.select(project_directories, {
		prompt = "Projects",
		format_item = function(project)
			return project.name
		end,
	}, function(project)
		if not project then
			return
		end

		vim.cmd("cd " .. vim.fn.fnameescape(project.path))

		Snacks.picker.files({
			cwd = project.path,
		})
	end)
end

return M
