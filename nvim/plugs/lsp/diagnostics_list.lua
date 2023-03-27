vim.cmd([[
  Plug 'folke/trouble.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, trouble = pcall(require, "trouble")
  if not status then
    return
  end
  trouble.setup({})
end
