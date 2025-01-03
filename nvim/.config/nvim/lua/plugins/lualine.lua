return {
  "nvim-lualine/lualine.nvim",
  config = function ()

    local lualine = require "lualine"

    local function hide_in_width()
      return vim.fn.winwidth(0) > 80
    end

    local mode = {
      "mode",
      fmt = function(str) return str:sub(1,1) end,
      separator = { left = "", right = "" }
    }

    local branch = {
      "branch",
      icons_enabled = true,
      icon = "",
    }

    local filename = {
      "filename",
      file_status = false,
    }

    local diff = {
      "diff",
      colored = false,
      symbols = { added = "+", modified = "~", removed = "-" },
      cond = hide_in_width,
      padding = 0,
    }

    local filetype = {
      "filetype",
      icons_enabled = true,
      colored = false,
      padding = 0,
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

    lualine.setup({
      options = {
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = '', right = '' },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { filename },
        lualine_c = { branch, diff },
        lualine_x = { diagnostics, "location", filetype },
        lualine_y = {},
        lualine_z = {}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      extensions = {}
    })

  end
}
