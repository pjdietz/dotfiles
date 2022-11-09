local material = require "material"
local colors = require "material.colors"

colors.main.darkorange = "#E2795B"
colors.editor.bg_alt2 = "#2C2C2C"
colors.editor.subtle = "#94A7B0"

vim.g.material_style = "darker"
-- vim.g.material_style = "lighter"

if vim.g.material_style == "lighter" then
  colors.editor.bg_alt2 = "#EEEEEE"
  colors.editor.subtle = colors.comments
end

local highlights = {
  Comment = { fg = colors.syntax.comments, italic = true },
  ColorColumn = { bg = colors.editor.bg_alt2 },
  CursorLine = { bg = colors.editor.bg_alt2 },
  ["@attribute"] = { fg = colors.main.green },
  ["@field"] = { fg = colors.editor.fg },
  ["@include"] = { fg = colors.main.darkblue },
  ["@keyword"] = { fg = colors.main.purple },
  ["@keyword.return"] = { fg = colors.main.purple },
  ["@method"] = { fg = colors.main.blue },
  ["@property"] = { fg = colors.editor.fg },
  ["@type"] = { fg = colors.main.white },
  ["@variable"] = { fg = colors.main.orange },
  ["@variable.builtin"] = { fg = colors.main.white },
  ["@user.dollar"] = { fg = colors.editor.fg },
}

if vim.g.material_style == "lighter" then
  highlights.TSType = { fg = colors.purple }
  highlights.TSVariableBuiltin = { fg = colors.yellow }
  highlights.UserDollar = { fg = colors.orange }
end

material.setup {
  custom_highlights = highlights,
  custom_colors = function (c)
    c.main.darkorange = colors.main.darkorange
    c.editor.bg_alt2 = colors.editor.bg_alt2
    c.editor.subtle = colors.editor.subtle
  end,
  plugins = {
    "gitsigns",
    "telescope"
  }
}

vim.cmd "colorscheme material"
