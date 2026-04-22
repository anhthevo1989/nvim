-- ==========================================================
-- PURPOSE
-- Define automatic commands
--
-- WHY IT EXISTS
-- Automates repetitive behaviors
--
-- HOW IT WORKS
-- Uses Neovim API to attach events
--
-- FLOW
-- Runs when events are triggered
--
-- BEGINNER NOTES
-- Autocommands react to editor actions
-- ==========================================================

local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})
