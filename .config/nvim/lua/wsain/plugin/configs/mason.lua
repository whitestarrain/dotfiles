local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "williamboman/mason.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "mason-org/mason-registry",
}
plugin.config = function()
  require("mason").setup({
    install_root_dir = vim.g.absolute_config_path .. ".mason",
    ui = {
      border = "single",
    },
    registries = {
      "github:mason-org/mason-registry",
    },
  })
end

return plugin
