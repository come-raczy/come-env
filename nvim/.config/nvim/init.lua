require("come.core")
require("come.lazy")
vim.g.python3_host_prog = "/home/come/venv/bin/python"
vim.g.loaded_perl_provider = 0
-- vim.o.mouse = ""
vim.opt.clipboard = "unnamedplus"
if vim.fn.has('wsl') == 1 then
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('Yank', { clear = true }),
    callback = function()
      vim.fn.system('clip.exe', vim.fn.getreg('"'))
    end,
  })
end
