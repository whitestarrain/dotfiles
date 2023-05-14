local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "joshdick/onedark.vim"
plugin.config = function()
  vim.cmd("colorscheme onedark")
end

return plugin
