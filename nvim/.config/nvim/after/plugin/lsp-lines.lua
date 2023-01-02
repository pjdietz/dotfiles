local lspLines = require("lsp_lines")

lspLines.setup()

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = true
})

vim.keymap.set("", "<Leader>l", lspLines.toggle, { desc = "Toggle lsp_lines" })
