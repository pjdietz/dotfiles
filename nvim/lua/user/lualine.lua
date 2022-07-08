local status_ok, lualine = pcall(require, 'lualine')
if not status_ok then
  return
end

local colors = require('material.colors')

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

local buffers = {
  'buffers',
  show_filename_only = true,          -- Shows shortened relative path when set to false.
  hide_filename_extension = false,    -- Hide filename extension when set to true.
  show_modified_status = true,        -- Shows indicator when the buffer is modified.
  mode = 0, -- 0: Shows buffer name
  -- 1: Shows buffer index
  -- 2: Shows buffer name + buffer index
  -- 3: Shows buffer number
  -- 4: Shows buffer name + buffer number
  max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
  -- it can also be a function that returns
  -- the value of `max_length` dynamically.
  filetype_names = {
    TelescopePrompt = 'Telescope',
    dashboard = 'Dashboard',
    packer = 'Packer',
    fzf = 'FZF',
    alpha = 'Alpha'
  }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

  buffers_color = {
    active = { bg = colors.darkblue, fg = colors.bg },
    inactive = { bg = colors.border, fg = colors.fg }
  },

  symbols = {
    modified = ' ●',      -- Text to show when the buffer is modified
    alternate_file = '', -- Text to show to identify the alternate file
    directory =  '',     -- Text to show when the buffer is a directory
  }
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
    lualine_x = { 'filetype', diagnostics, 'encoding', 'fileformat', 'progress', 'location' },
    lualine_y = {},
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
  tabline = {
    lualine_a = { buffers }
  },
  extensions = {}
})
