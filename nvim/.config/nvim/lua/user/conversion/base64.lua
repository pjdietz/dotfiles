local M = {}

local alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                 .. 'abcdefghijklmnopqrstuvwxyz'
                 .. '0123456789+/'

-- Reverse lookup table
local inverse = {}
for i = 1, #alphabet do
  inverse[alphabet:sub(i, i)] = i - 1
end

function M.encode(data)
  local res = {}
  local len = #data
  for i = 1, len, 3 do
    local b1 = data:byte(i)     or 0
    local b2 = data:byte(i+1)   or 0
    local b3 = data:byte(i+2)   or 0
    -- pack into a 24-bit integer
    local n24 = b1 * 65536 + b2 * 256 + b3
    -- extract four 6-bit indexes
    local c1 = math.floor(n24 / 262144) % 64  -- 2^18
    local c2 = math.floor(n24 / 4096)   % 64  -- 2^12
    local c3 = math.floor(n24 / 64)     % 64  -- 2^6
    local c4 = n24                      % 64
    -- map to chars, pad with '=' if we ran past the end
    res[#res+1] = alphabet:sub(c1+1, c1+1)
    res[#res+1] = alphabet:sub(c2+1, c2+1)
    res[#res+1] = (i+1 <= len) and alphabet:sub(c3+1, c3+1) or '='
    res[#res+1] = (i+2 <= len) and alphabet:sub(c4+1, c4+1) or '='
  end
  return table.concat(res)
end

function M.decode(str)
  -- strip out any non-Base64 chars (incl. newlines, spaces)
  str = str:gsub('[^'..alphabet..'=]', '')
  local res = {}
  for i = 1, #str, 4 do
    local c1 = inverse[str:sub(i,   i  )] or 0
    local c2 = inverse[str:sub(i+1, i+1)] or 0
    local c3 = inverse[str:sub(i+2, i+2)] or 0
    local c4 = inverse[str:sub(i+3, i+3)] or 0
    -- re-pack into 24 bits
    local n24 = c1 * 262144 + c2 * 4096 + c3 * 64 + c4
    -- extract up to three 8-bit bytes
    local b1 = math.floor(n24 / 65536) % 256
    local b2 = math.floor(n24 / 256)   % 256
    local b3 = n24                     % 256
    res[#res+1] = string.char(b1)
    if str:sub(i+2,i+2) ~= '=' then res[#res+1] = string.char(b2) end
    if str:sub(i+3,i+3) ~= '=' then res[#res+1] = string.char(b3) end
  end
  local out = table.concat(res)
  out = out:gsub("%z+$", "")
  return out
end

return M
