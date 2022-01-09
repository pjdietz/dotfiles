" Zooms the current tmux pane
function TmuxZoom()
	if executable('tmux') && strlen($TMUX)
		silent !tmux resize-pane -Z
	endif
endfunction

nnoremap <leader>z :call TmuxZoom()<CR>
