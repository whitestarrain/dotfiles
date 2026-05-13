---@diagnostic disable: param-type-mismatch, cast-local-type
local M = {}

local modules = { "common", "colors", "string", "system", "file", "vim_api", "plugin" }
for _, mod_name in ipairs(modules) do
  local mod = require("wsain.utils." .. mod_name)
  for k, v in pairs(mod) do
    M[k] = v
  end
end

return M
