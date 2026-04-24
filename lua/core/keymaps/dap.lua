-- ==========================================================
-- DEBUGGING (DAP)
-- ==========================================================

local map = vim.keymap.set

-- ----------------------------------------------------------
-- BREAKPOINTS
-- ----------------------------------------------------------

map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end)

map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Condition: "))
end)

map("n", "<leader>dC", function()
  require("dap").clear_breakpoints()
end)

-- ----------------------------------------------------------
-- EXECUTION
-- ----------------------------------------------------------

map("n", "<leader>dc", function()
  require("dap").continue()
end)

map("n", "<leader>dR", function()
  require("dap").restart()
end)

map("n", "<leader>dt", function()
  require("dap").terminate()
end)

map("n", "<leader>dl", function()
  require("dap").run_last()
end)

-- ----------------------------------------------------------
-- STEPPING
-- ----------------------------------------------------------

map("n", "<leader>di", function()
  require("dap").step_into()
end)

map("n", "<leader>do", function()
  require("dap").step_over()
end)

map("n", "<leader>dO", function()
  require("dap").step_out()
end)

-- ----------------------------------------------------------
-- UTILITIES
-- ----------------------------------------------------------

map("n", "<leader>dr", function()
  require("dap").repl.open()
end)
