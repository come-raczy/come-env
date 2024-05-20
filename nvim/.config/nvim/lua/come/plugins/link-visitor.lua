return {
	-- add symbols-outline
	{
		"xiyaowong/link-visitor.nvim",
		open_cmd = "wsl-open",
		config = function()
			local lv = require("link-visitor")
			--vim.keymap.set("n", "<leader>gx", lv.link_under_cursor(), {desc = "Open link under cursor"})
			vim.keymap.set("n", "<leader>gx", function()
				lv.link_under_cursor()
			end, { desc = "Open link under cursor" })
		end,
	},
}
