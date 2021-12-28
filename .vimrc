syntax on

set relativenumber

filetype on
filetype plugin on
filetype indent on

set shiftwidth=4
set tabstop=4
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=1000
set cursorline 		" Highlight the line with the cursor
set vb t_vb=		" No visual bell & flash

set splitbelow splitright
set fillchars+=vert:\ 

colorscheme slate

" PLUGINS ---------------------------------------------------------------- {{{

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
   \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin(data_dir . '/plugged')
Plug 'preservim/nerdtree'
Plug 'romainl/vim-cool'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
call plug#end()

" Configure NERDTree
let NERDTreeShowHidden=1

" Configure Material colorscheme
let g:material_terminal_italics = 0
let g:material_theme_style = 'default'
silent! colorscheme material

" }}}


" MAPPINGS --------------------------------------------------------------- {{{
map <F1> :NERDTreeToggle<CR>
map <F2> :bprev<CR>
map <F3> :bnext<CR>
" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %t\ %M\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2

" }}}





