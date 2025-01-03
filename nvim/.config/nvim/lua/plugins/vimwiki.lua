local function open_journal()
  local entry = os.date("~/vimwiki/journal/%Y-%m.md")
  vim.cmd.edit(entry)
  vim.cmd("normal G")
end

local function open_scratch()
  local entry = os.date("~/vimwiki/scratch/index.md")
  vim.cmd.edit(entry)
end

return {
  "vimwiki/vimwiki",
  keys = {
    { "<Leader>ww", "<Plug>VimwikiIndex", desc = "Open Vim[W]iki" },
    { "<Leader>wj", open_journal, desc = "Open Vim[W]iki [J]ournal" },
    { "<Leader>ws", open_scratch, desc = "Open Vim[W]iki [S]cratch" },
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
