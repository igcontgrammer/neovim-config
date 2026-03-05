return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- TypeScript snippets
      ls.add_snippets("typescript", {
        s("sepa", {
          t("// ******* "),
          i(1),
          t(" *******"),
        }),
        s("todo", {
          t("// TODO: "),
          i(1),
        }),
      })

      -- Python snippets
      ls.add_snippets("python", {
        -- TODO comment
        s("todo", {
          t("# TODO: "),
          i(1),
        }),

        -- FIXME comment
        s("fixme", {
          t("# FIXME: "),
          i(1, "description"),
        }),

        -- NOTE comment
        s("note", {
          t("# NOTE: "),
          i(1, "description"),
        }),

        -- HACK comment
        s("hack", {
          t("# HACK: "),
          i(1, "description"),
        }),

        -- Main function
        s("main", {
          t({ "def main():", "    " }),
          i(1, "pass"),
          t({ "", "", "", 'if __name__ == "__main__":', "    main()" }),
        }),

        -- Function with docstring
        s("def", {
          t("def "),
          i(1, "function_name"),
          t("("),
          i(2, "args"),
          t({ "):", '    """' }),
          i(3, "Description"),
          t({ "", '    """', "    " }),
          i(0, "pass"),
        }),

        -- Class with docstring
        s("class", {
          t("class "),
          i(1, "ClassName"),
          t({ ":", '    """' }),
          i(2, "Class description"),
          t({ "", '    """', "", "    def __init__(self" }),
          i(3),
          t({ "):", "        " }),
          i(0, "pass"),
        }),

        -- Try-except block
        s("try", {
          t({ "try:", "    " }),
          i(1, "# code"),
          t({ "", "except " }),
          i(2, "Exception"),
          t({ " as e:", "    " }),
          i(0, "print(f'Error: {e}')"),
        }),

        -- Print f-string
        s("pf", {
          t('print(f"'),
          i(1, "text"),
          t('")'),
        }),

        -- Import from
        s("from", {
          t("from "),
          i(1, "module"),
          t(" import "),
          i(0, "name"),
        }),

        -- separator
        s("sepa", {
          t("# ==== "),
          i(1, " ===="),
        }),
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          -- Navegación en el menú de completado
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

          -- Scroll en la documentación
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),

          -- Confirmar selección
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            local copilot_suggestion = vim.fn["copilot#GetDisplayedSuggestion"]()
            if copilot_suggestion.text ~= "" then
              vim.api.nvim_feedkeys(vim.fn["copilot#Accept"](), "n", true)
            elseif cmp.visible() then
              cmp.confirm({ select = true })
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Cerrar menú
          ["<C-e>"] = cmp.mapping.abort(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "path", priority = 500 },
        }, {
          { name = "buffer", priority = 250 },
        }),
        formatting = {
          format = function(entry, item)
            local icons = {
              Text = "",
              Method = "󰆧",
              Function = "󰊕",
              Constructor = "",
              Field = "󰇽",
              Variable = "󰂡",
              Class = "󰠱",
              Interface = "",
              Module = "",
              Property = "󰜢",
              Unit = "",
              Value = "󰎠",
              Enum = "",
              Keyword = "󰌋",
              Snippet = "",
              Color = "󰏘",
              File = "󰈙",
              Reference = "",
              Folder = "󰉋",
              EnumMember = "",
              Constant = "󰏿",
              Struct = "",
              Event = "",
              Operator = "󰆕",
              TypeParameter = "󰅲",
            }
            item.kind = string.format("%s %s", icons[item.kind] or "", item.kind)
            item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
