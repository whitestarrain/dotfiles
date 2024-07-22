local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "ThePrimeagen/refactoring.nvim"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
}
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("wsain.plugin.whichkey").register({
    { "<leader>r", group = "refactor", mode = "n" },
    { "<leader>r", group = "refactor", mode = "v" },
    {
      "<leader>re",
      "<Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
      desc = "extract function",
      mode = "v",
    },
    {
      "<leader>rf",
      "<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
      desc = "extract function to file",
      mode = "v",
    },
    {
      "<leader>rv",
      "<Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
      desc = "extract variable",
      mode = "v",
    },
    {
      "<leader>ri",
      "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
      desc = "inline variable",
      mode = "n",
    },
    {
      "<leader>ri",
      "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
      desc = "inline variable",
      mode = "v",
    },
    {
      "<leader>rb",
      "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
      desc = "extract block",
      mode = "n",
    },
    {
      "<leader>rbf",
      "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
      desc = "extract block to file",
      mode = "n",
    },
  })
end
return plugin
