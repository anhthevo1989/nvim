-- ==========================================================
-- FILE: lua/config/layout/ide.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Control IDE and Zen layout.
-- ==========================================================

local M = {}

local layout_has_opened = false

-- ==========================================================
-- HELPERS
-- ==========================================================

local function is_real_file_buffer()
	return vim.api.nvim_buf_get_name(0) ~= "" and vim.bo.buftype == ""
end

local function get_visible_terminal_windows()
	local terminal_windows = {}

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)

		if vim.bo[buf].buftype == "terminal" then
			table.insert(terminal_windows, win)
		end
	end

	return terminal_windows
end

local function terminal_is_visible()
	return #get_visible_terminal_windows() > 0
end

-- ==========================================================
-- FILE TREE (Neo-tree)
-- ==========================================================

local function open_file_tree()
	vim.cmd("Neotree reveal left filesystem")
end

local function close_file_tree()
	vim.cmd("Neotree close")
end

-- ==========================================================
-- TERMINAL (betterTerm)
-- ==========================================================

local function open_terminal()
	if terminal_is_visible() then
		return
	end

	local ok, better_term = pcall(require, "betterTerm")
	if not ok then
		vim.notify("betterTerm not available", vim.log.levels.WARN)
		return
	end

	better_term.open(0)
end

local function close_terminal()
	for _, win in ipairs(get_visible_terminal_windows()) do
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end
end

-- ==========================================================
-- LAYOUT CONTROL
-- ==========================================================

function M.open()
	if layout_has_opened or not is_real_file_buffer() then
		return
	end

	layout_has_opened = true

	vim.schedule(function()
		open_file_tree()
		open_terminal()
	end)
end

function M.ide_layout()
	layout_has_opened = true

	vim.schedule(function()
		open_file_tree()
		open_terminal()
	end)
end

function M.zen_layout()
	vim.schedule(function()
		close_file_tree()
		close_terminal()
	end)
end

-- ==========================================================
-- SETUP
-- ==========================================================

function M.setup()
	vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("AutoOpenIdeLayout", { clear = true }),
		callback = function()
			M.open()
		end,
	})

	vim.keymap.set("n", "<leader>li", M.ide_layout, {
		desc = "IDE Layout",
	})

	vim.keymap.set("n", "<leader>lz", M.zen_layout, {
		desc = "Zen Layout",
	})
end

return M
