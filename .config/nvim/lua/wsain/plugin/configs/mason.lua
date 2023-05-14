local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "williamboman/mason.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("mason").setup({
    install_root_dir = vim.g.absolute_config_path .. ".mason",
    ui = {
      border = "single",
    },
  })
end

return plugin
