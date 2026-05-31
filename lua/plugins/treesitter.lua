return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        -- Web
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "vue",
        "svelte",

        -- Backend
        "python",
        "go",
        "rust",
        "java",
        "php",

        -- Data & Config
        "json",
        "jsonc",
        "yaml",
        "toml",
        "xml",

        -- Shell & System
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "regex",

        -- Documentation
        "markdown",
        "markdown_inline",

        -- Otros
        "sql",
        "dockerfile",
        "gitignore",
        "diff",
        "comment",
        "prisma",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
  },
}
