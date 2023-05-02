return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim" ,
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "camgraff/telescope-tmux.nvim"
  },
  config = function()
    local telescope = require "telescope"

    telescope.setup {
      -- defaults = {
      --   winblend = 10
      -- }
    }

    telescope.load_extension "file_browser"
    telescope.load_extension "fzy_native"

    local builtin = require "telescope.builtin"

    -- https://github.com/nvim-telescope/telescope.nvim/issues/621
    local action_state = require "telescope.actions.state"
    local actions = require "telescope.actions"

    -- Find open buffers and allow closing from picker using multiselect
    -- https://github.com/nvim-telescope/telescope.nvim/issues/621
    local function multi_buffers()
      builtin.buffers {
        attach_mappings = function(prompt_bufnr, map)
          local delete_buf = function()
            local current_picker = action_state.get_current_picker(prompt_bufnr)
            local multi_selections = current_picker:get_multi_selection()
            if next(multi_selections) == nil then
              local selection = action_state.get_selected_entry()
              actions.close(prompt_bufnr)
              vim.api.nvim_buf_delete(selection.bufnr, { force = true })
            else
              actions.close(prompt_bufnr)
              for _, selection in ipairs(multi_selections) do
                vim.api.nvim_buf_delete(selection.bufnr, { force = true })
              end
            end
          end
          map("i", "<C-x>", delete_buf)
          map("n", "d", delete_buf)
          return true
        end
      }
    end

    local nmap = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { desc = desc })
    end

    --------------------------------------------------------------------------------
    -- Files and buffers

    nmap("<Leader><Space>", multi_buffers, "[ ] Find open buffers")

    nmap("<leader>/", function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, "[/] Fuzzy search in current buffer")

    nmap("<Leader>fr", builtin.resume, "[F]ind [R]esume (open previous Telescope)")
    nmap("<Leader>fi", builtin.live_grep, "[F]ind [I]nside files (live grep)")
    nmap("<Leader>fd", builtin.diagnostics, "[F]ind [D]iagnostics")

    nmap("<Leader>ff", function()
      builtin.find_files({
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      })
    end, "[F]ind [F]iles")

    nmap("<Leader>FF", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true
      })
    end, "[F]ind [F]iles (include ignored)")

    nmap("<Leader>fq", function()
      builtin.quickfix({
        show_line = false
      })
    end, "[F]ind in [Q]uickfix")

    nmap("<Leader>ft", "<CMD>TodoTelescope keywords=TODO,FIX<CR>", "[F]ind [T]ODO and [F]IX")
    nmap("<Leader>fb", "<CMD>Telescope file_browser<CR>", "[F]ile [B]rowser")
    nmap("<Leader>fs", builtin.treesitter, "[F]ind Treesitter [S]ymbols")
    nmap("<Leader>fj", "<CMD>Telescope tmux sessions<CR>", "Find Tmux Session")

    --------------------------------------------------------------------------------
    -- Help and info

    nmap("<Leader>fk", builtin.keymaps, "[F]ind [K]eymaps")
    nmap("<Leader>fh", builtin.help_tags, "[F]ind [H]help")
    nmap("<Leader>fc", builtin.commands, "[F]ind [C]ommands")

    --------------------------------------------------------------------------------
    -- Git

    nmap("<Leader>fgs", builtin.git_status, "[F]ind [G]it [S]tatus")
    nmap("<Leader>fgc", builtin.git_commits, "[F]ind [G]it [C]ommits")
    nmap("<Leader>fgtb", builtin.git_bcommits, "[F]ind [G]it [B]uffer commits")

  end
}


