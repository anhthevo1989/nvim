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
	------------------------------------------
	-- INSTALLATION
	------------------------------------------
	"jbyuki/one-small-step-for-vimkind",

	dependencies = {
		"mfussenegger/nvim-dap",

		{
			"tomblind/local-lua-debugger-vscode",
			build = "npm install && npm run build",
		},
	},

	------------------------------------------
	-- CONFIGURATION
	------------------------------------------
	config = function()
		local dap = require("dap")

		------------------------------------------
		-- NEOVIM LUA DEBUGGING
		------------------------------------------

		local port = 8086

		dap.adapters.nlua = function(callback)
			callback({
				type = "server",
				host = "127.0.0.1",
				port = port,
			})
		end

		------------------------------------------
		-- STANDALONE LUA DEBUGGING
		------------------------------------------
		dap.adapters["local-lua"] = {
			type = "executable",
			command = "node",
			args = {
				vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode/extension/debugAdapter.js",
			},
		}

		------------------------------------------
		-- LUA DEBUG CONFIGURATIONS
		------------------------------------------

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

			{
				name = "Debug Standalone Lua File",
				type = "local-lua",
				request = "launch",
				cwd = "${workspaceFolder}",

				program = {
					lua = "luajit",
					file = "${file}",
				},

				args = {},

				extensionPath = vim.fn.stdpath("data") .. "/lazy/local-lua-debugger-vscode",
			},
		}
	end,
}
