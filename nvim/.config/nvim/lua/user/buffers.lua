local M = {}

function M.delete_noname_buffers()
  local curbufno = vim.api.nvim_get_current_buf()
  local buflist = vim.api.nvim_list_bufs()
  for _, bufno in ipairs(buflist) do
    local noname = vim.api.nvim_buf_get_name(bufno) == ""
    local listed = vim.bo[bufno].buflisted
    local modifiable = vim.api.nvim_get_option_value("modifiable", { buf = bufno })
    local modified = vim.api.nvim_get_option_value("modified", { buf = bufno })
    if noname and listed and bufno ~= curbufno and modifiable and not modified then
      vim.cmd("bd " .. tostring(bufno))
    end
  end
end

return M
