return {
  "MeanderingProgrammer/render-markdown.nvim",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim", -- if you use the mini.nvim suite
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    -- Pasar de "preview" (renderizado) a markdown crudo y volver, solo en este buffer.
    { "<leader>mm", "<cmd>RenderMarkdown buf_toggle<cr>", desc = "Markdown: toggle render/raw" },
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- No des-renderizar la linea del cursor: la vista no se mueve al scrollear.
    -- Poner `disabled_modes = { "n" }` en vez de `enabled = false` si preferis
    -- ver el markdown crudo solo al editar (modo insert).
    anti_conceal = {
      enabled = false,
    },
    heading = {
      enabled = true,
      sign = true,
      icons = { "① ", "② ", "③ ", "④ ", "⑤ ", "⑥ " },
      left_pad = 1,
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      right_pad = 1,
      highlight = "render-markdownBullet",
    },
  },
}
