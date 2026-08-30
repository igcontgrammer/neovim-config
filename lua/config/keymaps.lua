-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- ══════════════════════════════════════════════════════════════
-- GRUG-FAR (buscar/reemplazar proyecto)
-- ══════════════════════════════════════════════════════════════
map("n", "<leader>sr", "<cmd>GrugFar<cr>", { desc = "Search & Replace" })
map("n", "<leader>sw", function()
  require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { desc = "Search current word" })
map("v", "<leader>sw", function()
  require("grug-far").with_visual_selection({ prefills = {} })
end, { desc = "Search selection" })
map("n", "<leader>sf", function()
  require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
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

-- Symbols / outline (LSP)
map("n", "<leader>xs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (outline, sin foco)" })
map("n", "<leader>xS", "<cmd>Trouble symbols toggle focus=true<cr>", { desc = "Symbols (outline, con foco)" })
map("n", "<leader>xo", "<cmd>Trouble lsp_document_symbols toggle win.position=right<cr>", { desc = "Symbols del documento" })

-- Navegacion LSP en el panel de Trouble
map("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Referencias" })
map("n", "<leader>xd", "<cmd>Trouble lsp_definitions toggle<cr>", { desc = "Definiciones" })
map("n", "<leader>xy", "<cmd>Trouble lsp_type_definitions toggle<cr>", { desc = "Type definitions" })
map("n", "<leader>xi", "<cmd>Trouble lsp_implementations toggle<cr>", { desc = "Implementaciones" })
map("n", "<leader>xL", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP (defs/refs/impls)" })

map("n", "<leader>xc", "<cmd>Trouble close<cr>", { desc = "Cerrar Trouble" })

-- Saltar entre items sin salir del buffer (cae a quickfix si Trouble esta cerrado)
map("n", "]x", function()
  local trouble = require("trouble")
  if trouble.is_open() then
    trouble.next({ skip_groups = true, jump = true })
  else
    vim.cmd("cnext")
  end
end, { desc = "Trouble: siguiente item" })
map("n", "[x", function()
  local trouble = require("trouble")
  if trouble.is_open() then
    trouble.prev({ skip_groups = true, jump = true })
  else
    vim.cmd("cprev")
  end
end, { desc = "Trouble: item anterior" })

-- Toggle diagnostics del LSP/linter (errores, warnings, hints)
-- Uso: :DiagToggle  |  :DiagToggle on  |  :DiagToggle off
vim.api.nvim_create_user_command("DiagToggle", function(opts)
  local arg = opts.args
  local target = arg == "on" and true or arg == "off" and false or not vim.diagnostic.is_enabled()
  vim.diagnostic.enable(target)
  vim.notify("Diagnostics " .. (target and "ON" or "OFF"), vim.log.levels.INFO)
end, {
  nargs = "?",
  complete = function()
    return { "on", "off" }
  end,
  desc = "Toggle LSP/linter diagnostics",
})

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

-- Split navigation handled by vim-kitty-navigator

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

-- Terminal (snacks.terminal) — horizontal split, bottom, persistent across toggles
-- count = terminal id => `2<leader>]` abre/togglea la terminal 2

-- La instancia snacks.win del buffer actual, si es una terminal
local function cur_term()
  local buf = vim.api.nvim_get_current_buf()
  for _, w in ipairs(require("snacks.terminal").list()) do
    if w.buf == buf then
      return w
    end
  end
end

local function toggle_term(count)
  if not count then
    -- Dentro de una terminal => esconde ESA. Ojo: v:count no sirve acá,
    -- conserva el count del último comando normal y apuntaría a otra.
    local w = cur_term()
    if w then
      return w:hide()
    end
    count = vim.v.count1
  end
  require("snacks.terminal").toggle(nil, {
    count = count,
    win = { position = "bottom", height = 0.3, border = "rounded" },
  })
end
map({ "n", "t" }, "<leader>]", function() toggle_term() end, { desc = "Toggle terminal" })
map({ "n", "t" }, "<C-/>", function() toggle_term() end, { desc = "Toggle terminal" })
map({ "n", "t" }, "<C-_>", function() toggle_term() end, { desc = "Toggle terminal (tmux fallback)" })

-- Nueva terminal en el primer id libre
map({ "n", "t" }, "<leader>[", function()
  local n = 1
  while require("snacks.terminal").get(nil, { create = false, count = n }) do
    n = n + 1
  end
  toggle_term(n)
end, { desc = "Nueva terminal" })

-- Toggle de TODAS: si hay alguna visible las esconde, si no las muestra
map({ "n", "t" }, "<leader>}", function()
  local terms = require("snacks.terminal").list()
  local hide = vim.iter(terms):any(function(w)
    return w:win_valid()
  end)
  for _, w in ipairs(terms) do
    if hide then
      w:hide()
    else
      w:show()
    end
  end
end, { desc = "Toggle todas las terminales" })

-- Elegir entre las terminales abiertas
map({ "n", "t" }, "<leader>\\", function()
  vim.ui.select(require("snacks.terminal").list(), {
    prompt = "Terminales",
    format_item = function(w)
      local t = vim.b[w.buf].snacks_terminal or {}
      return (t.id or "?") .. ": " .. (vim.b[w.buf].term_title or "")
    end,
  }, function(w)
    if w then
      w:show()
      w:focus()
    end
  end)
end, { desc = "Listar terminales" })
map("t", "<leader>x", "<C-\\><C-n>", { desc = "Salir del modo terminal" })

-- Navegación entre splits
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Lo mismo desde terminal mode
map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to lower window" })
map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to upper window" })
map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to right window" })

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

-- move between tabs
vim.keymap.set("n", "<leader>tl", ":tabnext<CR>", { desc = "Next tab" })

-- tab anterior
vim.keymap.set("n", "<leader>th", ":tabprevious<CR>", { desc = "Prev tab" })

-- Ciclar entre tabs
map("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "[t", "<cmd>tabprevious<CR>", { desc = "Prev tab" })
map("n", "<M-Tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<M-S-Tab>", "<cmd>tabprevious<CR>", { desc = "Prev tab" })
map("n", "<M-l>", "<cmd>tabnext<CR>", { desc = "Next tab" })
map("n", "<M-h>", "<cmd>tabprevious<CR>", { desc = "Prev tab" })

-- goto preview
vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true })

vim.keymap.set("v", "<leader>sg", function()
  -- Get the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")

  -- Escape special characters for grep
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  -- Use the selected text for grep
  if pcall(require, "snacks") then
    require("snacks").picker.grep({ search = selected_text })
  elseif pcall(require, "telescope.builtin") then
    require("telescope.builtin").grep_string({ search = selected_text })
  else
    vim.notify("No grep picker available", vim.log.levels.ERROR)
  end
end, { desc = "Grep Selected Text" })

-- Grep keybinding for visual mode with G - search selected text at root level
vim.keymap.set("v", "<leader>sG", function()
  -- Get git root or fallback to cwd
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
  local root = vim.v.shell_error == 0 and git_root ~= "" and git_root or vim.fn.getcwd()

  -- Get the selected text
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then
    return
  end

  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")

  -- Escape special characters for grep
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  -- Use the selected text for grep at root level
  if pcall(require, "snacks") then
    require("snacks").picker.grep({ search = selected_text, cwd = root })
  elseif pcall(require, "telescope.builtin") then
    require("telescope.builtin").grep_string({ search = selected_text, cwd = root })
  else
    vim.notify("No grep picker available", vim.log.levels.ERROR)
  end
end, { desc = "Grep Selected Text (Root Dir)" })

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
