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
      lock_target = true,
      choose_target = function(targets)
        table.sort(targets, function(a, b)
          return #a < #b
        end)
        return targets[1]
      end,
    },
  },
}
