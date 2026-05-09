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
-- Scans the user's project directory for folders,
-- displays them through Snacks picker,
-- previews their contents,
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
		local name, entry_type = vim.loop.fs_scandir_next(handle)

		if not name then
			break
		end

		if entry_type == "directory" then
			table.insert(projects, {
				name = name,
				path = PROJECTS_DIR .. "/" .. name,
				file = PROJECTS_DIR .. "/" .. name,
				dir = true,
			})
		end
	end

	table.sort(projects, function(a, b)
		return a.name < b.name
	end)

	return projects
end

local function get_project_preview_lines(project)
	local lines = {
		project.name,
		string.rep("=", #project.name),
		"",
		project.path,
		"",
		"Contents",
		"--------",
	}

	local handle = vim.loop.fs_scandir(project.path)

	if not handle then
		table.insert(lines, "Unable to read project directory.")
		return lines
	end

	local count = 0

	while true do
		local name, entry_type = vim.loop.fs_scandir_next(handle)

		if not name then
			break
		end

		count = count + 1

		local icon = "󰈔"

		if entry_type == "directory" then
			icon = "󰉋"
		end

		table.insert(lines, icon .. " " .. name)

		if count >= 30 then
			table.insert(lines, "")
			table.insert(lines, "Preview limited to first 30 entries.")
			break
		end
	end

	if count == 0 then
		table.insert(lines, "No visible entries found.")
	end

	return lines
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
			return {
				{
					item.name,
					"Directory",
				},
			}
		end,

		preview = function(ctx)
			ctx.preview:set_lines(get_project_preview_lines(ctx.item))
		end,

		confirm = function(picker, item)
			picker:close()

			vim.cmd("cd " .. vim.fn.fnameescape(item.path))

			Snacks.picker.files({
				cwd = item.path,
				hidden = true,
				ignored = false,

				confirm = function(file_picker, file_item)
					file_picker:close()

					local file = file_item.file or file_item.path
					if file then
						vim.cmd("edit " .. vim.fn.fnameescape(file))
					end

					vim.schedule(function()
						require("adapters.layout").ide_layout()
					end)
				end,
			})
		end,
	})
end

return M
