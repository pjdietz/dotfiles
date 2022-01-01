" Tabs
set tabstop=4 softtabstop=4
set shiftwidth=4

" Line numbers
set relativenumber
set number
set signcolumn=yes

" Rulers
set colorcolumn=80,100
highlight ColorColumn ctermbg=1 guibg=#ffffff

set termguicolors
set scrolloff=8
set noerrorbells

" Search
set nohlsearch
set incsearch

" Splits
set splitbelow splitright
set fillchars=vert:│

" Undo and swap
set noswapfile
set nobackup
set undofile

set mouse=a
set updatetime=50

" -----------------------------------------------------------------------------
" Mappings
" -----------------------------------------------------------------------------

let mapleader = "\<space>"

" Move lines up or down
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==

" Buffers
nnoremap <leader>b :bn<CR>

" Splits
nnoremap <leader>\| <C-w>v
nnoremap <leader>- <C-w>s
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Reload configuratio
nnoremap <F5> :so $MYVIMRC<CR>

" Allow gf to open non-existent files
map gf :edit <cfile><cr>

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------

" Automatically install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(data_dir . '/plugins')

source ~/.config/nvim/plugins/airline.vim
source ~/.config/nvim/plugins/floaterm.vim
source ~/.config/nvim/plugins/fugitive.vim
source ~/.config/nvim/plugins/git-gutter.vim
source ~/.config/nvim/plugins/markdown-preview.vim
source ~/.config/nvim/plugins/nerdcommenter.vim
source ~/.config/nvim/plugins/nerdtree.vim
source ~/.config/nvim/plugins/telescope.vim
source ~/.config/nvim/plugins/tmuxline.vim
source ~/.config/nvim/plugins/termtoggle.vim
source ~/.config/nvim/plugins/theme.vim

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
	\| PlugInstall --sync | source $MYVIMRC
\| endif

doautocmd User PlugLoaded

" -----------------------------------------------------------------------------
" Auto Commands
" -----------------------------------------------------------------------------

augroup CUSTOM
	autocmd!
	" Remove trailing whitepace on save.
	autocmd BufWritePre * %s/\s\+$//e
augroup end
