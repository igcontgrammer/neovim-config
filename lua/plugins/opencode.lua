return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("snacks.terminal").toggle("opencode --port", {
          win = { position = "left", width = math.floor(vim.o.columns * 0.35) },
        })
      end,
      mode = { "n" },
      desc = "Toggle OpenCode",
    },
    {
      "<leader>as",
      function()
        require("opencode").select()
      end,
      mode = { "n", "x" },
      desc = "OpenCode select",
    },
    {
      "<leader>ai",
      function()
        require("opencode").ask("")
      end,
      mode = { "n", "x" },
      desc = "OpenCode ask",
    },
    {
      "<leader>aI",
      function()
        require("opencode").ask("@this: ")
      end,
      mode = { "n", "x" },
      desc = "OpenCode ask with context",
    },
    {
      "<leader>ab",
      function()
        require("opencode").ask("@buffer ")
      end,
      mode = { "n", "x" },
      desc = "OpenCode ask about buffer",
    },
    {
      "<leader>ap",
      function()
        require("opencode").prompt("@this")
      end,
      mode = { "n", "x" },
      desc = "OpenCode prompt",
    },
    -- Built-in prompts
    {
      "<leader>ape",
      function()
        require("opencode").prompt("explain")
      end,
      mode = { "n", "x" },
      desc = "OpenCode explain",
    },
    {
      "<leader>apf",
      function()
        require("opencode").prompt("fix")
      end,
      mode = { "n", "x" },
      desc = "OpenCode fix",
    },
    {
      "<leader>apd",
      function()
        require("opencode").prompt("diagnose")
      end,
      mode = { "n", "x" },
      desc = "OpenCode diagnose",
    },
    {
      "<leader>apr",
      function()
        require("opencode").prompt("review")
      end,
      mode = { "n", "x" },
      desc = "OpenCode review",
    },
    {
      "<leader>apt",
      function()
        require("opencode").prompt("test")
      end,
      mode = { "n", "x" },
      desc = "OpenCode test",
    },
    {
      "<leader>apo",
      function()
        require("opencode").prompt("optimize")
      end,
      mode = { "n", "x" },
      desc = "OpenCode optimize",
    },
  },
  config = function()
    local cmd = "opencode --port"
    local snacks_opts = {
      win = { position = "left", width = math.floor(vim.o.columns * 0.35) },
    }
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(cmd, snacks_opts)
        end,
      },
    }
    vim.o.autoread = true
  end,
}
