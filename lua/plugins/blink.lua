return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    enabled = function()
      local disabled_ft = {
        NvimTree = true,
        ["neo-tree"] = true,
        ["neo-tree-popup"] = true,
        oil = true,
        TelescopePrompt = true,
        ["snacks_picker_input"] = true,
        DressingInput = true,
        markdown = true,
       }
      return not disabled_ft[vim.bo.filetype] and vim.bo.buftype ~= "prompt"
    end,
    snippets = { preset = "luasnip" },
    keymap = {
      preset = "default",
      ["<CR>"] = { "accept", "fallback" },
      -- <Tab>: 1) acepta la sugerencia de Copilot si hay una visible,
      -- 2) salta al siguiente placeholder del snippet, 3) Tab normal.
      ["<Tab>"] = {
        function()
          return require("config.copilot_tab").accept_keys()
        end,
        "snippet_forward",
        "fallback",
      },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },
      ["<Up>"] = { "select_prev", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-e>"] = { "hide", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    cmdline = { enabled = false },
    completion = {
      menu = {
        border = "rounded",
        winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind", gap = 1 },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        },
      },
      ghost_text = { enabled = false },
    },
    signature = {
      enabled = true,
      window = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
      },
    },
  },
  opts_extend = { "sources.default" },
}
