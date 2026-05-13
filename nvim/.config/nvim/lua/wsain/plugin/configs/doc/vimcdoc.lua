local plugin = require("wsain.plugin.template"):new()
plugin.short_url = "yianwillis/vimcdoc"
plugin.load_event = "VeryLazy"
return plugin
