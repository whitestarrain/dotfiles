local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "ThePrimeagen/refactoring.nvim"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
}
plugin.loadEvent = "VeryLazy"
plugin.config = function()
  require("refactoring").setup({})
end
plugin.globalMappings = {
  { "n", "<leader>r", name = "refactor" },
  { "v", "<leader>re", "<Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "extract function" },
  { "v", "<leader>rf", "<Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", "extract function to file" },
  { "v", "<leader>rv", "<Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "extract variable" },
  { "n", "<leader>ri", "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "inline variable" },
  { "v", "<leader>ri", "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "inline variable" },
  { "n", "<leader>rb", "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>", "extract block" },
  { "n", "<leader>rbf", "<Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "extract block to file" },
}
return plugin
