local colors = require('material.colors')
colors.bg_alt2 = '#2C2C2C'

local material = {}

material.normal = {
  a = { fg = colors.bg, bg = colors.blue, gui = 'bold' },
  b = { fg = colors.title, bg = colors.bg_alt2 },
  c = { fg = colors.fg, bg = colors.border }
}

material.insert = {
  a = { fg = colors.bg, bg = colors.green, gui = 'bold' }
}

material.visual = {
  a = { fg = colors.bg, bg = colors.purple, gui = 'bold' }
}

material.replace = {
  a = { fg = colors.bg, bg = colors.red, gui = 'bold' }
}

material.command = {
  a = { fg = colors.bg, bg = colors.yellow, gui = 'bold' }
}

material.inactive = {
  a = { fg = colors.disabled, bg = colors.bg },
  b = { fg = colors.disabled, bg = colors.bg },
  c = { fg = colors.disabled, bg = colors.bg }
}

return material
