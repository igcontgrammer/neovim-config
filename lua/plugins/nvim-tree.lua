return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    },
    opts = {
      view = {
        width = 45,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")

        -- Keymaps por defecto
        api.config.mappings.default_on_attach(bufnr)

        -- Keymaps personalizados
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        vim.keymap.set("n", "<leader>e", api.tree.close, opts("Close"))
      end,
      actions = {
        open_file = {
          quit_on_open = true,
          resize_window = true,
          window_picker = {
            enable = false,
          },
        },
      },
    },
  },
}
