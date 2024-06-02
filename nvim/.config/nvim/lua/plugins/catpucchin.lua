return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function ()
    local catppuccin = require "catppuccin"
    catppuccin.setup {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        lsp_trouble = true
      }
    }
    vim.cmd.colorscheme "catppuccin"
  end
}
