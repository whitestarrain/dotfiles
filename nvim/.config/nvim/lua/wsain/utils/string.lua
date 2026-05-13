local M = {}

---@param str string
---@return string
function M.escape_pattern(str)
  return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c)
    return "%" .. c
  end)
end

---@param inputstr? string
---@param sep? string
---@return string[]
function M.split_string(inputstr, sep)
  inputstr = inputstr or ""
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

return M
