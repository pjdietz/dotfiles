vim.lsp.enable({
  "bashls",
  "gopls",
  "intelephense",
  "lua_ls",
  "ts_ls",
})

vim.diagnostic.config({
  virtual_lines = true,
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", vim.lsp.buf.hover, "Hover Documentation")
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
