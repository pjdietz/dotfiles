local material = require "material"
local colors = require "material.colors"

colors.bg_alt2 = "#2C2C2C"
colors.subtle = "#94A7B0"

material.setup({
  custom_highlights = {
    Comment = { fg = colors.text, italic = true },
    ColorColumn = { bg = colors.bg_alt2 },
    CursorLine = { bg = colors.bg_alt2 },
    TSKeyword = { fg = colors.purple },
    TSMethod = { fg = colors.blue },
    TSProperty = { fg = colors.fg },
    TSType = { fg = colors.yellow },
    TSVariable = { fg = colors.orange },
    TSVariableBuiltin = { fg = colors.fg },
    UserDollar = { fg = colors.subtle },
  }
})

vim.g.material_style = "darker"
vim.cmd "colorscheme material"
