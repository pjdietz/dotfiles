return {

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
  "christoomey/vim-tmux-navigator",
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  "liuchengxu/vim-which-key",
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "stevearc/dressing.nvim",
  "tpope/vim-commentary",
  "tpope/vim-fugitive",
  "tpope/vim-obsession",
  {
    "tpope/vim-projectionist",
    keys = {
      { "<Leader>aa", "<CMD>A<CR>", { desc = "Switch to alternate file" } },
      { "<Leader>av", "<CMD>AV<CR>", { desc = "Switch to alternate file (split)" } },
    },
  },
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
}
