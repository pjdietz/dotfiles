return {
  {
    "kylechui/nvim-surround",
    config = function () require("nvim-surround").setup() end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup {}
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    config = function ()
      require("which-key").setup()
      require("which-key").register({
        ['<Leader>f'] = { name = "[F]ind", _ = "which_key_ignore" },
        ['<Leader>fg'] = { name = "[F]ind [G]it", _ = "which_key_ignore" },
        ['<Leader>fs'] = { name = "[F]ind [S]ymbols", _ = "which_key_ignore" },
        ['<Leader>g'] = { name = "[G]it", _ = "which_key_ignore" },
        ['<Leader>h'] = { name = "[H]unk", _ = "which_key_ignore" },
        ['<Leader>t'] = { name = "[T]oggle", _ = "which_key_ignore" },
      })
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
  { "johmsalas/text-case.nvim", config = function() require("textcase").setup {} end },
  { "kevinhwang91/nvim-ufo", dependencies = "kevinhwang91/promise-async" },
  {
    "mbbill/undotree",
    keys = {
      { "<F3>", "<CMD>UndotreeToggle<CR>", desc = "[U]ndo Tree" },
      { "<Leader>u", "<CMD>UndotreeToggle<CR>", desc = "[U]ndo Tree" }
    }
  },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "stevearc/dressing.nvim",
  "tpope/vim-dotenv",
  "tpope/vim-fugitive",
  "tpope/vim-obsession",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
}
