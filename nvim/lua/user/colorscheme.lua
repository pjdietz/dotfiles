local material = require "material"
local colors = require "material.colors"

colors.darkorange = "#E2795B"
colors.bg_alt2 = "#2C2C2C"
colors.subtle = "#94A7B0"

vim.g.material_style = "darker"
-- vim.g.material_style = "lighter"

if vim.g.material_style == "lighter" then
  colors.bg_alt2 = "#EEEEEE"
  colors.subtle = colors.comments
end

local highlights = {
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

if vim.g.material_style == "lighter" then
  highlights.TSType = { fg = colors.purple }
  highlights.TSVariableBuiltin = { fg = colors.yellow }
  highlights.UserDollar = { fg = colors.orange }
end


material.setup {
  custom_highlights = highlights
}

vim.cmd "colorscheme material"
