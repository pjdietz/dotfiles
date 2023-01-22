-- Use // for line comments in PHP.
vim.opt_local.commentstring = '// %s'

local group = vim.api.nvim_create_augroup("USER-PHP", { clear = true })

local function config_file_present()
   return (vim.fn.filereadable(".php-cs-fixer.dist.php") == 1) or
      (vim.fn.filereadable(".php-cs-fixer.php") == 1)
end

local function fix_cs_cmd(opts)
   if config_file_present() then
      vim.cmd([[silent! !php-cs-fixer fix ]] .. opts.file)
   end
end

vim.api.nvim_create_autocmd("BufWritePost", {
   desc = "Run php-cs-fixer after saving",
   callback = fix_cs_cmd,
   buffer = 0,
   group = group
})
