return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-live-grep-args.nvim",
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fa", "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "Find all files" },
      { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Git commits" },
      { "<leader>fs", "<cmd>Telescope git_status<cr>", desc = "Git status" },
      { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Resume last search" },
      { "<leader>fu", "<cmd>Telescope undo<cr>", desc = "Undo history" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
      { "<leader>l", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document symbols" },
      { "<leader>ll", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace symbols" },
      {
        "<leader>fG",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Grep with args",
      },
      {
        "<leader>fW",
        function()
          require("telescope.builtin").grep_string({ word_match = "-w" })
        end,
        desc = "Grep word under cursor",
      },
    },
    opts = function(_, opts)
      local lga_actions = require("telescope-live-grep-args.actions")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
        },
      })

      opts.extensions = opts.extensions or {}
      opts.extensions.fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
      opts.extensions.live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
          },
        },
      }
      opts.extensions.undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = { preview_height = 0.8 },
      }

      return opts
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
      telescope.load_extension("undo")
    end,
  },
}
