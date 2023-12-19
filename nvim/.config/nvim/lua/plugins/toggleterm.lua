return {
  "akinsho/toggleterm.nvim",
  enabled = false,
  cmd = "Toggleterm",
  keys = {
    { "<F1>", "<CMD>Toggleterm<CR>", { desc = "Toggleterm" } }
  },
  opts = {
    open_mapping = [[<F1>]],
    direction = "float",
    float_opts = {
      border = "curved"
    },
    size = 20,
    close_on_exit = true,
    hide_numbers = true,
    start_in_insert = true,
    shade_terminals = false
  }
}
