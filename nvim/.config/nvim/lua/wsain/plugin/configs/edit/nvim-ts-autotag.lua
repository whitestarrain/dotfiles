local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "windwp/nvim-ts-autotag"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  local status_ok, _ = pcall(require, "nvim-treesitter.configs")
  if not status_ok then
    return
  end
  require("nvim-ts-autotag").setup()
end

return plugin
