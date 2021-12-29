Plug 'kaicataldo/material.vim', { 'branch': 'main' }

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
let g:airline_theme = 'material'

augroup MaterialOverrides
	autocmd!
	autocmd User PlugLoaded ++nested colorscheme material
	autocmd User PlugLoaded ++nested exec 'hi ColorColumn guibg=' . material_colorscheme_map.guides.gui . ' ctermbg=' . material_colorscheme_map.guides.cterm
augroup end
