local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "troydm/zoomwintab.vim"
plugin.loadEvent = "VeryLazy"
plugin.globalMappings = {
  { "n", "<leader>zz", ":ZoomWinTabToggle<cr>", "zoom toogle" },
}
plugin.config = function()
  -- disable default map
  vim.cmd("unmap <C-w_o>")
end
return plugin
