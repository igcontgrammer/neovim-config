-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Line numbers
opt.relativenumber = true
opt.number = true
opt.numberwidth = 2 -- Ancho mínimo de la columna de números

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

-- Splits
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
  signs = true,
  underline = true,
  update_in_insert = false,
})

-- Iconos de diagnósticos
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
