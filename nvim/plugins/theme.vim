Plug 'kaicataldo/material.vim', { 'branch': 'main' }

let g:material_terminal_italics = 1
let g:material_theme_style = 'default'
let g:airline_theme = 'material'

augroup MaterialOverrides
	autocmd!
	autocmd User PlugLoaded ++nested colorscheme material
	" Rulers and split dividers
	autocmd User PlugLoaded ++nested exec 'hi ColorColumn guibg=' . material_colorscheme_map.guides.gui . ' ctermbg=' . material_colorscheme_map.guides.cterm
	" Variables and dolar sign
	autocmd User PlugLoaded ++nested exec 'hi VertSplit guifg=' . material_colorscheme_map.guides.gui . ' ctermfg=' . material_colorscheme_map.guides.cterm
	autocmd User PlugLoaded ++nested exec 'hi Identifier guifg=' . material_colorscheme_map.orange.gui . ' ctermfg=' . material_colorscheme_map.orange.cterm
	autocmd User PlugLoaded ++nested exec 'hi phpVarSelector guifg=' . material_colorscheme_map.orange.gui . ' ctermfg=' . material_colorscheme_map.orange.cterm
	" Braces and parens
	autocmd User PlugLoaded ++nested exec 'hi phpParent guifg=' . material_colorscheme_map.cyan.gui . ' ctermfg=' . material_colorscheme_map.cyan.cterm
augroup end
