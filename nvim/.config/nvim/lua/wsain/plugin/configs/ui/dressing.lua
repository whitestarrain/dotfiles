local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "stevearc/dressing.nvim"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("dressing").setup({
    input = {
      enabled = false,
    },
    select = {},
  })
end

return plugin
