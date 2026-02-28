-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ══════════════════════════════════════════════════════════════
-- SPECTRE (buscar/reemplazar)
-- ══════════════════════════════════════════════════════════════
map("n", "<leader>sr", function()
  require("spectre").toggle()
end, { desc = "Search & Replace" })
map("n", "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })
map("v", "<leader>sw", function()
  require("spectre").open_visual()
end, { desc = "Search selection" })
map("n", "<leader>sf", function()
  require("spectre").open_file_search({ select_word = true })
end, { desc = "Search in current file" })

-- ══════════════════════════════════════════════════════════════
-- GIT
-- ══════════════════════════════════════════════════════════════
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Diff view" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File history" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Branch history" })
map("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Close diff view" })

-- Gitsigns
map("n", "]h", function()
  require("gitsigns").next_hunk()
end, { desc = "Next hunk" })
map("n", "[h", function()
  require("gitsigns").prev_hunk()
end, { desc = "Prev hunk" })
map("n", "<leader>gp", function()
  require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
map("n", "<leader>gb", function()
  require("gitsigns").blame_line({ full = true })
end, { desc = "Blame line" })
map("n", "<leader>gr", function()
  require("gitsigns").reset_hunk()
end, { desc = "Reset hunk" })
map("n", "<leader>gR", function()
  require("gitsigns").reset_buffer()
end, { desc = "Reset buffer" })
map("n", "<leader>gs", function()
  require("gitsigns").stage_hunk()
end, { desc = "Stage hunk" })
map("n", "<leader>gS", function()
  require("gitsigns").stage_buffer()
end, { desc = "Stage buffer" })

-- ══════════════════════════════════════════════════════════════
-- HARPOON
-- ══════════════════════════════════════════════════════════════
map("n", "<leader>ha", function()
  require("harpoon"):list():add()
end, { desc = "Harpoon add" })
map("n", "<leader>hh", function()
  require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "Harpoon menu" })
map("n", "<leader>1", function()
  require("harpoon"):list():select(1)
end, { desc = "Harpoon 1" })
map("n", "<leader>2", function()
  require("harpoon"):list():select(2)
end, { desc = "Harpoon 2" })
map("n", "<leader>3", function()
  require("harpoon"):list():select(3)
end, { desc = "Harpoon 3" })
map("n", "<leader>4", function()
  require("harpoon"):list():select(4)
end, { desc = "Harpoon 4" })
map("n", "<leader>hp", function()
  require("harpoon"):list():prev()
end, { desc = "Harpoon prev" })
map("n", "<leader>hn", function()
  require("harpoon"):list():next()
end, { desc = "Harpoon next" })

-- ══════════════════════════════════════════════════════════════
-- TROUBLE / DIAGNOSTICS
-- ══════════════════════════════════════════════════════════════
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
map("n", "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", { desc = "Quickfix" })
map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "TODOs" })

-- ══════════════════════════════════════════════════════════════
-- UTILIDADES
-- ══════════════════════════════════════════════════════════════
-- Mover líneas
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Mantener cursor centrado
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Limpiar resaltado de búsqueda
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Pegar sin perder registro
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- Copiar al clipboard del sistema
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

-- Eliminar sin yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yank" })

-- Quickfix navigation
map("n", "]q", "<cmd>cnext<cr>zz", { desc = "Next quickfix" })
map("n", "[q", "<cmd>cprev<cr>zz", { desc = "Prev quickfix" })

-- Split navigation mejorada
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize splits
local RESIZE_AMOUNT = 2
map("n", "<C-s-Up>", "<cmd>resize +2<cr>")
map("n", "<C-s-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")
map("n", "<leader>,.", ":resize +5" .. RESIZE_AMOUNT .. "<CR>", { desc = "Aumentar Alto de Split" })
map("n", "<leader>,/", ":resize -5" .. RESIZE_AMOUNT .. "<CR>", { desc = "Disminuir Alto de Split" })
map("n", "<leader>,]", ":vertical resize +5" .. RESIZE_AMOUNT .. "<CR>", { desc = "Aumentar Ancho de Split" })
map("n", "<leader>,[", ":vertical resize -5" .. RESIZE_AMOUNT .. "<CR>", { desc = "Disminuir Ancho de Split" })

-- Guardar rápido
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("i", "<C-s>", "<esc><cmd>w<cr>", { desc = "Save" })

-- Navegación entre buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Quit y cerrar buffers
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })
map("n", "<leader>qa", "<cmd>%bd|e#|bd#<cr>", { desc = "Close all buffers except current" })

-- Agregar punto y coma al final
map("n", "<leader>;", "A;", { desc = "Add semicolon at end" })

-- LSP rename
map("n", "<leader>rn", function()
  vim.lsp.buf.rename()
end, { desc = "Rename symbol (LSP)" })

-- Splits
map("n", "<leader>vs", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal split" })

-- Write/Quit
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })

-- Terminal (nvterm)
map("n", "<leader>te", function()
  require("nvterm.terminal").toggle("vertical")
end, { desc = "Toggle terminal" })
map("t", "<leader>t", function()
  require("nvterm.terminal").toggle("vertical")
end, { desc = "Toggle terminal" })
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Salir del modo terminal" })
map("t", "<leader>x", "<C-\\><C-n>", { desc = "Salir del modo terminal" })

-- Tabs
map("n", "<leader>tn", ":tabnew<CR>", { desc = "Nuevo Tab" })
map("n", "<leader>tt", ":tabclose<CR>", { desc = "Cerrar Tab" })

-- Code action
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code action" })

-- Diagnostics float
map("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, {
    focus = false,
    border = "rounded",
    source = "always",
  })
end, { desc = "Mostrar error del LSP" })

-- ══════════════════════════════════════════════════════════════
-- NEOVIDE ZOOM
-- ══════════════════════════════════════════════════════════════
if vim.g.neovide then
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  -- Zoom in
  map("n", "<D-=>", function()
    change_scale_factor(1.1)
  end, { desc = "Zoom in" })
  map("n", "<C-=>", function()
    change_scale_factor(1.1)
  end, { desc = "Zoom in" })

  -- Zoom out
  map("n", "<D-->", function()
    change_scale_factor(1 / 1.1)
  end, { desc = "Zoom out" })
  map("n", "<C-->", function()
    change_scale_factor(1 / 1.1)
  end, { desc = "Zoom out" })

  -- Reset zoom
  map("n", "<D-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset zoom" })
  map("n", "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Reset zoom" })
end
