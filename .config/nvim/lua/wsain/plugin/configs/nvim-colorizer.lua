local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "norcalli/nvim-colorizer.lua"
plugin.config = function()
  require("colorizer").setup({ "json", "xml", "html", "css", "ps1", "lua", "vim", "yaml" })
end

return plugin
