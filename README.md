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

# Terninal

Install tmux.
Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm):

    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

After starting tmux, press 'prefix I' to *I*nstall plugins, 'prefix u' to *u*pdate plugins, and 'prefix alt u' to 
*u*ninstall plugins.

# Neovim
