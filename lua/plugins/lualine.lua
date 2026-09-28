return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    return {
      options = {
        theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
    }
  end,
}
