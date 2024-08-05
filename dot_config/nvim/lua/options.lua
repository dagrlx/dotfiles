-- lua/options.lua

-- Configuraciones generales de Neovim
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.wrap = true                 -- Hace que el texto de las líneas largas (las que sobrepasan el ancho de la pantalla) siempre esté visible.
vim.opt.breakindent = true          -- Conserva la indentación de las líneas que sólo son visibles cuando wrap es true
vim.opt.textwidth = 80
vim.opt.tabstop = 4                 -- La cantidad de carácteres que ocupa Tab. El valor por defecto es 8. Yo prefiero 2.
vim.opt.shiftwidth = 4              -- El espacio que Neovim usará para indentar una línea (en consonancia con tabstop)
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.iskeyword:append('-')
vim.opt.syntax = 'enable'
vim.opt.mouse = 'a'                 -- Se activa todos los modos de mouse

-- Activar la statusline
vim.opt.laststatus = 2

-- Configuración básica de la statusline
vim.opt.statusline = "%f %y %m %r %= %-14.(%l,%c%V%) %P"

 -- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

