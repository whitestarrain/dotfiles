local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.globalMappings = {
  {
    key = "<leader>d",
    cmd = function()
      vim.fn.execute("bp|bd #")
    end,
    desc = "delete buffer",
  },
  {
    key = "<leader>z",
    name = "+others",
  },
  {
    key = "<leader>zp",
    cmd = function()
      vim.fn.execute("syntax sync fromstart")
    end,
    desc = "syntax sync",
  },
  {
    key = "<leader>zl",
    cmd = function()
      vim.fn.execute("%s/\\v(\\n\\s*){2,}/\\r\\r/")
    end,
    desc = "compress blank line",
  },
  {
    key = "<leader>zf",
    cmd = function()
      print(vim.fn.expand("%:p"))
    end,
    desc = "show file path",
  },
}

return plugin
