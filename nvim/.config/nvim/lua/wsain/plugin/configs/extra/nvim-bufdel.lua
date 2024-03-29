local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "ojroques/nvim-bufdel"
plugin.loadEvent = "VeryLazy"
plugin.opts = {
  -- how to retrieve the next buffer
  next = "tabs",
  -- quit Neovim when last buffer is closed
  quit = false,
}
plugin.config = function()
  require("bufdel").setup(plugin.opts)
end
plugin.globalMappings = {
  { "n", "<leader>zd", ":BufDelOthers<cr>", "delOtherBufs", opts = { silent = false } },
}
return plugin
