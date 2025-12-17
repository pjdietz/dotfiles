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
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function ()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        provider = require("user.opencode_tmux_provider"),
        events = {
          enabled = true,
          reload = true,
          permissions = {
            enabled = false,
            idle_delay_ms = 1000,
          },
        },
      }
      vim.o.autoread = true
      vim.keymap.set({ "n", "x" }, "<Leader>oc", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask [O]pen[C]ode" })
      vim.keymap.set({ "n", "t" }, "<Leader>os", function() require("opencode").show() end, { desc = "[S]how [O]pencode" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    config = function ()

      require("codecompanion").setup({
        display = {
          chat = {
            show_settings = false,
            window = {
              -- layout = "vertical",
              -- position = "left",
              layout = "buffer",
              position = nil,
            }
          }
        },
        strategies = {
          chat = {
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash"
            },
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
            -- variables = {
            --   ["buffer"] = {
            --     opts = {
            --       default_params = 'pin'
            --     },
            --   }
            -- }
          },
          inline = {
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash"
            },
            variables = {
              ["buffer"] = {
                opts = {
                  default_params = 'pin'
                },
              }
            }
          }
        },
      })

      -- Alias CC for CodeCompanion
      vim.api.nvim_create_user_command("CC", function(opts)
        vim.cmd("CodeCompanion " .. opts.args)
      end, { nargs = "*" })

      -- vim.api.nvim_create_autocmd("FileType", {
      --   pattern = "codecompanion",
      --   callback = function()
      --     vim.cmd("set filetype=markdown")
      --   end,
      -- })

      -- -- Disable colorcolumn for the CodeCompanion chat window.
      -- local function find_window_for_buffer(buffer_id)
      --   local windows = vim.api.nvim_list_wins()
      --   for _, win_id in ipairs(windows) do
      --     if vim.api.nvim_win_get_buf(win_id) == buffer_id then
      --       return win_id
      --     end
      --   end
      --   return nil -- Return nil if no window is found for the buffer
      -- end
      -- local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
      -- vim.api.nvim_create_autocmd({ "User" }, {
      --   pattern = "CodeCompanionChatOpened",
      --   group = group,
      --   callback = function(request)
      --     local win = find_window_for_buffer(request.buf)
      --     vim.api.nvim_set_option_value("colorcolumn", "", { win = win })
      --   end,
      -- })

      require("plugins.ai.fidget"):init()

      -- https://gist.github.com/itsfrank/942780f88472a14c9cbb3169012a3328
      -- add 2 commands:
      --    CodeCompanionSave [space delimited args]
      --    CodeCompanionLoad
      -- Save will save current chat in a md file named 'space-delimited-args.md'
      -- Load will use a telescope filepicker to open a previously saved chat

      -- create a folder to store our chats
      -- local Path = require("plenary.path")
      -- local data_path = vim.env.HOME .. "/vimwiki"
      -- local save_folder = Path:new(data_path, "chats")
      -- if not save_folder:exists() then
      --     save_folder:mkdir({ parents = true })
      -- end

      -- -- telescope picker for our saved chats
      -- vim.api.nvim_create_user_command("CodeCompanionLoad", function()
      --     local t_builtin = require("telescope.builtin")
      --     local t_actions = require("telescope.actions")
      --     local t_action_state = require("telescope.actions.state")
      --
      --     local function start_picker()
      --         t_builtin.find_files({
      --             prompt_title = "Saved CodeCompanion Chats | <c-d>: delete",
      --             cwd = save_folder:absolute(),
      --             attach_mappings = function(_, map)
      --                 map("i", "<c-d>", function(prompt_bufnr)
      --                     local selection = t_action_state.get_selected_entry()
      --                     local filepath = selection.path or selection.filename
      --                     os.remove(filepath)
      --                     t_actions.close(prompt_bufnr)
      --                     start_picker()
      --                 end)
      --                 return true
      --             end,
      --         })
      --     end
      --     start_picker()
      -- end, {})

      -- save current chat, `CodeCompanionSave foo bar baz` will save as 'foo-bar-baz.md'
      -- vim.api.nvim_create_user_command("CodeCompanionSave", function(opts)
      --     local codecompanion = require("codecompanion")
      --     local success, chat = pcall(function()
      --         return codecompanion.buf_get_chat(0)
      --     end)
      --     if not success or chat == nil then
      --         vim.notify(
      --             "CodeCompanionSave should only be called from CodeCompanion chat buffers",
      --             vim.log.levels.ERROR
      --         )
      --         return
      --     end
      --     if #opts.fargs == 0 then
      --         vim.notify("CodeCompanionSave requires at least 1 arg to make a file name", vim.log.levels.ERROR)
      --     end
      --     local save_name = table.concat(opts.fargs, "-") .. ".md"
      --     local save_path = Path:new(save_folder, save_name)
      --     local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
      --     save_path:write(table.concat(lines, "\n"), "w")
      -- end, { nargs = "*" })

    end,
    dependencies = {
      "j-hui/fidget.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<Leader>cn", "<CMD>CodeCompanionChat<CR>", desc = "[C]ode Companion [N]ew Chat" },
      { "<Leader>cc", "<CMD>CodeCompanionChat Toggle<CR>", desc = "[C]ode Companion [C]hat" },
      { "<Leader>ci", "<CMD>CodeCompanion<CR>", desc = "[C]ode Companion [I]nline" }
    },
    cmd = { "CodeCompanion", "CC" }
  }
}
