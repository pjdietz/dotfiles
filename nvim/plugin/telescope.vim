lua <<EOF
local telescope = require('telescope')
telescope.setup()
telescope.load_extension 'file_browser'
EOF

" Files and buffers, etc.
nnoremap <leader>fr :lua require('telescope.builtin').resume()<CR>
nnoremap <leader>ff :lua require('telescope.builtin').find_files()<CR>
nnoremap <leader>FF :lua require('telescope.builtin').find_files({ no_ignore=true })<CR>
nnoremap <leader>fi :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>fq :lua require('telescope.builtin').quickfix()<CR>
nnoremap <leader>fo :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>fb :Telescope file_browser<CR>
nnoremap <leader>fc :lua require('telescope.builtin').commands()<CR>
" Git
nnoremap <leader>fgs :lua require('telescope.builtin').git_status()<CR>
nnoremap <leader>fgc :lua require('telescope.builtin').git_commits()<CR>
nnoremap <leader>fgb :lua require('telescope.builtin').git_bcommits()<CR>
