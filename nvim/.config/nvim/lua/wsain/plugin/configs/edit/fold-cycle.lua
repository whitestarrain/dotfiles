local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "jghauser/fold-cycle.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("fold-cycle").setup()

  require("wsain.plugin.whichkey").register({
    {
      "za",
      function()
        require("fold-cycle").toggle_all()
      end,
      desc = "toggle fold recursively",
      mode = "n",
    },
  })
end
return plugin
