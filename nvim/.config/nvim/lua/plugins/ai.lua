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
        strategies = {
          chat = {
            adapter = "copilot",
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
            adapter = "copilot"
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

    end,
    dependencies = {
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
