-- ==========================================================
-- FILE: lua/core/keymaps/dap.lua
-- ==========================================================
-- PURPOSE
-- -------
-- Keymaps for debugging (nvim-dap).
--
-- WHY IT EXISTS
-- -------------
-- Debug keymaps should be available at startup without forcing
-- nvim-dap to load immediately.
--
-- HOW IT WORKS
-- ------------
-- When a debug keymap is pressed, lazy.nvim loads nvim-dap.
-- Then the requested dap action runs.
-- ==========================================================

local map = vim.keymap.set

local function with_dap(callback)
	local lazy_ok, lazy = pcall(require, "lazy")

	if lazy_ok then
		lazy.load({
			plugins = {
				"nvim-dap",
			},
		})
	end

	local ok, dap = pcall(require, "dap")

	if not ok then
		vim.notify("nvim-dap is not available", vim.log.levels.WARN)
		return
	end

	callback(dap)
end

-- ==========================================================
-- BREAKPOINTS
-- ==========================================================

map("n", "<leader>db", function()
	with_dap(function(dap)
		dap.toggle_breakpoint()
	end)
end, {
	desc = "Debug: Toggle Breakpoint",
})

-- ==========================================================
-- CONTROL
-- ==========================================================

map("n", "<leader>dc", function()
	with_dap(function(dap)
		dap.continue()
	end)
end, {
	desc = "Debug: Start/Continue",
})

map("n", "<leader>dx", function()
	with_dap(function(dap)
		dap.terminate()

		pcall(function()
			require("dapui").close()
		end)

		vim.schedule(function()
			pcall(function()
				require("adapters.layout").ide_layout()
			end)
		end)
	end)
end, {
	desc = "Debug: Stop",
})

-- ==========================================================
-- STEPPING
-- ==========================================================

map("n", "<leader>di", function()
	with_dap(function(dap)
		dap.step_into()
	end)
end, {
	desc = "Debug: Step Into",
})

map("n", "<leader>do", function()
	with_dap(function(dap)
		dap.step_over()
	end)
end, {
	desc = "Debug: Step Over",
})

map("n", "<leader>dO", function()
	with_dap(function(dap)
		dap.step_out()
	end)
end, {
	desc = "Debug: Step Out",
})

-- ==========================================================
-- REPL
-- ==========================================================

map("n", "<leader>dr", function()
	with_dap(function(dap)
		dap.repl.open()
	end)
end, {
	desc = "Debug: REPL",
})
