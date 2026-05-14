# TROUBLESHOOTING

## Mason issues
Restart Neovim and run :Mason

## Treesitter issues
Run :TSUpdate

## Broken symlink installs
Re-run install.sh with --repair

## Plugin issues
Run :Lazy sync


## Python workflow issues

If `debugpy` or `pytest` fail:

Remove:

```bash
~/.local/share/nvim-python-tools
```

Then rerun:

```bash
install.sh
```
