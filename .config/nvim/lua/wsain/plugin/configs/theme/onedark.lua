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
      -- nvim-tree
      NvimTreeFolderIcon = { fg = theme.palette.blue },
      NvimTreeOpenedFolderIcon = { fg = theme.palette.purple },
      -- telescope
      TelescopeSelection = {
        bg = config.options.cursorline and theme.generated.cursorline or theme.palette.bg,
        fg = theme.palette.white,
      },
      -- startify
      StartifyFile = { fg = theme.palette.red },
      -- dap
      NvimDapVirtualText = { fg = theme.palette.gray },

      -- cursor line nr
      CursorLineNr = {
        fg = theme.palette.white,
      },
      -- pmenu
      PmenuThumb = {
        bg = theme.palette.white,
      },
      -- filetype
      markdownItalic = { fg = theme.palette.purple, italic = true },
      mkdHeading = { link = "htmlH1" },
      htmlItalic = { fg = theme.palette.purple, italic = true },
      -- pair match
      MatchParen = { bg = theme.palette.gray },
      -- term
      TermCursor = { bg = theme.palette.white },
      -- search
      IncSearch = { fg = theme.palette.orange, reverse = true },
      Search = { fg = theme.palette.yellow, reverse = true },
      CurSearch = { fg = theme.palette.orange, reverse = true },
    },
  })
  vim.cmd("colorscheme onedark")
end

return plugin
