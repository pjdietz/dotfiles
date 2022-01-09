" -----------------------------------------------------------------------------
" Mappings
" -----------------------------------------------------------------------------

let mapleader = "\<space>"

" Move lines up or down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

" Buffers
nnoremap <TAB> :bn<CR>
nnoremap <S-TAB> :bp<CR>
nnoremap <leader><TAB> :bp\|bd #<CR>

" Splits
nnoremap <leader>\| <C-w>v
nnoremap <leader>- <C-w>s
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Reload configuration
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

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Goyo and Limelight
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" Nerdtree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'voldikss/vim-floaterm'
Plug 'liuchengxu/vim-which-key'

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
			\| PlugInstall --sync | source $MYVIMRC
			\| endif

doautocmd User PlugLoaded

" -----------------------------------------------------------------------------
" After plugins
" -----------------------------------------------------------------------------

nmap <leader>mp <Plug>MarkdownPreviewToggle
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

colorscheme material

let g:material_terminal_italics = 1
let g:material_theme_style = 'darker-community'
let g:airline_theme = 'material'

" -----------------------------------------------------------------------------
" Auto Commands
" -----------------------------------------------------------------------------

augroup CUSTOM
	autocmd!
	" Remove trailing whitepace on save.
	autocmd BufWritePre * %s/\s\+$//e
augroup end
