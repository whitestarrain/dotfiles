local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "andymass/vim-matchup"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return plugin
