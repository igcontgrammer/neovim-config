-- Aplicar itálica a todo el código para usar la fuente cursiva del terminal
local function apply_highlights()
  local groups = {
    "Normal",
    "NormalFloat",
    "Function",
    "Identifier",
    "Type",
    "Constant",
    "Number",
    "Boolean",
  }

  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    if hl and next(hl) then
      hl.italic = true
      vim.api.nvim_set_hl(0, group, hl)
    end
  end
end

apply_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_highlights,
})
