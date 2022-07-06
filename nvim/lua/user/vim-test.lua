vim.cmd [[
  nnoremap <leader>tn :TestNearest<CR>
  nnoremap <leader>tf :TestFile<CR>
  nnoremap <leader>ts :TestSuite<CR>
  nnoremap <leader>tl :TestLast<CR>
  nnoremap <leader>tv :TestVisit<CR>

  let test#strategy = 'neovim'
  let test#php#phpunit#executable = 'docker-compose run --rm php phpunit --no-coverage'
]]
