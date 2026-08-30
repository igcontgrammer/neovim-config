return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    opts = {
      -- v3: las opciones viejas (position/height/use_diagnostic_signs) ya no existen.
      focus = false, -- no robar el cursor al abrir
      auto_close = true, -- cerrar cuando no quedan items
      win = { position = "bottom", size = 12 },
      modes = {
        -- Outline de symbols a la derecha, siguiendo el cursor.
        symbols = {
          win = { position = "right", size = 45 },
          auto_refresh = true,
        },
      },
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
    "MagicDuck/grug-far.nvim",
    cmd = { "GrugFar", "GrugFarWithin" },
    opts = {
      headerMaxWidth = 80,
      windowCreationCommand = "vsplit",
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
}
