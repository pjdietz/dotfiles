local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  return
end

telescope.setup()
telescope.load_extension 'file_browser'
telescope.load_extension 'fzy_native'

local builtin = require('telescope.builtin')

-- Files and buffers
vim.keymap.set('n', '<Leader>fr', builtin.resume)
vim.keymap.set('n', '<Leader>ff', builtin.find_files)
vim.keymap.set('n', '<Leader>FF', function() builtin.find_files({ hidden = true }) end)
vim.keymap.set('n', '<Leader>fi', builtin.live_grep)
vim.keymap.set('n', '<Leader>fq', builtin.quickfix)
vim.keymap.set('n', '<Leader>fo', builtin.buffers)
vim.keymap.set('n', '<Leader>fb', '<CMD>Telescope file_browser<CR>')
-- Commands
vim.keymap.set('n', '<Leader>fc', builtin.commands)
-- Git
vim.keymap.set('n', '<Leader>fgs', builtin.git_status)
vim.keymap.set('n', '<Leader>fgc', builtin.git_commits)
vim.keymap.set('n', '<Leader>fgb', builtin.git_bcommits)
