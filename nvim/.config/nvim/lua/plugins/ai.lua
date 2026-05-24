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
  }
}
