local M = {}

local function get_pane_count()
  local paneCount = io.popen("tmux list-panes | wc -l"):read()
  return tonumber(paneCount)
end

local function is_in_tmux()
  return os.getenv("TMUX") and io.popen("pgrep tmux")
end

local function open_pane()
  io.popen("tmux split-window -v")
end

M.autopane = function ()
  if not is_in_tmux() or get_pane_count() > 1 then
    return
  end
  open_pane()
end

vim.api.nvim_create_user_command('TmuxAutoPane', M.autopane, { nargs = 0 })

return M
