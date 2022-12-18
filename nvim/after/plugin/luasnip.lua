local ls = require "luasnip"

ls.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnipts = true,
}

vim.keymap.set({ "i", "s" }, "<C-k>", function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-j>", function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set("i", "<C-l>", function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

vim.keymap.set("n", "<Leader><Leader>s", "<CMD>source ~/.config/nvim/after/plugin/luasnip.lua<CR>")
require("luasnip/loaders/from_vscode").lazy_load()

-- -----------------------------------------------------------------------------
-- Friendly Snippets
ls.filetype_extend("php", { "php", "twig" })

-- -----------------------------------------------------------------------------
-- TODO Move to external file and require

local snippet_collection = require "luasnip.session.snippet_collection"

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

snippet_collection.clear_snippets "php"
ls.add_snippets("php", {
  s("class",
    fmt(
      [[
        class {}
        {{
            {}
        }}
      ]],
      {
        f(function()
          local path = vim.api.nvim_buf_get_name(0)
          local file_name = path:match("[^/]*.php$")
          return file_name:sub(0, #file_name - 4)
        end),
        i(0)
      }
    )
  )
})
