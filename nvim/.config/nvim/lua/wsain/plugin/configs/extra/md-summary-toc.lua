local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "whitestarrain/md-summary-toc.nvim"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("md-summary-toc").setup()
end

return plugin

