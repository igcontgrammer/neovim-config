-- Apagar/prender el LSP en TODO Neovim, no solo en el buffer actual.
--
-- `:LspStop` mata al cliente del buffer, pero `vim.lsp.enable()` lo vuelve a
-- levantar apenas abrís el siguiente archivo. Acá se desactivan los configs:
-- Neovim para los servidores corriendo y deja de arrancarlos en buffers nuevos.
--
-- Uso:
--   <leader>ul  o  :LspToggle    (también :LspOn / :LspOff)
--   NVIM_NO_LSP=1 nvim           arranca sin LSP (útil al clonar un repo ajeno)

local M = {}

-- Servidores registrados desde lua/plugins/lsp.lua
M.servers = {}

if vim.env.NVIM_NO_LSP == "1" then
  vim.g.lsp_disabled = true
end

--- @param on boolean
--- @param opts? { silent?: boolean }
function M.set(on, opts)
  opts = opts or {}
  vim.g.lsp_disabled = not on

  if #M.servers > 0 then
    -- enable(names, false) frena los clientes vivos y evita que arranquen
    -- en los próximos buffers; enable(names, true) los vuelve a levantar
    -- en los buffers ya abiertos.
    vim.lsp.enable(M.servers, on)

    if on then
      -- enable() solo re-procesa los buffers abiertos si ya pasó VimEnter;
      -- se lo pedimos a mano para que el LSP vuelva sin tener que recargar.
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
          pcall(vim.api.nvim_exec_autocmds, "FileType", { buffer = buf, group = "nvim.lsp.enable" })
        end
      end
    end
  end

  vim.diagnostic.enable(on)

  if not opts.silent then
    vim.notify("LSP " .. (on and "ON" or "OFF"), vim.log.levels.INFO)
  end
end

function M.toggle()
  M.set(vim.g.lsp_disabled == true)
end

--- Lo llama lua/plugins/lsp.lua con la lista de servidores configurados.
--- @param servers string[]
function M.register(servers)
  M.servers = servers
  M.set(not vim.g.lsp_disabled, { silent = true })
end

vim.api.nvim_create_user_command("LspToggle", function(opts)
  local arg = opts.args
  if arg == "on" then
    M.set(true)
  elseif arg == "off" then
    M.set(false)
  else
    M.toggle()
  end
end, {
  nargs = "?",
  complete = function()
    return { "on", "off" }
  end,
  desc = "Prender/apagar el LSP globalmente",
})

vim.api.nvim_create_user_command("LspOn", function()
  M.set(true)
end, { desc = "Prender el LSP globalmente" })

vim.api.nvim_create_user_command("LspOff", function()
  M.set(false)
end, { desc = "Apagar el LSP globalmente" })

return M
