local Template = require("wsain.plugin.template")
local plugin = Template:new()
plugin.shortUrl = "ojroques/nvim-bufdel"
plugin.opts = {
  -- how to retrieve the next buffer
  next = "tabs",
  -- quit Neovim when last buffer is closed
  quit = false,
}
plugin.config = function()
  require("bufdel").setup(plugin.opts)
end
return plugin
