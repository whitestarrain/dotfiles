local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "phaazon/hop.nvim"
plugin.loadEvent = "VeryLazy"
plugin.opts = {}
plugin.config = function()
  require("hop").setup(plugin.opts)
end
plugin.globalMappings = {
  { "n", "<leader>j", name = "jump easy" },
  { "n", "<leader>ja", ":HopAnywhere<cr>", "any where" },
  { "n", "<leader>jc", ":HopChar2<cr>", "by char" },
  { "n", "<leader>jj", ":HopLine<cr>", "line" },
  { "n", "<leader>jk", ":HopWord<cr>", "word" },
}

return plugin
