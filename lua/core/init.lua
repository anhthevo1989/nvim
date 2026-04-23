-- ==========================================================
-- PURPOSE
-- Load all core configuration modules
--
-- WHY IT EXISTS
-- Ensures consistent and predictable load order
--
-- HOW IT WORKS
-- Requires modules in a defined sequence
--
-- FLOW
-- globals → options → keymaps → autocmds
--
-- BEGINNER NOTES
-- Order matters. Globals must load first.
-- ==========================================================

require("core.globals")
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostics")
