-- ==========================================================
-- FILE: lua/core/keymaps/lsp.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Define LSP keymaps.
--
-- WHY IT EXISTS
-- -------------
-- LSP keymaps should only exist when an LSP server is attached.
--
-- HOW IT WORKS
-- ------------
-- Uses LspAttach to register buffer-local mappings.
--
-- BEGINNER NOTES
-- --------------
-- <leader>r = run / refactor namespace
-- ==========================================================

local keymap = vim.keymap.set

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true }),

	callback = function(args)
		local opts = {
			buffer = args.buf,
			silent = true,
		}

		-- ======================================================
		-- REFACTOR
		-- ======================================================

		keymap(
			"n",
			"<leader>rn",
			vim.lsp.buf.rename,
			vim.tbl_extend("force", opts, {
				desc = "Rename Symbol",
			})
		)

		keymap(
			{ "n", "v" },
			"<leader>ra",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, {
				desc = "Code Action",
			})
		)

		-- ======================================================
		-- NAVIGATION
		-- ======================================================

		keymap(
			"n",
			"gd",
			vim.lsp.buf.definition,
			vim.tbl_extend("force", opts, {
				desc = "Go to Definition",
			})
		)

		keymap(
			"n",
			"gr",
			vim.lsp.buf.references,
			vim.tbl_extend("force", opts, {
				desc = "References",
			})
		)

		keymap(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("force", opts, {
				desc = "Go to Implementation",
			})
		)

		keymap(
			"n",
			"gD",
			vim.lsp.buf.declaration,
			vim.tbl_extend("force", opts, {
				desc = "Go to Declaration",
			})
		)

		-- ======================================================
		-- INFO
		-- ======================================================

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({
				border = "rounded",
			})
		end, {
			buffer = args.buf,
			desc = "LSP Hover",
		})

		keymap(
			"n",
			"<leader>ld",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, {
				desc = "Line Diagnostics",
			})
		)

		keymap(
			"n",
			"[d",
			vim.diagnostic.goto_prev,
			vim.tbl_extend("force", opts, {
				desc = "Prev Diagnostic",
			})
		)

		keymap(
			"n",
			"]d",
			vim.diagnostic.goto_next,
			vim.tbl_extend("force", opts, {
				desc = "Next Diagnostic",
			})
		)

		-- ==========================================================
		-- DIAGNOSTICS KEYMAPS
		-- ==========================================================
		-- PURPOSE
		-- -------
		-- Provide quick access to diagnostics without clutter.

		-- ==========================================================

		-- show diagnostics for current line
		vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, {
			desc = "Diagnostics: Show line",
		})

		-- toggle virtual text
		local diagnostics_virtual_text = false

		vim.keymap.set("n", "<leader>dt", function()
			diagnostics_virtual_text = not diagnostics_virtual_text

			vim.diagnostic.config({
				virtual_text = diagnostics_virtual_text,
			})

			vim.notify("Diagnostics virtual text: " .. (diagnostics_virtual_text and "ON" or "OFF"))
		end, {
			desc = "Diagnostics: Toggle virtual text",
		})
	end,
})
