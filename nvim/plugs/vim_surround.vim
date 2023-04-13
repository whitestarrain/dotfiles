Plug 'tpope/vim-surround'

" help surround-customizing

autocmd FileType markdown let b:surround_{char2nr('c')} = "```\n\r\n```"

autocmd FileType markdown let b:surround_{char2nr('*')} = " **\r** "
