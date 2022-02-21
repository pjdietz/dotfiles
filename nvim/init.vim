let mapleader = "\<space>"

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
Plug 'nvim-telescope/telescope-file-browser.nvim'
" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'onsails/lspkind-nvim'
" CMP
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'akinsho/toggleterm.nvim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'vim-airline/vim-airline'
Plug 'StanAngeloff/php.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'christoomey/vim-tmux-navigator'
Plug 'edkolev/tmuxline.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
Plug 'liuchengxu/vim-which-key'
Plug 'lewis6991/gitsigns.nvim'
Plug 'towolf/vim-helm'
Plug 'fatih/vim-go'

call plug#end()

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \| PlugInstall --sync | source $MYVIMRC
        \| endif

" -----------------------------------------------------------------------------
" After plugins
" -----------------------------------------------------------------------------

nmap <leader>mp <Plug>MarkdownPreviewToggle
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
set timeoutlen=500

let g:material_theme_style = 'darker-community'
let g:material_terminal_italics = 1
let g:airline_theme='material'

colorscheme material
if exists('*FixThemeColors')
    call FixThemeColors()
endif

" -----------------------------------------------------------------------------
" Auto Commands
" -----------------------------------------------------------------------------

augroup CUSTOM
    autocmd!
    " Remove trailing whitepace on save.
    autocmd BufWritePre * %s/\s\+$//e
    " Use // for commenting out lines in PHP
    autocmd FileType php setlocal commentstring=//\ %s
    " 2-spaces for shell scripts
    autocmd FileType sh setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup end
