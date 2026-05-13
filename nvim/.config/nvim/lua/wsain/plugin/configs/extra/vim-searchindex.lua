local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "google/vim-searchindex"
plugin.load_event = "VeryLazy"

return plugin
