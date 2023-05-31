local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "troydm/zoomwintab.vim"
plugin.loadEvent = "VeryLazy"
plugin.globalMappings = {
  { "n", "<leader>zz", ":ZoomWinTabToggle<cr>", "zoom toogle" },
}
return plugin
