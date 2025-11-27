local M = {}
local tmux_util = require("user.tmux")

M.cmd = "opencode"
M.window_name = "opencode"

function M:get_current_session()
  if not tmux_util.active() then
    return nil
  end
  return tmux_util.get_session_name()
end

function M:get_window_id()
  if not tmux_util.active() then
    return nil
  end

  -- Find window named "opencode" in current session
  local cmd = string.format(
    "tmux list-windows -t '%s' -F '#{window_id} #{window_name}' | grep ' %s$' | awk '{print $1}'",
    self:get_current_session(),
    self.window_name
  )
  local result = vim.fn.system(cmd)
  local window_id = result:match("^@%d+")

  return window_id
end

function M:start()
  if not tmux_util.active() then
    vim.notify("Not running in tmux", vim.log.levels.WARN, { title = "opencode" })
    return
  end

  -- Check if window already exists
  local existing_window = self:get_window_id()
  if existing_window then
    -- Window exists, nothing to do
    return
  end

  -- Create new window with the opencode name
  local session = self:get_current_session()
  local cmd = string.format(
    "tmux new-window -t '%s' -n '%s' -d '%s'",
    session,
    self.window_name,
    self.cmd
  )
  vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to create opencode window", vim.log.levels.ERROR, { title = "opencode" })
  end
end

function M:stop()
  -- No-op: Never close the opencode window
  -- Users should manually close the window if desired
end

function M:show()
  local window_id = self:get_window_id()
  if window_id then
    -- Select the window to bring it into view
    vim.fn.system(string.format("tmux select-window -t '%s'", window_id))
  else
    -- No window exists, start it first
    self:start()
  end
end

-- No-op for toggle since we're skipping it
function M:toggle()
  self:show()
end

return M
