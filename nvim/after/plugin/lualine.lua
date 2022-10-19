local lualine = require "lualine"
local colors = require "material.colors"

local function hide_in_width()
  return vim.fn.winwidth(0) > 80
end

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = "+", modified = "~", removed = "-" },
  cond = hide_in_width
}

local filetype = {
  "filetype",
  icons_enabled = true,
  colored = false,
}

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  update_in_insert = false,
  always_visible = true
}

local function location()
  -- Display position as row/total : column
  -- Pad the row to match width of total rows and column to 3 digits
  local row, column = unpack(vim.api.nvim_win_get_cursor(0))
  local total_rows = vim.api.nvim_buf_line_count(0)
  local total_width = math.floor(math.log10(total_rows) + 2)
  return string.format("%" .. total_width .. "d/%d : %-3d", row, total_rows, column)
end

local buffers = {
  "buffers",
  show_filename_only = true,          -- Shows shortened relative path when set to false.
  hide_filename_extension = false,    -- Hide filename extension when set to true.
  show_modified_status = true,        -- Shows indicator when the buffer is modified.
  mode = 0, -- 0: Shows buffer name
            -- 1: Shows buffer index
            -- 2: Shows buffer name + buffer index
            -- 3: Shows buffer number
            -- 4: Shows buffer name + buffer number
  max_length = vim.o.columns, -- Maximum width of buffers component,
  -- it can also be a function that returns
  -- the value of `max_length` dynamically.
  filetype_names = {
    ["neo-tree"] = "Neo-tree",
    TelescopePrompt = "Telescope",
    dashboard = "Dashboard",
    packer = "Packer",
    fzf = "FZF",
    alpha = "Alpha"
  }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )

  buffers_color = {
    active = { bg = colors.main.blue, fg = colors.editor.bg },
    inactive = { bg = colors.editor.border, fg = colors.editor.fg }
  },

  symbols = {
    modified = " ●",      -- Text to show when the buffer is modified
    alternate_file = "", -- Text to show to identify the alternate file
    directory =  "",     -- Text to show when the buffer is a directory
  }
}

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "material",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { branch },
    lualine_c = { diff },
    lualine_x = { filetype, diagnostics, location },
    lualine_y = {},
    lualine_z = {}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = { buffers }
  },
  extensions = {}
})
