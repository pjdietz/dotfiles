require("mason").setup()
require("mason-lspconfig").setup()

local lspconfig = require "lspconfig"

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function (_, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "K", "<CMD>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gd", "<CMD>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gD", "<CMD>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gi", "<CMD>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<CMD>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "gt", "<CMD>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>dj", "<CMD>lua vim.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "<Leader>dk", "<CMD>lua vim.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<c-k>", "<CMD>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<Leader>rn", "<CMD>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>ca", "<CMD>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<Leader>f", "<CMD>lua vim.lsp.buf.formatting()<CR>", opts)
  buf_set_keymap("n", "<Leader>q", "<CMD>lua vim.diagnostic.setloclist()<CR>", opts)

end

-- PHP
lspconfig.intelephense.setup({
  CMD = { "intelephense", "--stdio" },
  filetypes = { "php" },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
    intelephense = {
      diagnostics = {
        -- Prophecy causes a lot of false positives.
        undefinedMethods = false
      },
      formatting = true,
      -- https://github.com/JetBrains/phpstorm-stubs
      stubs = {
        "Core",
        "Reflection",
        "SPL",
        "bcmath",
        "crypto",
        "curl",
        "date",
        "ds",
        "filter",
        "hash",
        "json",
        "memcached",
        "openssl",
        "pcre",
        "pdo",
        "redis",
        "regex",
        "session",
        "standard",
        "zlib"
      }
    }
  }
})

-- Bash
lspconfig.bashls.setup({
  filetypes = { "sh" },
  on_attach = on_attach,
})

-- Go
lspconfig.gopls.setup {
  cmd = { "gopls" },
  on_attach = on_attach,
}

-- Lua
-- brew install lua-language-server
lspconfig.sumneko_lua.setup({
  filetypes = { "lua" },
  on_attach = on_attach,
  settings = {
    Lua = {
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        }
      },
      runtime = {
        -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
})

-- tsserver
lspconfig.tsserver.setup {
  filetypes = { "javascript", "typescript" },
  on_attach = on_attach,
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
}
