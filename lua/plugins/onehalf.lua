-- sonph/onehalf: colorscheme vimscript clásico (vive en el subdirectorio vim/).
-- Solo define grupos básicos, así que abajo se añade una capa de compatibilidad
-- con treesitter, LSP/diagnósticos, Telescope y blink.cmp usando su misma paleta.

local palettes = {
  onehalfdark = {
    bg = "#282c34",
    fg = "#dcdfe4",
    red = "#e06c75",
    green = "#98c379",
    yellow = "#e5c07b",
    blue = "#61afef",
    purple = "#c678dd",
    cyan = "#56b6c2",
    comment = "#5c6370",
    gutter = "#919baa",
    non_text = "#373c45",
    cursor_line = "#313640",
    selection = "#474e5d",
    float_bg = "#21252b",
  },
  onehalflight = {
    bg = "#fafafa",
    fg = "#383a42",
    red = "#e45649",
    green = "#50a14f",
    yellow = "#c18401",
    blue = "#0184bc",
    purple = "#a626a4",
    cyan = "#0997b3",
    comment = "#a0a1a7",
    gutter = "#d4d4d4",
    non_text = "#e5e5e5",
    cursor_line = "#f0f0f0",
    selection = "#bfceff",
    float_bg = "#eaeaeb",
  },
}

-- Mezcla dos colores hex (alpha 0 = base, 1 = color).
local function blend(color, base, alpha)
  local function parse(c)
    return tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16)
  end
  local r1, g1, b1 = parse(color)
  local r2, g2, b2 = parse(base)
  return string.format(
    "#%02x%02x%02x",
    math.floor(r1 * alpha + r2 * (1 - alpha) + 0.5),
    math.floor(g1 * alpha + g2 * (1 - alpha) + 0.5),
    math.floor(b1 * alpha + b2 * (1 - alpha) + 0.5)
  )
end

local function apply_overrides(name)
  local c = palettes[name]
  if not c then
    return
  end

  local function hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end
  local function link(group, target)
    vim.api.nvim_set_hl(0, group, { link = target })
  end
  local function diag_vt(color)
    return { fg = color, bg = blend(color, c.bg, 0.12) }
  end

  ----------------------------------------------------------------------------
  -- UI base
  ----------------------------------------------------------------------------
  hl("NormalFloat", { fg = c.fg, bg = c.float_bg })
  hl("FloatBorder", { fg = c.float_bg, bg = c.float_bg })
  hl("FloatTitle", { fg = c.blue, bg = c.float_bg, bold = true })
  hl("WinSeparator", { fg = c.cursor_line })
  hl("Pmenu", { fg = c.fg, bg = c.float_bg })
  hl("PmenuSel", { bg = c.selection, bold = true })
  hl("PmenuSbar", { bg = c.float_bg })
  hl("PmenuThumb", { bg = c.selection })
  hl("CurSearch", { fg = c.bg, bg = c.yellow, bold = true })
  hl("MatchParen", { fg = c.cyan, bold = true, underline = true })
  hl("Comment", { fg = c.comment, italic = true })
  hl("WinBar", { fg = c.fg, bg = c.bg })
  hl("WinBarNC", { fg = c.comment, bg = c.bg })

  ----------------------------------------------------------------------------
  -- Treesitter
  ----------------------------------------------------------------------------
  hl("@variable", { fg = c.fg })
  hl("@variable.builtin", { fg = c.red })
  hl("@variable.parameter", { fg = c.fg })
  hl("@variable.member", { fg = c.red })
  hl("@property", { fg = c.red })
  hl("@field", { fg = c.red })
  hl("@constant", { fg = c.cyan })
  hl("@constant.builtin", { fg = c.cyan })
  hl("@constant.macro", { fg = c.cyan })
  hl("@module", { fg = c.yellow })
  hl("@string", { fg = c.green })
  hl("@string.escape", { fg = c.cyan })
  hl("@string.special", { fg = c.cyan })
  hl("@character", { fg = c.green })
  hl("@number", { fg = c.cyan })
  hl("@boolean", { fg = c.cyan })
  hl("@float", { fg = c.cyan })
  hl("@function", { fg = c.blue })
  hl("@function.builtin", { fg = c.blue })
  hl("@function.call", { fg = c.blue })
  hl("@function.macro", { fg = c.blue })
  hl("@function.method", { fg = c.blue })
  hl("@function.method.call", { fg = c.blue })
  hl("@constructor", { fg = c.yellow })
  hl("@keyword", { fg = c.purple })
  hl("@keyword.function", { fg = c.purple })
  hl("@keyword.operator", { fg = c.purple })
  hl("@keyword.return", { fg = c.purple })
  hl("@keyword.import", { fg = c.purple })
  hl("@keyword.conditional", { fg = c.purple })
  hl("@keyword.repeat", { fg = c.purple })
  hl("@keyword.exception", { fg = c.purple })
  hl("@operator", { fg = c.fg })
  hl("@type", { fg = c.yellow })
  hl("@type.builtin", { fg = c.yellow })
  hl("@type.definition", { fg = c.yellow })
  hl("@attribute", { fg = c.yellow })
  hl("@punctuation.delimiter", { fg = c.gutter })
  hl("@punctuation.bracket", { fg = c.fg })
  hl("@punctuation.special", { fg = c.cyan })
  hl("@comment", { fg = c.comment, italic = true })
  hl("@tag", { fg = c.red })
  hl("@tag.builtin", { fg = c.red })
  hl("@tag.attribute", { fg = c.yellow })
  hl("@tag.delimiter", { fg = c.gutter })
  hl("@markup.heading", { fg = c.blue, bold = true })
  hl("@markup.strong", { fg = c.yellow, bold = true })
  hl("@markup.italic", { fg = c.purple, italic = true })
  hl("@markup.link", { fg = c.cyan, underline = true })
  hl("@markup.link.url", { fg = c.cyan, underline = true })
  hl("@markup.raw", { fg = c.green })
  hl("@markup.list", { fg = c.red })
  hl("@diff.plus", { fg = c.green })
  hl("@diff.minus", { fg = c.red })

  ----------------------------------------------------------------------------
  -- LSP y diagnósticos
  ----------------------------------------------------------------------------
  hl("DiagnosticError", { fg = c.red })
  hl("DiagnosticWarn", { fg = c.yellow })
  hl("DiagnosticInfo", { fg = c.blue })
  hl("DiagnosticHint", { fg = c.cyan })
  hl("DiagnosticOk", { fg = c.green })
  hl("DiagnosticVirtualTextError", diag_vt(c.red))
  hl("DiagnosticVirtualTextWarn", diag_vt(c.yellow))
  hl("DiagnosticVirtualTextInfo", diag_vt(c.blue))
  hl("DiagnosticVirtualTextHint", diag_vt(c.cyan))
  hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
  hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
  hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
  hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.cyan })
  hl("LspReferenceText", { bg = c.cursor_line })
  hl("LspReferenceRead", { bg = c.cursor_line })
  hl("LspReferenceWrite", { bg = c.cursor_line, underline = true })
  hl("LspInlayHint", { fg = c.comment, bg = blend(c.comment, c.bg, 0.1), italic = true })
  link("@lsp.type.class", "@type")
  link("@lsp.type.parameter", "@variable.parameter")
  link("@lsp.type.property", "@property")
  link("@lsp.type.variable", "@variable")
  link("@lsp.type.namespace", "@module")
  link("@lsp.type.enumMember", "@constant")

  ----------------------------------------------------------------------------
  -- Telescope
  ----------------------------------------------------------------------------
  hl("TelescopeTitle", { fg = c.blue, bold = true })
  hl("TelescopePromptNormal", { bg = c.cursor_line })
  hl("TelescopePromptBorder", { fg = c.cursor_line, bg = c.cursor_line })
  hl("TelescopeResultsNormal", { fg = c.fg, bg = c.float_bg })
  hl("TelescopeResultsBorder", { fg = c.float_bg, bg = c.float_bg })
  hl("TelescopePreviewNormal", { bg = c.float_bg })
  hl("TelescopePreviewBorder", { fg = c.float_bg, bg = c.float_bg })
  hl("TelescopeSelection", { bg = c.selection, bold = true })
  hl("TelescopeMatching", { fg = c.yellow, bold = true })

  ----------------------------------------------------------------------------
  -- blink.cmp
  ----------------------------------------------------------------------------
  hl("BlinkCmpMenu", { fg = c.fg, bg = c.float_bg })
  hl("BlinkCmpMenuBorder", { fg = c.float_bg, bg = c.float_bg })
  hl("BlinkCmpMenuSelection", { bg = c.selection, bold = true })
  hl("BlinkCmpDoc", { fg = c.fg, bg = c.float_bg })
  hl("BlinkCmpDocBorder", { fg = c.float_bg, bg = c.float_bg })
  hl("BlinkCmpDocSeparator", { fg = c.non_text, bg = c.float_bg })
  hl("BlinkCmpSignatureHelp", { fg = c.fg, bg = c.float_bg })
  hl("BlinkCmpSignatureHelpBorder", { fg = c.float_bg, bg = c.float_bg })
  hl("BlinkCmpLabel", { fg = c.fg })
  hl("BlinkCmpLabelMatch", { fg = c.blue, bold = true })
  hl("BlinkCmpLabelDescription", { fg = c.comment })
  hl("BlinkCmpLabelDetail", { fg = c.comment })
  hl("BlinkCmpLabelDeprecated", { fg = c.comment, strikethrough = true })
  hl("BlinkCmpKind", { fg = c.gutter })
  hl("BlinkCmpKindText", { fg = c.green })
  hl("BlinkCmpKindMethod", { fg = c.blue })
  hl("BlinkCmpKindFunction", { fg = c.blue })
  hl("BlinkCmpKindConstructor", { fg = c.yellow })
  hl("BlinkCmpKindField", { fg = c.red })
  hl("BlinkCmpKindVariable", { fg = c.fg })
  hl("BlinkCmpKindClass", { fg = c.yellow })
  hl("BlinkCmpKindInterface", { fg = c.yellow })
  hl("BlinkCmpKindModule", { fg = c.yellow })
  hl("BlinkCmpKindProperty", { fg = c.red })
  hl("BlinkCmpKindUnit", { fg = c.cyan })
  hl("BlinkCmpKindValue", { fg = c.cyan })
  hl("BlinkCmpKindEnum", { fg = c.yellow })
  hl("BlinkCmpKindKeyword", { fg = c.purple })
  hl("BlinkCmpKindSnippet", { fg = c.green })
  hl("BlinkCmpKindColor", { fg = c.purple })
  hl("BlinkCmpKindFile", { fg = c.gutter })
  hl("BlinkCmpKindReference", { fg = c.purple })
  hl("BlinkCmpKindFolder", { fg = c.gutter })
  hl("BlinkCmpKindEnumMember", { fg = c.cyan })
  hl("BlinkCmpKindConstant", { fg = c.cyan })
  hl("BlinkCmpKindStruct", { fg = c.yellow })
  hl("BlinkCmpKindEvent", { fg = c.purple })
  hl("BlinkCmpKindOperator", { fg = c.fg })
  hl("BlinkCmpKindTypeParameter", { fg = c.yellow })

  ----------------------------------------------------------------------------
  -- gitsigns / nvim-tree / misc
  ----------------------------------------------------------------------------
  hl("GitSignsAdd", { fg = c.green })
  hl("GitSignsChange", { fg = c.yellow })
  hl("GitSignsDelete", { fg = c.red })
  hl("NvimTreeNormal", { fg = c.fg, bg = c.bg })
  hl("NvimTreeRootFolder", { fg = c.purple, bold = true })
  hl("NvimTreeFolderIcon", { fg = c.blue })
  hl("NvimTreeIndentMarker", { fg = c.non_text })
  hl("NvimTreeWinSeparator", { fg = c.cursor_line, bg = c.bg })
  hl("NvimTreeCursorLine", { bg = c.cursor_line })
end

return {
  "sonph/onehalf",
  name = "onehalf",
  lazy = false,
  priority = 1000,
  config = function(plugin)
    -- El colorscheme está en el subdirectorio vim/, no en la raíz del repo.
    vim.opt.rtp:append(plugin.dir .. "/vim")

    vim.opt.termguicolors = true

    -- Reaplica la capa de compatibilidad cada vez que se carga el colorscheme.
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("onehalf_overrides", { clear = true }),
      pattern = { "onehalfdark", "onehalflight" },
      callback = function(ev)
        apply_overrides(ev.match)
      end,
    })

    vim.o.background = "dark"
    vim.cmd.colorscheme("onehalfdark") -- onehalflight para la variante clara
  end,
}
