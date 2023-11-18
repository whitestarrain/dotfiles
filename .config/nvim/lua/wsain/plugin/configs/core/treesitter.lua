local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-treesitter/nvim-treesitter"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "nvim-lua/plenary.nvim",
  "windwp/nvim-ts-autotag",
  "JoosepAlviste/nvim-ts-context-commentstring",
}
plugin.opts = {
  auto_install = false,

  additional_vim_regex_highlighting = false,

  highlight = {
    enable = true,
    disable = { "markdown", "help" },
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    disable = { "markdown" },
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      -- scope_incremental = '<TAB>',
    },
  },

  indent = {
    enable = true,
    disable = { "markdown", "html", "php", "python", "c", "cpp" },
  },

  autotag = {
    enable = true,
    disable = { "markdown" },
  },

  context_commentstring = {
    enable = true,
    disable = { "markdown", "help" },
  },
}
plugin.config = function()
  require("nvim-treesitter.configs").setup(plugin.opts)
  --[[
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
 ]]
end
return plugin
