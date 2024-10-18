return {
  -- private leader mapping
  require("wsain.plugin.configs.private_mapping"),

  -- theme
  -- require("wsain.plugin.configs.theme.neosolarized"),
  require("wsain.plugin.configs.theme.onedark"),

  -- core
  require("wsain.plugin.configs.core.treesitter"),
  require("wsain.plugin.configs.core.telescope"),
  require("wsain.plugin.configs.core.nvim-cmp"),

  -- ui
  require("wsain.plugin.configs.ui.startify"),
  require("wsain.plugin.configs.ui.tabline"),
  require("wsain.plugin.configs.ui.nvim-colorizer"),
  require("wsain.plugin.configs.ui.indent-blankline"),
  require("wsain.plugin.configs.ui.feline"),
  require("wsain.plugin.configs.ui.statuscol"),
  require("wsain.plugin.configs.ui.dressing"),
  require("wsain.plugin.configs.ui.rainbow-delimiters"),

  -- edit
  require("wsain.plugin.configs.edit.todo-comments"),
  require("wsain.plugin.configs.edit.nvim-spectre"),
  require("wsain.plugin.configs.edit.nvim-autopairs"),
  require("wsain.plugin.configs.edit.undotree"),
  require("wsain.plugin.configs.edit.nvim-surround"),
  require("wsain.plugin.configs.edit.tabular"),
  require("wsain.plugin.configs.edit.md-img-paste"),
  require("wsain.plugin.configs.edit.md-section-number"),
  require("wsain.plugin.configs.edit.comment"),
  require("wsain.plugin.configs.edit.treesj"),
  require("wsain.plugin.configs.edit.guess_indent"),
  require("wsain.plugin.configs.edit.suda"),

  -- mode
  require("wsain.plugin.configs.mode.venn"),
  require("wsain.plugin.configs.mode.luapad"),
  require("wsain.plugin.configs.mode.zen-mode"),

  -- terminal
  require("wsain.plugin.configs.terminal.vim-floaterm"),
  require("wsain.plugin.configs.terminal.asynctasks"),
  require("wsain.plugin.configs.terminal.vim-tmux-navigator"),
  require("wsain.plugin.configs.terminal.compile_mode"),

  --doc
  require("wsain.plugin.configs.doc.vimcdoc"),
  require("wsain.plugin.configs.doc.neogen"),

  -- git
  require("wsain.plugin.configs.git.gitsigns"),
  require("wsain.plugin.configs.git.diffview"),

  -- ide
  require("wsain.plugin.configs.ide.refactoring"),
  require("wsain.plugin.configs.ide.outline"),
  require("wsain.plugin.configs.ide.mason"),
  require("wsain.plugin.configs.ide.fmt"),
  require("wsain.plugin.configs.ide.linter"),
  require("wsain.plugin.configs.ide.lsp"),
  require("wsain.plugin.configs.ide.dap"),

  -- file manger
  require("wsain.plugin.configs.nvim-tree"),

  -- extra
  require("wsain.plugin.configs.extra.zoomwintab"),
  require("wsain.plugin.configs.extra.hop"),
  require("wsain.plugin.configs.extra.nvim-bufdel"),
  require("wsain.plugin.configs.extra.vim-scriptease"),
  require("wsain.plugin.configs.extra.vim-abolish"),
  require("wsain.plugin.configs.extra.vim-illuminate"),
}
