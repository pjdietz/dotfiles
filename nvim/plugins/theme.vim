Plug 'kaicataldo/material.vim', { 'branch': 'main' }

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'

augroup MaterialOverrides
	autocmd!
	autocmd User PlugLoaded ++nested colorscheme material
augroup end
