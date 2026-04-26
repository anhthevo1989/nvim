-- ==========================================================
-- FILE: lua/core/keymaps.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Load core keymaps and keymap modules.
--
-- WHY IT EXISTS
-- -------------
-- This file owns global keymaps that should always be available.
-- Feature-specific keymaps live in lua/core/keymaps/.
--
-- HOW IT WORKS
-- ------------
-- Core mappings are defined first.
-- Then feature keymap modules are loaded.
--
-- FLOW
-- ----
-- 1. Neovim loads core config.
-- 2. This file registers global keymaps.
-- 3. Feature keymap modules are loaded.
--
-- BEGINNER NOTES
-- --------------
-- Keep universal mappings here.
-- Put feature-specific mappings in lua/core/keymaps/.
-- ==========================================================

local keymap = vim.keymap.set

-- ==========================================================
-- VIRTUAL ENV (PYTHON)
-- ==========================================================

keymap("n", "<leader>pv", function()
	local root = vim.fn.getcwd()
	local venv_path = root .. "/.venv"

	-- check if already exists
	if vim.fn.isdirectory(venv_path) == 1 then
		vim.notify(".venv already exists", vim.log.levels.INFO)
		return
	end

	vim.notify("Creating Python virtual environment...")

	vim.fn.jobstart({ "python", "-m", "venv", ".venv" }, {
		cwd = root,
		on_exit = function(_, code)
			if code == 0 then
				vim.schedule(function()
					vim.notify(".venv created successfully", vim.log.levels.INFO)
				end)
			else
				vim.schedule(function()
					vim.notify("Failed to create .venv", vim.log.levels.ERROR)
				end)
			end
		end,
	})
end, { desc = "Python: Create .venv" })

-- ==========================================================
-- FILE ACTIONS
-- ==========================================================

keymap("n", "<leader>w", "<cmd>write<CR>", {
	desc = "Save File",
})

keymap("n", "<leader>q", "<cmd>quit<CR>", {
	desc = "Quit Window",
})

-- ==========================================================
-- WINDOW NAVIGATION
-- ==========================================================

keymap("n", "<C-h>", "<C-w>h", {
	desc = "Move to Left Window",
})

keymap("n", "<C-j>", "<C-w>j", {
	desc = "Move to Lower Window",
})

keymap("n", "<C-k>", "<C-w>k", {
	desc = "Move to Upper Window",
})

keymap("n", "<C-l>", "<C-w>l", {
	desc = "Move to Right Window",
})

-- ----------------------------------------------------------
-- SEARCH
-- ----------------------------------------------------------
keymap("n", "Esc", "<cmd>nohlsearch<CR>")

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
end, {
	desc = "Explorer Focus",
})

-- ==========================================================
-- TERMINAL
-- ==========================================================

keymap("t", "<Esc><Esc>", [[<C-\><C-n>]], {
	desc = "Exit Terminal Mode",
})

-- ==========================================================
-- THEME CYCLER
-- ==========================================================

local themes = {
	-- Pulse variants
	{ type = "pulse", name = "dark" },
	{ type = "pulse", name = "light" },
	{ type = "pulse", name = "high_contrast" },
}

local current_theme_index = 1

local function apply_theme(entry)
	if entry.type == "pulse" then
		local ok, apply = pcall(require, "theme.apply")

		if ok then
			apply.apply(entry.name)
			vim.notify("Pulse: " .. entry.name)
		end
	else
		vim.cmd.colorscheme(entry.name)
		vim.notify("Theme: " .. entry.name)
	end
end

vim.keymap.set("n", "<leader>uc", function()
	current_theme_index = current_theme_index + 1

	if current_theme_index > #themes then
		current_theme_index = 1
	end

	apply_theme(themes[current_theme_index])
end, {
	desc = "UI: Cycle Colors",
})

-- ==========================================================
-- MODULES
-- ==========================================================

require("core.keymaps.lsp")
require("core.keymaps.dap")
require("core.keymaps.run")
require("core.keymaps.selection")
