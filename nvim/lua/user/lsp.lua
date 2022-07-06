local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function (client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', '<leader>dj', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
  buf_set_keymap('n', '<leader>dk', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
  buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<cr>', opts)

end

nvim_lsp.intelephense.setup {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
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
      -- https://github.com/JetBrains/phpstorm-stubs
      stubs = {
        'Core',
        'Reflection',
        'SPL',
        'bcmath',
        'crypto',
        'curl',
        'date',
        'ds',
        'filter',
        'json',
        'memcached',
        'pcre',
        'pdo',
        'redis',
        'regex',
        'session',
        'standard',
        'zlib'
      }
    }
  }
}

nvim_lsp.bashls.setup {
  filetypes = { 'sh' },
  on_attach = on_attach
}

-- Toggle diagnostic
require('toggle_lsp_diagnostics').init()