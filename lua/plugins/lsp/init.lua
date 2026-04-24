-- ==========================================================
-- FILE: lua/plugins/lsp/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure LSP servers
--
-- SERVERS
-- -------
-- - lua_ls   → Lua
-- - bashls   → Shell
-- - pyright  → Python
-- ==========================================================

return {
	"neovim/nvim-lspconfig",

	config = function()
		local lspconfig = require("lspconfig")

		-- ------------------------------------------------------
		-- LUA
		-- ------------------------------------------------------
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- ------------------------------------------------------
		-- BASH
		-- ------------------------------------------------------
		lspconfig.bashls.setup({})

		-- ------------------------------------------------------
		-- PYTHON (PYRIGHT)
		-- ------------------------------------------------------
		lspconfig.pyright.setup({})
	end,
}
