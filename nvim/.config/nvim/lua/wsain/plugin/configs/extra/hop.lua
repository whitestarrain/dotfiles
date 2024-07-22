local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "phaazon/hop.nvim"
plugin.loadEvent = "VeryLazy"
plugin.opts = {}
plugin.config = function()
  require("hop").setup(plugin.opts)
  require("wsain.plugin.whichkey").register({
    { "<leader>j", group = "jump easy" },
    { "<leader>ja", ":HopAnywhere<cr>", desc = "any where" },
    { "<leader>jc", ":HopChar2<cr>", desc = "by char" },
    { "<leader>jj", ":HopLine<cr>", desc = "line" },
    { "<leader>jk", ":HopWord<cr>", desc = "word" },
  })
end

return plugin
