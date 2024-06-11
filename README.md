# Come's Environment

All the files to configure [tmux](https://github.com/tmux/tmux/wiki) and [Neovim](https://neovim.io/)
for a mouse-free development environment. [Douglas Engelbart](https://www.britannica.com/biography/Douglas-Engelbart)'s award
winning invention shines in so many othe places that we must remember that [Christopher Shole](https://www.invent.org/inductees/christopher-sholes)'s
finest invention had modern developers in mind - untyped writers and mypy denyer can go back to their mouse-infested world.

This configuration does provide all the VS Code functionalities that I am aware of (that's a small subset as I am not a specialist). If there
are important ones that are missing (clicking around doesn't count), I'd be really happy to know.

Inspiration from other sources:

- [Kickstart](https://github.com/nvim-lua/kickstart.nvim) and [The Only Video You Need to Get Started with Neovim](https://www.youtube.com/watch?v=m8C0Cq9Uv9o) from [TJ DeVries](https://www.youtube.com/@teej_dv)
- [Josean Martinez dev environment files](https://github.com/josean-dev/dev-environment-files)

Best used with [GNU Stow](https://www.gnu.org/software/stow/). After installing 'stow', run
the following commands from this directory:

    UNSTOW="$HOME/unstow"
    TMUX_CONF="$HOME/.tmux.conf"
    NVIM_CONF="$HOME/.config/nvim"
    [[ -d "$UNSTOW" ]] || mkdir -p "$UNSTOW"
    [[ -f "$TMUX_CONF" ]] && mv "$TMUX_CONF" "$UNSTOW"
    [[ -d "$NVIM_CONF" ]] && mv "$NVIM_CONF" "$UNSTOW"
    stow -t $HOME tmux
    stow -t $HOME nvim
    stow -t $HOME fzf
    stow -t $HOME starship
    stow -t $HOME alacritty
    stow -t $HOME wezterm
    stow -t $HOME waybar
    stow -t $HOME sway
    stow -t $HOME hyprland
    stow -t $HOME editorconfig

# Prerequisites

In order to silent all the warnings from masson, install additional language support:

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    sudo apt install golang composer php luarocks ruby-dev  default-jdk ripgrep fd-find npm tree-sitter-cli cargo maven libxml2-dev libcurl4-gnutls-dev
    sudo gem install neovim
    sudo npm install -g neovim tree-sitter-cli
    sudo snap install julia --classic
    # assuming active venv in $HOME/venv
    pip install neovim

Start `nvim` and run `:checkhealth`.

# Fonts

Install some Nerd Fonts. For instance, go to [ryanoasis/nerd-fonts releases page](https://github.com/ryanoasis/nerd-fonts/releases),
select the latest release (v3.2.1 as of 2004-05-20), and downloas the chosen set of fonts (e.g. JetBrainsMono.zip). Install according
to the OS:

- Windows: unzip all, select all the font files in the file explorer, right click, and select 'Install'
- Ubuntu: TBD
- Arch:

  sudo pacman -S ttf-sourcecodepro-nerd ttf-liberation-mono-nerd ttf-cascadia-code-nerd ttf-cascadia-mono-nerd ttf-roboto-mono-nerd ttf-victor-mono-nerd ttf-dejavu-nerd ttf-ubuntu-mono-nerd

Once the fonts are installed, select a Nerd Font for the terminal, according to the OS and terminal:

- Windows Terminal: 'Ctrl,' to open settings, select the profile (e.g. 'Ubuntu' under the hamburger menu on the left), then
  'Additional settings' > 'Appearence' > 'Font face' to select the desired font (e.g. 'JetBrainsMone Nerd Font Mono').

# Terminal

Install tmux.
Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm):

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

After starting tmux, press 'prefix I' to *I*nstall plugins, 'prefix u' to *u*pdate plugins, and 'prefix alt u' to
*u*ninstall plugins.

# Neovim

## Opening a browser on WSL2

The simplest is to instal 'wsl-open':

    sudo npm install -g wsl-open

In Vanilla neovim, simply set 'g:netrw_http_cmd':

    :let g:netrw_http_cmd='wsl-open'

Then the command 'gx', in normal mode, should open a browser on windows.

However, the 'telescope' plugin prevents the loading of 'netrw' and another solution is required.
The plugin "xiyaowong/link-visitor.nvim" offers this functionality, and the "link-visitor.lua" loads
the plugin with Lazy, and configures it to bind the "link_under_cursor" function to "<leader>gx".

## Copy/Paste WSL/tmux/neovim

The solution used here is to explicitly link the '"' register to 'clip.exe':

    vim.fn.system('clip.exe', vim.fn.getreg('"')):

The limitation is that 'Ctrl-C' doesn't work for copy-paste at the moment.

The previous attempt was to:

- using 'tmux-plugins/tmux-yank' to allow yanking with the mouse to the clipboard
- disabling the mouse in neovim (`vim.o.mouse=""`)

But that didn't work with line numbering and such.

There aro other solutions, for instance, putting `win32yank.exe` in the `$PATH` and explicitly configuring
tmux to use it (neovim is supposed to detect it automatically).

# Pretty printer

## Svelte

This requires adding several languages: svelte, typescript, css, scss, and html. All can be done with `:TSInstall <language>` or in the treesitter configuration.

# Lint

These are the linters that are worth installing:

- Docker: [hadolint](https://github.com/hadolint/hadolint/)
- JSON: jsonlint
- javascript: `sudo npm install -g eslint_d`
- Markdown: `sudo npm install -g markdownlint-cli`
- Python: `sudo apt install pylint`
- Text: `sudo snap install vale`

# Language servers

There is a balance between added value of complementary language servers and the pain of redundant diagnostics.
For instance, for web development, just select one that does everything well (html. css, js, ts, svelte, etc)
and disable the others.

For troubleshootion, open a file that requires the problematic language server, run `:LspInstall`, and select the server to install.
When it fails, expand the trace to see the error message. Typically, the failure is because of some missing dependency.

Some useful commands to inspect LSP configuration:

    :lua print(vim.inspect(vim.lsp.get_active_clients()))
    :lua print(vim.inspect(vim.lsp.get_log_path()))
    :enew|put=execute(\"lua print(vim.inspect(vim.lsp.get_active_clients({name='pylsp'})))\")

## lua-language-server

With ChadNv, there is a need to install a language server for lua. The steps are:

- Download the pre-built tarball from the [lua-language-server Releases Page](https://github.com/LuaLS/lua-language-server/releases)
- create the directory for all the files (bin, scripts, etc)
- untar into this newly-created directory
- add the newly-created bin directory to the PATH

Note that the `bin/lua-language-server` could be copied to another bin directory, but this rerquires
copying the `bin/main.lua` as well, and editing it to specify the root of the lua-language-server install.

## python

For python, install:

- ruff: works with poetry configuration specified in `pyproject.toml`
- basedpyright: that's the pip version of VS Code standard

Note that Ruff has code actions: `<leader>ca` to apply the code action under the cursor. For instance,
uswe it to reorder imports only, or to 'Fix All'.

## svelte-language-server

Can be installed with npm:

    sudo npm install -g svelte-language-server

# NvChad

Starts with the usual `~/.config/nvim/init.lua`, that bootstraps `lazy` if it can't find:

    #  vim.fn.stdpath("data") is $HOME/.local/share/nvim
    lazypath = vim.fn.stdpath("data") .. '/lazy/lazy.nvim'

The bootstrapping is done by cloning the github repo 'folke/lazi.nvim.git' into `lazypath`. This path is then prepended
to vim runtimepath (`vim.opt.rtp`, type `:set rtp` to see the value).
With 'lazy' installed, the plugins are loaded within a `require("lazy").setup({...})`. First, loads
'NvChad/NvChad' (which itself imports 'nvchad.plugins'), then imports 'plugins'.
Lazy installs 'NvChad' in `NVCHAD=$HOME/.local/share/nvim/lazy/NvChad/` and the plugins are in
`$NVCHAD/lua/nvchad/plugins`. By default, that's just two files:

- `init.lua`
  - "nvim-lua/plenary.nvim"
  - "stevearc/conform.nvim"
  - "nvim-treesitter/nvim-treesitter"
  - "lewis6991/gitsigns.nvim"
  - "williamboman/mason.nvim"
  - "neovim/nvim-lspconfig"
  - "hrsh7th/nvim-cmp"
    - "L3MON4D3/LuaSnip"
    - "windwp/nvim-autopairs"
    - "saadparwaiz1/cmp_luasnip"
    - "hrsh7th/cmp-nvim-lua"
    - "hrsh7th/cmp-nvim-lsp"
    - "hrsh7th/cmp-buffer"
    - "hrsh7th/cmp-path"
  - "numToStr/Comment.nvim"
  - "nvim-telescope/telescope.nvim"
- `ui.lua`
  - "NvChad/base46"
  - "NvChad/ui"
  - "NvChad/nvim-colorizer.lua"
  - "nvim-tree/nvim-web-devicons"
  - "lukas-reineke/indent-blankline.nvim"
  - "nvim-tree/nvim-tree.lua"
  - "folke/which-key.nvim"

Note that the directory to configure everything is `$NVCHAD/lua/nvchad/configs`:

- cmp.lua
- gitsigns.lua
- lazy_nvim.lua
- lspconfig.lua
- luasnip.lua
- mason.lua
- nvimtree.lua
- telescope.lua
- treesitter.lua

Other significant files and directories:

- `WHICH_KEY=$HOME/.local/share/nvim/lazy/which-key.nvim/`
- `$NVCHAD/lua/nvchad/autocmds.lua`
- `$NVCHAD/lua/nvchad/configs/lazy.lua`: for additional configuration options for the command
  'require("lazy").setup({...}, lazy_config)'
