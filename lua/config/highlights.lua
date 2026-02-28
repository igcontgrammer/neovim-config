-- Configuración de highlights personalizados para gruvbox-material
-- Este archivo se carga automáticamente después de los plugins

-- Colores de gruvbox-material
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

-- Aplicar highlights personalizados
local function apply_highlights()
  -- Diagnósticos
  vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.red, bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.yellow, bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.blue })
  vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.aqua })

  -- Signos
  vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = colors.red, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = colors.yellow, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = colors.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = colors.aqua, bg = "NONE" })

  -- Virtual text
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = colors.red, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = colors.yellow, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = colors.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = colors.aqua, bg = "NONE" })

  -- Underlines
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = colors.red, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = colors.yellow, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = colors.blue, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = colors.aqua, undercurl = true })

  -- Ventanas flotantes
  vim.api.nvim_set_hl(0, "NormalFloat", { fg = colors.fg1, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.grey1, bg = colors.bg1 })
  vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.orange, bg = colors.bg1, bold = true })

  -- Markdown en floating windows
  vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = colors.green, bg = colors.bg2 })
  vim.api.nvim_set_hl(0, "@markup.heading.markdown", { fg = colors.orange, bold = true })
  vim.api.nvim_set_hl(0, "@text.literal.markdown_inline", { fg = colors.green, bg = colors.bg2 })
end

-- Aplicar inmediatamente
apply_highlights()

-- Reaplicar cuando cambie el colorscheme
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   callback = apply_highlights,
-- })
