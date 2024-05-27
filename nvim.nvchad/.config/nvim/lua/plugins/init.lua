return {
  {
    "stevearc/conform.nvim",
     event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "black",
        "clangd",
        "css-lsp" ,
        "eslint-lsp" ,
        "flake8",
        "html-lsp",
        "isort",
        "lua-language-server",
        "mypy",
        "prettier",
        "prettierd",
        "pylint",
        "python-lsp-server",
        "r-languageserver",
        "stylua",
        "svelte-language-server",
        "typescript-language-server",
      },
    },
  },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "diff",
        "dockerfile",
        "gitignore",
        "graphql",
        "html",
        "json",
        "javascript",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "prisma",
        "query",
        "svelte",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
  {
   "m4xshen/hardtime.nvim",
   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
   opts = {}
  },
}
