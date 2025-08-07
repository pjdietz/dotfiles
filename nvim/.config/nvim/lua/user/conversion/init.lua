local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf         = require("telescope.config").values

local M = {
  base64 = require("user.conversion.base64"),
  json = require("user.conversion.json"),
  url = require("user.conversion.url")
}

local conversions = {
  { "Base64 Decode", M.base64.decode },
  { "Base64 Encode", M.base64.encode },
  { "JSON Pretty Print", M.json.pretty },
  { "JWT Decode", M.json.jwt_decode },
  { "URL Decode", M.url.decode },
  { "URL Encode", M.url.encode },
}

local function convert_buffer(convert_fn)
  local bufnr = 0 -- current buffer
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local raw_text = table.concat(lines, '\n')
  local converted = convert_fn(raw_text)
  local out_lines = vim.split(converted, '\n', {plain = true, trimempty = false})
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, out_lines)
end

local function clamp_col(row, col)
  local bufnr = 0 -- current buffer
  local line = vim.api.nvim_buf_get_lines(bufnr, row-1, row, false)[1]
  local maxc = #line
  -- -- allow col == maxc (i.e. append after last char)
  -- if col < 2 then return 1 end
  if col > maxc then return maxc end
  return col
end

local function convert_selection(convert_fn, start_row, start_col, end_row, end_col)

  local bufnr = 0 -- current buffer
  local lines = {}

  if start_row == end_row then
    -- Single-line selection
    local line = vim.api.nvim_buf_get_lines(bufnr, start_row-1, start_row, false)[1]
    lines = { line:sub(start_col+1, end_col+1) }
  else
    -- Multi-line selection
    lines = vim.api.nvim_buf_get_lines(bufnr, start_row-1, end_row, false)
    lines[1] = lines[1]:sub(start_col+1)
    lines[#lines] = lines[#lines]:sub(1, end_col+1)
  end

  local raw_text = table.concat(lines, '')
  print(raw_text)
  local converted = convert_fn(raw_text)
  print(converted)
  local out_lines = vim.split(converted, '\n', {plain = true})

  -- vim.api.nvim_paste(converted, true, -1)
  -- vim.api.nvim_put(out_lines, "", false, false)
  -- -- Ensure columns are in range.
  local s_col = clamp_col(start_row, start_col)
  local e_col = clamp_col(end_row, end_col+1)
  --
  --
  -- Replace the text.
  print(e_col)
  print(end_col)
  vim.api.nvim_buf_set_text(bufnr,
    start_row-1, s_col,
    end_row-1, e_col,
    out_lines
  )
  --
  -- -- Clear the visual marks.
  -- vim.fn.setpos("'<", {0,0,0,0})
  -- vim.fn.setpos("'>", {0,0,0,0})
end

local function convert(convert_fn)

  local bufnr = 0 -- current buffer
  local start_mark = vim.api.nvim_buf_get_mark(bufnr, "<")
  local end_mark = vim.api.nvim_buf_get_mark(bufnr, ">")
  local start_row, start_col = start_mark[1], start_mark[2]
  local end_row, end_col = end_mark[1], end_mark[2]

  if start_row > 0 and end_row > 0 then
    convert_selection(convert_fn, start_row, start_col, end_row, end_col)
  else
    convert_buffer(convert_fn)
  end
end

function M.select()
  local opts = {}
  pickers.new(opts, {
    promt_title = "Select a conversion",
    finder = finders.new_table {
      results = conversions,
      entry_maker = function(entry)
        return {
          value = entry[2],
          display = entry[1],
          ordinal = entry[1],
        }
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          local convert_fn = selection.value
          convert(convert_fn)
        end
      end)
      return true
    end,
  }):find()
end

return M
