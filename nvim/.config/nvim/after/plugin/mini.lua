local animate = require('mini.animate')
animate.setup {
  cursor = {
    timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
    path = animate.gen_path.line({
      predicate = function() return true end,
    }),
  },
  scroll = {
    enable = true,
    timing = animate.gen_timing.linear({ duration = 150, unit = 'total' }),
    subscroll = animate.gen_subscroll.equal({ max_output_steps = 120 }),
  }
}
