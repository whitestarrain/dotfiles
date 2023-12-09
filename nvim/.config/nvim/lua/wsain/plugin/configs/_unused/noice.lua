local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "folke/noice.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
}
plugin.init = function()
  vim.o.cmdheight = 0
end
plugin.config = function()
  require("noice").setup({})
  require("notify").setup({
    background_colour = "#000000",
  })
end

return plugin
