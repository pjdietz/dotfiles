Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

nmap <leader>mp <Plug>MarkdownPreviewToggle
