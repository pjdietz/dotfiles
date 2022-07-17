-- Leader key -> <Space>
-- Set this early to avoid adding keymaps with the default leder
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load configurations from the module found in ./lua/user
require "user.options"
require "user.keymap"
require "user.plugins"

require "user.colorscheme"
require "user.lualine"

require "user.telescope"
require "user.luasnip"
require "user.treesitter"
require "user.lsp"
require "user.null-ls"
require "user.completion"

require "user.rest"
require "user.gitsigns"
require "user.neo-tree"
require "user.toggleterm"
require "user.markdown-preview"
require "user.vimwiki"
require "user.vim-test"

require "user.tmux-auto-pane"
