-- ==========================================================
-- FILE: lua/adapters/run.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides run commands for the current file.
--
-- WHY IT EXISTS
-- -------------
-- Running code is workflow logic. Keeping it in an adapter prevents keymaps
-- and plugin files from becoming messy.
--
-- HOW IT WORKS
-- ------------
-- Detects the current file type, builds the correct shell command, and sends
-- that command to the dedicated BetterTerm run terminal.
--
-- FLOW
-- ----
-- User presses <leader>r -> keymap calls this adapter -> adapter saves the
-- current file -> adapter builds the run command -> BetterTerm opens the run
-- terminal and executes the command.
--
-- BEGINNER NOTES
-- --------------
-- This file does not define keymaps. It only decides how files should run.
-- Keymaps live in lua/core/keymaps/run.lua.
-- ==========================================================

local M = {}

local RUN_TERMINAL_ID = 1

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, {
		title = "Run",
	})
end

local function current_file()
	local file = vim.fn.expand("%:p")

	if file == "" then
		return nil
	end

	return file
end

local function file_extension(file)
	return vim.fn.fnamemodify(file, ":e")
end

local function shell_escape(value)
	return vim.fn.shellescape(value)
end

local function find_python_command()
	local virtual_env = vim.env.VIRTUAL_ENV

	if virtual_env and virtual_env ~= "" then
		return shell_escape(virtual_env .. "/bin/python")
	end

	local cwd = vim.fn.getcwd()
	local project_python = cwd .. "/.venv/bin/python"

	if vim.uv.fs_stat(project_python) then
		return shell_escape(project_python)
	end

	return "python"
end

local function build_current_file_command(file)
	local extension = file_extension(file)
	local escaped_file = shell_escape(file)

	if extension == "py" then
		return find_python_command() .. " " .. escaped_file
	end

	if extension == "lua" then
		return "lua " .. escaped_file
	end

	if extension == "sh" or extension == "bash" then
		return "bash " .. escaped_file
	end

	return nil
end

local function send_to_run_terminal(command)
	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		notify("BetterTerm is not available", vim.log.levels.ERROR)
		return
	end

	better_term.open(RUN_TERMINAL_ID)

	vim.defer_fn(function()
		better_term.send(command, RUN_TERMINAL_ID, {
			clean = true,
			interrupt = true,
		})
	end, 100)
end

function M.run_current_file()
	local file = current_file()

	if not file then
		notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	vim.cmd("write")

	local command = build_current_file_command(file)

	if not command then
		notify("No run command configured for this file type", vim.log.levels.WARN)
		return
	end

	send_to_run_terminal(command)
end

return M
