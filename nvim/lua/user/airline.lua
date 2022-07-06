vim.cmd [[

  let g:airline_powerline_fonts = 1
  let g:airline_skip_empty_sections = 1

  let g:airline_left_sep = ' '
  let g:airline_right_sep = ' '
  " let g:airline_left_sep = ''
  " let g:airline_right_sep = ''

  let g:airline#extensions#tabline#formatter = 'unique_tail'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#left_sep = ' '
  " let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = ' '
  let g:airline#extensions#hunks#enabled = 0
  let g:airline#extensions#branch#enabled = 1

  let g:tmuxline_separators = {
      \ 'left' : '',
      \ 'left_alt': '',
      \ 'right' : '',
      \ 'right_alt' : '',
      \ 'space' : ' '}

  set noshowmode

]]
