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
      default_direction = "right",
    },
    filter_kind = {
      "Class",
      "Constant",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Method",
      "Module",
      "Namespace",
      "Operator",
      "Package",
      "Struct",
      "Struct",
    },
    keymaps = {
      ["o"] = "actions.scroll",
      ["K"] = "actions.up_and_scroll",
      ["<C-j>"] = false,
      ["<C-k>"] = false,
      ["J"] = "actions.down_and_scroll",
      ["L"] = "actions.tree_open_all",
      ["H"] = "actions.tree_close_all",
      ["l"] = "actions.tree_toggle",
    },
    icons = {
      Collapsed     = "",
    },
    attach_mode = "global",
    link_folds_to_tree = false,
    link_tree_to_folds = false,
  })
  utils.addCommandBeforeSaveSession("silent! AerialClose")
  require("wsain.plugin.whichkey").register({
    { "<leader>ct", ":AerialToggle<CR>", desc = "outline" },
  })
end

return plugin
