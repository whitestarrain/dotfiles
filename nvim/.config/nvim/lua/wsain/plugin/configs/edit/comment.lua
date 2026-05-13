local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "numToStr/Comment.nvim"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("Comment").setup()
end
return plugin
