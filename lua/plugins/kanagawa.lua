return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = false,
  priority = 900,
  config = function()
    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      theme = "dragon", -- dragon | wave | lotus
      background = {
        dark = "dragon",
        light = "lotus",
      },
      colors = {
        theme = {
          all = {
            ui = {
              -- fondo de flotantes igual al fondo normal (bordes limpios)
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme
        local makeDiagnosticColor = function(color)
          local c = require("kanagawa.lib.color")
          return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
        end

        return {
          -- Comentarios legibles
          Comment = { fg = theme.ui.special, italic = true },

          -- Ventanas flotantes con separación clara
          NormalFloat = { bg = theme.ui.bg_m3, fg = theme.ui.fg },
          FloatBorder = { bg = theme.ui.bg_m3, fg = theme.ui.bg_m3 },
          FloatTitle = { bg = theme.ui.bg_m3, fg = theme.ui.special, bold = true },

          -- Menú de autocompletado con más contraste
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_m3 },
          PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, bold = true },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },

          -- Telescope
          TelescopeTitle = { fg = theme.ui.special, bold = true },
          TelescopePromptNormal = { bg = theme.ui.bg_p1 },
          TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
          TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
          TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
          TelescopePreviewNormal = { bg = theme.ui.bg_dim },
          TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

          -- Blink.cmp: menú y selección
          BlinkCmpMenu = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },
          BlinkCmpMenuBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },
          BlinkCmpMenuSelection = { bg = theme.ui.bg_p2, bold = true },
          BlinkCmpDoc = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },
          BlinkCmpDocBorder = { fg = theme.ui.bg_m3, bg = theme.ui.bg_m3 },

          -- Blink.cmp: labels
          BlinkCmpLabel = { fg = theme.ui.fg },
          BlinkCmpLabelMatch = { fg = theme.syn.constant, bold = true },
          BlinkCmpLabelDescription = { fg = theme.ui.fg_dim },
          BlinkCmpLabelDetail = { fg = theme.ui.fg_dim },
          BlinkCmpLabelDeprecated = { fg = theme.ui.special, strikethrough = true },

          -- Blink.cmp: kind icons/text
          BlinkCmpKind = { fg = theme.ui.special },
          BlinkCmpKindText = { fg = theme.syn.string },
          BlinkCmpKindMethod = { fg = theme.syn.fun },
          BlinkCmpKindFunction = { fg = theme.syn.fun },
          BlinkCmpKindConstructor = { fg = theme.syn.fun },
          BlinkCmpKindField = { fg = theme.syn.identifier },
          BlinkCmpKindVariable = { fg = theme.syn.identifier },
          BlinkCmpKindClass = { fg = theme.syn.type },
          BlinkCmpKindInterface = { fg = theme.syn.type },
          BlinkCmpKindModule = { fg = theme.syn.type },
          BlinkCmpKindProperty = { fg = theme.syn.identifier },
          BlinkCmpKindUnit = { fg = theme.syn.number },
          BlinkCmpKindValue = { fg = theme.syn.number },
          BlinkCmpKindEnum = { fg = theme.syn.type },
          BlinkCmpKindKeyword = { fg = theme.syn.keyword },
          BlinkCmpKindSnippet = { fg = theme.syn.preproc },
          BlinkCmpKindColor = { fg = theme.syn.special1 },
          BlinkCmpKindFile = { fg = theme.ui.special },
          BlinkCmpKindReference = { fg = theme.syn.special2 },
          BlinkCmpKindFolder = { fg = theme.ui.special },
          BlinkCmpKindEnumMember = { fg = theme.syn.constant },
          BlinkCmpKindConstant = { fg = theme.syn.constant },
          BlinkCmpKindStruct = { fg = theme.syn.type },
          BlinkCmpKindEvent = { fg = theme.syn.special2 },
          BlinkCmpKindOperator = { fg = theme.syn.operator },
          BlinkCmpKindTypeParameter = { fg = theme.syn.parameter },

          -- Diagnósticos con fondo tenue
          DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
          DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
          DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
          DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),
        }
      end,
    })

    -- Instalado pero no activo: el colorscheme lo fija onehalf.lua.
    -- Para volver: :colorscheme kanagawa-dragon
  end,
}
