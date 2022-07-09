local material = require "material"
local colors = require "material.colors"

colors.bg_alt2 = "#2C2C2C"
colors.subtle = "#94A7B0"
colors.darkorange = "#E2795B"

material.setup {
  custom_highlights = {
    Comment = { fg = colors.text, italic = true },
    ColorColumn = { bg = colors.bg_alt2 },
    CursorLine = { bg = colors.bg_alt2 },
    TSAttribute = { fg = colors.green },
    TSInclude = { fg = colors.darkblue },
    TSKeyword = { fg = colors.purple },
    TSKeywordReturn = { fg = colors.purple },
    TSMethod = { fg = colors.blue },
    TSProperty = { fg = colors.fg },
    TSType = { fg = colors.white },
    TSVariable = { fg = colors.orange },
    TSVariableBuiltin = { fg = colors.white },
    UserDollar = { fg = colors.fg },
  }
}

vim.g.material_style = "darker"
vim.cmd "colorscheme material"
