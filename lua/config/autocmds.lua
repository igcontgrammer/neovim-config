-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Mantener visible la barra de tmux dentro de Neovim por defecto.
-- Si alguna vez quieres ocultarla de forma temporal, levanta Neovim con:
--   NVIM_HIDE_TMUX_STATUS=1 nvim
if vim.env.TMUX and vim.env.NVIM_HIDE_TMUX_STATUS == "1" then
  vim.api.nvim_create_autocmd({ "VimEnter", "VimResume" }, {
    callback = function()
      vim.fn.system("tmux set status off")
    end,
  })
  vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
    callback = function()
      vim.fn.system("tmux set status on")
    end,
  })
end

-- Restaurar posición del cursor al abrir archivo
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
