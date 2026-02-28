return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      fast_wrap = { map = "<M-e>" },
    },
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    event = "BufReadPost",
    opts = {},
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_case_setting = "sensitive"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    -- event = "InsertEnter",
    -- opts = {
    --   enable_close = true,
    --   enable_rename = true,
    --   enable_close_on_slash = true,
    -- },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = { mode = "fuzzy" },
      jump = { autojump = true },
      modes = {
        char = { enabled = true, jump_labels = true },
        search = { enabled = false },
      },
    },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
