local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "stevearc/dressing.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("dressing").setup({
    input = {
      enabled = false,
    },
    select = {},
  })
end

return plugin
