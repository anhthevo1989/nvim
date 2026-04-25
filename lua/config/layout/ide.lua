-- ==========================================================
-- FILE: lua/config/layout/ide.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Open and control the IDE layout.
--
-- WHY IT EXISTS
-- -------------
-- The dashboard should stay lightweight.
-- Once a project or file is opened, Neovim should become an IDE
-- without manual toggles.
--
-- This file also provides explicit layout controls:
-- - IDE layout
-- - Zen layout
--
-- HOW IT WORKS
-- ------------
-- This module safely controls:
-- - nvim-tree on the left
-- - betterTerm shell terminal on the bottom
--
-- FLOW
-- ----
-- 1. Dashboard opens first.
-- 2. User opens a file or project.
-- 3. This module opens the IDE layout.
-- 4. User can switch between IDE and Zen layouts.
--
-- BEGINNER NOTES
-- --------------
-- betterTerm owns terminal workflow.
-- nvim-tree owns file explorer workflow.
-- This file only decides when those tools are shown or hidden.
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

local function focus_file_tree()
	local ok, nvim_tree_api = pcall(require, "nvim-tree.api")

	if not ok then
		vim.notify("nvim-tree is not available yet", vim.log.levels.WARN)
		return
	end

	nvim_tree_api.tree.open()
	nvim_tree_api.tree.focus()
end

local function close_file_tree()
	local ok, nvim_tree_api = pcall(require, "nvim-tree.api")

	if not ok then
		return
	end

	nvim_tree_api.tree.close()
end

local function open_bottom_terminal()
	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		vim.notify("betterTerm is not available yet", vim.log.levels.WARN)
		return
	end

	better_term.open(0)
end

local function close_bottom_terminal()
	local ok, better_term = pcall(require, "betterTerm")

	if not ok then
		return
	end

	better_term.toggle_termwindow()
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

function M.ide_layout()
	layout_has_opened = true

	vim.schedule(function()
		open_file_tree()
		open_bottom_terminal()
	end)
end

function M.zen_layout()
	vim.schedule(function()
		close_file_tree()
		close_bottom_terminal()
	end)
end

function M.setup()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("AutoOpenIdeLayout", { clear = true }),
		callback = function()
			M.open()
		end,
	})

	vim.keymap.set("n", "<leader>li", function()
		M.ide_layout()
	end, {
		desc = "IDE Layout",
	})

	vim.keymap.set("n", "<leader>lz", function()
		M.zen_layout()
	end, {
		desc = "Zen Layout",
	})
end

return M
