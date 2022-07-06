local status_ok, material = pcall(require, 'material')
if not status_ok then
	return
end

local colors = require('material.colors')

material.setup({
  custom_highlights = {
    Comment = {
      fg = colors.text,
      italic = true
    }
  }
})

vim.g.material_style = 'darker'
vim.cmd 'colorscheme material'
