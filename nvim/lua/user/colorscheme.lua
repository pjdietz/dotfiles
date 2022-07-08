local status_ok, material = pcall(require, 'material')
if not status_ok then
	return
end

local colors = require('material.colors')
colors.bg_alt2 = '#2C2C2C'

material.setup({
  custom_highlights = {
    Comment = {
      fg = colors.text,
      italic = true
    },
    ColorColumn = {
      bg = colors.bg_alt2
    },
    CursorLine = {
      bg = colors.bg_alt2
    }
  }
})

vim.g.material_style = 'darker'
vim.cmd 'colorscheme material'
