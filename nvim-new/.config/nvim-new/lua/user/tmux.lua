local M = {}

function M.active()
  return os.getenv("TMUX") and M.running()
end

function M.running()
  vim.fn.system([[pgrep tmux]])
  return vim.v.shell_error == 0
end

function M.show_status()
  if not M.active() then return end
  vim.fn.system([[tmux set status on]])
end

function M.hide_status()
  if not M.active() then return end
  vim.fn.system([[tmux set status off]])
end

function M.zoom()
  if M.is_zoomed() then return end
  vim.fn.system([[tmux resize-pane -Z]])
end

function M.is_zoomed()
  if not M.active() then return end
  -- Check for the zoom flag
  vim.fn.system([[tmux list-panes -F '#F' | grep -q Z]])
  return vim.v.shell_error == 0
end

function M.get_session_name()
  if not M.active() then return "" end
  local name = vim.fn.system([[tmux display-message -p '#S']])
  return (name:gsub("^%s*(.-)%s*$", "%1"))
end

return M
