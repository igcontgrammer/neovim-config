return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "moon",

      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = { italic = true },
        variables = { italic = true },
      },

      on_highlights = function(hl, colors)
        for name, group in pairs(hl) do
          if type(group) == "table" then
            group.italic = true
          end
        end
      end,
    })

    vim.cmd.colorscheme("tokyonight")
  end,
}
