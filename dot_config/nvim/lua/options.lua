-- lua/options.lua

local opt = vim.opt 

-- Configuraciones generales de Neovim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true           -- Resalta la línea donde está el cursor
vim.opt.cursorcolumn = true
vim.opt.wrap = true                 -- Hace que el texto de las líneas largas (las que sobrepasan el ancho de la pantalla) siempre esté visible.
vim.opt.breakindent = true          -- Conserva la indentación de las líneas que sólo son visibles cuando wrap es true
vim.opt.textwidth = 80
-- tabs & indentation
vim.opt.tabstop = 4                 -- La cantidad de carácteres que ocupa Tab. El valor por defecto es 8.
vim.opt.shiftwidth = 4              -- El espacio que Neovim usará para indentar una línea (en consonancia con tabstop)
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.iskeyword:append('-')       -- añade el carácter - a la lista de caracteres que Neovim considera como parte de una palabra.
vim.opt.syntax = 'enable'
vim.opt.mouse = 'a'                 -- Se activa todos los modos de mouse

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Activar la statusline
vim.opt.laststatus = 2

-- Configuración básica de la statusline
vim.opt.statusline = "%f %y %m %r %= %-14.(%l,%c%V%) %P"

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register
