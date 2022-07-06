vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- Y works like C and D
map('n', 'Y', 'y$')

-- Splits
map('n', '<Leader>|', '<C-w>v')
map('n', '<Leader>-', '<C-w>s')
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Buffers
map('n', '<S-tab>', '<CMD>bn<CR>')
map('n', '<Leader><Tab>', '<CMD>bp|bd #<CR>')
map('n', '<Leader>ww', '<CMD>bufdo bwideout<CR>')

-- Toggle invisibles
map('n', '<Leader>i', '<CMD>set list!<CR>')

-- Clean highlight
map('n', '<Leader><Esc>', '<CMD>nohl<CR>')

-- Git and merge
map('n', '<Leader>gh', '<CMD>diffget //2<CR>')
map('n', '<Leader>gl', '<CMD>diffget //3<CR>')

-- Move lines up or down
map('x', 'K', "<CMD>move '<-2<CR>gv-gv")
map('x', 'J', "<CMD>move '>+1<CR>gv-gv")

-- Indent and keep selection
map({'v', 'x'}, '<', '<gv')
map({'v', 'x'}, '>', '>gv')
