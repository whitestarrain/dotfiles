local plugin = require("wsain.plugin.template"):new()
plugin.short_url = "troydm/zoomwintab.vim"
plugin.load_event = "VeryLazy"
plugin.config = function()
  -- disable default map
  vim.cmd("unmap <C-w_o>")
  require("wsain.plugin.whichkey").register({
    { "<leader>zz", ":ZoomWinTabToggle<cr>", desc = "zoom toogle" },
  })
end
return plugin
