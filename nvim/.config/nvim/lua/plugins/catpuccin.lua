return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function ()
    local catppuccin = require "catppuccin"
    catppuccin.setup {
      flavour = "mocha",
      transparent_background = true,
    }
    vim.cmd.colorscheme "catppuccin"
    vim.api.nvim_set_hl(0, "NoicePopup", { bg = "#313244" })
  end
}
