local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local branch = {
	'branch',
	icons_enabled = true,
	icon = '',
}

local diff = {
	'diff',
	colored = false,
	symbols = { added = '+', modified = '*', removed = '-' },
  cond = hide_in_width
}

local diagnostics = {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	sections = { 'error', 'warn' },
	symbols = { error = ' ', warn = ' ' },
	colored = false,
	update_in_insert = false,
	always_visible = true
}

lualine.setup({
	options = {
		icons_enabled = true,
		theme = 'material',
		component_separators = { left = '', right = '' },
		section_separators = { left = '', right = '' },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { 'mode' },
		lualine_b = { branch },
		lualine_c = { diff },
		lualine_x = { 'filetype', diagnostics, 'encoding' },
		lualine_y = { 'progress', 'location' },
		lualine_z = {}
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { 'filename' },
		lualine_x = { 'location' },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	extensions = {}
})
