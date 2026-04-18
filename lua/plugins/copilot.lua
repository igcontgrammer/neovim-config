return {
  "github/copilot.vim",
  event = "InsertEnter",
  init = function()
    -- Disable default Tab mapping — we handle it manually in blink.cmp keymap
    vim.g.copilot_no_tab_map = true
    -- Optional: disable for specific filetypes
    vim.g.copilot_filetypes = {
      ["TelescopePrompt"] = false,
      ["DressingInput"] = false,
    }
  end,
}
