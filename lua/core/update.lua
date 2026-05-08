-- ==========================================================
-- FILE: lua/core/update.lua
-- ==========================================================
--
-- PURPOSE
-- -------
-- Provides a simple Neovim command for updating this config
-- from the stable Git branch.
--
-- WHY IT EXISTS
-- -------------
-- Users should be able to update the config without leaving
-- Neovim to manually run Git commands.
--
-- This creates:
--
-- :UpdateConfig
--
-- HOW IT WORKS
-- ------------
-- The command:
--
-- 1. Finds active config directory
-- 2. Fetches latest changes
-- 3. Ensures stable branch
-- 4. Pulls updates
-- 5. Syncs plugins
-- 6. Prompts restart
--
-- FLOW
-- ----
-- :UpdateConfig
-- → git fetch
-- → git checkout main
-- → git pull --ff-only
-- → Lazy sync
-- → restart prompt
--
-- BEGINNER NOTES
-- --------------
-- This only updates from:
--
-- main
--
-- Development branches remain manual by design.
-- ==========================================================

local M = {}

------------------------------------------
-- STABLE BRANCH
------------------------------------------

local STABLE_BRANCH = "main"

------------------------------------------
-- NOTIFICATIONS
------------------------------------------

local function notify(message, level)
	vim.notify(message, level or vim.log.levels.INFO, {
		title = "Neovim Update",
	})
end

------------------------------------------
-- GIT COMMAND RUNNER
------------------------------------------

local function run_git_command(config_dir, arguments)
	local command = {
		"git",
		"-C",
		config_dir,
	}

	for _, argument in ipairs(arguments) do
		table.insert(command, argument)
	end

	local result = vim.system(command, {
		text = true,
	}):wait()

	return result.code == 0, result.stdout, result.stderr
end

------------------------------------------
-- PLUGIN SYNC
------------------------------------------

local function sync_plugins()
	notify("Config updated. Syncing plugins...")
	vim.cmd("Lazy sync")
end

------------------------------------------
-- RESTART PROMPT
------------------------------------------

local function prompt_restart()
	vim.defer_fn(function()
		vim.ui.select({
			"Restart now",
			"Later",
		}, {
			prompt = "Restart Neovim to finish update?",
		}, function(choice)
			if choice == "Restart now" then
				vim.cmd("qa")
			end
		end)
	end, 1000)
end

------------------------------------------
-- MAIN UPDATE LOGIC
------------------------------------------

function M.update_config()
	local config_dir = vim.fn.stdpath("config")

	notify("Updating config from stable branch...")

	------------------------------------------
	-- FETCH LATEST CHANGES
	------------------------------------------

	local fetch_ok, _, fetch_error = run_git_command(config_dir, {
		"fetch",
		"origin",
	})

	if not fetch_ok then
		notify("Git fetch failed:\n" .. fetch_error, vim.log.levels.ERROR)
		return
	end

	------------------------------------------
	-- ENSURE MAIN BRANCH
	------------------------------------------

	local checkout_ok, _, checkout_error = run_git_command(config_dir, {
		"checkout",
		STABLE_BRANCH,
	})

	if not checkout_ok then
		notify("Git checkout failed:\n" .. checkout_error, vim.log.levels.ERROR)
		return
	end

	------------------------------------------
	-- PULL LATEST UPDATES
	------------------------------------------

	local pull_ok, _, pull_error = run_git_command(config_dir, {
		"pull",
		"--ff-only",
		"origin",
		STABLE_BRANCH,
	})

	if not pull_ok then
		notify("Git pull failed:\n" .. pull_error, vim.log.levels.ERROR)
		return
	end

	------------------------------------------
	-- SYNC PLUGINS
	------------------------------------------

	sync_plugins()

	------------------------------------------
	-- PROMPT RESTART
	------------------------------------------

	prompt_restart()
end

------------------------------------------
-- USER COMMAND
------------------------------------------

function M.setup()
	vim.api.nvim_create_user_command("UpdateConfig", function()
		M.update_config()
	end, {
		desc = "Update Neovim config from stable branch",
	})
end

return M
