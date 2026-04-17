local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "sheerun/vim-polyglot"
plugin.loadEvent = "VeryLazy"

plugin.init = function()
  vim.g.polyglot_disabled = { "markdown" }
end

return plugin
