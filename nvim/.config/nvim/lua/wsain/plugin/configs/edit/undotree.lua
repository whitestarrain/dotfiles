local plugin = require("wsain.plugin.template"):new()

plugin.short_url = "mbbill/undotree"
plugin.load_event = "VeryLazy"

return plugin
