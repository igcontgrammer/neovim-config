return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {
      position = "bottom",
      height = 12,
      use_diagnostic_signs = true,
    },
  },
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = {
      signs = true,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        PERF = { icon = "󰅒 ", color = "default", alt = { "OPTIM", "PERFORMANCE" } },
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      live_update = true,
      is_insert_mode = true,
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>s",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>sl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Restore last session",
      },
      {
        "<leader>sd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't save session",
      },
    },
    opts = {
      dir = vim.fn.stdpath("state") .. "/sessions/",
      need = 1,
    },
  },
  {
    "NvChad/nvterm",
    opts = {
      terminals = {
        type_opts = {
          horizontal = { location = "rightbelow", split_ratio = 0.3 },
          vertical = { location = "rightbelow", split_ratio = 0.5 },
        },
      },
    },
  },
}
