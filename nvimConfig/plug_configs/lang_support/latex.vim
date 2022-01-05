" 注意，使用版本： git checkout 607956c

"------------------------------------latex-------------------------------------
" latex支持
Plug 'lervag/vimtex'
"------------------------------------latex-------------------------------------


autocmd User LoadPluginConfig call PlugConfigLatex()

  function PlugConfigLatex()
    "
  "使vimtex默认pdf阅读器
  let g:vimtex_view_general_viewer = 'SumatraPDF.exe' 

  " vimtex提供了magic comments来为文件设置编译方式
  " 例如，我在tex文件开头输入 % !TEX program = xelatex   即指定-xelatex （xelatex）编译文件
  " (下面的配置一定要加，否则可能识别不出来)
  let g:vimtex_compiler_latexmk_engines = {
      \ '_'                : '-pdf',
      \ 'pdflatex'         : '-pdf',
      \ 'dvipdfex'         : '-pdfdvi',
      \ 'lualatex'         : '-lualatex',
      \ 'xelatex'          : '-xelatex',
      \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
      \ 'context (luatex)' : '-pdf -pdflatex=context',
      \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
      \}

  let g:vimtex_compiler_latexmk = {
      \ 'backend' : 'nvim',
      \ 'background' : 1,
      \ 'build_dir' : './build',
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'executable' : 'latexmk',
      \ 'options' : [
      \   '-pdf',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}

  "设置可以看到编译报错提示
  let g:vimtex_quickfix_mode=1

  " quick fix 忽略一些hook warn
  let g:vimtex_quickfix_ignore_filters = [
        \ 'LaTeX hooks Warning',
        \ 'Warning: Font',
        \]

endfunction
