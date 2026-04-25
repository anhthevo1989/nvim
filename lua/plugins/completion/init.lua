-- ==========================================================
-- FILE: lua/plugins/completion/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure completion system.
--
-- WHY IT EXISTS
-- -------------
-- nvim-cmp provides completion UI.
-- cmp-nvim-lsp connects completion to LSP servers.
-- buffer/path sources provide fallback suggestions.
--
-- HOW IT WORKS
-- ------------
-- Completion is loaded eagerly to avoid lazy-load race conditions.
-- This guarantees cmp sources are registered before InsertEnter.
--
-- FLOW
-- ----
-- 1. Neovim starts.
-- 2. nvim-cmp and sources load.
-- 3. Completion sources are registered.
-- 4. Insert mode suggestions work consistently.
--
-- BEGINNER NOTES
-- --------------
-- Reliability first.
-- We can optimize lazy-loading later if needed.
-- :CmpStatus should show nvim_lsp, path, and buffer.
-- ==========================================================

return {
	{
		"hrsh7th/nvim-cmp",

		lazy = false,

		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
				lazy = false,
			},
			{
				"hrsh7th/cmp-buffer",
				lazy = false,
			},
			{
				"hrsh7th/cmp-path",
				lazy = false,
			},
		},

		config = function()
			local cmp = require("cmp")

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert",
				},

				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),

					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-e>"] = cmp.mapping.abort(),
				}),

				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
				}),
			})
		end,
	},
}
