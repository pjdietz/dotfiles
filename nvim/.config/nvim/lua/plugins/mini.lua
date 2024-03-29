return {
  "echasnovski/mini.nvim",
  enabled = false,
  config = function()
    local animate = require('mini.animate')
    animate.setup {
      cursor = {
        enable = false,
        timing = animate.gen_timing.linear({ duration = 125, unit = 'total' }),
        path = animate.gen_path.line({
          predicate = function() return true end,
        }),
      },
      scroll = {
        enable = false,
        timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
        subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
      }
    }
  end
}
