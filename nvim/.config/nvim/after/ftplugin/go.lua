local go_constructor = require("user.go_constructor")

vim.api.nvim_buf_create_user_command(
  0,
  "GoConstructor",
  go_constructor.generate_constructor,
  {
    desc = "Generate Go constructor function",
  }
)

vim.keymap.set("n", "<Leader>gc", ":GoConstructor<CR>", {
  desc = "[G]o [C]onstructor",
  silent = true,
  buffer = 0,
})
