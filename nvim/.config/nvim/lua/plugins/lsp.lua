return {
  {
    "https://github.com/neovim/nvim-lspconfig",
    event = "VeryLazy",
    cmd = { "LspInfo", "LspStart", "LspStop", "LspRestart" },
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = "VeryLazy",
    keys = {
      { "<Leader>tl", function () require("lsp_lines").toggle() end, desc = "[T]oggle [L]SP Lines" }
    },
    config = function ()
      require("lsp_lines").setup()
    end,
  }
}
