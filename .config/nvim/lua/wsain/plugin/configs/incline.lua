local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "b0o/incline.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("incline").setup()
end

return plugin
