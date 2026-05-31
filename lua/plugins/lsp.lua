return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      -- Bordes redondeados para floats (hover, signature, etc.)
      local border = "rounded"
      vim.o.winborder = border

      -- Configurar diagnósticos con bordes
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = border,
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- Configurar keymaps LSP automáticamente cuando se adjunta un LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- Navegación
          map("gd", "<cmd>Telescope lsp_definitions<cr>", "Goto Definition")
          map("gr", "<cmd>Telescope lsp_references<cr>", "Goto References")
          map("gI", "<cmd>Telescope lsp_implementations<cr>", "Goto Implementation")
          map("gy", "<cmd>Telescope lsp_type_definitions<cr>", "Type Definition")
          map("gD", vim.lsp.buf.declaration, "Goto Declaration")

          -- Información
          map("K", vim.lsp.buf.hover, "Hover Documentation")
          map("<leader>k", vim.lsp.buf.signature_help, "Signature Help")

          -- Acciones
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")

          -- Formato
          map("<leader>fm", function()
            vim.lsp.buf.format({ async = true })
          end, "Format")

          -- Highlight de referencias bajo el cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
              end,
            })
          end
        end,
      })

      -- Capacidades de LSP con blink.cmp
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Configurar LSP servers usando la API moderna de Neovim 0.11+
      -- Lua
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        root_markers = {
          ".luarc.json",
          ".luarc.jsonc",
          ".luacheckrc",
          ".stylua.toml",
          "stylua.toml",
          "selene.toml",
          "selene.yml",
          ".git",
        },
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Rust
      vim.lsp.config("rust_analyzer", {
        cmd = { "rust-analyzer" },
        root_markers = { "Cargo.toml", "rust-project.json" },
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            check = {
              command = "clippy",
            },
          },
        },
      })

      -- Python
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          "pyrightconfig.json",
          ".git",
        },
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
        capabilities = capabilities,
      })

      -- C/C++
      vim.lsp.config("clangd", {
        cmd = { "clangd" },
        root_markers = {
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git",
        },
        capabilities = capabilities,
      })

      -- HTML
      vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
      })

      -- CSS
      vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        root_markers = { "package.json", ".git" },
        capabilities = capabilities,
      })

      -- Zig
      vim.lsp.config("zls", {
        cmd = { "zls" },
        root_markers = { "build.zig", "build.zig.zon", ".git" },
        filetypes = { "zig", "zon" },
        capabilities = capabilities,
      })

      -- Habilitar todos los LSP servers
      vim.lsp.enable({
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ts_ls",
        "clangd",
        "html",
        "cssls",
        "zls",
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      automatic_installation = true,
      automatic_enable = false,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP Servers
        "lua-language-server",
        "rust-analyzer",
        "pyright",
        "typescript-language-server",
        "clangd",
        "html-lsp",
        "css-lsp",
        "zls",

        -- Formatters
        "stylua",
        "ruff",
        "prettier",
        "clang-format",

        -- Linters
        "eslint_d",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
}
