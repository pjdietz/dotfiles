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
      require("which-key").add({
        { "<Leader>f", group = "[F]ind" },
        { "<Leader>fg", group = "[F]ind [G]it" },
        { "<Leader>fs", group = "[F]ind [S]ymbols" },
        { "<Leader>g", group = "[G]it" },
        { "<Leader>h", group = "[H]unk" },
        { "<Leader>t", group = "[T]oggle" },
      })
    end
  },
  {
    "danymat/neogen",
    config = function ()
      require("neogen").setup({
        snippet_engine = "luasnip"
      })
    end,
    keys = {
      { "<Leader>cb", function () require("neogen").generate() end, desc = "[C]reate Doc[B]lock" }
    }
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
