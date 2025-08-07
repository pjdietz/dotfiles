return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function ()
    require("catppuccin").setup {
      flavour = "mocha",
      transparent_background = true,
      custom_highlights = function(colors)
        return {
          FloatBorder = { fg = colors.surface2 },
          LightFloat = { bg = colors.surface0 },
          WhichKeyNormal = { bg = colors.surface0 },
          TelescopeBorder = { fg = colors.surface2 },
          TelescopeNormal = { bg = colors.backround0 },
          TelescopeTitle = { bg = colors.backround0 },
          NoiceCmdlinePopupBorderCmdline = { fg = colors.surface2 },
        }
      end,
      integrations = {
        telescope = true,
      }
    }

    vim.cmd.colorscheme "catppuccin"

  end
}
