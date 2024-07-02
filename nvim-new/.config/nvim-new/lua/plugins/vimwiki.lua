return {
  "vimwiki/vimwiki",
  keys = {
    { "<Leader>ww", "<Plug>VimwikiIndex", { desc = "Open Vimwiki" } },
    { "<Leader>x", "<Plug>VimwikiToggleListItem", { desc = "Toggle List Item" } },
  },
  ft = { "markdown" },
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
