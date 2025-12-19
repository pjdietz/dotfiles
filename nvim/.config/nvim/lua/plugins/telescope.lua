return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  event = "VimEnter",
  dependencies = {
    "nvim-lua/plenary.nvim" ,
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
    "johmsalas/text-case.nvim",
  },
  config = function()
    local telescope = require "telescope"

    telescope.load_extension "file_browser"
    telescope.load_extension "fzy_native"
    telescope.load_extension "textcase"
    telescope.load_extension "ui-select"
    telescope.load_extension "noice"

    local builtin = require "telescope.builtin"

    -- https://github.com/nvim-telescope/telescope.nvim/issues/621
    local action_state = require "telescope.actions.state"
    local actions = require "telescope.actions"

    -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-993956937
    local function multiopen(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()

        if not vim.tbl_isempty(multi) then
            actions.close(prompt_bufnr)
            for _, j in pairs(multi) do
                if j.path ~= nil then
                    local path = vim.fn.fnameescape(j.path)
                    if j.lnum ~= nil then
                        vim.cmd(string.format("silent! edit +%d %s", j.lnum, path))
                    else
                        vim.cmd(string.format("silent! edit %s", path))
                    end
                end
            end
        else
            actions.select_default(prompt_bufnr)
        end
    end

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

    local vmap = function(keys, func, desc)
      vim.keymap.set("v", keys, func, { desc = desc })
    end

    telescope.setup {
      defaults = {
        path_display = { "smart" },
        preview = {
          treesitter = false,
        },
        mappings = {
            i = {
                ["<CR>"] = multiopen,
            },
            n = {
                ["<CR>"] = multiopen,
            },
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    }

    ----------------------------------------------------------------------------
    -- Files and buffers

    nmap("<Leader>fo", multi_buffers, "[F]ind [0]pen buffers")

    nmap("<Leader><Leader>", function()
      builtin.find_files({
        -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
        find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
      })
    end, "Find files")

    nmap("<Leader>ff", function()
      builtin.find_files({
        hidden = true,
        no_ignore = true
      })
    end, "[F]ind [F]iles (include ignored)")

    nmap("<leader>/", function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        previewer = false,
      })
    end, "[/] Fuzzy search in current buffer")

    nmap("<Leader>fr", builtin.resume, "[F]ind [R]esume (open previous Telescope)")
    nmap("<Leader>fi", builtin.live_grep, "[F]ind [I]nside files (live grep)")
    nmap("<Leader>fd", builtin.diagnostics, "[F]ind [D]iagnostics")

    nmap("<Leader>fq", function()
      builtin.quickfix({
        show_line = false
      })
    end, "[F]ind in [Q]uickfix")

    nmap("<Leader>ft", "<CMD>TodoTelescope keywords=TODO,FIX<CR>", "[F]ind [T]ODO and FIX")
    nmap("<Leader>fb", "<CMD>Telescope file_browser<CR>", "[F]ile [B]rowser")
    nmap("<Leader>f'", builtin.marks, "[F]ind marks")
    nmap("<Leader>fst", builtin.treesitter, "[F]ind [S]ymbols in [T]reesitter")

    ----------------------------------------------------------------------------
    -- Help and info

    nmap("<Leader>fk", builtin.keymaps, "[F]ind [K]eymaps")
    nmap("<Leader>fh", builtin.help_tags, "[F]ind [H]help")
    nmap("<Leader>fc", builtin.commands, "[F]ind [C]ommands")
    nmap("<Leader>fm", "<CMD>Telescope noice<CR>", "[F]ind [M]essages")

    ----------------------------------------------------------------------------
    -- Git

    nmap("<Leader>fgs", builtin.git_status, "[F]ind [G]it [S]tatus")
    nmap("<Leader>fgc", builtin.git_commits, "[F]ind [G]it [C]ommits")
    nmap("<Leader>fgb", builtin.git_bcommits, "[F]ind [G]it [B]uffer commits")

    ----------------------------------------------------------------------------
    -- Case Change

    nmap("<Leader>ch", "<CMD>TextCaseOpenTelescope<CR>", "[CH]ange Case")

  end
}
