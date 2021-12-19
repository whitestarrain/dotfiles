" TODO 考虑使用galaxyline 和 bufferline 替换

"-------------------------------------vim-airline------------------------------------
" 下方提示栏
Plug 'vim-airline/vim-airline'
" 下方提示栏主题
Plug 'vim-airline/vim-airline-themes'

"-------------------------------------vim-airline------------------------------------

"------------------------------------airline-------------------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#tabs_label = 'TABS'
let g:airline#extensions#tabline#left_alt_sep = '>'
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#exclude_buffers = ["[defx]", "!", "vimfiler", "nnn", "vista"]

let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }
let g:airline_theme='onedark'


autocmd vimenter * call AirlineConfig()

function! AirlineConfig()
  " 显示窗口号
  function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
    return 0
  endfunction

  call airline#add_statusline_func('WindowNumber')
  call airline#add_inactive_statusline_func('WindowNumber')

endfunction

"------------------------------------airline-------------------------------------
