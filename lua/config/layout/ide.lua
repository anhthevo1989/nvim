-- ==========================================================
-- FILE: lua/config/layout/ide.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Open the full IDE layout automatically after real work starts.
--
-- WHY IT EXISTS
-- -------------
-- The dashboard should stay lightweight.
-- Once a project or file is opened, Neovim should become an IDE
-- without manual toggles.
--
-- HOW IT WORKS
-- ------------
-- This module safely opens:
-- - nvim-tree on the left
-- - Snacks terminal on the bottom
--
-- FLOW
-- ----
-- 1. Dashboard opens first.
-- 2. User opens a file or project.
-- 3. This module opens the IDE layout.
-- 4. If a tool is unavailable, it warns instead of crashing.
--
-- BEGINNER NOTES
-- --------------
-- Do not call :NvimTreeOpen directly here.
-- Use nvim-tree's Lua API so lazy-loaded commands do not break startup.
-- ==========================================================

local M = {}

local layout_has_opened = false

local function is_real_file_buffer()
	local buffer_name = vim.api.nvim_buf_get_name(0)

	if buffer_name == "" then
		return false
	end

	if vim.bo.buftype ~= "" then
		return false
	end

	return true
end

local function open_file_tree()
	local ok, nvim_tree_api = pcall(require, "nvim-tree.api")

	if not ok then
		vim.notify("nvim-tree is not available yet", vim.log.levels.WARN)
		return
	end

	nvim_tree_api.tree.open({
		focus = false,
	})
end

local function open_bottom_terminal()
	if not Snacks or not Snacks.terminal then
		vim.notify("Snacks terminal is not available yet", vim.log.levels.WARN)
		return
	end

	Snacks.terminal.open(nil, {
		win = {
			position = "bottom",
			height = 0.3,
		},
	})
end

function M.open()
	if layout_has_opened then
		return
	end

	if not is_real_file_buffer() then
		return
	end

	layout_has_opened = true

	vim.schedule(function()
		open_file_tree()
		open_bottom_terminal()
	end)
end

function M.force_open()
	layout_has_opened = true

	vim.schedule(function()
		open_file_tree()
		open_bottom_terminal()
	end)
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("AutoOpenIdeLayout", { clear = true }),
		callback = function()
			M.open()
		end,
	})
end

return M
