-- ==========================================================
-- FILE: lua/core/run.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Run current file in the betterTerm Run tab.
--
-- WHY IT EXISTS
-- -------------
-- One-key run should always send output to the dedicated Run tab.
-- It should not spawn random terminal buffers.
--
-- HOW IT WORKS
-- ------------
-- Detects the current filetype.
-- Builds the matching run command.
-- Opens betterTerm tab 1.
-- Sends the command there.
--
-- FLOW
-- ----
-- 1. User presses <leader>r.
-- 2. Current filetype is detected.
-- 3. Run command is sent to betterTerm Run tab.
-- 4. Output stays visible until Enter is pressed.
--
-- BEGINNER NOTES
-- --------------
-- betterTerm tab 1 is the Run tab.
-- This file should not call Snacks terminal.
-- ==========================================================

local M = {}

local function quote_file_path(file_path)
	return vim.fn.shellescape(file_path)
end

local function get_pause_command()
	local shell = vim.o.shell

	if shell:find("fish") then
		return "echo; read -P 'Press enter to continue'"
	end

	return "echo; read -r -p 'Press enter to continue'"
end

local function get_run_command()
	local filetype = vim.bo.filetype
	local file_path = vim.fn.expand("%:p")

	if file_path == "" then
		return nil
	end

	local quoted_file_path = quote_file_path(file_path)

	if filetype == "lua" then
		return "lua " .. quoted_file_path
	end

	if filetype == "python" then
		return "python " .. quoted_file_path
	end

	if filetype == "sh" or filetype == "bash" then
		return "bash " .. quoted_file_path
	end

	if filetype == "javascript" then
		return "node " .. quoted_file_path
	end

	return nil
end

function M.run()
	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		vim.notify("betterTerm is not available", vim.log.levels.ERROR)
		return
	end

	local run_command = get_run_command()

	if not run_command then
		vim.notify("No runner for filetype: " .. vim.bo.filetype, vim.log.levels.WARN)
		return
	end

	local command = run_command .. "; " .. get_pause_command()

	better_term.open(1)
	better_term.send(command, 1)
end

return M
