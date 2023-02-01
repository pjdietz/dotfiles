return {
  "vimwiki/vimwiki",
  keys = {
    { "<Leader>ww", "<Plug>VimwikiIndex", { desc = "Open Vimwiki" } },
  },
  ft = { "markdown", "vimwiki" },
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/vimwiki/",
        syntax = "markdown",
        ext = ".md"
      }
    }
  end
}
