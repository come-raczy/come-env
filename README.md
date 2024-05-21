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

# Prerequisites

In order to silent all the warnings from masson, install additional language support:

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    sudo apt install golang composer php luarocks ruby-dev  default-jdk ripgrep fd-find
    sudo gem install neovim
    sudo npm install -g neovim
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
