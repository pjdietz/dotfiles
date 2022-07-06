local status_ok, material = pcall(require, 'material')
if not status_ok then
	return
end

vim.g.material_style = 'darker'
vim.cmd 'colorscheme material'
