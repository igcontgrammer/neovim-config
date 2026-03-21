return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    styles = {
      comments = { italic = false },
      keywords = { italic = false },
    },
    on_highlights = function(highlights)
      for _, highlight in pairs(highlights) do
        if type(highlight) == "table" then
          highlight.italic = false
        end
      end
    end,
  },
  config = function()
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
