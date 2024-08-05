-- lua/mappings.lua

-- Mapeos de teclas
vim.g.mapleader = ","
vim.api.nvim_set_keymap('n', '<F7>', ':e.<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F9>', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : "<Tab>"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<CR>', 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>Files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>RG<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-b>', '<cmd>Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-h>', '<cmd>Helptags<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<A-¡>", "<cmd>vsplit<CR>", { desc = "Split vertically" })
vim.keymap.set("n", "<A-->", "<cmd>split<CR>", { desc = "Split horizontally" })
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>NvimTreeToggle<CR>', { noremap = true, silent = true })

--- Telescope ---
vim.api.nvim_set_keymap('n', '<leader>ff', ":lua require('telescope.builtin').find_files({ cwd = vim.fn.input('Directorio de búsqueda: ', '', 'dir') })<CR>", { noremap = true, silent = true })

--- OIL ---
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


