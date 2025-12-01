local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

-- -------------------------------------------------------------------------
-- Helper Functions
-- -------------------------------------------------------------------------

local function get_today()
  return os.date("%A, %B ") .. tostring(tonumber(os.date("%d")))
end

-- -------------------------------------------------------------------------
-- Snippets
-- -------------------------------------------------------------------------

return {
  s("today", {
    f(get_today),
  }),
}
