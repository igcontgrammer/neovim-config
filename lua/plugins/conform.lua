return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        -- Python
        python = { "ruff_format", "ruff_fix" },

        -- JavaScript/TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        svelte = { "prettier" },

        -- Web
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },

        -- Go
        go = { "gofmt", "goimports" },

        -- Rust
        rust = {},

        -- Lua
        lua = { "stylua" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },

        -- SQL
        sql = { "sql_formatter" },

        -- TOML
        toml = { "taplo" },

        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },

        -- Java
        java = { "google-java-format" },

        -- PHP
        php = { "pint", "php_cs_fixer" },

        -- Ruby
        ruby = { "rubocop" },

        -- Terraform
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },

        -- Nix
        nix = { "nixfmt" },

        -- Cualquier archivo (fallback)
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },

      -- Formato al guardar
      format_on_save = function(bufnr)
        -- Desactivar para ciertos filetypes
        local disable_filetypes = { c = true, cpp = true, markdown = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return
        end

        -- Desactivar si hay variable global
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end

        return {
          timeout_ms = 3000,
          lsp_fallback = true,
        }
      end,

      -- Configuración por formatter
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        prettier = {
          prepend_args = { "--tab-width", "2", "--single-quote" },
        },
        stylua = {
          prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        },
        ruff_format = {
          prepend_args = { "--line-length", "100" },
        },
      },
    },

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
