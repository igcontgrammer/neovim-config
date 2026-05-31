-- C# / .NET 10 — Roslyn LSP
--
-- The server binary is provided by Mason via the `github:Crashdummyy/mason-registry`
-- registry, which is already configured in plugins/lsp.lua.
--
-- We use roslyn.nvim instead of a plain `vim.lsp.config` entry because Roslyn does
-- NOT speak vanilla LSP: it needs solution/project bootstrapping and custom
-- notifications that roslyn.nvim handles for us.
return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      -- roslyn.nvim auto-detects the server installed by Mason.
    },
  },

  -- Treesitter parser for C#
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts) == "table" and type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "c_sharp" })
      end
    end,
  },

  -- Make sure Mason installs the Roslyn server
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "roslyn" })
      return opts
    end,
  },
}
