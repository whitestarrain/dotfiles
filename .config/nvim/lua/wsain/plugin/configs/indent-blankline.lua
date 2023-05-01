local Template = require("wsain.plugin.template")
local plugin = Template:new()

plugin.shortUrl = "lukas-reineke/indent-blankline.nvim"
plugin.opts = {
  char = "¦",
  filetype_exclude = {
    "leadf",
    "floaterm",
    "startify",
    "lspinfo",
    "packer",
    "checkhealth",
    "help",
    "man",
  },
}
plugin.config = function()
  require("indent_blankline").setup(plugin.opts)
  local utils = require("wsain.utils")
  utils.highlight("IndentBlanklineChar", { fg = utils.colors.grey, gui = "nocombine" })
end

return plugin
