-- ==========================================================
-- LSP KEYMAPS
-- ==========================================================

local map = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }

		-- ------------------------------------------------------
		-- NAVIGATION
		-- ------------------------------------------------------

		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "K", vim.lsp.buf.hover, opts)

		-- ------------------------------------------------------
		-- ACTIONS
		-- ------------------------------------------------------

		map("n", "<leader>rn", vim.lsp.buf.rename, opts)
		map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end,
})
