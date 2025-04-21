return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = false,
          hide_during_completion = true,
          debounce = 75,
          -- Keybinds for Copilot are defined in completion.lua to account
          -- for interactions with completion keybinds.
          keymap = {
            next = false,
            prev = false,
            dismiss = "<ESC>",
          }
        }
      })
      vim.keymap.set("n", "<leader>ta", require("copilot.suggestion").toggle_auto_trigger,
          { desc = "[T]oggle Copilot [A]uto trigger" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    config = function ()

      require("codecompanion").setup({
        display = {
          chat = {
            show_settings = false
          }
        },
        strategies = {
          chat = {
            adapter = "gemini",
            slash_commands = {
              ["file"] = {
                -- Location to the slash command in CodeCompanion
                callback = "strategies.chat.slash_commands.file",
                description = "Select a file using Telescope",
                opts = {
                  provider = "telescope",
                  contains_code = true,
                },
              },
            },
          },
          inline = {
            adapter = "gemini"
          }
        },
      })

      -- Alias CC for CodeCompanion
      vim.api.nvim_create_user_command("CC", function(opts)
        vim.cmd("CodeCompanion " .. opts.args)
      end, { nargs = "*" })

      -- Disable colorcolumn for the CodeCompanion chat window.
      local function find_window_for_buffer(buffer_id)
        local windows = vim.api.nvim_list_wins()
        for _, win_id in ipairs(windows) do
          if vim.api.nvim_win_get_buf(win_id) == buffer_id then
            return win_id
          end
        end
        return nil -- Return nil if no window is found for the buffer
      end
      local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
      vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionChatOpened",
        group = group,
        callback = function(request)
          local win = find_window_for_buffer(request.buf)
          vim.api.nvim_set_option_value("colorcolumn", "", { win = win })
        end,
      })

      require("plugins.ai.fidget"):init()

      -- https://gist.github.com/itsfrank/942780f88472a14c9cbb3169012a3328
      -- add 2 commands:
      --    CodeCompanionSave [space delimited args]
      --    CodeCompanionLoad
      -- Save will save current chat in a md file named 'space-delimited-args.md'
      -- Load will use a telescope filepicker to open a previously saved chat

      -- create a folder to store our chats
      local Path = require("plenary.path")
      local data_path = vim.env.HOME .. "/vimwiki"
      local save_folder = Path:new(data_path, "chats")
      if not save_folder:exists() then
          save_folder:mkdir({ parents = true })
      end

      -- telescope picker for our saved chats
      vim.api.nvim_create_user_command("CodeCompanionLoad", function()
          local t_builtin = require("telescope.builtin")
          local t_actions = require("telescope.actions")
          local t_action_state = require("telescope.actions.state")

          local function start_picker()
              t_builtin.find_files({
                  prompt_title = "Saved CodeCompanion Chats | <c-d>: delete",
                  cwd = save_folder:absolute(),
                  attach_mappings = function(_, map)
                      map("i", "<c-d>", function(prompt_bufnr)
                          local selection = t_action_state.get_selected_entry()
                          local filepath = selection.path or selection.filename
                          os.remove(filepath)
                          t_actions.close(prompt_bufnr)
                          start_picker()
                      end)
                      return true
                  end,
              })
          end
          start_picker()
      end, {})

      -- save current chat, `CodeCompanionSave foo bar baz` will save as 'foo-bar-baz.md'
      vim.api.nvim_create_user_command("CodeCompanionSave", function(opts)
          local codecompanion = require("codecompanion")
          local success, chat = pcall(function()
              return codecompanion.buf_get_chat(0)
          end)
          if not success or chat == nil then
              vim.notify(
                  "CodeCompanionSave should only be called from CodeCompanion chat buffers",
                  vim.log.levels.ERROR
              )
              return
          end
          if #opts.fargs == 0 then
              vim.notify("CodeCompanionSave requires at least 1 arg to make a file name", vim.log.levels.ERROR)
          end
          local save_name = table.concat(opts.fargs, "-") .. ".md"
          local save_path = Path:new(save_folder, save_name)
          local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
          save_path:write(table.concat(lines, "\n"), "w")
      end, { nargs = "*" })

    end,
    dependencies = {
      "j-hui/fidget.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<Leader>cc", "<CMD>CodeCompanionChat Toggle<CR>", desc = "[C]ode Companion [C]hat" },
      { "<Leader>ci", "<CMD>CodeCompanion<CR>", desc = "[C]ode Companion [I]nline" }
    },
    cmd = { "CodeCompanion", "CC" }
  }
}
