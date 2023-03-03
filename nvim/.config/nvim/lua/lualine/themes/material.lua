local colors = require('material.colors')

local material = {}

material.normal = {
  a = { bg = colors.editor.bg, fg = colors.main.blue, gui = "bold" },
  b = { fg = colors.title, bg = colors.editor.bg },
  c = { fg = colors.editor.fg, bg = colors.editor.bg }
}

material.insert = {
  a = { bg = colors.editor.bg, fg = colors.main.green, gui = "bold" }
}

material.visual = {
  a = { bg = colors.editor.bg, fg = colors.main.purple, gui = "bold" }
}

material.replace = {
  a = { bg = colors.editor.bg, fg = colors.main.red, gui = "bold" }
}

material.command = {
  a = { bg = colors.editor.bg, fg = colors.main.yellow, gui = "bold" }
}

material.inactive = {
  a = { fg = colors.editor.disabled, bg = colors.editor.bg },
  b = { fg = colors.editor.disabled, bg = colors.editor.bg },
  c = { fg = colors.editor.disabled, bg = colors.editor.bg }
}

return material
