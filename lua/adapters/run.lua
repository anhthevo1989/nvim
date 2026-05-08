-- ==========================================================
-- FILE: lua/adapters/run.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Run the current file using the correct command.
--
-- WHY IT EXISTS
-- -------------
-- Running files should be consistent and predictable.
--
-- This adapter centralizes file execution so keymaps do not need
-- to know language-specific run commands.
--
-- HOW IT WORKS
-- ------------
-- Detects the current filetype, builds the correct command,
-- then sends that command to the dedicated run terminal.
--
-- FLOW
-- ----
-- User presses <leader>r
-- → current filetype is detected
-- → run command is built
-- → command is sent to terminal 1
--
-- BEGINNER NOTES
-- --------------
-- This file only decides how to run files.
--
-- Terminal behavior belongs to betterTerm.
-- Python interpreter detection belongs to adapters/python.lua.
-- ==========================================================

local M = {}

------------------------------------------
-- HELPERS
------------------------------------------

local function get_current_file()
	return vim.fn.expand("%:p")
end

local function get_filetype()
	return vim.bo.filetype
end

local function shellescape(value)
	return vim.fn.shellescape(value)
end

local function send_to_run_terminal(command)
	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		vim.notify("betterTerm not available", vim.log.levels.WARN)
		return
	end

	better_term.open(1)
	better_term.send(command, 1)
end

------------------------------------------
-- COMMAND BUILDERS
------------------------------------------

local function build_python_command(file)
	local python = require("adapters.python").find_python()

	return python .. " " .. shellescape(file)
end

local function build_lua_command(file)
	return "lua " .. shellescape(file)
end

local function build_shell_command(file)
	return "bash " .. shellescape(file)
end

local function build_command(filetype, file)
	if filetype == "python" then
		return build_python_command(file)
	end

	if filetype == "lua" then
		return build_lua_command(file)
	end

	if filetype == "sh" or filetype == "bash" then
		return build_shell_command(file)
	end

	return nil
end

------------------------------------------
-- PUBLIC API
------------------------------------------

function M.run_current_file()
	local file = get_current_file()
	local filetype = get_filetype()

	if file == "" then
		vim.notify("No file to run", vim.log.levels.WARN)
		return
	end

	local command = build_command(filetype, file)

	if not command then
		vim.notify("No run command configured for filetype: " .. filetype, vim.log.levels.WARN)
		return
	end

	send_to_run_terminal(command)
end

return M
