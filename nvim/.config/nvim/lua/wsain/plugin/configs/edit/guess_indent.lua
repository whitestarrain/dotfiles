local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "NMAC427/guess-indent.nvim"
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("guess-indent").setup({
    auto_cmd = true,
    override_editorconfig = true,
    filetype_exclude = {
      "netrw",
      "tutor",
    },
    buftype_exclude = {
      "help",
      "nofile",
      "terminal",
      "prompt",
    },
  })
end

return plugin
