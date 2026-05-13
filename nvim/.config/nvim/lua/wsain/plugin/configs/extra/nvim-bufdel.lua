local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "ojroques/nvim-bufdel"
plugin.load_event = "VeryLazy"
plugin.opts = {
  -- how to retrieve the next buffer
  next = "tabs",
  -- quit Neovim when last buffer is closed
  quit = false,
}
plugin.config = function()
  require("bufdel").setup(plugin.opts)
  require("wsain.plugin.whichkey").register({
    { "<leader>zd", ":BufDelOthers<cr>", desc = "delOtherBufs", silent = false },
  })
end
return plugin
