local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
  return
end

toggleterm.setup {
  open_mapping = [[<F1>]],
  direction = vertical,
  size = 20,
  close_on_exit = true,
  hide_numbers = true,
  start_in_insert = true,
  shade_terminals = false
}
