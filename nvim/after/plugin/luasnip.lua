local ls = require "luasnip"
local s = ls.s
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("all", {
})

ls.add_snippets("lua", {
  s("req", fmt("local {} = require \"{}\"", { i(1, "default"), rep(1) }))
})

