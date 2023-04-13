" leader键提示插件。（懒加载，使用火才可以查看到文档）
" On-demand lazy load
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

let g:which_key_disable_default_offset = 1

autocmd User vim-which-key call which_key#register('<Space>', 'g:which_key_map')

autocmd User LoadPluginConfig call PlugConfigWhichKey()
function! PlugConfigWhichKey()
  " vim-which-key map
  nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
  vnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
endfunction


