-- Regla de oro de este archivo:
-- SOLO se formatea si el proyecto trae su propia config de formateo.
-- Nunca se pasan flags de estilo propios (indent, quotes, line-length...):
-- esos los decide el archivo de config del proyecto, no Neovim.

-- Busca hacia arriba desde el archivo del buffer (no desde el cwd).
local function find_up(bufnr, names)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local dir = fname ~= "" and vim.fs.dirname(fname) or vim.fn.getcwd()
  return vim.fs.find(names, { upward = true, path = dir })[1]
end

-- ¿pyproject.toml con una sección [tool.<name>]?
local function pyproject_has(bufnr, name)
  local pyproject = find_up(bufnr, { "pyproject.toml" })
  if not pyproject then
    return false
  end
  local ok, lines = pcall(vim.fn.readfile, pyproject)
  if not ok then
    return false
  end
  for _, line in ipairs(lines) do
    if line:match("^%s*%[tool%." .. name) then
      return true
    end
  end
  return false
end

-- Activa `formatters` solo si el proyecto tiene alguno de `markers`.
local function project_only(markers, formatters)
  return function(bufnr)
    return find_up(bufnr, markers) and formatters or {}
  end
end

local ruff_config = { "ruff.toml", ".ruff.toml" }

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>uf",
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          vim.notify("Autoformat " .. (vim.g.disable_autoformat and "OFF" or "ON"))
        end,
        desc = "Toggle autoformat on save",
      },
    },
    opts = {
      formatters_by_ft = {
        -- Python: ruff solo si el proyecto lo configura
        -- (ruff.toml, .ruff.toml o [tool.ruff] en pyproject.toml).
        python = function(bufnr)
          if find_up(bufnr, ruff_config) or pyproject_has(bufnr, "ruff") then
            return { "ruff_organize_imports", "ruff_fix", "ruff_format" }
          end
          if pyproject_has(bufnr, "black") then
            return { "black" }
          end
          return {}
        end,

        -- JS/TS/Web: prettier lleva `require_cwd = true` abajo, así que
        -- solo corre si encuentra .prettierrc* / prettier.config.* o la
        -- clave "prettier" en package.json. Y usa el binario de
        -- node_modules/.bin del proyecto si existe.
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        vue = { "prettier" },
        svelte = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },

        -- Formatters canónicos del lenguaje: no hay "estilo propio" que
        -- imponer, y ya leen su config del proyecto si existe
        -- (rustfmt.toml, .clang-format, etc.).
        go = { "gofmt", "goimports" },
        rust = { "rustfmt" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
        nix = { "nixfmt" },
        toml = { "taplo" },

        -- Con estilo propio → solo con config del proyecto.
        lua = project_only({ ".stylua.toml", "stylua.toml" }, { "stylua" }),
        c = project_only({ ".clang-format" }, { "clang_format" }),
        cpp = project_only({ ".clang-format" }, { "clang_format" }),
        sh = project_only({ ".editorconfig" }, { "shfmt" }),
        bash = project_only({ ".editorconfig" }, { "shfmt" }),
        zsh = project_only({ ".editorconfig" }, { "shfmt" }),
        sql = project_only({ ".sql-formatter.json" }, { "sql_formatter" }),
        ruby = project_only({ ".rubocop.yml", ".rubocop.toml" }, { "rubocop" }),
        php = project_only({ "pint.json" }, { "pint" }),
        java = project_only({ ".java-format.xml" }, { "google-java-format" }),

        -- Sin fallback "_": tocar whitespace en todos los archivos mete
        -- diffs que el proyecto no pidió.
      },

      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 3000,
          -- El LSP formatea con SU estilo por defecto (clangd → LLVM,
          -- ts_ls → su propio estilo) aunque el proyecto no lo pida.
          lsp_format = "never",
        }
      end,

      formatters = {
        -- Sin config de prettier en el proyecto → no se formatea.
        prettier = { require_cwd = true },
        -- Sin prepend_args en ningún formatter: el estilo lo manda el
        -- archivo de config del proyecto.
      },
    },

    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
