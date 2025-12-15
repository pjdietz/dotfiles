---@module "lazy"
---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "master",
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
  },
  opts = {
    ensure_installed = {
      "bash",
      "c_sharp",
      "diff",
      "dockerfile",
      "git_config",
      "git_rebase",
      "gitcommit",
      "gitignore",
      "go",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "php",
      "sql",
      "vim",
      "vimdoc",
    },
    auto_install = true,
    highlight = {
      enable = true,
      disable = { "dockerfile" },
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true
    },
    injections = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- init_selection = '<C-Space>',
        -- node_incremental = '<C-Space>',
        scope_incremental = '<C-s>',
        node_decremental = '<C-BS>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/tree/master#built-in-textobjects
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['ac'] = '@comment.outer',
          ['ic'] = '@comment.outer', -- comment does not have an inner
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ai'] = '@conditional.outer',
          ['ii'] = '@conditional.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']f'] = '@function.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>sa'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>SA'] = '@parameter.inner',
        },
      },
    },
    playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
      },
    },
  },
  config = function (_, opts)
    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup(opts)
  end,
}
