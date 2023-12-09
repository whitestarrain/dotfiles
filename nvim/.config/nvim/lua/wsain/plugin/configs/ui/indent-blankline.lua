local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "lukas-reineke/indent-blankline.nvim"
plugin.config = function()
  local utils = require("wsain.utils")
  utils.highlight("IndentBlanklineChar", { fg = utils.colors.grey, gui = "nocombine" })
  require("ibl").setup({
    enabled = true,
    indent = {
      char = "¦",
      smart_indent_cap = true,
      highlight = "IndentBlanklineChar",
    },
    scope = {
      enabled = false,
    },
    exclude = {
      filetypes = {
        "leadf",
        "floaterm",
        "startify",
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
      },
    },
  })
end

return plugin
