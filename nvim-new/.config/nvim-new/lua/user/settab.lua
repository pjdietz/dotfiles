local M = {}

function M.settab(width)
  vim.opt_local.tabstop = width
  vim.opt_local.shiftwidth = width
end

return M
