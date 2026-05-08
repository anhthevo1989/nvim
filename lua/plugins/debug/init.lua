-- ==========================================================
-- FILE: lua/plugins/debug/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Debugging system using nvim-dap + OSV (Lua debugger)
-- ==========================================================

return {
	{
		------------------------------------------
		-- INSTALLATION
		------------------------------------------
		"mfussenegger/nvim-dap",

		dependencies = {
			"jbyuki/one-small-step-for-vimkind",
		},

		------------------------------------------
		-- CONFIGURATION
		------------------------------------------
		config = function()
			local dap = require("dap")
			local osv = require("osv")

			------------------------------------------
			-- KEYMAPS
			------------------------------------------

			vim.keymap.set("n", "<F5>", function()
				local dap = require("dap")
				local osv = require("osv")

				osv.launch({ port = 8086 })
				dap.continue()
			end)

			vim.keymap.set("n", "<F10>", dap.step_over)
			vim.keymap.set("n", "<F11>", dap.step_into)
			vim.keymap.set("n", "<F12>", dap.step_out)

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)

			------------------------------------------
			-- ADAPTER
			------------------------------------------

			dap.adapters.nlua = function(callback, config)
				callback({
					type = "server",
					host = "127.0.0.1",
					port = 8086,
				})
			end

			dap.configurations.lua = {
				{
					type = "nlua",
					request = "attach",
					name = "Attach to running Neovim instance",
				},
			}
		end,
	},
}
