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
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    config = function ()
      require("avante_lib").load()
      require("avante").setup({
         provider = "claude",
         claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          temperature = 0,
          max_tokens = 4096,
        },
      })
    end,
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
