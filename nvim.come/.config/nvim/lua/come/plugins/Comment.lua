return {
   "numToStr/Comment.nvim",
	lazy = false,
    opts = {
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "JoosepAlviste/nvim-ts-context-commentstring",
      },
      config = function()
        -- import comment plugin safely
        local comment = require("Comment")

        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

        -- enable comment
        comment.setup({
          -- for commenting tsx, jsx, svelte, html files
          pre_hook = ts_context_commentstring.create_pre_hook(),
          padding = false,
          sticky = false,
          ignore = "",
          mappings = false,
          toggler = {
            block = "gbc",
            line = "gcc",
          },
          opleader = {
            line = "gc",
            block = "gb",
          },
          extra = {
            eol = "gcA",
            above = "gcO",
            below = "gco",
          },
          post_hook = ts_context_commentstring.create_post_hook(),
        })
      end,
    },
  }
