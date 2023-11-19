local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "olimorris/onedarkpro.nvim"
plugin.priority = 1000
plugin.config = function()
  local config = require("onedarkpro.config").config
  local theme = require("onedarkpro.themes.onedark")
  require("onedarkpro").setup({
    options = {
      transparency = true,
    },
    highlights = {
      CursorLineNr = {
        fg = theme.palette.white,
      },
      NvimTreeFolderIcon = { fg = theme.palette.blue },
      NvimTreeOpenedFolderIcon = { fg = theme.palette.purple },
      PmenuThumb = {
        bg = theme.palette.white,
      },
      TelescopeSelection = {
        bg = config.options.cursorline and theme.generated.cursorline or theme.palette.bg,
        fg = theme.palette.white,
      },
      markdownItalic = { fg = theme.palette.purple, italic = true },
      htmlItalic = { fg = theme.palette.purple, italic = true },
      TermCursor = { bg = theme.palette.white },
      StartifyFile = { fg = theme.palette.red },
      MatchParen = { bg = theme.palette.gray },
      NvimDapVirtualText = { fg = theme.palette.gray },
    },
  })
  vim.cmd("colorscheme onedark")
end

return plugin
