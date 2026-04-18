return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    dependencies = {
      "williamboman/mason.nvim",
    },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = "auto",
      broad_search = false,
      lock_target = false,
    },
  },
}
