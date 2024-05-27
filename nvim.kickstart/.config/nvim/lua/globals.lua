-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Some of the things that mason needs`
vim.g.python3_host_prog = "/home/come/venv/bin/python"
vim.g.loaded_perl_provider = 0
