local M = {}

local base64 = require("user.conversion.base64")

function M.pretty(json_str)
  if vim.fn.executable("jq") == 0 then
    error("`jq` not found in PATH")
  end
  local result = vim.fn.system({ "jq", "." }, json_str)
  -- check exit code
  if vim.v.shell_error ~= 0 then
    error(string.format("`jq` error (code %d): %s", vim.v.shell_error, result))
  end
  return result
end

function M.jwt_decode(jwt)
  local parts = vim.split(jwt, ".", { plain = true })
  local header = parts[1]
  local payload = parts[2]
  return "JWT Header:\n"
    .. M.pretty(base64.decode(header)) .. "\n"
    .. "JWT Payload:\n"
    .. M.pretty(base64.decode(payload))
end

return M
