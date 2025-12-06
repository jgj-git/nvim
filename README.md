# My Neovim configuration
Uses lazy as a package manager. Main plugins:
- telescope
- harpoon
- undotree

If installation fails, use `:checkhealth` for a detailed
rundown of all the plugins health.

## Dependencies
### luarocks
Required for plenary (async library required by many plugins, like telescope) and 
hererocks.
```{bash}
$ pacman -S luarocks 
```

### lua 5.1
This version of Lua is required to be installed by plenary.

### fzf
Required by telescope.
```{bash}
$ pacman -S fzf 
```
