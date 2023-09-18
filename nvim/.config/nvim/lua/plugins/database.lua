return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = "~/projects/arc/db"

    vim.api.nvim_set_hl(0, "NotificationInfo", { bg="#1e1e2e", fg="#a6e3a1" })
    vim.api.nvim_set_hl(0, "NotificationWarning", { bg="#1e1e2e", fg="#f9e2af" })
    vim.api.nvim_set_hl(0, "NotificationError", { bg="#1e1e2e", fg="#f38ba8" })

  end,
  keys = {
    { "<Leader>db", "<CMD>DBUIToggle<CR>", { desc = "[D]BUI Toggle" } }
  },
  config = function()
    require("user.dadbod").setup()
  end,
}
