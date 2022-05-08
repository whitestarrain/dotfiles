"------------------------------------tagbar-------------------------------------
" 代码大纲
Plug 'majutsushi/tagbar'
"------------------------------------tagbar-------------------------------------
" DEPN: 需要依赖：ctags
  " markdown 需要配置.ctags
autocmd User LoadPluginConfig call PlugConfigTagBar()
function! PlugConfigTagBar()
  " 
  let g:tagbar_ctags_options = ['NONE', split(&rtp,",")[0].'/ctags.cnf']

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

  " let g:tagbar_position = 'leftabove vertical'

  " 设置tagber对于go的支持

  " copy from vim-go:https://github.com/fatih/vim-go/blob/master/ftplugin/go/tagbar.vim
  " DEPN: 需要安装依赖：get -u github.com/jstemmer/gotags  
    let g:tagbar_type_go = {
          \ 'ctagstype' : 'go',
          \ 'kinds'     : [
          \ 'p:package',
          \ 'i:imports',
          \ 'c:constants',
          \ 'v:variables',
          \ 't:types',
          \ 'n:interfaces',
          \ 'w:fields',
          \ 'e:embedded',
          \ 'm:methods',
          \ 'r:constructor',
          \ 'f:functions'
          \ ],
          \ 'sro' : '.',
          \ 'kind2scope' : {
          \ 't' : 'ctype',
          \ 'n' : 'ntype'
          \ },
          \ 'scope2kind' : {
          \ 'ctype' : 't',
          \ 'ntype' : 'n'
          \ },
          \ 'ctagsbin'  : "gotags",
          \ 'ctagsargs' : '-sort -silent'
          \ }

  " tagbar map
  nnoremap <leader>t :TagbarToggle<CR>
  let g:which_key_map.t = "tagbar"

  " starify，seesion关闭时执行操作
  if exists("g:startify_session_before_save")
    let g:startify_session_before_save +=  ['silent! TagbarClose']
  endif
endfunction
