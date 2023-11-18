local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "numToStr/Comment.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("Comment").setup()
end
return plugin
