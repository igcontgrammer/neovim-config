return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Neovim 0.12 requiere el branch `main` (reescritura). El branch `master`
    -- solo soporta hasta 0.11 y rompe el runtime de treesitter en 0.12.
    -- En `main` el highlight lo hace Neovim; este plugin instala parsers
    -- y aporta las queries.
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")

      -- Parsers a instalar (se instalan async; idempotente en cada arranque)
      ts.install({
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
      })

      -- Arranca el highlight (y el indent de treesitter donde corresponde)
      -- por filetype, solo si el parser está disponible.
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end

          -- ¿Hay parser para este lenguaje? Si no, no hacemos nada.
          if not pcall(vim.treesitter.language.add, lang) then
            return
          end

          pcall(vim.treesitter.start, args.buf, lang)

          -- Indent de treesitter EXCEPTO donde el nativo es mejor. En python
          -- y la familia TS/JS usamos el indentexpr nativo de Neovim: el de
          -- treesitter (branch main) tiene bugs conocidos con `o`/`O` dentro
          -- de funciones, objetos y corchetes.
          local native_indent = {
            python = true,
            javascript = true,
            javascriptreact = true,
            typescript = true,
            typescriptreact = true,
          }
          if not native_indent[ft] then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
}
