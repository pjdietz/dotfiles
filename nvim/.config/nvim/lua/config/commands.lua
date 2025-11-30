vim.cmd [[
  " Set consistent tab size with arg and expand tabs to spaces
  command! -nargs=1 SetTab :setlocal tabstop=<args> shiftwidth=<args> softtabstop=<args> expandtab
]]

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
