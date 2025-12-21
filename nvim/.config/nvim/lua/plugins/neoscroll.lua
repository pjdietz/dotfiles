return {
  "karb94/neoscroll.nvim",
  opts = {
    duration_multiplier = 0.67
  },
  config = function (_, opts)
    local neoscroll = require("neoscroll")
    neoscroll.setup(opts)

    local function half(n)
      return math.floor(vim.api.nvim_win_get_height(0) / 2) * (n or 1)
    end

    local keymap = {

      -- <C-u> and <C-d> use gj and gk to scroll by n lines when wrapped.
      ["<C-u>"] = function()
        if not vim.wo.wrap then
          neoscroll.ctrl_u({ duration = 250; easing = 'sine' })
        end
        local n = vim.v.count1
        vim.cmd("normal! " .. half(n) .. "gkzz")
      end;

      ["<C-d>"] = function()
        if not vim.wo.wrap then
          neoscroll.ctrl_d({ duration = 250; easing = 'sine' })
        end
        local n = vim.v.count1
        vim.cmd("normal! " .. half(n) .. "gjzz")
      end;
    }

    local modes = { 'n', 'v', 'x' }
    for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
    end
  end
}
