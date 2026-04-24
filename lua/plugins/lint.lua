-- ==========================================================
-- FILE: lua/plugins/lint.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure linting using nvim-lint
--
-- SUPPORTED
-- ---------
-- - shell (shellcheck)
-- - python (ruff)
-- - lua (luacheck optional)
--
-- FLOW
-- ----
-- Lint runs automatically on:
-- - BufEnter
-- - BufWritePost
-- - InsertLeave
--
-- BEGINNER NOTES
-- --------------
-- Linters must be installed on your system:
-- - shellcheck
-- - ruff
-- - luacheck (optional)
-- ==========================================================

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local lint = require("lint")

		-- ------------------------------------------------------
		-- FILETYPE → LINTER
		-- ------------------------------------------------------
		lint.linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },

			python = { "ruff" },

			lua = { "luacheck" }, -- optional
		}

		-- ------------------------------------------------------
		-- AUTOCMD
		-- ------------------------------------------------------
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
