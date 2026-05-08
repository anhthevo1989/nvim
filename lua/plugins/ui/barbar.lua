-- ==========================================================
-- FILE: lua/plugins/ui/barbar.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure buffer tabs for Neovim.
--
-- WHY IT EXISTS
-- -------------
-- Barbar provides IDE-style buffer tabs at the top of the editor.
-- This makes open files visible and easy to switch between.
--
-- HOW IT WORKS
-- ------------
-- lazy.nvim installs barbar.nvim.
-- barbar.setup() configures tab behavior, icons, diagnostics,
-- and nvim-tree sidebar offset.
--
-- FLOW
-- ----
-- 1. Neovim starts.
-- 2. barbar.nvim loads.
-- 3. Open buffers appear as tabs.
-- 4. User switches, moves, pins, or closes buffers using keymaps.
--
-- BEGINNER NOTES
-- --------------
-- This file only controls buffer tabs.
-- Do not put statusline, dashboard, or layout logic here.
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"romgrk/barbar.nvim",

		event = "VeryLazy",

		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		init = function()
			vim.g.barbar_auto_setup = false
		end,

		opts = {
			animation = false,
			auto_hide = false,
			tabpages = false,
			clickable = true,
			focus_on_close = "previous",
			hide = {
				extensions = true,
				inactive = false,
			},

			icons = {
				buffer_index = false,
				buffer_number = false,
				button = "",
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.WARN] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.INFO] = { enabled = true, icon = " " },
					[vim.diagnostic.severity.HINT] = { enabled = true, icon = "󰌵 " },
				},
				gitsigns = {
					added = { enabled = true, icon = "+" },
					changed = { enabled = true, icon = "~" },
					deleted = { enabled = true, icon = "-" },
				},
				filetype = {
					enabled = true,
				},
				separator = {
					left = "",
					right = "",
				},
				separator_at_end = false,
				modified = {
					button = "●",
				},
				pinned = {
					button = "",
					filename = true,
				},
			},

			sidebar_filetypes = {
				NvimTree = true,
			},

			maximum_padding = 1,
			minimum_padding = 1,
			maximum_length = 30,
			minimum_length = 0,
		},
		------------------------------------------
		-- KEYMAPS
		------------------------------------------
		keys = {
			{
				"<S-h>",
				"<Cmd>BufferPrevious<CR>",
				desc = "Previous Buffer",
			},
			{
				"<S-l>",
				"<Cmd>BufferNext<CR>",
				desc = "Next Buffer",
			},
			{
				"<leader>bp",
				"<Cmd>BufferPin<CR>",
				desc = "Pin Buffer",
			},
			{
				"<leader>bc",
				"<Cmd>BufferClose<CR>",
				desc = "Close Buffer",
			},
			{
				"<leader>bC",
				"<Cmd>BufferCloseAllButCurrent<CR>",
				desc = "Close Other Buffers",
			},
			{
				"<leader>bl",
				"<Cmd>BufferCloseBuffersRight<CR>",
				desc = "Close Buffers Right",
			},
			{
				"<leader>bh",
				"<Cmd>BufferCloseBuffersLeft<CR>",
				desc = "Close Buffers Left",
			},
			{
				"<leader>bo",
				"<Cmd>BufferOrderByDirectory<CR>",
				desc = "Order Buffers By Directory",
			},
		},
	},
}
