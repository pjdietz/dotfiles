vim.wo.wrap = true
vim.wo.linebreak = true
vim.opt.colorcolumn = {}

vim.keymap.set("n", "<C-j>", [[/^##\+ .*<CR>:nohlsearch<CR>]], { desc = "Next Header", buffer = true, silent = true })
vim.keymap.set("n", "<C-k>", [[?^##\+ .*<CR>:nohlsearch<CR>]], { desc = "Previous Header", buffer = true, silent = true })
