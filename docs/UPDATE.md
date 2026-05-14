# UPDATE

Update from inside Neovim:

```vim
:UpdateConfig
```

Flow:

git fetch  
→ git checkout main  
→ git pull --ff-only  
→ Lazy sync  
→ restart prompt
