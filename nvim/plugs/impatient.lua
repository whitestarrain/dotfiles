vim.cmd([[
  Plug 'lewis6991/impatient.nvim'
]])

-- 启动时间优化
require("au")["User LoadPluginConfig"] = function()
  local status, impatient = pcall(require, "impatient")
  if not status then
    return
  end
end
