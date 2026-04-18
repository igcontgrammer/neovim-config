return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night",
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { bold = false, italic = false },
      keywords = { bold = false, italic = false },
      functions = { bold = false, italic = false },
      variables = { bold = false, italic = false },
      conditionals = { bold = false, italic = false },
      loops = { bold = false, italic = false },
      strings = { bold = false, italic = false },
      numbers = { bold = false, italic = false },
      booleans = { bold = false, italic = false },
      properties = { bold = false, italic = false },
      types = { bold = false, italic = false },
      operators = { bold = false, italic = false },
      sidebars = "dark",
      floats = "dark",
    },
    on_highlights = function(hl, _)
      -- Structural groups (layout/chrome) must keep their own weight,
      -- and the theme should not force bold globally.
      local skip = {
        Normal = true,
        NormalNC = true,
        NormalFloat = true,
        NormalSB = true,
        SignColumn = true,
        SignColumnSB = true,
        LineNr = true,
        LineNrAbove = true,
        LineNrBelow = true,
        CursorLine = true,
        CursorLineNr = true,
        CursorColumn = true,
        ColorColumn = true,
        StatusLine = true,
        StatusLineNC = true,
        WinBar = true,
        WinBarNC = true,
        WinSeparator = true,
        VertSplit = true,
        TabLine = true,
        TabLineFill = true,
        TabLineSel = true,
        Pmenu = true,
        PmenuSel = true,
        PmenuSbar = true,
        PmenuThumb = true,
        FloatBorder = true,
        FloatTitle = true,
        MsgArea = true,
        MsgSeparator = true,
        EndOfBuffer = true,
        NonText = true,
        Whitespace = true,
        Folded = true,
        FoldColumn = true,
      }
      for name, spec in pairs(hl) do
        if type(spec) == "table" and not skip[name] then
          spec.bold = false
          spec.italic = false
          hl[name] = spec
        end
      end
    end,
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd.colorscheme("tokyonight-night")
  end,
}
