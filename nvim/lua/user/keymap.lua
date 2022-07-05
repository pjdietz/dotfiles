vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set
        
-- Y works like C and D
map('n', 'Y', 'y$')

-- Splits
map('n', '<leader>|', '<C-w>v')
map('n', '<leader>-', '<C-w>s')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Buffers
map('n', '<s-tab>', '<cmd>bn<cr>')
map('n', '<leader><tab>', '<cmd>bp|bd #<cr>')
map('n', '<leader>ww', '<cmd>bufdo bwideout<cr>')

-- Toggle invisibles
map('n', '<leader>i', ':set list!<cr>')

-- Git and merge
map('n', '<leader>gh', ':diffget //2<CR>')
map('n', '<leader>gl', ':diffget //3<CR>')

-- Move lines up or down
map('x', 'K', ":move '<-2<CR>gv-gv")
map('x', 'J', ":move '>+1<CR>gv-gv")

-- Indent and keep selection
map({'v', 'x'}, '<', '<gv')
map({'v', 'x'}, '>', '>gv')
