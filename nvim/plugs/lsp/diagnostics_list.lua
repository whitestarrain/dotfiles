vim.cmd[[
  Plug 'folke/trouble.nvim'
]]

require("au")["User LoadPluginConfig"] = function()
  require("trouble").setup{}
end

