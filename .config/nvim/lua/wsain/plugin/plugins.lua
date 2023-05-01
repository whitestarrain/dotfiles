return {
  require("wsain.plugin.configs.private_mapping"),

  -- theme
  require("wsain.plugin.configs.neosolarized"),

  -- core
  require("wsain.plugin.configs.treesitter"),

  -- ui
  require("wsain.plugin.configs.startify"),
  require("wsain.plugin.configs.indent-blankline"),
  require("wsain.plugin.configs.bufferline"),
  require("wsain.plugin.configs.lualine"),

  -- function
  require("wsain.plugin.configs.nvim-bufdel"),
  require("wsain.plugin.configs.nvim-surround"),
  require("wsain.plugin.configs.vim-abolish"),
  require("wsain.plugin.configs.tabular"),

  -- undo
  require("wsain.plugin.configs.undotree"),

  -- terminal
  require("wsain.plugin.configs.vim-floaterm"),
  require("wsain.plugin.configs.asynctasks"),

  -- comment
  require("wsain.plugin.configs.kommentary"),

}
