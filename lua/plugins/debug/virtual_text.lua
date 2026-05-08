-- ==========================================================
-- FILE: lua/plugins/debug/virtual_text.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Show inline variable values during debugging
--
-- WHAT THIS DOES
-- --------------
-- - Displays variable values next to code
-- - Updates live during debug session
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"theHamsta/nvim-dap-virtual-text",

		dependencies = {
			"mfussenegger/nvim-dap",
		},

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			require("nvim-dap-virtual-text").setup({
				commented = true,
			})
		end,
	},
}
