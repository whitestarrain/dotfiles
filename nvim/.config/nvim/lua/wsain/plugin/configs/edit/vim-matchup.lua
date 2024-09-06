local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "andymass/vim-matchup"
plugin.loadEvent = "BufReadPost"
plugin.config = function()
  vim.g.matchup_matchparen_offscreen = {}
  vim.g.matchup_matchparen_pumvisible = 0
end

return plugin
