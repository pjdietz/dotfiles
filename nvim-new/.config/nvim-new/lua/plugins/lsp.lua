return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    "onsails/lspkind-nvim",
    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)

        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
        map("gr", function()
          require("telescope.builtin").lsp_references({
            show_line = false
          })
        end, "[G]oto [R]eferences")
        map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
        map("<Leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
        map("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Diagnostics
        map("[d", vim.diagnostic.goto_next, "Next [D]iagnostic")
        map("]d", vim.diagnostic.goto_prev, "Previous [D]iagnostic")
        map("<Leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat")
        map("<Leader>q", vim.diagnostic.setloclist, "Diagnostics to locallist")

      end
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    local servers = {

      gopls = {},

      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
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
            },
          },
        },
      }, -- lua_ls

    } -- servers

    require("mason").setup()

    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
    })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for tsserver)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }

  end,
}

    -- local signs = {
    --   Error = " ",
    --   Warn = " ",
    --   Hint = " ",
    --   Info = " "
    -- }

    -- for type, icon in pairs(signs) do
    --   local hl = "DiagnosticSign" .. type
    --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    -- end

    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities.textDocument.foldingRange = {
    --   dynamicRegistration = false,
    --   lineFoldingOnly = true
    -- }

    -- -- PHP
    -- lspconfig.intelephense.setup({
    --   CMD = { "intelephense", "--stdio" },
    --   filetypes = { "php" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    --   settings = {
    --     -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md#configuration-options
    --     intelephense = {
    --       diagnostics = {
    --         -- Prophecy causes a lot of false positives.
    --         undefinedMethods = false
    --       },
    --       formatting = true,
    --       -- https://github.com/JetBrains/phpstorm-stubs
    --       stubs = {
    --         "Core",
    --         "Reflection",
    --         "SPL",
    --         "bcmath",
    --         "crypto",
    --         "curl",
    --         "date",
    --         "ds",
    --         "fmp",
    --         "filter",
    --         "hash",
    --         "json",
    --         "ldap",
    --         "memcached",
    --         "openssl",
    --         "opentelemetry",
    --         "pcntl",
    --         "pcre",
    --         "pdo",
    --         "redis",
    --         "regex",
    --         "session",
    --         "superglobals",
    --         "standard",
    --         "zlib"
    --       }
    --     }
    --   }
    -- })

    -- -- Bash
    -- lspconfig.bashls.setup({
    --   filetypes = { "sh" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- })

    -- -- C#
    -- -- lspconfig.csharp_ls.setup {
    -- --   cmd = { "csharp-ls" },
    -- --   on_attach = on_attach,
    -- --   capabilities = capabilities,
    -- -- }
    -- lspconfig.omnisharp.setup {
    --   cmd = { "omnisharp" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- }

    -- -- Go
    -- lspconfig.gopls.setup {
    --   cmd = { "gopls" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- }

    -- -- Go Templ
    -- lspconfig.templ.setup {
    --   -- cmd = { "templ" },
    --   filetypes = { "templ" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    -- }

    -- vim.filetype.add({ extension = { templ = "templ" } })

    -- -- Lua
    -- -- brew install lua-language-server
    -- lspconfig.lua_ls.setup({
    --   filetypes = { "lua" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   settings = {
    --     Lua = {
    --       completion = {
    --         callSnippet = "Replace",
    --       },
    --       format = {
    --         enable = true,
    --         defaultConfig = {
    --           indent_style = "space",
    --           indent_size = "2",
    --         }
    --       },
    --       runtime = {
    --         -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
    --         version = "LuaJIT",
    --       },
    --       diagnostics = {
    --         globals = { "vim" }
    --       },
    --       workspace = {
    --         library = vim.api.nvim_get_runtime_file("", true)
    --       }
    --     }
    --   }
    -- })

    -- -- tsserver
    -- lspconfig.tsserver.setup {
    --   filetypes = { "javascript", "typescript" },
    --   on_attach = on_attach,
    --   capabilities = capabilities,
    --   init_options = {
    --     preferences = {
    --       disableSuggestions = true,
    --     },
    --   },
    -- }

  -- end
-- }
