return {
  -- Debugger: nvim-dap + UI + adaptador de Python (debugpy)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          -- Usa el debugpy instalado por Mason
          local debugpy = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
          require("dap-python").setup(debugpy)
        end,
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "DAP: Continue" },
      { "<leader>di", function() require("dap").step_into() end, desc = "DAP: Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "DAP: Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "DAP: Step Out" },
      { "<leader>dr", function() require("dap").repl.open() end, desc = "DAP: Open REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "DAP: Toggle UI" },
      { "<leader>dT", function() require("dap-python").test_method() end, desc = "DAP: Test Method (Python)" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      -- Abre/cierra la UI automáticamente con la sesión de debug
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
    end,
  },

  -- Test runner: neotest + pytest
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Test: Run nearest" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test: Run file" },
      { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end, desc = "Test: Debug nearest" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Test: Toggle summary" },
      { "<leader>to", function() require("neotest").output.open({ enter = true }) end, desc = "Test: Show output" },
      { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Test: Toggle output panel" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Test: Stop" },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            dap = { justMyCode = false },
            runner = "pytest",
          }),
        },
      })
    end,
  },

  -- Selector de virtualenv (detecta .venv/poetry/pipenv y lo aplica a pyright + debugpy)
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap-python",
      "nvim-telescope/telescope.nvim",
    },
    ft = "python",
    keys = {
      { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Venv: Select" },
    },
    opts = {},
  },
}
