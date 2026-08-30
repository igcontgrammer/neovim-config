return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- Csharp (filetype is "cs" in Neovim, not "csharp")
      ls.add_snippets("cs", {
        s("unused", {
          t("// TODO: UNUSED, remove"),
        }),
        s("sepa", {
          t("// ******* "),
          i(1),
          t(" *******"),
        }),
      })

      -- TypeScript and TSX snippets
      local typescript_snippets = {
        s("clog", {
          t("console.log("),
          i(1, "value"),
          t(");"),
        }),
        s("clogj", {
          t("console.log(JSON.stringify("),
          i(1, "value"),
          t(", null, 2));"),
        }),
        s("imp", {
          t("import { "),
          i(1, "symbol"),
          t(" } from \""),
          i(2, "module"),
          t("\";"),
        }),
        s("fn", {
          t("export function "),
          i(1, "name"),
          t("("),
          i(2, "args"),
          t("): "),
          i(3, "returnType"),
          t({ " {", "  " }),
          i(0),
          t({ "", "}" }),
        }),
        s("afn", {
          t("export async function "),
          i(1, "name"),
          t("("),
          i(2, "args"),
          t("): Promise<"),
          i(3, "returnType"),
          t({ "> {", "  " }),
          i(0),
          t({ "", "}" }),
        }),
        s("sepa", {
          t("// ******* "),
          i(1),
          t(" *******"),
        }),
        s("todo", {
          t("// TODO: "),
          i(1),
        }),
      }

      ls.add_snippets("typescript", typescript_snippets)
      ls.add_snippets("typescriptreact", typescript_snippets)

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
}
