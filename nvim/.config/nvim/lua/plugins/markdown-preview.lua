return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && yarn install",
  init = function () vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    { "<Leader>mp", "<Plug>MarkdownPreviewToggle<CR>", desc = "[M]arkdown [P]review" }
  }
}
