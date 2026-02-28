return {
  "sainnhe/gruvbox-material",
  lazy = false,
  priority = 1000,
  config = function()
    -- Configuración de gruvbox-material
    vim.g.gruvbox_material_background = "medium" -- 'hard', 'medium', 'soft'
    vim.g.gruvbox_material_foreground = "mix" -- 'material', 'mix', 'original'
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_enable_bold = true
    vim.g.gruvbox_material_transparent_background = 0
    vim.g.gruvbox_material_diagnostic_text_highlight = 0
    vim.g.gruvbox_material_diagnostic_line_highlight = 0
    vim.g.gruvbox_material_better_performance = 1

    -- Colores de gruvbox
    local colors = {
      red = "#ea6962",
      orange = "#e78a4e",
      yellow = "#d8a657",
      green = "#a9b665",
      aqua = "#89b482",
      blue = "#7daea3",
      purple = "#d3869b",
      bg0 = "#282828",
      bg1 = "#32302f",
      bg2 = "#3c3836",
      bg3 = "#45403d",
      fg0 = "#d4be98",
      fg1 = "#ddc7a1",
      grey0 = "#7c6f64",
      grey1 = "#928374",
    }

    -- Función para aplicar highlights personalizados
    local function apply_custom_highlights()
      -- Configurar colores de diagnósticos
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.red, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.yellow, bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.blue })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.aqua })

      -- Signos en la columna de números
      vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.red, bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.yellow, bg = "NONE", bold = true })
      vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.blue, bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.aqua, bg = "NONE" })

      -- Underline para diagnósticos
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = colors.yellow, undercurl = true })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = colors.blue, undercurl = true })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = colors.aqua, undercurl = true })

      -- Virtual text para diagnósticos
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = colors.red, bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = colors.yellow, bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = colors.blue, bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = colors.aqua, bg = "NONE" })

      -- Ventanas flotantes (hover documentation)
      vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg1, bg = colors.bg1 })
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.grey1, bg = colors.bg1 })
      vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.orange, bg = colors.bg1, bold = true })

      -- Syntax highlighting en floating windows
      vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = colors.green, bg = colors.bg2 })
      vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = colors.orange, bold = true })
      vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = colors.fg1 })
      vim.api.nvim_set_hl(0, "@text.literal.markdown_inline", { fg = colors.green, bg = colors.bg2 })
      vim.api.nvim_set_hl(0, "@none", { fg = colors.fg1, bg = "NONE" })
    end

    -- Aplicar el colorscheme
    vim.cmd.colorscheme("gruvbox-material")

    apply_custom_highlights()

    -- Crear autocmd para reaplicar después de cambios de colorscheme
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "gruvbox-material",
      callback = apply_custom_highlights,
    })
  end,
}
