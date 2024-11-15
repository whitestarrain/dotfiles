local plugin = require("wsain.plugin.template"):new()
local utils = require("wsain.utils")

plugin.shortUrl = "stevearc/aerial.nvim"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-treesitter/nvim-treesitter",
  "nvim-tree/nvim-web-devicons",
}
plugin.config = function()
  require("aerial").setup({
    backends = {
      ["_"] = { "lsp", "treesitter" },
    },
    layout = {
      width = 30,
      min_width = 20,
    },
    keymaps = {
      ["K"] = "actions.up_and_scroll",
      ["J"] = "actions.down_and_scroll",
    },
  })
  utils.addCommandBeforeSaveSession("silent! AerialClose")
  require("wsain.plugin.whichkey").register({
    { "<leader>ct", ":AerialToggle<CR>", desc = "outline" },
  })
end

return plugin
