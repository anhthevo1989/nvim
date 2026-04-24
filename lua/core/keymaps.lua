-- ==========================================================
-- FILE: lua/core/keymaps.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Define core keymaps for Neovim configuration
-- ==========================================================

local keymap = vim.keymap.set

-- ==========================================================
-- EXPLORER
-- ==========================================================

keymap("n", "<leader>ex", function()
	local ok, api = pcall(require, "nvim-tree.api")

	if ok then
		api.tree.focus()
	else
		vim.notify("nvim-tree not available", vim.log.levels.WARN)
	end
end, { desc = "Explorer Focus" })

-- ==========================================================
-- TERMINAL
-- ==========================================================

-- Exit terminal mode
keymap("t", "<Esc><Esc>", [[<C-\><C-n>]], {
	desc = "Exit Terminal Mode",
})
