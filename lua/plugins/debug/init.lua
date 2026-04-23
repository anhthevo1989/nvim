-- ==========================================================
-- FILE: lua/plugins/debug/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Debugging system using nvim-dap
--
-- WHAT THIS DOES
-- --------------
-- - Installs core debugging engine
-- - Adds basic debugging keymaps
-- ==========================================================

return {
	{
		"mfussenegger/nvim-dap",

		config = function()
			local dap = require("dap")

			-- ======================================================
			-- KEYMAPS
			-- ======================================================

			vim.keymap.set("n", "<F5>", dap.continue)
			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
		end,
	},
}
