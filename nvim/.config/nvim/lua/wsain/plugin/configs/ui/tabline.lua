local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "crispgm/nvim-tabline"
plugin.config = function()
  require("tabline").setup({
    show_index = true,
    show_modify = true,
    show_icon = false,
    fnamemodify = ":t",

    modify_indicator = "[+]",
    no_name = "No name",
    brackets = { "[", "]" },
    inactive_tab_max_length = 0,
  })
end

return plugin
