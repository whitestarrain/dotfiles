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
        bg = theme.palette.gray,
        fg = theme.palette.white,
      },
      -- startify
      StartifyFile = { fg = theme.palette.red },
      -- dap
      NvimDapVirtualText = { fg = theme.palette.gray },
      -- git
      GitSignsAddInline = { bg = "#3c6b3e" },

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
      mkdURL = { fg = theme.palette.purple },
      -- pair match
      MatchParen = { bg = theme.palette.gray },
      -- term
      TermCursor = { bg = theme.palette.white },
      -- search
      IncSearch = { fg = theme.palette.orange, reverse = true },
      Search = { fg = theme.palette.yellow, reverse = true },
      CurSearch = { fg = theme.palette.orange, reverse = true },
      -- Visual = { reverse = true }, -- Visual mode selection

      -- lang
      ["@odp.import_module.python"] = { fg = theme.palette.yellow },
      ["@field.lua"] = { fg = theme.palette.red },
      ["@parameter.lua"] = { fg = theme.palette.red, style = config.styles.parameters },
      ["@operator.lua"] = { link = "@operator" },
      ["@keyword.operator.lua"] = { link = "@operator" },
      ["@text.title.1.markdown"] = { link = "htmlH1" },
      ["@text.title.2.markdown"] = { link = "htmlH1" },
      ["@text.title.3.markdown"] = { link = "htmlH1" },
      ["@text.title.4.markdown"] = { link = "htmlH1" },
      ["@text.title.5.markdown"] = { link = "htmlH1" },
      ["@text.title.6.markdown"] = { link = "htmlH1" },
      ["@text.title.1.marker.markdown"] = { link = "htmlH1" },
      ["@text.title.2.marker.markdown"] = { link = "htmlH1" },
      ["@text.title.3.marker.markdown"] = { link = "htmlH1" },
      ["@text.title.4.marker.markdown"] = { link = "htmlH1" },
      ["@text.title.5.marker.markdown"] = { link = "htmlH1" },
      ["@text.title.6.marker.markdown"] = { link = "htmlH1" },
      ["@text.reference.markdown_inline"] = { link = "htmlLink" },
      ["@text.todo.unchecked.markdown"] = { link = "Normal" },
      ["@text.quote.markdown"] = { link = "Comment" },
    },
  })
  vim.cmd("colorscheme onedark")
end

return plugin
