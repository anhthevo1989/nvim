-- ==========================================================
-- ONE-KEY RUN
-- ==========================================================

local map = vim.keymap.set

map("n", "<leader>r", function()
	require("core.run").run()
end, { desc = "Run file" })
