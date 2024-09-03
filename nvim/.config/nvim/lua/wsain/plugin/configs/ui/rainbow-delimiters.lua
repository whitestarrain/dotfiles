local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "HiPhish/rainbow-delimiters.nvim"
plugin.dependencies = {
  "nvim-treesitter/nvim-treesitter",
}
plugin.config = function()
  local rainbow_delimiters = require("rainbow-delimiters")
  vim.g.rainbow_delimiters = {
    strategy = {
      [""] = rainbow_delimiters.strategy["global"],
      vim = rainbow_delimiters.strategy["local"],
    },
    query = {
      [""] = "rainbow-delimiters",
    },
    priority = {
      [""] = 110,
      lua = 210,
    },
    highlight = {
      "RainbowDelimiterYellow",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterBlue",
      "RainbowDelimiterCyan",
    },
    blacklist = {
      "markdown",
    },
    condition = function(bufnr)
      if vim.filetype.match({ buf = bufnr }) == nil then
        return false
      end
      return not utils.get_check_bigfile_function(10000, 1000, {})(bufnr)
    end,
  }
end

return plugin
