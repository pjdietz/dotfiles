return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "jose-elias-alvarez/null-ls.nvim",
    "onsails/lspkind-nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup()

    local null_ls = require "null-ls"
    null_ls.setup {
      sources = {
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.diagnostics.shellcheck
      }
    }

    local lspconfig = require "lspconfig"

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(_, bufnr)

      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("gr", function()
        require("telescope.builtin").lsp_references({
          show_line = false
        })
      end, "[G]oto [R]eferences")
      nmap("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
      nmap("<Leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
      nmap("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      -- Diagnostics
      nmap("[d", vim.diagnostic.goto_next, "Next [D]iagnostic")
      nmap("]d", vim.diagnostic.goto_prev, "Previous [D]iagnostic")
      nmap("<Leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat")
      nmap("<Leader>q", vim.diagnostic.setloclist, "Diagnostics to locallist")

    end

    local signs = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " "
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

    -- PHP
    lspconfig.intelephense.setup({
      CMD = { "intelephense", "--stdio" },
      filetypes = { "php" },
      on_attach = on_attach,
      capabilities = capabilities,
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
            "ldap",
            "memcached",
            "openssl",
            "pcntl",
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
      capabilities = capabilities,
    })

    -- C#
    lspconfig.omnisharp.setup {
      cmd = { "omnisharp" },
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Go
    lspconfig.gopls.setup {
      cmd = { "gopls" },
      on_attach = on_attach,
      capabilities = capabilities,
    }

    -- Lua
    -- brew install lua-language-server
    lspconfig.lua_ls.setup({
      filetypes = { "lua" },
      on_attach = on_attach,
      capabilities = capabilities,
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
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
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
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    }

  end
}
