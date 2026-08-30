return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 900,
  opts = {
    style = "storm", -- night | storm | day | moon
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
    on_highlights = function(hl, c)
      -- Menú de autocompletado con más contraste
      hl.Pmenu = { bg = c.bg_popup, fg = c.fg }
      hl.PmenuSel = { bg = c.bg_highlight, fg = c.fg, bold = true }
      hl.PmenuSbar = { bg = c.bg_sidebar }
      hl.PmenuThumb = { bg = c.comment }

      -- Ventanas flotantes con mejor separación
      hl.NormalFloat = { bg = c.bg_popup, fg = c.fg }
      hl.FloatBorder = { bg = c.bg_popup, fg = c.border_highlight }
      hl.FloatTitle = { bg = c.yellow, fg = c.bg, bold = true }

      -- Línea del cursor más visible pero no agresiva
      hl.CursorLine = { bg = c.bg_highlight }
      hl.CursorColumn = { bg = c.bg_highlight }

      -- Blink.cmp: menú y selección
      hl.BlinkCmpMenu = { bg = c.bg_popup, fg = c.fg }
      hl.BlinkCmpMenuBorder = { bg = c.bg_popup, fg = c.comment }
      hl.BlinkCmpMenuSelection = { bg = c.bg_highlight, fg = c.fg, bold = true }

      -- Blink.cmp: labels
      hl.BlinkCmpLabel = { fg = c.fg }
      hl.BlinkCmpLabelMatch = { fg = c.cyan, bold = true }
      hl.BlinkCmpLabelDescription = { fg = c.fg_dark }
      hl.BlinkCmpLabelDetail = { fg = c.fg_dark }
      hl.BlinkCmpLabelDeprecated = { fg = c.comment, strikethrough = true }

      -- Blink.cmp: kind icons/text (colores tokyonight consistentes)
      hl.BlinkCmpKind = { fg = c.comment }
      hl.BlinkCmpKindText = { fg = c.yellow }
      hl.BlinkCmpKindMethod = { fg = c.green }
      hl.BlinkCmpKindFunction = { fg = c.green }
      hl.BlinkCmpKindConstructor = { fg = c.green }
      hl.BlinkCmpKindField = { fg = c.blue }
      hl.BlinkCmpKindVariable = { fg = c.cyan }
      hl.BlinkCmpKindClass = { fg = c.cyan }
      hl.BlinkCmpKindInterface = { fg = c.cyan }
      hl.BlinkCmpKindModule = { fg = c.cyan }
      hl.BlinkCmpKindProperty = { fg = c.blue }
      hl.BlinkCmpKindUnit = { fg = c.magenta }
      hl.BlinkCmpKindValue = { fg = c.magenta }
      hl.BlinkCmpKindEnum = { fg = c.blue }
      hl.BlinkCmpKindKeyword = { fg = c.red }
      hl.BlinkCmpKindSnippet = { fg = c.green }
      hl.BlinkCmpKindColor = { fg = c.magenta }
      hl.BlinkCmpKindFile = { fg = c.comment }
      hl.BlinkCmpKindReference = { fg = c.magenta }
      hl.BlinkCmpKindFolder = { fg = c.comment }
      hl.BlinkCmpKindEnumMember = { fg = c.blue }
      hl.BlinkCmpKindConstant = { fg = c.magenta }
      hl.BlinkCmpKindStruct = { fg = c.cyan }
      hl.BlinkCmpKindEvent = { fg = c.blue }
      hl.BlinkCmpKindOperator = { fg = c.red }
      hl.BlinkCmpKindTypeParameter = { fg = c.blue }

      -- Comentarios: gris legible + itálica
      hl.Comment = { fg = c.comment, italic = true }
    end,
  },
  -- Instalado pero no activo: el colorscheme lo fija onehalf.lua.
  -- Para volver: :colorscheme tokyonight-night
  config = function(_, opts)
    require("tokyonight").setup(opts)
  end,
}
