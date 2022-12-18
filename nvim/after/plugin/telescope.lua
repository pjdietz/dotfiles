local telescope = require "telescope"

telescope.setup {}
telescope.load_extension "file_browser"
telescope.load_extension "fzy_native"

local builtin = require "telescope.builtin"

-- https://github.com/nvim-telescope/telescope.nvim/issues/621
local action_state = require "telescope.actions.state"
local actions = require "telescope.actions"

local function user_buffers()
  builtin.buffers {
    attach_mappings = function (prompt_bufnr, map)
      local delete_buf = function ()
        local selection = action_state.get_selected_entry()
        -- TODO Instead of closing the picker, update it with the buffer closed
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.bufnr, { force = true })
      end
      map("n", "d", delete_buf)
      return true
    end
  }
end

-- Files and buffers
vim.keymap.set("n", "<Leader>fr", builtin.resume)
vim.keymap.set("n", "<Leader>ff", builtin.find_files)
vim.keymap.set("n", "<Leader>FF", function ()
  builtin.find_files({
    hidden = true,
    no_ignore = true
  }) end)
vim.keymap.set("n", "<Leader>fi", builtin.live_grep)
vim.keymap.set("n", "<Leader>fh", builtin.help_tags)
vim.keymap.set("n", "<Leader>fq", builtin.quickfix)
vim.keymap.set("n", "<Leader>fo", user_buffers)
vim.keymap.set("n", "<Leader>fb", "<CMD>Telescope file_browser<CR>")
vim.keymap.set("n", "<Leader>ft", "<CMD>TodoTelescope keywords=TODO,FIX<CR>")
-- Commands
vim.keymap.set("n", "<Leader>fc", builtin.commands)
-- Git
vim.keymap.set("n", "<Leader>fgs", builtin.git_status)
vim.keymap.set("n", "<Leader>fgc", builtin.git_commits)
vim.keymap.set("n", "<Leader>fgb", builtin.git_bcommits)
