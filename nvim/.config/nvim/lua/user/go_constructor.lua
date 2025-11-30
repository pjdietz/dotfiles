local M = {}

local function find_struct_above_cursor()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local parser = vim.treesitter.get_parser(0, "go")
  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.parse("go", [[
    (type_declaration
      (type_spec
        name: (type_identifier) @struct_name
        type: (struct_type) @struct_body))
  ]])

  local struct_name = nil
  local struct_node = nil
  local closest_row = -1
  local candidates = {}

  for id, node in query:iter_captures(root, 0, 0, -1) do
    local capture_name = query.captures[id]
    local node_row = node:range()
    
    if node_row < cursor_row then
      if not candidates[node_row] then
        candidates[node_row] = {}
      end
      candidates[node_row][capture_name] = node
    end
  end

  for row, captures in pairs(candidates) do
    if row > closest_row and captures.struct_name and captures.struct_body then
      closest_row = row
      struct_name = vim.treesitter.get_node_text(captures.struct_name, 0)
      struct_node = captures.struct_body
    end
  end

  return struct_name, struct_node
end

local function extract_struct_fields(struct_node)
  if not struct_node then
    return {}
  end

  local fields = {}
  
  for child in struct_node:iter_children() do
    if child:type() == "field_declaration_list" then
      for field_decl in child:iter_children() do
        if field_decl:type() == "field_declaration" then
          local field_name = nil
          local field_type = nil
          
          for field_child in field_decl:iter_children() do
            if field_child:type() == "field_identifier" then
              field_name = vim.treesitter.get_node_text(field_child, 0)
            elseif field_child:type() ~= "field_identifier" and field_child:type() ~= "comment" then
              field_type = vim.treesitter.get_node_text(field_child, 0)
            end
          end
          
          if field_name and field_type then
            table.insert(fields, { name = field_name, type = field_type })
          end
        end
      end
    end
  end

  return fields
end

function M.generate_constructor()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local struct_name, struct_node = find_struct_above_cursor()

  if not struct_name then
    vim.notify("No struct found above cursor", vim.log.levels.ERROR)
    return
  end

  local fields = extract_struct_fields(struct_node)
  local func_name = "New" .. struct_name

  local params = {}
  local field_assignments = {}
  
  for _, field in ipairs(fields) do
    local param_name = field.name:sub(1, 1):lower() .. field.name:sub(2)
    table.insert(params, param_name .. " " .. field.type)
    table.insert(field_assignments, "\t\t" .. field.name .. ": " .. param_name .. ",")
  end

  local lines = { "" }
  table.insert(lines, string.format("func %s(%s) *%s {", func_name, table.concat(params, ", "), struct_name))
  table.insert(lines, string.format("\treturn &%s{", struct_name))
  
  for _, assignment in ipairs(field_assignments) do
    table.insert(lines, assignment)
  end
  
  table.insert(lines, "\t}")
  table.insert(lines, "}")

  vim.api.nvim_buf_set_lines(0, row, row, false, lines)
end

return M
