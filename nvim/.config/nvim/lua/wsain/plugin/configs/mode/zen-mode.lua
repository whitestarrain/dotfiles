local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "folke/zen-mode.nvim"
plugin.loadEvent = "VeryLazy"

plugin.config = function()
  require("zen-mode").setup()

  require("wsain.plugin.whichkey").register({
    { "<leader>zm", group = "+mode" },
    {
      "<leader>zmz",
      function()
        require("zen-mode").toggle({
          window = {
            -- width will be 85% of the editor width
            width = 0.6,
          },
        })
      end,
      desc = "zen mode",
    },
  })
end

return plugin
