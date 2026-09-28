-- OpenCode v2 dropped the `--port` flag: the TUI now talks to a background
-- service and opencode.nvim discovers it via ~/.local/state/opencode/service.json.
local opencode_cmd = "opencode"

local function terminal_opts()
  return {
    win = { position = "left", width = math.floor(vim.o.columns * 0.35) },
  }
end

-- opencode.nvim v2 `prompt()` sends text literally; named prompts no longer exist.
local function prompt(text)
  return function()
    require("opencode").prompt(text)
  end
end

return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  init = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require("snacks.terminal").open(opencode_cmd, terminal_opts())
        end,
      },
    }
  end,
  keys = {
    {
      "<leader>aa",
      function()
        require("snacks.terminal").toggle(opencode_cmd, terminal_opts())
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
    { "<leader>ap", prompt("@this"), mode = { "n", "x" }, desc = "OpenCode prompt" },
    { "<leader>ape", prompt("Explain @this and its context"), mode = { "n", "x" }, desc = "OpenCode explain" },
    { "<leader>apf", prompt("Fix @diagnostics"), mode = { "n", "x" }, desc = "OpenCode fix" },
    { "<leader>apd", prompt("Explain @diagnostics"), mode = { "n", "x" }, desc = "OpenCode diagnose" },
    {
      "<leader>apr",
      prompt("Review @this for correctness and readability"),
      mode = { "n", "x" },
      desc = "OpenCode review",
    },
    { "<leader>apt", prompt("Add tests for @this"), mode = { "n", "x" }, desc = "OpenCode test" },
    {
      "<leader>apo",
      prompt("Optimize @this for performance and readability"),
      mode = { "n", "x" },
      desc = "OpenCode optimize",
    },
  },
}
