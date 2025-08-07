local M = {}

-- URL-encode (RFC 3986)
function M.encode(str)
  str = str:gsub("\n", "\r\n")
  return (str:gsub("([^%w%-._~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

-- URL-decode (form-style: + → space)
function M.decode(str)
  str = str:gsub("%+", " ")
  return (str:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end))
end

return M
