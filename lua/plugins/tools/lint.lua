-- ==========================================================
-- FILE: lua/plugins/tools/lint.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure linting using nvim-lint.
--
-- WHY IT EXISTS
-- -------------
-- Linting catches code problems while editing without needing
-- to manually run command-line tools.
--
-- HOW IT WORKS
-- ------------
-- nvim-lint maps filetypes to external linters.
-- Autocommands trigger linting when buffers are opened,
-- saved, or when insert mode ends.
--
-- FLOW
-- ----
-- User opens or edits a file
-- → nvim-lint checks the filetype
-- → matching linter runs
-- → diagnostics appear in Neovim
--
-- BEGINNER NOTES
-- --------------
-- Linters must be installed before they can run.
-- Mason installs the main linters used by this config.
-- ==========================================================

return {
	------------------------------------------
	-- INSTALLATION
	------------------------------------------
	"mfussenegger/nvim-lint",

	event = { "BufReadPre", "BufNewFile" },

	------------------------------------------
	-- CONFIGURATION
	------------------------------------------
	config = function()
		local lint = require("lint")

		------------------------------------------
		-- FILETYPE → LINTER
		------------------------------------------
		lint.linters_by_ft = {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			zsh = { "shellcheck" },

			python = { "ruff" },

			lua = { "luacheck" },
		}

		------------------------------------------
		-- AUTOCMD
		-----------------------------------------
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
