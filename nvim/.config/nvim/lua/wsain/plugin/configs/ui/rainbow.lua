local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "luochen1990/rainbow"
plugin.init = function()
  vim.g.rainbow_active = 1
  vim.g.rainbow_conf = {
    guifgs = {
      "#d19a66",
      "darkorange3",
      "seagreen3",
      "mediumpurple3",
      "dodgerblue2",
      "orchid2",
    },
    ctermfgs = {
      "lightblue",
      "lightyellow",
      "lightcyan",
      "lightmagenta",
    },
  }
end
plugin.config = function()
  local disable_highlights = {
    "@punctuation.bracket",
    "@punctuation.bracket.python",
    "@odp.punctuation.bracket.python",
  }
  for _, hl in ipairs(disable_highlights) do
    vim.api.nvim_set_hl(0, hl, { link = "" })
  end
end

return plugin
