return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function ()
    local catppuccin = require "catppuccin"
    catppuccin.setup {
      flavour = "mocha"
    }
    vim.cmd.colorscheme "catppuccin"
  end
}
