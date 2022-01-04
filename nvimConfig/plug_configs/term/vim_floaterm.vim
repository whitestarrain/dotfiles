Plug 'voldikss/vim-floaterm'

autocmd User LoadPluginConfig call PlugConfigFloaterm()

function PlugConfigFloaterm()

  let g:floaterm_opener='edit'
  " let g:floaterm_shell='bash'
  let g:floaterm_rootmarkers=['.project', '.git', '.hg', '.svn', '.root', '.gitignore']

  " float 中间
  let g:floaterm_position='center'
  let g:floaterm_width=0.8
  let g:floaterm_height=0.8

  " split 底部
  " let g:floaterm_wintype='split'
  " let g:floaterm_height=0.3

  nmap <silent> <M-+> :FloatermNew<cr>
  nmap <silent> <M-=> :FloatermToggle<cr>
  tnoremap <silent> <M-+> <c-\><c-n>:FloatermNew<cr>
  tnoremap <silent> <M-=> <c-\><c-n>:FloatermToggle<cr>

  augroup vime_floaterm_group
      autocmd!
      au FileType floaterm tnoremap <buffer> <silent> <M-h> <c-\><c-n>:FloatermPrev<CR>
      au FIleType floaterm tnoremap <buffer> <silent> <M-l> <c-\><c-n>:FloatermNext<CR>
  augroup END

endfunction

