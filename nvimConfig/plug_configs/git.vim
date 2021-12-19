"-----------------------------------vim-gitgutter--------------------------------------
" git插件
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
" 显示文件每行的状态
Plug 'airblade/vim-gitgutter'
"-----------------------------------vim-gitgutter--------------------------------------

autocmd vimenter * call PlugConfigGit()
function! PlugConfigGit()
  " vim-gitgutter map
  nnoremap <silent> <leader>hf :GitGutterNextHunk<CR>
  nnoremap <silent> <leader>hb :GitGutterPrevHunk<CR>
  nnoremap <silent> <leader>hp :GitGutterPreviewHunk<CR>
  nnoremap <silent> <leader>hh :GitGutterLineHighlightsToggle<CR>
  nnoremap <silent> <leader>hs :GitGutterStageHunk<CR>
  nnoremap <silent> <leader>hu :GitGutterUndoHunk<CR>
  nnoremap <silent> [c :GitGutterPrevHunk<CR>
  nnoremap <silent> ]c :GitGutterNextHunk<CR>
  let g:which_key_map.h.b = "findBack"
  let g:which_key_map.h.f = "findForward"
  let g:which_key_map.h.p = "preview"
  let g:which_key_map.h.s = "stage"
  let g:which_key_map.h.u = "undo"
  let g:which_key_map.h.h = "highLight"
  " let g:gitgutter_diff_args = ' --cached '
endfunction

