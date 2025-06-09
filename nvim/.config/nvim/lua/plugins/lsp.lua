return {
  {
    "https://github.com/neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    enabled = true,
    config = function ()
      local lsp_lines = require("lsp_lines")

      lsp_lines.setup()

      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false
      })

      vim.keymap.set("", "<Leader>tl", lsp_lines.toggle, { desc = "[T]oggle [L]SP Lines" })

    end
  }
}
