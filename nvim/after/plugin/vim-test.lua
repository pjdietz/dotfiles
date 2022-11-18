vim.cmd [[
  nnoremap <Leader>tn <CMD>TestNearest<CR>
  nnoremap <Leader>tf <CMD>TestFile<CR>
  nnoremap <Leader>ts <CMD>TestSuite<CR>
  nnoremap <Leader>tl <CMD>TestLast<CR>
  nnoremap <Leader>tv <CMD>TestVisit<CR>

  let test#strategy = "toggleterm"
  let test#php#phpunit#executable = "docker-compose run --rm php phpunit --no-coverage"
]]
