local M = {}

---@param origin_tb? table
---@param custom_tb? table
---@return table
function M.deep_merge(origin_tb, custom_tb)
  origin_tb = origin_tb or {}
  custom_tb = custom_tb or {}
  return vim.tbl_deep_extend("force", origin_tb, custom_tb)
end

---@param t any[]
---@return any[]
function M.list_unique(t)
  local check = {}
  local result = {}
  for _, value in ipairs(t) do
    if not check[value] then
      table.insert(result, value)
      check[value] = true
    end
  end
  return result
end

return M
