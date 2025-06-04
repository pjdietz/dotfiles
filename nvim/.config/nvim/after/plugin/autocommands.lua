local api = vim.api
local group = api.nvim_create_augroup("USER", { clear = true })

-- Remove trailing whitepace on save.
api.nvim_create_autocmd("BufWritePre", {
  command = "%s/\\s\\+$//e",
  group = group
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
    pattern = { ".env", "*.env", ".env.*" },
    group = group,
    callback = function ()
      vim.diagnostic.enable(false)
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

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.html.tmpl",
    group = group,
    callback = function ()
       vim.bo.filetype = "gohtmltmpl"
    end
})

-- Use markdown as ft instead of vimwiki
api.nvim_create_autocmd("FileType", {
  pattern = { "vimwiki" },
  group = group,
  callback = function ()
     vim.bo.filetype = "markdown"
  end
})

-- Close "No Name" buffers
api.nvim_create_autocmd("BufDelete", {
    group = group,
    callback = function ()
      require("user.buffers").delete_noname_buffers()
    end
})
