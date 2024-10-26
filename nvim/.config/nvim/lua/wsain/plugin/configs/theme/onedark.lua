local plugin = require("wsain.plugin.template"):new()

local gui_running = vim.fn.has("gui_running")
plugin.shortUrl = "olimorris/onedarkpro.nvim"
plugin.priority = 1000
plugin.config = function()
  local config = require("onedarkpro.config").config
  local theme = require("onedarkpro.themes.onedark")
  require("onedarkpro").setup({
    options = {
      transparency = gui_running == 0,
    },
    -- use vim.highlight.priorities to change priorities
    highlights = {
      -- diff
      DiffAdd = {
        bg = "#3E554C",
      },
      DiffDelete = {
        bg = "#54252B",
      },
      -- nvim-tree
      NvimTreeFolderIcon = { fg = theme.palette.blue },
      NvimTreeOpenedFolderIcon = { fg = theme.palette.purple },
      NvimTreeCursorLine = { link = "CursorLine" },

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

      -- quickfix
      QuickFixLine = { fg = theme.palette.cyan },

      -- cursor line nr
      CursorLineNr = {
        fg = theme.palette.white,
      },
      -- pmenu
      PmenuThumb = {
        bg = theme.palette.white,
      },
      -- tabline
      TabLineSel = {
        bg = nil,
        fg = theme.palette.blue,
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

      -- whick key
      WhichKeyFloat = { link = "Normal" },

      -- illuminate
      IlluminatedWordRead = { link = "Visual" },
      IlluminatedWordText = { link = "Visual" },
      IlluminatedWordWrite = { link = "Visual" },

      -- treesitter, semantic tokens
      ["@odp.import_module.python"] = { fg = theme.palette.yellow },
      ["@field.lua"] = { fg = theme.palette.red },
      ["@parameter.lua"] = { fg = theme.palette.red, style = config.styles.parameters },
      ["@operator.lua"] = { link = "@operator" },
      ["@keyword.operator.lua"] = { link = "@operator" },
      ["@markup.heading.1.markdown"] = { link = "htmlH1" },
      ["@markup.heading.2.markdown"] = { link = "htmlH1" },
      ["@markup.heading.3.markdown"] = { link = "htmlH1" },
      ["@markup.heading.4.markdown"] = { link = "htmlH1" },
      ["@markup.heading.5.markdown"] = { link = "htmlH1" },
      ["@markup.heading.6.markdown"] = { link = "htmlH1" },
      ["@markup.heading.1.marker.markdown"] = { link = "htmlH1" },
      ["@markup.heading.2.marker.markdown"] = { link = "htmlH1" },
      ["@markup.heading.3.marker.markdown"] = { link = "htmlH1" },
      ["@markup.heading.4.marker.markdown"] = { link = "htmlH1" },
      ["@markup.heading.5.marker.markdown"] = { link = "htmlH1" },
      ["@markup.heading.6.marker.markdown"] = { link = "htmlH1" },
      ["@markup.list.markdown"] = { link = "mkdListItem" },
      ["@text.reference.markdown_inline"] = { link = "htmlLink" },
      ["@text.todo.unchecked.markdown"] = { link = "Normal" },
      ["@text.quote.markdown"] = { link = "Comment" },
      ["@keyword.directive.define.cpp"] = { link = "Macro" },

      -- rainbow
      RainbowDelimiterYellow = { fg = "#d19a66" },
      RainbowDelimiterBlue = { fg = "dodgerblue2" },
      RainbowDelimiterOrange = { fg = "darkorange3" },
      RainbowDelimiterGreen = { fg = "seagreen3" },
      RainbowDelimiterViolet = { fg = "mediumpurple3" },
      RainbowDelimiterCyan = { fg = "orchid2" },
    },
  })
  vim.cmd("colorscheme onedark")
end

return plugin
