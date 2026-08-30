return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Cargar al inicio
    priority = 1000, -- Cargar antes que otros plugins
    keys = {
      { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle NvimTree (find current file)" },
    },
    config = function()
      require("nvim-tree").setup({
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

        -- Liberar <C-k> (default: Info) para navegar entre ventanas
        vim.keymap.del("n", "<C-k>", { buffer = bufnr })

        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        vim.keymap.set("n", "<leader>e", api.tree.close, opts("Close"))
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "S", api.node.open.horizontal, opts("Open: Horizontal Split"))
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
      })

      -- Abrir nvim-tree automáticamente al inicio
      local function open_nvim_tree(data)
        -- Buffer es un directorio
        local directory = vim.fn.isdirectory(data.file) == 1

        if not directory then
          return
        end

        -- Cambiar al directorio
        vim.cmd.cd(data.file)

        -- Abrir nvim-tree
        require("nvim-tree.api").tree.open()
      end

      vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
    end,
  },
}
