require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.commands")
require("config.lsp")

local convert = require("user.conversion")

vim.api.nvim_create_user_command(
  "Convert",
  convert.select,
  {
    desc = "Convert selection",
    range = true,
  }
)

vim.keymap.set({ "n", "v" }, "<Leader>ct", convert.select, { desc = "[C]onvert [T]ext" })
