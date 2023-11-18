local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "NeogitOrg/neogit"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-lua/plenary.nvim", -- required
  "nvim-telescope/telescope.nvim", -- optional
  "sindrets/diffview.nvim", -- optional
}
plugin.config = function()
  require("neogit").setup()
end

return plugin
