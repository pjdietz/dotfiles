local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function ()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function (use)

  -- Packer can mangage itself.
  use "wbthomason/packer.nvim"

  -- Themes
  use "marko-cerovac/material.nvim"

  use "nvim-lualine/lualine.nvim"

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  }
  use { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }
  use "nvim-treesitter/playground"

  -- LSP
  use "neovim/nvim-lspconfig"
  use "jose-elias-alvarez/null-ls.nvim"
  use "onsails/lspkind-nvim"
  use "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

  -- Mason
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"

  -- Completion
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"

  -- Snipets
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  use "saadparwaiz1/cmp_luasnip"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = { {"nvim-lua/plenary.nvim"} }
  }
  use "nvim-telescope/telescope-file-browser.nvim"
  use "nvim-telescope/telescope-fzy-native.nvim"

  -- Neo Tree
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function () vim.g.neo_tree_remove_legacy_commands = 1 end
  }

  -- Neotest
  use {
    'nvim-neotest/neotest',
    requires = {
      'nvim-neotest/neotest-go',
      'olimorris/neotest-phpunit'
    },
  }

  use {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  }

  -- Misc
  use "akinsho/toggleterm.nvim"
  use "christoomey/vim-tmux-navigator"
  use "folke/twilight.nvim"
  use "folke/zen-mode.nvim"
  use { "kevinhwang91/nvim-ufo", requires = 'kevinhwang91/promise-async' }
  use "lewis6991/gitsigns.nvim"
  use "liuchengxu/vim-which-key"
  use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
  use "stevearc/dressing.nvim"
  use "tpope/vim-commentary"
  use "tpope/vim-fugitive"
  use "tpope/vim-obsession"
  use "tpope/vim-projectionist"
  use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically
  use "vim-test/vim-test"

  use {
    "vimwiki/vimwiki",
    setup = function()
      vim.g.vimwiki_list = {
        {
          path = "~/vimwiki/",
          syntax = "markdown",
          ext = ".md"
        }
      }
    end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function () require("colorizer").setup(
      {},
      { names = false }
    )
    end
  }

  use {
    "kylechui/nvim-surround",
    config = function () require("nvim-surround").setup() end
  }

  use {
    "rmagatti/auto-session",
    config = function ()
      require("auto-session").setup {
        pre_save_cmds = {"Neotree close"}
      }
    end
  }

  -- Lua
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }

  -- Languages
  use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function () vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  }
  use "othree/html5.vim"
  use "nelsyeung/twig.vim"
  use "towolf/vim-helm"
  use "fatih/vim-go"
  use "StanAngeloff/php.vim"
  use {
    "stephpy/vim-php-cs-fixer",
    setup = function ()
      vim.g.php_cs_fixer_config_file = '.php-cs-fixer.dist.php'
      vim.g.php_cs_fixer_php_path = "php"
      vim.g.php_cs_fixer_enable_default_mapping = 1
      vim.g.php_cs_fixer_dry_run = 0
      vim.g.php_cs_fixer_verbose = 0
    end
  }

  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end

end)
