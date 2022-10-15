Plug 'dkarter/bullets.vim'

let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text'
    \]
" 禁用默认mapping
let g:bullets_set_mappings = 0

" https://stackoverflow.com/questions/598113/can-terminals-detect-shift-enter-or-control-enter
" <c-cr> in windows terminal is <c-J>
let g:bullets_custom_mappings = [
  \ ['imap', '<C-CR>', '<plug>(bullets-newline)'],
  \ ['imap', '<C-J>', '<plug>(bullets-newline)'],
  \ ]
