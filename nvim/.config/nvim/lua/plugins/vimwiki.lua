local function open_journal()
  local entry = os.date("~/vimwiki/journal/%Y-%m.md")
  vim.cmd.edit(entry)
  vim.cmd("normal G")
end

return {
  "vimwiki/vimwiki",
  keys = {
    { "<Leader>ww", "<Plug>VimwikiIndex", desc = "Open Vim[W]iki" },
    { "<Leader>wj", open_journal, desc = "Open Vim[W]iki [J]ournal" },
    { "<Leader>x", "<Plug>VimwikiToggleListItem", desc = "Toggle List Item" },
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
