-- ==========================================================
-- FILE: lua/plugins/dap/lua.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure Lua debugging using one-small-step-for-vimkind.
--
-- WHY IT EXISTS
-- -------------
-- Enables debugging Lua code running inside Neovim.
--
-- HOW IT WORKS
-- ------------
-- one-small-step-for-vimkind starts a Lua debug server.
-- nvim-dap attaches to that server using the nlua adapter.
--
-- FLOW
-- ----
-- 1. User starts Lua debugging.
-- 2. osv launches a debug server.
-- 3. nvim-dap attaches to the running Neovim instance.
-- 4. Breakpoints can be hit.
--
-- BEGINNER NOTES
-- --------------
-- Lua debugging here is for Lua running inside Neovim.
-- It is different from running a standalone lua script.
-- ==========================================================

return {
	"jbyuki/one-small-step-for-vimkind",

	dependencies = {
		"mfussenegger/nvim-dap",
	},

	config = function()
		local dap = require("dap")

		local port = 8086

		dap.adapters.nlua = function(callback)
			callback({
				type = "server",
				host = "127.0.0.1",
				port = port,
			})
		end

		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
				port = port,

				before = function()
					require("osv").launch({
						port = port,
					})
				end,
			},
		}
	end,
}
