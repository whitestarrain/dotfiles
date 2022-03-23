"------------------------------------vim-surround-------------------------------------
" 可以删除括号，修改括号等
Plug 'tpope/vim-surround'
"------------------------------------vim-surround-------------------------------------

" same as let b:surround_99=...
autocmd FileType markdown let b:surround_{char2nr('c')} = "```\n\r\n```"
