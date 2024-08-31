local plugin = require("wsain.plugin.template"):new()
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
      lua = "rainbow-blocks",
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
  }
end

return plugin
