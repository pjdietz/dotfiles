local colors = require('material.colors')

if vim.g.material_style == "darker" then
  colors.editor.bg_alt2 = "#2C2C2C"
  colors.editor.subtle = "#94A7B0"
else
  colors.editor.bg_alt2 = "#E7E7E8"
  colors.editor.subtle = colors.syntax.comments
end

local material = {}

material.normal = {
  a = { fg = colors.editor.bg, bg = colors.main.blue, gui = 'bold' },
  b = { fg = colors.title, bg = colors.editor.bg_alt2 },
  c = { fg = colors.editor.fg, bg = colors.editor.border }
}

material.insert = {
  a = { fg = colors.editor.bg, bg = colors.main.green, gui = 'bold' }
}

material.visual = {
  a = { fg = colors.editor.bg, bg = colors.main.purple, gui = 'bold' }
}

material.replace = {
  a = { fg = colors.editor.bg, bg = colors.main.red, gui = 'bold' }
}

material.command = {
  a = { fg = colors.editor.bg, bg = colors.main.yellow, gui = 'bold' }
}

material.inactive = {
  a = { fg = colors.editor.disabled, bg = colors.editor.bg },
  b = { fg = colors.editor.disabled, bg = colors.editor.bg },
  c = { fg = colors.editor.disabled, bg = colors.editor.bg }
}

return material
