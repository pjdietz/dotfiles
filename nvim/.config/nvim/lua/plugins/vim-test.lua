return {
  "vim-test/vim-test",
  keys = {
    { "<Leader>tn", "<CMD>TestNearest<CR>", desc = { "[T]est [N]earest" } },
    { "<Leader>tf", "<CMD>TestFile<CR>", desc = { "[T]est [F]ile" } },
    { "<Leader>ts", "<CMD>TestSuite<CR>", desc = { "[T]est [S]uite" } },
    { "<Leader>tl", "<CMD>TestLast<CR>", desc = { "[T]est [L]ast" } },
    { "<Leader>tv", "<CMD>TestVisit<CR>", desc = { "[T]est [V]isit" } },
  },
  init = function()
    vim.cmd [[
      let test#strategy = "toggleterm"
      let test#php#phpunit#executable = "docker-compose run --rm php phpunit --no-coverage"
    ]]
  end
}
