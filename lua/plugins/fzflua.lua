return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  keys = {
    -- Buscar archivos
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader><leader>", "<cmd>FzfLua files<cr>", desc = "Find files" },
    -- Buscar texto (live grep)
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    -- Buscar en buffers abiertos
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    -- Buscar en archivos recientes
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
    -- Buscar texto bajo el cursor
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
    -- Help tags
    { "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Help tags" },
    -- Keymaps
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Keymaps" },
    -- Comandos
    { "<leader>fc", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    -- Diagnostics
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document diagnostics" },
    { "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace diagnostics" },
    -- Resume (retomar ultima busqueda)
    { "<leader>f;", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
    -- Git
    { "<leader>fG", "<cmd>FzfLua git_status<cr>", desc = "Git status" },
  },
  opts = {
    "default-title",
    winopts = {
      height = 0.85,
      width = 0.80,
      row = 0.35,
      col = 0.50,
      preview = {
        layout = "flex",
        flip_columns = 120,
      },
    },
    keymap = {
      fzf = {
        ["ctrl-q"] = "select-all+accept",
      },
    },
    grep = {
      -- Habilita filtrado por glob en live_grep
      -- Uso: <search_term> -- *.ts *.tsx
      rg_glob = true,
      glob_flag = "--iglob",
      glob_separator = "%s%-%-",
    },
  },
}
