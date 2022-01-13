"Theme adjustments
function! FixThemeColors()
	if !exists('g:neovide')
		hi! Normal ctermbg=NONE guibg=NONE
		highlight SignColumn guibg=NONE
	endif
	" Rulers and split dividers
	exec 'hi ColorColumn guibg=' . g:material_colorscheme_map.guides.gui . ' ctermbg=' . g:material_colorscheme_map.guides.cterm
	exec 'hi VertSplit guifg=' . g:material_colorscheme_map.guides.gui . ' ctermfg=' . g:material_colorscheme_map.guides.cterm
	" Comments and line numbers
	hi Comment guifg=#617b87
	hi LineNr guifg=#617b87 guibg=NONE
	" Git
	hi DiffAdd guibg=NONE
	hi DiffChange guibg=NONE
	hi DiffDelete guibg=NONE
	" PHP (color $ same as variable)
	exec 'hi Identifier guifg=' . g:material_colorscheme_map.orange.gui . ' ctermfg=' . g:material_colorscheme_map.orange.cterm
	exec 'hi phpVarSelector guifg=' . g:material_colorscheme_map.orange.gui . ' ctermfg=' . g:material_colorscheme_map.orange.cterm
	" PHP (braces and parens)
	exec 'hi phpParent guifg=' . g:material_colorscheme_map.cyan.gui . ' ctermfg=' . g:material_colorscheme_map.cyan.cterm
endfunction

call FixThemeColors()
