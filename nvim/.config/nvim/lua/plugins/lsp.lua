return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "onsails/lspkind-nvim",
    -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    { "folke/neodev.nvim", opts = {} },
    { "saghen/blink.cmp" },
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
        -- map("<C-K>", vim.lsp.buf.signature_help, "Signature Documentation")

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
        map("<Leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat")
        map("<Leader>q", vim.diagnostic.setloclist, "Diagnostics to locallist")

      end
    })

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

    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- bashls
    lspconfig.bashls.setup({
      capabilities = capabilities,
      settings = {
        bashls = {
          diagnostic = {
            excludeGlobs = { ".env" },
          },
        },
      },
    }) -- bashls

    -- gopls
    lspconfig.gopls.setup({
      capabilities = capabilities,
      settings = {
        gopls = {
          buildFlags = { "-tags=integration" },
        }
      }
    }) -- gopls

    -- lua_ls
    lspconfig.lua_ls.setup({
      capabilities = capabilities,
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
    }) -- lua_ls

    -- omnisharp
    lspconfig.omnisharp.setup({
      capabilities = capabilities
    }) -- omnisharp

    -- intelephense
    lspconfig.intelephense.setup({
      capabilities = capabilities,
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
    }) -- intelephense

    -- ts_ls
    lspconfig.ts_ls.setup({
      filetypes = { "javascript", "typescript" },
      init_options = {
        preferences = {
          disableSuggestions = true,
        },
      },
    }) -- ts_ls

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "bashls", "gopls", "lua_ls", "intelephense", "ts_ls" },
    })

  end,
}
