local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
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
          local file_name = path:match("([^/]+)%.php$")
          if file_name then
            return file_name
          end
          return "ClassName"
        end),
        i(0)
      }
    )
  ),
  s("<?php",
    fmt([[
      <?php

      declare(strict_types=1);

      namespace {}
    ]], {
        i(0)
    })
  ),
  s("// -",
    fmt([[
      // -------------------------------------------------------------------------

      {}
    ]], {
        i(0)
    })
  )
}
