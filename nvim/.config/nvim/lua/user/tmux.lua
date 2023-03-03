local M = {}

function M.show_status()
  vim.fn.system([[tmux set status on]])
end

function M.hide_status()
  vim.fn.system([[tmux set status off]])
end

function M.zoom()
  if M.is_zoomed() then return end
  vim.fn.system([[tmux resize-pane -Z]])
end

function M.is_zoomed()
  -- Check for the zoom flag
  vim.fn.system([[tmux list-panes -F '#F' | grep -q Z]])
  return vim.v.shell_error == 0
end

function M.get_session_name()
  local name = vim.fn.system([[tmux display-message -p '#S']])
  return (name:gsub("^%s*(.-)%s*$", "%1"))
end

return M
