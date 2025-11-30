require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.commands")
require("config.lsp")

local convert = require("user.conversion")
local go_constructor = require("user.go_constructor")

vim.api.nvim_create_user_command(
  "Convert",
  convert.select,
  {
    desc = "Convert selection",
    range = true,
  }
)

vim.api.nvim_create_user_command(
  "GoConstructor",
  go_constructor.generate_constructor,
  {
    desc = "Generate Go constructor function",
  }
)

vim.keymap.set({ "n", "v" }, "<Leader>ct", ":Convert<CR>", {
  desc = "[C]onvert [T]ext",
  silent = true,
})
