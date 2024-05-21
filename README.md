# Come's Environment

All the files to configure my dev environment

Inspiration from other sources:

- [Josean Martinez dev environment files](https://github.com/josean-dev/dev-environment-files)

Best used with [GNU Stow](https://www.gnu.org/software/stow/). After installing 'stow', run
the following commands from this directory:

    stow -t $HOME tmux
    stow -t $HOME nvim

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

The solution used here:

- using 'tmux-plugins/tmux-yank' to allow yanking with the mouse to the clipboard
- disabling the mouse in neovim (`vim.o.mouse=""`)

There aro other solutions, for instance, putting `win32yank.exe` in the `$PATH` and explicitly configuring
tmux to use it (neovim is supposed to detect it automatically).
