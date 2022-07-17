local api = vim.api
local group = api.nvim_create_augroup("USER", { clear = true })

-- Remove trailing whitepace on save.
api.nvim_create_autocmd("BufWritePre", {
  command = "%s/\\s\\+$//e",
  group = group
})

-- Use // for line comments in PHP.
api.nvim_create_autocmd("FileType", {
  pattern = "php",
  callback = function ()
    vim.opt_local.commentstring = '// %s'
  end
})

-- Use 2 spaces for these file types.
api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "markdown", "sh", "yaml", "zsh" },
  group = group,
  callback = function ()
    require("user.settab").settab(2)
  end
})

-- Disable diagnostics for .env files.
api.nvim_create_autocmd("BufEnter", {
    pattern = { ".env", "*.env" },
    group = group,
    callback = function ()
      vim.diagnostic.disable(0)
    end
})

-- Go templates are text by default.
api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.tmpl",
    group = group,
    callback = function ()
       vim.bo.filetype = "gotexttmpl"
    end
})
