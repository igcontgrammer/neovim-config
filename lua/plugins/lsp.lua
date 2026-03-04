return {
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      -- Configurar ventanas flotantes con bordes
      local border = "rounded"
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
      })
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = border,
      })

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
          -- Para C#, usar omnisharp-extended
          if vim.bo[event.buf].filetype == "cs" then
            map("gd", function()
              require("omnisharp_extended").lsp_definitions()
            end, "Goto Definition")
            map("gD", function()
              require("omnisharp_extended").lsp_definition()
            end, "Goto Declaration")
            map("gr", function()
              require("omnisharp_extended").lsp_references()
            end, "Goto References")
            map("gI", function()
              require("omnisharp_extended").lsp_implementation()
            end, "Goto Implementation")
            map("gy", function()
              require("omnisharp_extended").lsp_type_definition()
            end, "Type Definition")
          else
            map("gd", "<cmd>FzfLua lsp_definitions<cr>", "Goto Definition")
            map("gr", "<cmd>FzfLua lsp_references<cr>", "Goto References")
            map("gI", "<cmd>FzfLua lsp_implementations<cr>", "Goto Implementation")
            map("gy", "<cmd>FzfLua lsp_typedefs<cr>", "Type Definition")
            map("gD", vim.lsp.buf.declaration, "Goto Declaration")
          end

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
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
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
        root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
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
        root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
        capabilities = capabilities,
      })

      -- C#
      vim.lsp.config("omnisharp", {
        cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
        root_markers = { "*.sln", "*.csproj", "*.fsproj", "omnisharp.json", ".git" },
        capabilities = capabilities,
        settings = {
          FormattingOptions = {
            EnableEditorConfigSupport = true,
            OrganizeImports = true,
          },
          RoslynExtensionsOptions = {
            EnableAnalyzersSupport = true,
            EnableImportCompletion = true,
            AnalyzeOpenDocumentsOnly = false,
          },
        },
      })

      -- C/C++
      vim.lsp.config("clangd", {
        cmd = { "clangd" },
        root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
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

      -- Habilitar todos los LSP servers
      vim.lsp.enable({
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ts_ls",
        "omnisharp",
        "clangd",
        "html",
        "cssls",
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
        "omnisharp",
        "clangd",
        "html-lsp",
        "css-lsp",

        -- Formatters
        "stylua",
        "rustfmt",
        "ruff",
        "prettier",
        "csharpier",
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
