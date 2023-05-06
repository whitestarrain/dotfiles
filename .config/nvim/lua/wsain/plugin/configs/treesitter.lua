local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "nvim-treesitter/nvim-treesitter"
plugin.dependencies = {
  "p00f/nvim-ts-rainbow",
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
    disable = { "markdown", "html", "php", "python" },
  },

  rainbow = {
    enable = true,
    disable = { "markdown" },
    -- disable = { "jsx", "cpp" },
    extended_mode = true,
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {},
    -- termcolors = {},
  },
}
plugin.config = function()
  --[[
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 99
 ]]
end
return plugin
