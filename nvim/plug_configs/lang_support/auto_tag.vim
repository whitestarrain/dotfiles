" Before        Input         After
" ------------------------------------
" <div           >              <div></div>
" <div></div>    ciwspan<esc>   <span></span>
" ------------------------------------

Plug 'windwp/nvim-ts-autotag'

" User treesitter setup

autocmd User LoadPluginConfig call PlugConfigAutoTag()

function! PlugConfigAutoTag()

lua << EOF

  require'nvim-treesitter.configs'.setup {
    autotag = {
      enable = true,
    }
  }

EOF

endfunction


