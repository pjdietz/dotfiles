local pickers      = require("telescope.pickers")
local finders      = require("telescope.finders")
local actions      = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf         = require("telescope.config").values
local base64       = require("user.base64")

local M = {}

local function passthru(str)
  return str
end

local conversions = {
  { "Passthru", passthru },
  { "Base64 Encode", base64.encode },
  { "Base64 Decode", base64.decode },
}

local function convert_selection(convert_fn)
  local bufnr = 0   -- current buffer
  -- get the character‐precise visual marks
  local sp = vim.fn.getpos("'<")   -- {buf#, line, col, _}
  local ep = vim.fn.getpos("'>")
  local sr, sc = sp[2], sp[3]
  local er, ec = ep[2], ep[3]

  local function clamp_col(line_num, col)
    local line = vim.api.nvim_buf_get_lines(bufnr, line_num-1, line_num, false)[1]
    local maxc = #line
    -- allow col == maxc (i.e. append after last char)
    if col < 1 then return 0 end
    if col-1 > maxc then return maxc end
    return col-1
  end

  local lines
  if sr > 0 and er > 0 then
    -- we really had a visual selection (charwise or linewise)
    if sr == er then
      -- single-line selection
      local line = vim.api.nvim_buf_get_lines(bufnr, sr-1, sr, false)[1]
      lines = { line:sub(sc, ec) }
    else
      -- multi-line selection
      lines = vim.api.nvim_buf_get_lines(bufnr, sr-1, er, false)
      -- trim first line to start at sc
      lines[1]      = lines[1]:sub(sc)
      -- trim last  line to end at ec
      lines[#lines] = lines[#lines]:sub(1, ec)
    end

    local raw_text = table.concat(lines, '')
    local converted = convert_fn(raw_text)
    local out_lines = vim.split(converted, '\n', {plain = true})

    -- clamp start/end cols
    local s_col = clamp_col(sr, sc)
    local e_col = clamp_col(er, ec)

    -- do the replacement
    vim.api.nvim_buf_set_text(bufnr,
      sr-1, s_col,
      er-1, e_col,
      out_lines
    )

    -- clear the visual marks
    vim.fn.setpos("'<", {0,0,0,0})
    vim.fn.setpos("'>", {0,0,0,0})

  else
    -- no visual selection active → dump whole buffer
    lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local raw_text = table.concat(lines, '')
    local converted = convert_fn(raw_text)
    local out_lines = vim.split(converted, '\n', {plain = true})
    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, out_lines)
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
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local convert_fn = selection.value
        convert_selection(convert_fn)
      end)
      return true
    end,
  }):find()
end

return M
