Plug 'karb94/neoscroll.nvim'

autocmd User LoadPluginConfig call PlugConfigNeoScroll()

function! PlugConfigNeoScroll()
  " 光标移动起来太慢了
  lua require('neoscroll').setup()
endfunction
