-- ==========================================================
-- FILE: lua/core/keymaps/selection.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Define selection keymaps.
--
-- WHY IT EXISTS
-- -------------
-- Selection actions should be grouped under one clear namespace.
-- This keeps editing actions discoverable and consistent.
--
-- HOW IT WORKS
-- ------------
-- All mappings use <leader>s.
-- Native Vim motions handle simple selections.
-- Treesitter textobjects handle structural selections.
--
-- FLOW
-- ----
-- 1. User presses <leader>s.
-- 2. which-key shows selection actions.
-- 3. User chooses what to select.
--
-- BEGINNER NOTES
-- --------------
-- Function and class selection uses nvim-treesitter-textobjects.
-- Lazy may install a plugin without loading it, so we load it explicitly.
-- ==========================================================

local keymap = vim.keymap.set

local function load_textobjects()
	local lazy_ok, lazy = pcall(require, "lazy")

	if lazy_ok then
		lazy.load({
			plugins = {
				"nvim-treesitter-textobjects",
			},
		})
	end
end

local function select_textobject(textobject_name)
	load_textobjects()

	local ok, textobject_select = pcall(require, "nvim-treesitter-textobjects.select")

	if not ok then
		vim.notify("Treesitter textobjects not available", vim.log.levels.WARN)
		return
	end

	textobject_select.select_textobject(textobject_name, "textobjects")
end

keymap({ "n", "v" }, "<leader>sa", "ggVG", {
	desc = "Select All",
})

keymap({ "n", "v" }, "<leader>sw", "viw", {
	desc = "Select Word",
})

keymap({ "n", "v" }, "<leader>sl", "V", {
	desc = "Select Line",
})

keymap({ "n", "v" }, "<leader>sp", "vip", {
	desc = "Select Paragraph",
})

keymap({ "n", "v" }, "<leader>sb", "vi{", {
	desc = "Select Block",
})

keymap({ "n", "v" }, "<leader>sf", function()
	select_textobject("@function.outer")
end, {
	desc = "Select Function",
})

keymap({ "n", "v" }, "<leader>sc", function()
	select_textobject("@class.outer")
end, {
	desc = "Select Class",
})
