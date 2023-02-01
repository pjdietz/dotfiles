return {
  "iamcco/markdown-preview.nvim",
  build = "cd app && npm install",
  init = function () vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
  keys = {
    { "<Leader>mp", "<Plug>MarkdownPreviewToggle<CR>", { desc = "[M]arkdown [P]review" } }
  }
}
