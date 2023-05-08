local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "stevearc/dressing.nvim"
plugin.loadEvent = "VeryLazy"
plugin.opts = {}
plugin.config = function()
  require("dressing").setup(plugin.opts)
end

return plugin
