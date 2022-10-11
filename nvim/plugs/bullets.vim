"-----------------------------------vim-markdown--------------------------------------
"markdonw 语法高亮
"-----------------------------------vim-markdown--------------------------------------

Plug 'whitestarrain/bullets.vim'

"------------------------------------markdown-------------------------------------
autocmd User LoadPluginConfig call PlugConfigMarkDown()
function! PlugConfigMarkDown()
  let g:bullets_enabled_file_types = [
      \ 'markdown',
      \ 'text'
      \]
  " 禁用默认mapping
  let g:bullets_set_mappings = 0

  let g:bullets_custom_mappings = [
    \ ['imap', '<cr>', '<Plug>(bullets-newline)'],
    \ ['nmap', 'o', '<Plug>(bullets-newline)'],
    \ ]
endfunction
"------------------------------------markdown-------------------------------------
