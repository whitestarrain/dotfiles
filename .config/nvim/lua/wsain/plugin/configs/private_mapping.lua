local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.globalMappings = {
  { "n", "<leader>d", ":bp|bd #<cr>", "delete buffer" },

  { "n", "<leader>z", name = "+others" },
  { "n", "<leader>zp", ":syntax sync fromstart<cr>", "syntax sync" },
  { "n", "<leader>zl", ":%s/\\v(\\n\\s*){2,}/\\r\\r/<cr> :/jkjk<cr>", "compress blank line" },

  { "n", "<leader>zf", "%:p", "show file path" },
}

return plugin
