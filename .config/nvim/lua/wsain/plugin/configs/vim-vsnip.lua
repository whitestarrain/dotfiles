local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "hrsh7th/vim-vsnip"
plugin.event = "VeryLazy"
plugin.dependencies = {
  "rafamadriz/friendly-snippets",
}
plugin.init = function()
  vim.g.vsnip_snippet_dir = vim.g.absolute_config_path .. "others/.snippet"
end

return plugin
