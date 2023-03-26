vim.cmd([[
  Plug 'norcalli/nvim-colorizer.lua'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, colorizer = pcall(require, "colorizer")
  if not status then
    return
  end
  colorizer.setup({ "json", "xml", "html", "css", "ps1", "lua", "vim", "yaml" })
end
