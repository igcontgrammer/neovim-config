-- Go: gopls (lsp.lua), goimports (conform.lua), parsers (treesitter.lua),
-- neotest-golang (python.lua neotest spec). This file adds the debugger
-- and Go-specific keymaps.
return {
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      delve = {
        -- Delve installed by Mason (see lsp.lua ensure_installed)
        path = vim.fn.stdpath("data") .. "/mason/bin/dlv",
      },
    },
    config = function(_, opts)
      require("dap-go").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("go-keymaps", { clear = true }),
        pattern = "go",
        callback = function(event)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = event.buf, desc = "Go: " .. desc })
          end

          map("<leader>dT", function()
            require("dap-go").debug_test()
          end, "Debug nearest test")
          map("<leader>dL", function()
            require("dap-go").debug_last_test()
          end, "Debug last test")
          map("<leader>Gt", "<cmd>!go mod tidy<cr>", "go mod tidy")
          map("<leader>Gr", "<cmd>split | terminal go run .<cr>", "go run .")
          map("<leader>Gh", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
          end, "Toggle inlay hints")
          map("<leader>Gl", vim.lsp.codelens.run, "Run code lens")
        end,
      })

      -- ft-lazy loading: the first Go buffer's FileType already fired.
      vim.api.nvim_exec_autocmds("FileType", { group = "go-keymaps", buffer = 0 })
    end,
  },
}
