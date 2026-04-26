-- ==========================================================
-- FILE: lua/plugins/lsp/init.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Configure LSP servers using Neovim native API.
--
-- WHY IT EXISTS
-- -------------
-- LSP provides language intelligence:
-- - completion
-- - diagnostics
-- - rename
-- - code actions
-- - go to definition
--
-- HOW IT WORKS
-- ------------
-- This file:
-- - builds cmp-aware capabilities
-- - configures Lua, Bash, and Python language servers
-- - detects Python virtual environments for Pyright
-- - enables the configured servers
--
-- BEGINNER NOTES
-- --------------
-- If a file has no LSP client attached, completion will fall back
-- to buffer/path suggestions only.
-- ==========================================================

return {
	"neovim/nvim-lspconfig",

	lazy = false,

	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},

	config = function()
		-- ======================================================
		-- CAPABILITIES
		-- ======================================================

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if ok then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- ======================================================
		-- HELPERS
		-- ======================================================

		local function get_root(markers)
			return vim.fs.root(0, markers) or vim.fn.getcwd()
		end

		local function find_python_venv(root)
			local candidates = {
				{
					name = ".venv",
					python = root .. "/.venv/bin/python",
				},
				{
					name = "venv",
					python = root .. "/venv/bin/python",
				},
				{
					name = "env",
					python = root .. "/env/bin/python",
				},
			}

			for _, candidate in ipairs(candidates) do
				if vim.fn.executable(candidate.python) == 1 then
					return {
						name = candidate.name,
						path = root .. "/" .. candidate.name,
						python = candidate.python,
					}
				end
			end

			return nil
		end

		-- ======================================================
		-- LUA
		-- ======================================================

		vim.lsp.config("lua_ls", {
			cmd = { "lua-language-server" },
			filetypes = { "lua" },
			root_markers = {
				".luarc.json",
				".luarc.jsonc",
				".luacheckrc",
				".stylua.toml",
				"stylua.toml",
				"selene.toml",
				"selene.yml",
				".git",
			},
			capabilities = capabilities,

			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						checkThirdParty = false,
						library = vim.api.nvim_get_runtime_file("", true),
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})

		-- ======================================================
		-- BASH
		-- ======================================================

		vim.lsp.config("bashls", {
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh", "bash" },
			root_markers = {
				".git",
			},
			capabilities = capabilities,
		})

		-- ======================================================
		-- PYTHON
		-- ======================================================

		vim.lsp.config("pyright", {
			cmd = { "pyright-langserver", "--stdio" },
			filetypes = { "python" },
			root_markers = {
				"pyrightconfig.json",
				"pyproject.toml",
				"setup.py",
				"setup.cfg",
				"requirements.txt",
				"Pipfile",
				".git",
			},
			capabilities = capabilities,

			before_init = function(_, config)
				local root = get_root(config.root_markers)
				local venv = find_python_venv(root)

				if not venv then
					return
				end

				config.settings = config.settings or {}
				config.settings.python = config.settings.python or {}

				config.settings.python.pythonPath = venv.python
				config.settings.python.venvPath = root
				config.settings.python.venv = venv.name
			end,

			settings = {
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = "openFilesOnly",
						useLibraryCodeForTypes = true,
					},
				},
			},
		})

		-- ======================================================
		-- ENABLE SERVERS
		-- ======================================================

		vim.lsp.enable("lua_ls")
		vim.lsp.enable("bashls")
		vim.lsp.enable("pyright")
	end,
}
