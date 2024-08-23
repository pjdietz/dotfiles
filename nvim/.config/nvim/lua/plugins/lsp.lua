return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- Must be loaded before dependants
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
        map("<Leader>fsd", require("telescope.builtin").lsp_document_symbols, "[F]ind [S]ymbols in [D]ocument")
        map("<Leader>fsw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[F]ind [S]ymbols in [W]orkspact")

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

      bashls = {},
      gopls = {},
      omnisharp = {},

      -- PHP
      intelephense = {
        CMD = { "intelephense", "--stdio" },
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
              "fpm",
              "filter",
              "hash",
              "json",
              "ldap",
              "memcached",
              "openssl",
              "opentelemetry",
              "pcntl",
              "pcre",
              "pdo",
              "redis",
              "regex",
              "session",
              "superglobals",
              "standard",
              "zlib"
            }
          }
        }
      },

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

      tsserver = {
        filetypes = { "javascript", "typescript" },
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      }, -- tsserver

    } -- servers

    local signs = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " "
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

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
