Plug 'neovim/nvim-lspconfig'
" diagnostics list
Plug 'folke/trouble.nvim'


autocmd vimenter * call PlugConfigLsp()

function! PlugConfigLsp()

lua <<EOF

  -- 大多数是默认值
  require("trouble").setup{}

EOF

endfunction


