require("zen-mode").setup {
  window = {
    backdrop = 0.90,
    width = 100
  },
  plugins = {
    -- tmux = { enabled = true }, -- disables the tmux statusline
    twilight = { enabled = false }
  },
  -- callback where you can add custom code when the Zen window opens
  on_open = function(win)
    vim.fn.system([[tmux set status off]])
  end,
  -- callback where you can add custom code when the Zen window closes
  on_close = function()
    vim.fn.system([[tmux set status on]])
  end,
}

vim.keymap.set("n", "<Leader>z", "<CMD>ZenMode<CR>")
