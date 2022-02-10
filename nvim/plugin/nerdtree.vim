let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1

let NERDTreeWinSize = 40

" let g:NERDTreeDirArrowExpandable = "\u00a0"
" let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeDirArrowCollapsible = '▾'

nnoremap <leader>t :NERDTreeToggle <CR>

" avoid crashes when calling vim-plug functions while the cursor is on the NERDTree window
let g:plug_window = 'noautocmd vertical topleft new'

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1
