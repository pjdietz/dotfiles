return {

  -- Themes
  "marko-cerovac/material.nvim",
  "nvim-lualine/lualine.nvim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      pcall(require("nvim-treesitter.install").update { with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    }
  },
  "nvim-treesitter/playground",

  -- LSP
  "neovim/nvim-lspconfig",
  "jose-elias-alvarez/null-ls.nvim",
  "onsails/lspkind-nvim",
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

  -- Mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",

  -- Snipets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "saadparwaiz1/cmp_luasnip",

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  "nvim-telescope/telescope-file-browser.nvim",
  "nvim-telescope/telescope-fzy-native.nvim",

  -- Neotest
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-go',
      'olimorris/neotest-phpunit'
    },
  },

  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  {
    "vimwiki/vimwiki",
    init = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/",
          syntax = "markdown",
          ext = ".md"
        }
      }
    end
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function () require("colorizer").setup(
      {},
      { names = false }
    )
    end
  },

  {
    "kylechui/nvim-surround",
    config = function () require("nvim-surround").setup() end
  },

  -- Lua
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end
  },

  -- Languages
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function () vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  "othree/html5.vim",
  "nelsyeung/twig.vim",
  "towolf/vim-helm",
  "fatih/vim-go",
  "StanAngeloff/php.vim",
  {
    "stephpy/vim-php-cs-fixer",
    init = function ()
      vim.g.php_cs_fixer_config_file = '.php-cs-fixer.dist.php'
      vim.g.php_cs_fixer_php_path = "php"
      vim.g.php_cs_fixer_enable_default_mapping = 1
      vim.g.php_cs_fixer_dry_run = 0
      vim.g.php_cs_fixer_verbose = 0
    end
  },

   -- Misc
  "akinsho/toggleterm.nvim",
  "christoomey/vim-tmux-navigator",
  "echasnovski/mini.nvim",
  "folke/twilight.nvim",
  "folke/zen-mode.nvim",
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  "lewis6991/gitsigns.nvim",
  "liuchengxu/vim-which-key",
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "stevearc/dressing.nvim",
  "tpope/vim-commentary",
  "tpope/vim-fugitive",
  "tpope/vim-obsession",
  "tpope/vim-projectionist",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  "vim-test/vim-test",
}
