local configs = require("nvim-treesitter.configs")

require("nvim-treesitter.highlight").set_custom_captures {
  ["user.dollar"] = "UserDollar"
}

configs.setup({
  ensure_installed = "all",
  sync_install = false,
  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  }
})

