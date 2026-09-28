-- Puente entre copilot.vim y blink.cmp para el mapeo de <Tab>.
--
-- copilot#Accept() no acepta la sugerencia por sí mismo: devuelve las teclas
-- que hay que insertar. Por eso solo sirve desde un mapeo <expr> con
-- replace_keycodes = false (las teclas ya vienen en codificación interna).
local M = {}

--- Teclas que aceptan la sugerencia visible de Copilot, o nil si no hay ninguna.
--- @return string|nil
function M.accept_keys()
  -- pcall cubre el caso de que copilot.vim aún no esté cargado.
  local ok, sug = pcall(vim.fn["copilot#GetDisplayedSuggestion"])
  if not ok or type(sug) ~= "table" then
    return nil
  end
  if type(sug.text) ~= "string" or sug.text == "" then
    return nil
  end
  -- Solo llamamos a Accept si hay sugerencia: tiene efectos secundarios.
  return vim.fn["copilot#Accept"]("")
end

return M
