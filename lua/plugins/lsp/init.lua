-- ==========================================================
-- FILE: lua/plugins/lsp/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure LSP servers using Neovim native API (0.11+)
--
-- SERVERS
-- -------
-- - lua_ls   → Lua
-- - bashls   → Shell
-- - pyright  → Python
--
-- NOTES
-- -----
-- Uses vim.lsp.config instead of deprecated lspconfig.setup
-- ==========================================================

return {
	"neovim/nvim-lspconfig",

	config = function()
		-- ======================================================
		-- LUA
		-- ======================================================
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- ======================================================
		-- BASH
		-- ======================================================
		vim.lsp.config("bashls", {})

		-- ======================================================
		-- PYTHON
		-- ======================================================
		vim.lsp.config("pyright", {})

		-- ======================================================
		-- ENABLE SERVERS
		-- ======================================================
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("bashls")
		vim.lsp.enable("pyright")
	end,
}
