-- ==========================================================
-- FILE: lua/adapters/search.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides the internal Search / Replace workflow for this Neovim config.
--
-- WHY IT EXISTS
-- -------------
-- This keeps search and replace behavior private, lightweight, and easy to
-- maintain without depending on an abandoned external plugin.
--
-- HOW IT WORKS
-- ------------
-- Uses Snacks input when available, falls back to vim.ui.input, uses ripgrep
-- for project discovery, and uses native Lua replacement logic for edits.
--
-- FLOW
-- ----
-- User presses a keymap -> adapter asks for input -> search or replacement
-- runs -> results are shown through quickfix or notifications.
--
-- BEGINNER NOTES
-- --------------
-- This file contains workflow logic only. Keymaps live in core/keymaps.
-- Plugin setup stays in plugins.
-- ==========================================================

local M = {}

------------------------------------------
-- INPUT
------------------------------------------

local function input(prompt, callback)
	local ok, snacks = pcall(require, "snacks")

	if ok and snacks.input then
		snacks.input({ prompt = prompt }, callback)
		return
	end

	vim.ui.input({ prompt = prompt }, callback)
end

------------------------------------------
-- PROJECT ROOT
------------------------------------------

local function project_root()
	local result = vim.system({ "git", "rev-parse", "--show-toplevel" }, { text = true }):wait()

	if result.code == 0 and result.stdout then
		return vim.trim(result.stdout)
	end

	return vim.fn.getcwd()
end

------------------------------------------
-- ESCAPING
------------------------------------------

local function escape_pattern(text)
	return vim.pesc(text)
end

local function escape_replacement(text)
	return text:gsub("%%", "%%%%")
end

------------------------------------------
-- NOTIFICATIONS
------------------------------------------

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, {
		title = "Search / Replace",
	})
end

------------------------------------------
-- SEARCH IN FILE
------------------------------------------

function M.search_in_file()
	input("Find: ", function(find_text)
		if not find_text or find_text == "" then
			return
		end

		vim.fn.setreg("/", escape_pattern(find_text))
		vim.opt.hlsearch = true

		local found = vim.fn.search(escape_pattern(find_text), "w")

		if found == 0 then
			notify("No matches found in current file", vim.log.levels.WARN)
		end
	end)
end

------------------------------------------
-- SEARCH IN PROJECT
------------------------------------------

function M.search_in_project()
	input("Find: ", function(find_text)
		if not find_text or find_text == "" then
			return
		end

		local root = project_root()

		local result = vim.system({
			"rg",
			"--vimgrep",
			"--fixed-strings",
			"--hidden",
			"--glob",
			"!.git",
			find_text,
			root,
		}, { text = true }):wait()

		if result.code ~= 0 or not result.stdout or result.stdout == "" then
			notify("No project matches found", vim.log.levels.WARN)
			return
		end

		local quickfix_items = {}

		for line in result.stdout:gmatch("[^\n]+") do
			local filename, lnum, col, text = line:match("^(.-):(%d+):(%d+):(.*)$")

			if filename and lnum and col then
				table.insert(quickfix_items, {
					filename = filename,
					lnum = tonumber(lnum),
					col = tonumber(col),
					text = text,
				})
			end
		end

		vim.fn.setqflist({}, " ", {
			title = "Search: " .. find_text,
			items = quickfix_items,
		})

		vim.cmd("copen")
		notify("Project search complete")
	end)
end

------------------------------------------
-- REPLACE IN FILE
------------------------------------------

function M.replace_in_file()
	input("Find: ", function(find_text)
		if not find_text or find_text == "" then
			return
		end

		input("Replace: ", function(replace_text)
			if replace_text == nil then
				return
			end

			local pattern = escape_pattern(find_text)
			local replacement = escape_replacement(replace_text)
			local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
			local changed_count = 0

			for index, line in ipairs(lines) do
				local updated_line, replacements = line:gsub(pattern, replacement)

				lines[index] = updated_line
				changed_count = changed_count + replacements
			end

			if changed_count == 0 then
				notify("No matches found in current file", vim.log.levels.WARN)
				return
			end

			vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
			notify("Replaced " .. changed_count .. " match(es) in current file")
		end)
	end)
end

------------------------------------------
-- REPLACE IN PROJECT
------------------------------------------

function M.replace_in_project()
	input("Find: ", function(find_text)
		if not find_text or find_text == "" then
			return
		end

		input("Replace: ", function(replace_text)
			if replace_text == nil then
				return
			end

			input("File filter optional, example *.lua: ", function(file_filter)
				local root = project_root()

				local rg_command = {
					"rg",
					"--files-with-matches",
					"--fixed-strings",
					"--hidden",
					"--glob",
					"!.git",
				}

				if file_filter and file_filter ~= "" then
					table.insert(rg_command, "--glob")
					table.insert(rg_command, file_filter)
				end

				table.insert(rg_command, find_text)
				table.insert(rg_command, root)

				local result = vim.system(rg_command, { text = true }):wait()

				if result.code ~= 0 or not result.stdout or result.stdout == "" then
					notify("No project matches found", vim.log.levels.WARN)
					return
				end

				local files = {}

				for file in result.stdout:gmatch("[^\n]+") do
					table.insert(files, file)
				end

				input("Replace in " .. #files .. " file(s)? Type YES: ", function(confirm)
					if confirm ~= "YES" then
						notify("Project replace cancelled")
						return
					end

					local pattern = escape_pattern(find_text)
					local replacement = escape_replacement(replace_text)
					local changed_files = 0
					local changed_matches = 0

					for _, file in ipairs(files) do
						local lines = vim.fn.readfile(file)
						local file_changed = false

						for index, line in ipairs(lines) do
							local updated_line, replacements = line:gsub(pattern, replacement)

							if replacements > 0 then
								lines[index] = updated_line
								file_changed = true
								changed_matches = changed_matches + replacements
							end
						end

						if file_changed then
							vim.fn.writefile(lines, file)
							changed_files = changed_files + 1
						end
					end

					notify("Replaced " .. changed_matches .. " match(es) across " .. changed_files .. " file(s)")
				end)
			end)
		end)
	end)
end

return M
