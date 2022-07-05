local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup()
telescope.load_extension 'file_browser'

local builtin = require('telescope.builtin')

-- Files and buffers
vim.keymap.set('n', '<leader>fr', builtin.resume)
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>FF', function() builtin.find_files({ hidden = true }) end)
vim.keymap.set('n', '<leader>fi', builtin.live_grep)
vim.keymap.set('n', '<leader>fq', builtin.quickfix)
vim.keymap.set('n', '<leader>fo', builtin.buffers)
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope file_browser<cr>')
-- Commands
vim.keymap.set('n', '<leader>fc', builtin.commands)
-- Git
vim.keymap.set('n', '<leader>fgs', builtin.git_status)
vim.keymap.set('n', '<leader>fgc', builtin.git_commits)
vim.keymap.set('n', '<leader>fgb', builtin.git_bcommits)
