vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

-- Y works like C and D
map('n', 'Y', 'y$')

-- Splits
map('n', '<Leader>|', '<C-w>v')
map('n', '<Leader>-', '<C-w>s')
-- Open a tmux vertical split if this is the only pane.
map('n', '<Leader>j', '<CMD>TmuxAutoPane<CR>')

-- Buffers
map('n', '<C-n>', '<CMD>bn<CR>')
map('n', '<C-p>', '<CMD>bp<CR>')
map('n', '<Leader>WW', '<CMD>bp|bd #<CR>')
map('n', '<Leader>WA', '<CMD>Neotree close<CR><CMD>bufdo bwipeout<CR>')

-- Keep cursor in place while navigating, joining.
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('n', 'J', 'mzJ`z')

-- Yank to clipboard
map({ 'n', 'v' }, '<Leader>y', '"+y')
map('n', '<Leader>Y', '"+Y', { remap = true })

-- Toggle invisibles
map('n', '<Leader>i', '<CMD>set list!<CR>')

-- Clean highlight
map('n', '<Leader><Esc>', '<CMD>nohl<CR>')

-- Git and merge
map('n', '<Leader>gh', '<CMD>diffget //2<CR>')
map('n', '<Leader>gl', '<CMD>diffget //3<CR>')

-- Move lines up or down
map('v', 'J', "<CMD>move '>+1<CR>gv=gv")
map('v', 'K', "<CMD>move '<-2<CR>gv=gv")

-- Indent and keep selection
map({ 'v', 'x' }, '<', '<gv')
map({ 'v', 'x' }, '>', '>gv')

-- Toggle rulers
local function toggle_column_guides()
  local default = { 80, 100 }
  local current = vim.inspect(vim.opt.colorcolumn:get())
  if current == "{}" then
    vim.opt.colorcolumn = default
  else
    vim.opt.colorcolumn = {}
  end
end
vim.keymap.set('n', '<Leader>cg', toggle_column_guides)

-- Reload init.lua and all user modules
local function reload()
  for name,_ in pairs(package.loaded) do
    if name:match('^user') then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end
vim.keymap.set('n', '<Leader>r', reload)
