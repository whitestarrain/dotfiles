" 更新后，在退出时不会exit terminal。暂时无解
Plug 'voldikss/vim-floaterm'

" NOTE: 重要：终端中在当前vim打开文件：floaterm file
autocmd User LoadPluginConfig call PlugConfigFloaterm()

function! PlugConfigFloaterm()

  let g:floaterm_opener='edit'
  " git-bash中gitui会渲染混乱
  let g:floaterm_shell='nu' " DEPN: scoop install nushell
  let g:floaterm_rootmarkers=['.project', '.git', '.hg', '.svn', '.root', '.gitignore']

  " float 中间
  let g:floaterm_position='center'
  let g:floaterm_width=0.85
  let g:floaterm_height=0.85

  " split 底部
  " let g:floaterm_wintype='split'
  " let g:floaterm_height=0.4

  nmap <silent> <M-+> :FloatermNew<cr>
  nmap <silent> <M-=> :FloatermToggle<cr>
  tnoremap <silent> <M-+> <c-\><c-n>:FloatermNew<cr>
  tnoremap <silent> <M-=> <c-\><c-n>:FloatermToggle<cr>

  augroup vime_floaterm_group
      autocmd!
      au FileType floaterm tnoremap <buffer> <silent> <M-h> <c-\><c-n>:FloatermPrev<CR>
      au FIleType floaterm tnoremap <buffer> <silent> <M-l> <c-\><c-n>:FloatermNext<CR>
  augroup END

  nnoremap <silent> <leader>l :FloatermNew lf<cr>
  let g:which_key_map.l = 'lf'

  nnoremap <silent> <leader>k :FloatermNew lf -- "./"<cr>
  let g:which_key_map.k = 'lf(current path)'

endfunction

