-- ==========================================================
-- FILE: lua/adapters/test.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides test commands for the current file and nearest test.
--
-- WHY IT EXISTS
-- -------------
-- Testing is workflow logic. Keeping it in adapters prevents keymaps and
-- plugin files from becoming bloated.
--
-- HOW IT WORKS
-- ------------
-- Detects Python test files, builds pytest commands, and sends those commands
-- to the dedicated BetterTerm test terminal.
--
-- FLOW
-- ----
-- User presses <leader>t or <leader>tn -> adapter saves file -> adapter builds
-- pytest command -> BetterTerm executes tests in terminal 2.
--
-- BEGINNER NOTES
-- --------------
-- V1 only supports Python tests. Lua and Bash test support can be added later.
-- ==========================================================

local M = {}

------------------------------------------
-- CONSTANTS
------------------------------------------

local TEST_TERMINAL_ID = 2

------------------------------------------
-- NOTIFICATIONS
------------------------------------------

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, {
		title = "Test",
	})
end

------------------------------------------
-- CURRENT FILE HELPERS
------------------------------------------

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

------------------------------------------
-- PYTHON COMMAND DETECTION
------------------------------------------

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

local function pytest_command()
	return find_python_command() .. " -m pytest"
end

------------------------------------------
-- TEST TERMINAL
------------------------------------------

local function send_to_test_terminal(command)
	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		notify("BetterTerm is not available", vim.log.levels.ERROR)
		return
	end

	better_term.open(TEST_TERMINAL_ID)

	vim.defer_fn(function()
		better_term.send(command, TEST_TERMINAL_ID, {
			clean = true,
			interrupt = true,
		})
	end, 100)
end

------------------------------------------
-- NEAREST PYTHON TEST DETECTION
------------------------------------------
--
-- Uses Treesitter to detect the nearest test function/class
-- based on the user's current cursor position.
--
-- Supports:
--
-- def test_example():
--
-- class TestUser:
--     def test_create_user():
--
-- Returns:
--
-- test_example
--
-- OR
--
-- TestUser::test_create_user

local function nearest_python_test_name()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cursor_row = cursor[1] - 1
	local cursor_col = cursor[2]

	local ok, parser = pcall(vim.treesitter.get_parser, 0, "python")

	if not ok or not parser then
		notify("Python Treesitter parser is not available", vim.log.levels.WARN)
		return nil
	end

	local trees = parser:parse()

	if not trees or not trees[1] then
		notify("Python syntax tree is not available", vim.log.levels.WARN)
		return nil
	end

	local root = trees[1]:root()

	local node = root:named_descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)

	local test_function = nil
	local test_class = nil

	while node do
		if node:type() == "function_definition" then
			local name_node = node:field("name")[1]

			if name_node then
				local name = vim.treesitter.get_node_text(name_node, 0)

				if name and vim.startswith(name, "test_") then
					test_function = name
				end
			end
		end

		if node:type() == "class_definition" then
			local name_node = node:field("name")[1]

			if name_node then
				local name = vim.treesitter.get_node_text(name_node, 0)

				if name and vim.startswith(name, "Test") then
					test_class = name
				end
			end
		end

		node = node:parent()
	end

	if test_class and test_function then
		return test_class .. "::" .. test_function
	end

	return test_function
end

------------------------------------------
-- TEST CURRENT FILE
------------------------------------------

function M.test_current_file()
	local file = current_file()

	if not file then
		notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	if file_extension(file) ~= "py" then
		notify("Only Python tests are supported in V1", vim.log.levels.WARN)
		return
	end

	vim.cmd("write")

	local command = pytest_command() .. " " .. shell_escape(file) .. " -v"

	send_to_test_terminal(command)
end

------------------------------------------
-- TEST NEAREST
------------------------------------------

function M.test_nearest()
	local file = current_file()

	if not file then
		notify("No file is currently open", vim.log.levels.WARN)
		return
	end

	if file_extension(file) ~= "py" then
		notify("Only Python nearest-test is supported in V1", vim.log.levels.WARN)
		return
	end

	local test_name = nearest_python_test_name()

	if not test_name then
		notify("No nearest Python test function found", vim.log.levels.WARN)
		return
	end

	vim.cmd("write")

	local command = pytest_command() .. " " .. shell_escape(file .. "::" .. test_name) .. " -v"

	send_to_test_terminal(command)
end

return M
