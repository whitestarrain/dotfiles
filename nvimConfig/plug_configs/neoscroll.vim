Plug 'karb94/neoscroll.nvim'

autocmd User LoadPluginConfig call PlugConfigNeoScroll()

function! PlugConfigNeoScroll()
  lua require('neoscroll').setup()
endfunction
