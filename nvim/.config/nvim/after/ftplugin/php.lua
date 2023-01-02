-- Use // for line comments in PHP.
vim.opt_local.commentstring = '// %s'

local group = vim.api.nvim_create_augroup("USER-PHP", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
   desc = "Run php-cs-fixer after saving",
   command = "silent! !php-cs-fixer fix <afile>",
   group = group
})
