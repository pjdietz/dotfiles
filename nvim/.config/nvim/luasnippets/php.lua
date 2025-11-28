local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- -------------------------------------------------------------------------
-- Helper Functions
-- -------------------------------------------------------------------------

local function find_composer_json(start_path)
  local path = start_path
  while path ~= "/" do
    local composer_path = path .. "/composer.json"
    local file = io.open(composer_path, "r")
    if file then
      file:close()
      return composer_path
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return nil
end

local function parse_composer_autoload(composer_path)
  local file = io.open(composer_path, "r")
  if not file then
    return {}
  end

  local content = file:read("*all")
  file:close()

  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    return {}
  end

  local mappings = {}

  if data.autoload and data.autoload["psr-4"] then
    for namespace, paths in pairs(data.autoload["psr-4"]) do
      local path_list = type(paths) == "table" and paths or { paths }
      for _, path in ipairs(path_list) do
        table.insert(mappings, { namespace = namespace, path = path })
      end
    end
  end

  if data["autoload-dev"] and data["autoload-dev"]["psr-4"] then
    for namespace, paths in pairs(data["autoload-dev"]["psr-4"]) do
      local path_list = type(paths) == "table" and paths or { paths }
      for _, path in ipairs(path_list) do
        table.insert(mappings, { namespace = namespace, path = path })
      end
    end
  end

  return mappings
end

local function infer_namespace()
  local file_path = vim.api.nvim_buf_get_name(0)
  local dir_path = vim.fn.fnamemodify(file_path, ":h")

  local composer_path = find_composer_json(dir_path)
  if not composer_path then
    return "App"
  end

  local composer_dir = vim.fn.fnamemodify(composer_path, ":h")
  local mappings = parse_composer_autoload(composer_path)

  local best_match = nil
  local best_match_len = 0

  for _, mapping in ipairs(mappings) do
    local autoload_path = vim.fn.fnamemodify(composer_dir .. "/" .. mapping.path, ":p:h")
    local rel_path = file_path:gsub("^" .. vim.pesc(autoload_path .. "/"), "")

    if rel_path ~= file_path and #autoload_path > best_match_len then
      best_match = {
        base_namespace = mapping.namespace:gsub("\\$", ""),
        relative_path = rel_path,
      }
      best_match_len = #autoload_path
    end
  end

  if not best_match then
    return "App"
  end

  local dir_part = vim.fn.fnamemodify(best_match.relative_path, ":h")

  if dir_part == "." then
    return best_match.base_namespace
  end

  local namespace_suffix = dir_part:gsub("/", "\\")
  return best_match.base_namespace .. "\\" .. namespace_suffix
end

-- -------------------------------------------------------------------------
-- Snippets
-- -------------------------------------------------------------------------

return {
  s(
    "classf",
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
        i(0),
      }
    )
  ),
  s(
    "<?php",
    fmt(
      [[
<?php

declare(strict_types=1);

namespace {};
]],
      {
        f(infer_namespace),
      }
    )
  ),
  s(
    "// -",
    fmt(
      [[
// -------------------------------------------------------------------------

{}
]],
      {
        i(0),
      }
    )
  ),
}
