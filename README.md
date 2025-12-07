# Neovim for Systemverilog development
This neovim configuration includes a systemverilog lsp 
([slang](https://sv-lang.com/index.html)), as well as 
my keybindings and other convenient plugins for development (RTL or verification).
It uses [lazy.nvim](https://lazy.folke.io/) as the package manager. Main plugins:
- telescope
- harpoon
- undotree
- nvim-lspconfig
- mason

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

### ripgrep (optional)
Required for the `live_grep` functionality of telescope to work (bound to
`<leader>fg`).

### slang-server
For now it needs to be built from source (see
[installation guide](https://hudson-trading.github.io/slang-server/start/installing/)).
Build requirements:
- cmake
- python

> [!NOTE]
> The default number of build threads is very large and may cause the program to
> run out of memory and crash. To avoid this, reduce the number of threads to
> something manageable, e.g. 4: `cmake --build build -j 4 --target slang_server`

After building, `SLANG_SERVER_DIR/build/bin/slang-server` has to be added to the
path. If installing locally, run
```
$ ln -s SLANG_SERVER_DIR/build/bin/slang-server ~/local/bin/slang-server
```

## Language Servers
### LuaLS
The latest version (3.16) cannot find `libbfg` shared library, so Mason is 
explicitly configured so that it installs latest working version (3.15). It is
only included for smoother neovim configuration, it is not required for 
Systemverilog development.

### slang-server
Wrapper for the `slang` tools. Currently not using Mason as it is not recommended.

> [!NOTE]
> Requires Neovim version >= 0.11 since it uses the vim.lsp api. For older 
> versions slight changes are needed in `lspconfig.lua`, see the
> [installation guide](https://hudson-trading.github.io/slang-server/start/installing/)).

Currently only works when it nvim is called the root directory, which is
the directory that contains a `.slang` or a `.git` directory.

It relies on the `diagnostic-manipulation.nvim` plugin to avoid UVM related
parser errors.

**TODO**: add the option to insert Accelera's
[UVM reference implementation](https://www.accellera.org/downloads/standards/uvm)
files into slang's file list. For the most popular vendors (Questa, VCS) the 
UVM source code will be in `$UVM_HOME/src`.

