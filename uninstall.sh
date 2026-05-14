#!/bin/sh
# ==========================================================
# FILE: uninstall.sh
# ==========================================================
#
# PURPOSE
# -------
# Remove this Neovim configuration safely.
#
# WHY IT EXISTS
# -------------
# Users should be able to undo the install without guessing which
# files were created or backed up.
#
# HOW IT WORKS
# ------------
# The script removes the config path, optionally removes Neovim data,
# optionally restores backups, and optionally removes dependencies.
#
# FLOW
# ----
# 1. Detect the package manager.
# 2. Ask which paths should be removed.
# 3. Remove the config path.
# 4. Optionally remove the cloned repo.
# 5. Optionally remove Neovim data/cache/state.
# 6. Optionally restore the latest backup.
# 7. Optionally remove workflow dependencies.
# 8. Optionally remove system dependencies.
#
# BEGINNER NOTES
# --------------
# This script does not need to be run as root.
# ==========================================================

set -eu

# ==========================================================
# CONFIGURATION
# ==========================================================

DEFAULT_CONFIG_DIR="$HOME/.config/nvim"
DEFAULT_REPO_DIR="$HOME/Projects/nvim"
PYTHON_TOOLS_DIR="$HOME/.local/share/nvim-python-tools"

CONFIG_DIR="$DEFAULT_CONFIG_DIR"
REPO_DIR="$DEFAULT_REPO_DIR"

# ==========================================================
# COLORS
# ==========================================================

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
	RED="$(printf '\033[31m')"
	GREEN="$(printf '\033[32m')"
	YELLOW="$(printf '\033[33m')"
	RESET="$(printf '\033[0m')"
else
	RED=""
	GREEN=""
	YELLOW=""
	RESET=""
fi

# ==========================================================
# OUTPUT HELPERS
# ==========================================================

say() { printf '%s\n' "$1"; }
ok() { printf '%s%s%s\n' "$GREEN" "✔ $1" "$RESET"; }
warn() { printf '%s%s%s\n' "$YELLOW" "⚠ $1" "$RESET"; }
fail() { printf '%s%s%s\n' "$RED" "✘ $1" "$RESET"; exit 1; }
has() { command -v "$1" >/dev/null 2>&1; }

expand_path() {
	case "$1" in
		"~") EXPANDED_PATH="$HOME" ;;
		"~/"*) EXPANDED_PATH="$HOME/$(printf '%s\n' "$1" | sed 's|^~/||')" ;;
		*) EXPANDED_PATH="$1" ;;
	esac
}

remove_path() {
	path="$1"
	if [ -e "$path" ] || [ -L "$path" ]; then rm -rf "$path"; ok "Removed $path"; else ok "No $path found"; fi
}

# ==========================================================
# SYSTEM DETECTION
# ==========================================================

detect_package_manager() {
	if has pacman; then PM="pacman"
	elif has apt-get; then PM="apt"
	elif has dnf; then PM="dnf"
	elif has zypper; then PM="zypper"
	elif has xbps-remove; then PM="xbps"
	elif has apk; then PM="apk"
	elif has brew; then PM="brew"
	elif has nix; then PM="nix"
	else PM="unknown"
	fi
}

# ==========================================================
# PATH PROMPTS
# ==========================================================

ask_paths() {
	say ""
	printf '%s' "Config path to remove (default: $DEFAULT_CONFIG_DIR): "
	read config_input
	if [ -n "$config_input" ]; then expand_path "$config_input"; CONFIG_DIR="$EXPANDED_PATH"; fi

	say ""
	printf '%s' "Repo path to remove if separate (default: $DEFAULT_REPO_DIR): "
	read repo_input
	if [ -n "$repo_input" ]; then expand_path "$repo_input"; REPO_DIR="$EXPANDED_PATH"; fi
}

confirm_uninstall() {
	say ""
	warn "This can remove your Neovim config."
	printf '%s' "Continue? [y/N]: "
	read confirm
	case "$confirm" in y|Y|yes|YES) ;; *) fail "Cancelled." ;; esac
}

# ==========================================================
# CONFIG REMOVAL
# ==========================================================

remove_config_and_repo() {
	if [ -L "$CONFIG_DIR" ]; then
		target="$(readlink "$CONFIG_DIR")"
		remove_path "$CONFIG_DIR"
		if [ "$target" = "$REPO_DIR" ]; then
			printf '%s' "Remove cloned repo at $REPO_DIR? [y/N]: "
			read remove_repo
			case "$remove_repo" in y|Y|yes|YES) remove_path "$REPO_DIR" ;; *) ok "Keeping repo." ;; esac
		fi
		return
	fi
	remove_path "$CONFIG_DIR"
}

remove_neovim_data() {
	printf '%s' "Remove Neovim data/cache/state? [y/N]: "
	read remove_data
	case "$remove_data" in
		y|Y|yes|YES)
			remove_path "$HOME/.local/share/nvim"
			remove_path "$HOME/.local/state/nvim"
			remove_path "$HOME/.cache/nvim"
			;;
		*) ok "Keeping data/cache/state." ;;
	esac
}

# ==========================================================
# BACKUP RESTORE
# ==========================================================

restore_backup() {
	say ""
	say "Available Neovim config backups:"
	if ! ls -d "$CONFIG_DIR".bak.* >/dev/null 2>&1; then warn "No config backups found."; return; fi
	ls -d "$CONFIG_DIR".bak.*

	say ""
	printf '%s' "Restore latest backup? [y/N]: "
	read restore
	case "$restore" in
		y|Y|yes|YES)
			latest="$(ls -dt "$CONFIG_DIR".bak.* 2>/dev/null | sed -n '1p')"
			if [ -z "$latest" ]; then warn "No backup found."; return; fi
			if [ -e "$CONFIG_DIR" ] || [ -L "$CONFIG_DIR" ]; then rm -rf "$CONFIG_DIR"; fi
			mv "$latest" "$CONFIG_DIR"
			ok "Restored $latest -> $CONFIG_DIR"
			;;
		*) ok "Skipping restore." ;;
	esac
}

# ==========================================================
# WORKFLOW DEPENDENCY REMOVAL
# ==========================================================

remove_python_tools_environment() {
	printf '%s' "Remove Python tools venv at $PYTHON_TOOLS_DIR? [y/N]: "
	read remove_python_tools
	case "$remove_python_tools" in y|Y|yes|YES) remove_path "$PYTHON_TOOLS_DIR" ;; *) ok "Keeping Python tools venv." ;; esac
}

remove_lua_dependencies() {
	if ! has luarocks; then warn "LuaRocks was not found. Skipping LuaRocks package removal."; return; fi
	printf '%s' "Remove LuaRocks package busted? [y/N]: "
	read remove_luarocks
	case "$remove_luarocks" in y|Y|yes|YES) luarocks remove --local busted || true; ok "Removed LuaRocks workflow package when present." ;; *) ok "Keeping LuaRocks packages." ;; esac
}

# ==========================================================
# SYSTEM DEPENDENCY REMOVAL
# ==========================================================

remove_system_dependencies() {
	say ""
	warn "Dependency removal is optional and may remove tools used by other projects."
	printf '%s' "Uninstall system dependencies? [y/N]: "
	read answer
	case "$answer" in y|Y|yes|YES) ;; *) ok "Keeping system dependencies."; return ;; esac
	printf '%s' "Are you absolutely sure? [y/N]: "
	read sure
	case "$sure" in y|Y|yes|YES) ;; *) ok "Keeping system dependencies."; return ;; esac

	case "$PM" in
		pacman) sudo pacman -Rns neovim git ripgrep fd lazygit nodejs npm python-pip python-virtualenv lua luajit luarocks luacheck bash bats shellcheck shfmt tree-sitter-cli || true ;;
		apt) sudo apt-get remove -y neovim git ripgrep fd-find lazygit nodejs npm python3-pip python3-venv lua5.4 luajit luarocks luacheck bash bats shellcheck shfmt tree-sitter-cli || true ;;
		dnf) sudo dnf remove -y neovim git ripgrep fd-find lazygit nodejs npm python3-pip python3-virtualenv lua luajit luarocks luacheck bash bats ShellCheck shfmt tree-sitter-cli || true ;;
		zypper) sudo zypper remove -y neovim git ripgrep fd lazygit nodejs npm python3-pip python3-virtualenv lua54 luajit luarocks luacheck bash bats ShellCheck shfmt tree-sitter || true ;;
		xbps) sudo xbps-remove -R neovim git ripgrep fd lazygit nodejs npm python3-pip python3-virtualenv lua LuaJIT luarocks luacheck bash bats ShellCheck shfmt tree-sitter || true ;;
		apk) sudo apk del neovim git ripgrep fd lazygit nodejs npm py3-pip py3-virtualenv lua5.4 luajit luarocks luacheck bash bats shellcheck shfmt tree-sitter-cli || true ;;
		brew) brew uninstall neovim git ripgrep fd lazygit node python lua luajit luarocks luacheck bash bats-core shellcheck shfmt tree-sitter || true ;;
		nix) warn "Remove Nix packages declaratively or with nix profile remove." ;;
		*) warn "Unsupported package manager for dependency removal." ;;
	esac
}

# ==========================================================
# MAIN
# ==========================================================

say "Neovim Uninstaller"
detect_package_manager
say "Package manager: $PM"
ask_paths
confirm_uninstall
remove_config_and_repo
remove_neovim_data
restore_backup
remove_python_tools_environment
remove_lua_dependencies
remove_system_dependencies
ok "Uninstall complete."
