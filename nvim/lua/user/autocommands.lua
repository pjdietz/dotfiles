vim.cmd [[
  augroup CUSTOM
    autocmd!
    " Remove trailing whitepace on save.
    autocmd BufWritePre * %s/\s\+$//e
    " Use // for commenting out lines in PHP
    autocmd FileType php setlocal commentstring=//\ %s
    " 2-spaces for certain file types
    autocmd FileType lua SetTab 2
    autocmd FileType org SetTab 2
    autocmd FileType sh SetTab 2
    autocmd FileType yaml SetTab 2
    autocmd FileType zsh SetTab 2
    " Soft-wrap Markdown
    autocmd FileType markdown setlocal wrap linebreak
    " Go templates as text by default
    autocmd BufRead,BufNewFile *.tmpl set filetype=gotexttmpl
    " Disable diagnostics for env files
    autocmd BufEnter .env lua vim.diagnostic.disable(0)
  augroup end
]]
