return {
  "3rd/diagram.nvim",
  dependencies = {
    {
      "3rd/image.nvim",
      build = false,
      opts = {
        processor = "magick_cli",
        -- Por defecto image.nvim limita la altura al 50% de la ventana, lo que
        -- achica los diagramas anchos. Dejamos que usen la ventana completa.
        max_width_window_percentage = 100,
        max_height_window_percentage = 100,
      },
    },
  },
  keys = {
    -- Ver el diagrama bajo el cursor en una ventana flotante grande.
    { "<leader>md", function() require("diagram").show_diagram_hover() end, desc = "Diagram: ver en flotante" },
  },
  opts = { -- you can just pass {}, defaults below
    events = {
      render_buffer = { "InsertLeave", "BufWinEnter", "TextChanged" },
      clear_buffer = { "BufLeave" },
    },
    renderer_options = {
      mermaid = {
        background = nil, -- nil | "transparent" | "white" | "#hex"
        theme = nil, -- nil | "default" | "dark" | "forest" | "neutral"
        -- mmdc rinde a 784px de ancho con scale=1: se ve chico en terminales
        -- anchos. scale=4 -> ~3100px, image.nvim lo baja al ancho de ventana.
        scale = 4,
        width = nil, -- nil | 800 | 400 | ...
        height = nil, -- nil | 600 | 300 | ...
        cli_args = nil, -- nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
      },
      plantuml = {
        charset = nil,
        cli_args = nil, -- nil | { "-Djava.awt.headless=true" } | ...
      },
      d2 = {
        theme_id = nil,
        dark_theme_id = nil,
        scale = nil,
        layout = nil,
        sketch = nil,
        cli_args = nil, -- nil | { "--pad", "0" } | ...
      },
      gnuplot = {
        size = nil, -- nil | "800,600" | ...
        font = nil, -- nil | "Arial,12" | ...
        theme = nil, -- nil | "light" | "dark" | custom theme string
        cli_args = nil, -- nil | { "-p" } | { "-c", "config.plt" } | ...
      },
    },
  },
}
