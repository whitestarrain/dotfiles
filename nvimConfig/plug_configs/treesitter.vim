Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

" Plug 'romgrk/nvim-treesitter-context'
" Plug 'nvim-treesitter/nvim-treesitter-refactor'
" Plug'nvim-treesitter/playground'

autocmd vimenter * call PlugConfigTreeSitter()

function PlugConfigTreeSitter()

lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- 安装 language parser
  -- :TSInstallInfo 命令查看支持的语言
  ensure_installed = {"html", "css", "vim", "lua", "javascript", "typescript", "tsx", "rust", "python", "java"},
  -- 启用代码高亮功能
  highlight = {
    enable = true,
    disable = {'markdown'},
    additional_vim_regex_highlighting = false
  },
  -- 启用增量选择
  incremental_selection = {
    enable = true,
    disable = {'markdown'},
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      node_decremental = '<BS>',
      scope_incremental = '<TAB>',
    }
  },
  -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
  indent = {
    disable = {'markdown'},
    enable = true
  }
}
-- 开启 Folding
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 默认不要折叠
-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
vim.wo.foldlevel = 99
EOF

endfunction

" 高亮模块  TSBufferToggle highlight 可以查看效果
" indent模块：gg=G格式化代码，或者高亮选择
" 增量选择模块：进入可视模式后，enter和Backspace增量选择控制
" fold模块：zc ,zo zC,zO
