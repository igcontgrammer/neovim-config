return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup({
        settings = { save_on_toggle = true, sync_on_ui_close = true },
      })
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = { "TmuxNavigateLeft", "TmuxNavigateDown", "TmuxNavigateUp", "TmuxNavigateRight" },
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right" },
    },
  },
}
