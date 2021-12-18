"------------------------------------tagbar-------------------------------------
" 代码大纲
Plug 'majutsushi/tagbar'
"------------------------------------tagbar-------------------------------------
autocmd vimenter * call PlugConfigTagBar()
function! PlugConfigTagBar()
  " 设置宽度
  " let g:tagbar_width = 30
  "设置tagber对于markdown的支持
  let g:tagbar_type_markdown = {
          \ 'ctagstype' : 'markdown',
          \ 'kinds' : [
                  \ 'h:headings',
          \ ],
      \ 'sort' : 0
  \ }
  " 位置调整

  " tagbar map
  nnoremap <leader>t :TagbarToggle<CR>
  let g:which_key_map.t = "tagbar"

 " starify，seesion关闭时执行操作
if exists("g:startify_session_before_save")
  let g:startify_session_before_save +=  ['silent! TagbarClose']
endif
endfunction
