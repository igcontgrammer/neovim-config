return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  lazy = false,
  priority = 900,
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      contrast = "", -- "" (clásico, #282828) | "hard" | "soft"
      transparent_mode = false,
      italic = {
        strings = false,
        comments = true,
        folds = true,
        operators = false,
        emphasis = true,
      },
      bold = true,
      undercurl = true,
      underline = true,
      inverse = true,
      invert_selection = false,
      dim_inactive = false,
      strikethrough = true,
      overrides = {},
    })

    -- Instalado pero no activo: el colorscheme lo fija onehalf.lua.
    -- Para volver: :colorscheme gruvbox
  end,
}
