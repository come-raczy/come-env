-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Yank to the system clipboard using win32yank.exe.
-- Note that win32yank.exe causes hangs
-- Note that clip.exe causes pronlems with CR/LF and non ASCII
if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("Yank", { clear = true }),
		callback = function()
			-- vim.fn.system("clip.exe", vim.fn.getreg('"'))
			-- vim.fn.system("win32yank.exe", vim.fn.getreg('"'))
			vim.fn.system("xclip", vim.fn.getreg('"'))
		end,
	})
end

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
