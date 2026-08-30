-- Indentación PEP8 (4 espacios). El indentexpr nativo de Neovim
-- (runtime/indent/python.vim) maneja bien `o` dentro de funciones y
-- corchetes. El indent de treesitter está desactivado para python en
-- treesitter.lua para evitar sus bugs conocidos de indentación.
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4

-- Ancho de columna sugerido por PEP8 (visual, no fuerza wrap)
vim.bo.textwidth = 88
vim.wo.colorcolumn = "88"
