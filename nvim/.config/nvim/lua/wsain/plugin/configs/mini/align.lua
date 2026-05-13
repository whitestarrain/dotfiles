local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "nvim-mini/mini.nvim"
plugin.config = function()
  require("mini.align").setup()
end

return plugin
