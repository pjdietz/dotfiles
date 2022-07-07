vim.cmd [[
  " Set consistent tab size with arg and expand tabs to spaces
  command! -nargs=1 SetTab :setlocal tabstop=<args> shiftwidth=<args> softtabstop=<args> expandtab
]]
