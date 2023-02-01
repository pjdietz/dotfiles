local tmux = require("user.tmux")

return {
  "folke/zen-mode.nvim",
  keys = {
    { "<Leader>z", "<CMD>ZenMode<CR>", { desc = "[Z]en mode" } }
  },
  config = {
    window = {
      backdrop = 0.90,
      width = 100
    },
    plugins = {
      -- tmux = { enabled = true }, -- disables the tmux statusline
      twilight = { enabled = false }
    },
    -- callback where you can add custom code when the Zen window opens
    on_open = function()
      tmux.zoom()
      tmux.hide_status()
    end,
    -- callback where you can add custom code when the Zen window closes
    on_close = function()
      tmux.show_status()
    end,
  }
}
