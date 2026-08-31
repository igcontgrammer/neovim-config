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

          -- ruff: solo lint/diagnósticos. pyright maneja hover y types;
          -- conform maneja el formateo. Evita conflictos entre ambos.
          local attached = vim.lsp.get_client_by_id(event.data.client_id)
          if attached and attached.name == "ruff" then
            attached.server_capabilities.hoverProvider = false
            attached.server_capabilities.documentFormattingProvider = false
            attached.server_capabilities.documentRangeFormattingProvider = false
          end

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

      -- Ruff (linter de Python como LSP, solo diagnósticos + code actions).
      -- Solo arranca si el proyecto configura ruff explícitamente; si no,
      -- ruff lintearía con SU set de reglas por defecto (E4, E7, E9, F),
      -- que el proyecto nunca pidió.
      vim.lsp.config("ruff", {
        cmd = { "ruff", "server" },
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local dir = fname ~= "" and vim.fs.dirname(fname) or vim.fn.getcwd()

          local explicit = vim.fs.find({ "ruff.toml", ".ruff.toml" }, { upward = true, path = dir })[1]
          if explicit then
            return on_dir(vim.fs.dirname(explicit))
          end

          local pyproject = vim.fs.find({ "pyproject.toml" }, { upward = true, path = dir })[1]
          if pyproject then
            local ok, lines = pcall(vim.fn.readfile, pyproject)
            if ok then
              for _, line in ipairs(lines) do
                if line:match("^%s*%[tool%.ruff") then
                  return on_dir(vim.fs.dirname(pyproject))
                end
              end
            end
          end
          -- Sin config de ruff → no se arranca el servidor.
        end,
      })

      -- ESLint: el linter del proyecto para JS/TS. Solo arranca si el
      -- proyecto trae config de eslint (root_markers), y usa las reglas
      -- de esa config, no unas propias.
      vim.lsp.config("eslint", {
        cmd = { "vscode-eslint-language-server", "--stdio" },
        root_markers = {
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          "eslint.config.ts",
          "eslint.config.mts",
          "eslint.config.cts",
          ".eslintrc",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.json",
          ".eslintrc.yaml",
          ".eslintrc.yml",
        },
        capabilities = capabilities,
      })

      -- TypeScript/JavaScript
      --
      -- TypeScript 7 es el compilador nativo en Go: no trae tsserver.js, así que
      -- ts_ls (un wrapper de Node sobre tsserver.js) no puede usar el TS del
      -- proyecto y cae en silencio a su copia bundleada. En esos proyectos usamos
      -- el LSP nativo (`tsc --lsp --stdio`) y ts_ls no engancha.

      --- Devuelve el directorio que contiene el node_modules/typescript del
      --- workspace si ese TypeScript es 7+; nil en cualquier otro caso.
      --- @return string?
      local function native_ts_dir(bufnr)
        local name = vim.api.nvim_buf_get_name(bufnr)
        if name == "" then
          return nil
        end
        for dir in vim.fs.parents(name) do
          local pkg = dir .. "/node_modules/typescript/package.json"
          if vim.uv.fs_stat(pkg) then
            local ok, json = pcall(function()
              return vim.json.decode(table.concat(vim.fn.readfile(pkg), "\n"))
            end)
            if not ok or type(json) ~= "table" then
              return nil
            end
            local version = vim.version.parse(json.version or "")
            return (version and version.major >= 7) and dir or nil
          end
        end
        return nil
      end

      local ts_ls_root_dir = vim.lsp.config.ts_ls.root_dir

      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
          if native_ts_dir(bufnr) then
            return
          end
          if ts_ls_root_dir then
            return ts_ls_root_dir(bufnr, on_dir)
          end
          on_dir(vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }))
        end,
      })

      -- TypeScript nativo (7+). Reusamos el root_dir de lspconfig (sabe de
      -- monorepos y descarta proyectos Deno) pero resolvemos el binario nosotros:
      -- el suyo lo cachea en un upvalue que no sobrevive al merge del config.
      local tsc_root_dir = vim.lsp.config.tsc.root_dir
      local tsc_bin = {} ---@type table<string, string>

      vim.lsp.config("tsc", {
        capabilities = capabilities,
        root_dir = function(bufnr, on_dir)
          local dir = native_ts_dir(bufnr)
          if not dir then
            return
          end
          local bin = dir .. "/node_modules/.bin/tsc"
          if vim.fn.executable(bin) ~= 1 then
            return
          end
          tsc_root_dir(bufnr, function(root)
            tsc_bin[root] = bin
            on_dir(root)
          end)
        end,
        cmd = function(dispatchers, config)
          local bin = tsc_bin[(config or {}).root_dir] or "tsc"
          return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
        end,
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

      -- Habilitar todos los LSP servers. Va por config.lsp_toggle para poder
      -- apagarlos/prenderlos en todo Neovim con <leader>ul / :LspToggle.
      require("config.lsp_toggle").register({
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "eslint",
        "ts_ls",
        "tsc",
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
        "eslint-lsp",
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

        -- Debuggers
        "debugpy",
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
