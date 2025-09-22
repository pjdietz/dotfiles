return {
  "iamcco/markdown-preview.nvim",
  -- build = "cd app && yarn install",
  build = function() vim.fn["mkdp#util#install"]() end,
  init = function () vim.g.mkdp_filetypes = { "markdown" } end,
  ft = { "markdown" },
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  keys = {
    { "<Leader>mp", "<Plug>MarkdownPreviewToggle<CR>", desc = "[M]arkdown [P]review" }
  }
}

-- If you get an error loading, run this manually to install npm packages.
-- cd ~/.local/share/nvim/lazy/markdown-preview.nvim
-- npm install
