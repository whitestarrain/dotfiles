local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "whitestarrain/md-summary-toc.nvim"
plugin.load_event = "VeryLazy"
plugin.config = function()
  require("md-summary-toc").setup()
  require("wsain.utils").add_command_before_save_session("silent! MdSummaryTocClose")
end

return plugin

