local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "whitestarrain/neosolarized.nvim"
plugin.dependencies = { "tjdevries/colorbuddy.nvim" }
plugin.priority = 100
plugin.opts = {
  comment_italics = true,
}
plugin.config = function()
  local neo = require("neosolarized")

  neo.setup(plugin.opts)

  local cb = require("colorbuddy.init")
  local Color = cb.Color
  local colors = cb.colors
  local Group = cb.Group
  local groups = cb.groups
  local styles = cb.styles

  -- line style
  Color.new("black", "#000000")
  Group.new("CursorLine", colors.none, colors.base03, styles.NONE, colors.base1)
  Group.new("CursorLineNr", colors.yellow, colors.none, styles.NONE, colors.base1)
  Group.new("Visual", colors.none, colors.base03, styles.reverse)

  -- diagnostic style
  local cError = groups.Error.fg
  local cInfo = groups.Information.fg
  local cWarn = groups.Warning.fg
  local cHint = groups.Hint.fg
  Group.new("DiagnosticVirtualTextError", cError, cError:dark():dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextInfo", cInfo, cInfo:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextWarn", cWarn, cWarn:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticVirtualTextHint", cHint, cHint:dark():dark():dark(), styles.NONE)
  Group.new("DiagnosticUnderlineError", colors.none, colors.none, styles.undercurl, cError)
  Group.new("DiagnosticUnderlineWarn", colors.none, colors.none, styles.undercurl, cWarn)
  Group.new("DiagnosticUnderlineInfo", colors.none, colors.none, styles.undercurl, cInfo)
  Group.new("DiagnosticUnderlineHint", colors.none, colors.none, styles.undercurl, cHint)

  -- float window and it's boarder style
  Group.new("FloatBorder", colors.none, colors.none)
  Group.new("NormalFloat", colors.none, colors.none)

  -- markdown doc style
  local cConstant = groups.Constant.fg
  Group.new("markdownBlockquote", colors.gray)
  Group.new("markdownBold", colors.yellow)
  Group.new("htmlBold", colors.yellow)
  Group.new("mkdBold", colors.yellow)
  Group.new("markdownBoldItalic", colors.green)
  Group.new("markdownCode", cConstant)
  Group.new("markdownCodeBlock", colors.green)
  Group.new("markdownCodeDelimiter", colors.green)
  Group.new("markdownHeadingDelimiter", colors.grey, colors.none)
  Group.new("markdownHeadingRule", colors.purple, colors.none)
  Group.new("markdownId", colors.purple)
  Group.new("markdownIdDeclaration", colors.blue)
  Group.new("markdownIdDelimiter", colors.purple)
  Group.new("markdownItalic", colors.purple)
  Group.new("markdownLinkDelimiter", colors.purple)
  Group.new("markdownLinkText", colors.red)
  Group.new("markdownListMarker", colors.red)
  Group.new("markdownOrderedListMarker", colors.red)
  Group.new("markdownRule", colors.gray)
  Group.new("markdownUrl", colors.cyan)

  -- autocomplete color
  Group.new("CmpItemAbbrMatch", colors.green)
  Group.new("CmpItemAbbrMatchFuzzy", colors.green)
end

return plugin
