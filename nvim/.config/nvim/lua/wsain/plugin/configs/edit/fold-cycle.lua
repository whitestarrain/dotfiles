local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "jghauser/fold-cycle.nvim"
plugin.load_event = "VeryLazy"
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
