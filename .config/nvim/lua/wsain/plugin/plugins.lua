return {
  require("wsain.plugin.configs.private_mapping"),

  -- theme
  require("wsain.plugin.configs.neosolarized"),
  -- require("wsain.plugin.configs.onedark"),

  -- core
  require("wsain.plugin.configs.treesitter"),
  require("wsain.plugin.configs.telescope"),
  require("wsain.plugin.configs.nvim-cmp"),

  -- ui
  require("wsain.plugin.configs.startify"),
  require("wsain.plugin.configs.nvim-colorizer"),
  require("wsain.plugin.configs.indent-blankline"),
  require("wsain.plugin.configs.bufferline"),
  require("wsain.plugin.configs.feline"),
  require("wsain.plugin.configs.statuscol"),

  -- file manger
  require("wsain.plugin.configs.nvim-tree"),

  -- function
  require("wsain.plugin.configs.nvim-bufdel"),
  require("wsain.plugin.configs.nvim-surround"),
  require("wsain.plugin.configs.vim-abolish"),
  require("wsain.plugin.configs.tabular"),
  require("wsain.plugin.configs.md-img-paste"),
  require("wsain.plugin.configs.vim-scriptease"),
  require("wsain.plugin.configs.hop"),
  require("wsain.plugin.configs.md-section-number"),
  require("wsain.plugin.configs.undotree"),
  require("wsain.plugin.configs.nvim-autopairs"),
  require("wsain.plugin.configs.nvim-spectre"),
  require("wsain.plugin.configs.todo-comments"),
  require("wsain.plugin.configs.refactoring"),
  require("wsain.plugin.configs.zoomwintab"),

  -- mode
  require("wsain.plugin.configs.venn"),

  -- terminal
  require("wsain.plugin.configs.vim-floaterm"),
  require("wsain.plugin.configs.asynctasks"),

  -- comment
  require("wsain.plugin.configs.kommentary"),

  --doc
  require("wsain.plugin.configs.vimcdoc"),

  -- git
  require("wsain.plugin.configs.gitsigns"),
  require("wsain.plugin.configs.diffview"),

  -- lsp
  require("wsain.plugin.configs.mason"),
  require("wsain.plugin.configs.nvim-lspconfig"),

  -- dap
  require("wsain.plugin.configs.nvim-dap"),
}
