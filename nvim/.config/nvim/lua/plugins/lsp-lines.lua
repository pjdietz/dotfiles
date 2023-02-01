return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function ()
    local lspLines = require("lsp_lines")

    lspLines.setup()

    vim.diagnostic.config({
      virtual_text = false,
      virtual_lines = true
    })

    vim.keymap.set("", "<Leader>l", lspLines.toggle, { desc = "Toggle [L]SP Lines" })

  end
}
