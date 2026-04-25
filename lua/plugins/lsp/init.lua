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
-- Adds nvim-cmp capabilities so LSP completion works.
-- ==========================================================

return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

		if ok then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- ======================================================
		-- LUA
		-- ======================================================
		vim.lsp.config("lua_ls", {
			capabilities = capabilities,

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
		vim.lsp.config("bashls", {
			capabilities = capabilities,
		})

		-- ======================================================
		-- PYTHON
		-- ======================================================
		vim.lsp.config("pyright", {
			capabilities = capabilities,
		})

		-- ======================================================
		-- ENABLE SERVERS
		-- ======================================================
		vim.lsp.enable("lua_ls")
		vim.lsp.enable("bashls")
		vim.lsp.enable("pyright")
	end,
}
