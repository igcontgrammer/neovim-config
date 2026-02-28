-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Deshabilitar netrw (usamos nvim-tree en su lugar)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line numbers
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2 -- Ancho mínimo de la columna de números

-- Indentación
vim.opt.expandtab = true -- usa espacios en vez de tabs
vim.opt.shiftwidth = 4 -- tamaño de indentación
vim.opt.tabstop = 4 -- tamaño visual del tab
vim.opt.softtabstop = 4 -- espacios que inserta Tab
vim.opt.autoindent = true -- copia indentación de la línea actual
vim.opt.smartindent = true -- indentación inteligente

-- Padding/Spacing
opt.signcolumn = "yes" -- Siempre mostrar signcolumn (1 columna)
opt.foldcolumn = "0" -- Sin columna de plegado

-- Scrolling
opt.scrolloff = 8 -- Líneas de padding arriba/abajo
opt.sidescrolloff = 8 -- Columnas de padding izquierda/derecha

-- Update time
opt.updatetime = 100
opt.timeoutlen = 300

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Clipboard (compartir con el sistema)
opt.clipboard = "unnamedplus"

-- Splits
opt.splitbelow = true -- Splits horizontales se abren abajo y el cursor va allí
opt.splitright = true -- Splits verticales se abren a la derecha y el cursor va allí
opt.splitkeep = "screen"
opt.inccommand = "split" -- Preview de sustituciones en split

-- Search
opt.ignorecase = true -- Búsqueda case insensitive por defecto
opt.smartcase = true -- Si hay mayúsculas en el patrón, será case sensitive
opt.hlsearch = true -- Resaltar todas las coincidencias
opt.incsearch = true -- Búsqueda incremental (muestra coincidencias mientras escribes)

-- Grep
opt.grepprg = "rg --vimgrep --smart-case"
opt.grepformat = "%f:%l:%c:%m"

-- Diagnósticos LSP mejorados
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    source = "if_many",
  },
  float = {
    source = "always",
    border = "rounded",
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
})

-- ══════════════════════════════════════════════════════════════
-- NEOVIDE CONFIG
-- ══════════════════════════════════════════════════════════════
if vim.g.neovide then
  -- Fuente
  vim.o.guifont = "JetBrains Mono:h14"

  -- Título de la ventana con el path actual
  opt.title = true
  opt.titlestring = "%{fnamemodify(getcwd(), ':~')} - Neovide"

  -- Tamaño inicial de la ventana (más grande que el default)
  opt.lines = 45 -- Altura en líneas
  opt.columns = 150 -- Ancho en columnas

  -- Recordar el tamaño de la ventana entre sesiones
  vim.g.neovide_remember_window_size = true

  -- Configuraciones opcionales de apariencia
  vim.g.neovide_scale_factor = 1.0
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- Animaciones más suaves
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.3
end
