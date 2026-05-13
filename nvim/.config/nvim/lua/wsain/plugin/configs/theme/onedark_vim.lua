local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "joshdick/onedark.vim"
plugin.config = function()
  vim.cmd("colorscheme onedark")
end

return plugin
