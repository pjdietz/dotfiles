" Key bindings for built-in features.

" Y works like C and D
nnoremap Y y$

" Move lines up or down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Indent and keep selection
:vnoremap < <gv
:vnoremap > >gv

" Buffers
nnoremap <S-TAB> :bn<CR>
nnoremap <A-TAB> :bp<CR>
nnoremap <leader><TAB> :bp\|bd #<CR>
nnoremap <leader>ww :bufdo bwipeout<CR>

" Splits
nnoremap <leader>\| <C-w>v
nnoremap <leader>- <C-w>s
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Toggle invisibles
nnoremap <leader>i :set list!<CR>

" Clear search hightlight
nnoremap <leader><esc> :noh<CR>

" Reload configuration
nnoremap <F5> :so $MYVIMRC<CR>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" Git and merge
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
nmap <leader>gs :G<CR>
