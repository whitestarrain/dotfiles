vim.cmd[[
  Plug 'lewis6991/impatient.nvim'
]]

-- 启动时间优化
require("au")["User LoadPluginConfig"] = function()
  require('impatient')
end
