# Configuración de Neovim con LazyVim

Configuración personalizada de Neovim usando LazyVim como base, con todos los plugins, mappings, snippets y formatters de la configuración anterior de NvChad.

## Estructura

```
~/.config/nvim/
├── init.lua                          # Bootstrap de lazy.nvim
├── lua/
│   ├── config/
│   │   ├── autocmds.lua             # Autocmds personalizados
│   │   ├── keymaps.lua              # Todos los keymaps
│   │   └── options.lua              # Opciones de vim
│   └── plugins/
│       ├── coding.lua               # Plugins de coding (autopairs, surround, etc.)
│       ├── conform.lua              # Formatters con conform.nvim
│       ├── git.lua                  # Neogit y Diffview
│       ├── lsp.lua                  # LSP servers
│       ├── navigation.lua           # Harpoon y vim-tmux-navigator
│       ├── nvim-tree.lua            # Explorador de archivos
│       ├── productivity.lua         # Trouble, todo-comments, spectre, etc.
│       ├── snippets.lua             # Snippets de LuaSnip (Python, TS)
│       ├── telescope.lua            # Telescope + extensiones
│       ├── treesitter.lua           # Treesitter
│       └── ui.lua                   # Plugins de UI
├── .gitignore
└── README.md
```

## Plugins Incluidos

### Core
- **lazy.nvim** - Plugin manager
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** - LSP configuration
- **nvim-cmp** - Autocompletado
- **LuaSnip** - Snippets

### Telescope & Búsqueda
- **telescope.nvim** - Fuzzy finder
- **telescope-fzf-native** - FZF sorter
- **telescope-live-grep-args** - Live grep con argumentos
- **telescope-undo** - Historial de undo
- **nvim-spectre** - Buscar y reemplazar en proyecto

### Git
- **neogit** - Interface de git
- **diffview.nvim** - Diff viewer
- **gitsigns.nvim** - Git signs

### Navegación
- **harpoon** - Navegación rápida entre archivos
- **vim-tmux-navigator** - Navegación entre vim y tmux
- **nvim-tree** - Explorador de archivos
- **flash.nvim** - Saltos rápidos

### Productividad
- **trouble.nvim** - Lista de diagnósticos
- **todo-comments.nvim** - Highlight de TODOs
- **persistence.nvim** - Sesiones
- **nvterm** - Terminal integrado

### Coding
- **nvim-autopairs** - Auto-pairs
- **nvim-surround** - Surround
- **Comment.nvim** - Comentarios
- **vim-visual-multi** - Multi-cursor
- **nvim-ts-autotag** - Auto-close HTML tags

### Formatters & Linters
- **conform.nvim** - Formatters unificados
- **mason.nvim** - Instalador de LSP/formatters

### UI
- **dressing.nvim** - Mejoras de UI
- **indent-blankline** - Guías de indentación
- **render-markdown** - Renderizar markdown
- **markdown-preview** - Preview de markdown

## LSP Servers Configurados

- **html** - HTML
- **cssls** - CSS
- **ts_ls** - TypeScript/JavaScript
- **pyright** - Python
- **omnisharp** - C#
- **rust_analyzer** - Rust
- **zls** - Zig
- **clangd** - C/C++

## Formatters Configurados

- **Python**: ruff_format, ruff_fix
- **JavaScript/TypeScript**: prettier
- **Web** (HTML, CSS, JSON, YAML): prettier
- **C#**: csharpier
- **Go**: gofmt, goimports
- **Rust**: rustfmt
- **Lua**: stylua
- **Shell**: shfmt
- **SQL**: sql_formatter
- **C/C++**: clang_format
- Y más...

## Keymaps Principales

### Telescope
- `<leader>ff` - Find files
- `<leader><space>` - Find files
- `<leader>fw` - Live grep
- `<leader>fg` - Live grep con args
- `<leader>fb` - Buffers
- `<leader>fo` - Recent files
- `<leader>fu` - Undo history
- `<leader>fd` - Diagnostics

### Git
- `<leader>gg` - Neogit
- `<leader>gd` - Diff view
- `<leader>gh` - File history
- `<leader>gp` - Preview hunk
- `<leader>gb` - Blame line
- `<leader>gs` - Stage hunk
- `]h` / `[h]` - Next/prev hunk

### Harpoon
- `<leader>ha` - Add file
- `<leader>hh` - Toggle menu
- `<leader>1-4` - Go to file 1-4
- `<leader>hp` / `<leader>hn` - Prev/next

### Utilidades
- `<leader>sr` - Spectre (search & replace)
- `<leader>xx` - Trouble diagnostics
- `<leader>te` - Toggle terminal
- `<leader>e` - NvimTree find file
- `<leader>ca` - Code action
- `<leader>rn` - Rename symbol
- `<C-s>` - Save

### Edición
- `J` / `K` (visual) - Move lines up/down
- `<leader>p` (visual) - Paste without yanking
- `<leader>y` - Yank to clipboard
- `<leader>d` - Delete without yank
- `s` - Flash jump
- `S` - Flash treesitter

## Snippets

### Python
- `todo` - TODO comment
- `fixme` - FIXME comment
- `note` - NOTE comment
- `main` - Main function
- `def` - Function with docstring
- `class` - Class with docstring
- `try` - Try-except block
- `pf` - Print f-string
- `from` - Import from
- `sepa` - Separator

### TypeScript
- `todo` - TODO comment

## Instalación y Verificación

### Primera vez
1. Abre Neovim: `nvim`
2. Lazy.nvim instalará automáticamente todos los plugins
3. Espera a que termine la instalación

### Comandos de verificación

```vim
:Lazy           " Ver estado de plugins
:LspInfo        " Ver LSP servers activos
:ConformInfo    " Ver formatters disponibles
:TSInstallInfo  " Ver parsers de Treesitter
:Mason          " Ver LSP/formatters instalados
:checkhealth    " Verificar salud de Neovim
```

### Instalar formatters adicionales

```vim
:Mason
```
Busca e instala: prettier, stylua, shfmt, ruff, csharpier, etc.

## Notas

- **Auto-formato**: Activado al guardar para la mayoría de archivos (excepto C/C++)
- **Tema**: Usa el tema por defecto de vim (habamax). Puedes cambiarlo instalando tu tema favorito
- **Sesiones**: `<leader>s` para restaurar la última sesión
- **Terminal**: `<leader>te` para abrir terminal vertical

## Desactivar auto-formato

```vim
:let g:disable_autoformat = 1        " Globalmente
:let b:disable_autoformat = 1        " Solo este buffer
```

## Troubleshooting

Si algo no funciona:

1. Verifica la instalación: `:checkhealth`
2. Reinstala plugins: `:Lazy sync`
3. Reinstala LSP/formatters: `:Mason`
4. Actualiza Treesitter: `:TSUpdate`
5. Limpia y reinstala todo:
   ```bash
   rm -rf ~/.local/share/nvim
   rm -rf ~/.local/state/nvim
   rm -rf ~/.cache/nvim
   ```
   Luego abre Neovim de nuevo.

## Personalización

Para agregar más plugins, crea un nuevo archivo en `lua/plugins/` con el formato:

```lua
return {
  {
    "usuario/plugin",
    opts = {
      -- opciones
    },
  },
}
```

LazyVim cargará automáticamente todos los archivos en `lua/plugins/`.
