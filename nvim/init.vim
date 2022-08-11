" nvim-qt 要加上 --no-ext-tabline，才能使用airline的bufferline。加上 --fullscreen全屏显示


"=================================================env config start===================================================
" 定义载入配置命令
" let g:absolute_config_path = expand("%:p")[0:strlen(expand("%:p"))-strlen(expand("%:t"))-1]
let g:absolute_config_path = simplify(expand("<sfile>:p")[0:strlen(expand("<sfile>:p"))-strlen(expand("<sfile>:t"))-1])
command! -nargs=1 LoadScript exec 'source' . ' ' . simplify(g:absolute_config_path . '<args>')
command! -nargs=1 LoadLua exec 'luafile' . ' ' .  simplify(g:absolute_config_path . '<args>')

" 添加不在runtimepath中的lua文件的加载路径
let &runtimepath.="," . g:absolute_config_path[0:-2]

" python 环境
let g:python3_host_prog='D:/ProgramFiles/scoop/apps/anaconda3/current/envs/develop/python.exe'

"=================================================env config end===================================================

"=================================================leader group start===================================================
" 按键map规范
let mapleader="\<space>"
let g:which_key_map =  {}
let g:which_key_map.z = { 'name' : '[second]' }
let g:which_key_map.s = { 'name' : '[startify]' }
let g:which_key_map.o = { 'name' : '[open in]' }
let g:which_key_map.h = { 'name' : '[hunk]' }
let g:which_key_map.f = { 'name' : '[find]' }
let g:which_key_map.b = { 'name' : '[buffer]' }
let g:which_key_map.c = { 'name' : '[code]' }
let g:which_key_map.h = { 'name' : '[hunk]' }
"=================================================leader group end===================================================

"=================================================common config start===================================================
LoadScript common.vim
LoadScript mappings.vim
LoadScript functions.vim
"=================================================common config end===================================================

"=================================================control var start===================================================

" g:load_theme
" g:skip_project_plugs
" g:set_termguicolors
" g:plug_install_path
" g:code_language_list

" 默认值处理
if !exists("g:code_language_list") 
  let g:code_language_list=[] 
endif
let g:plug_install_path = g:absolute_config_path . "../vim_plug_download"


" 主题以及set_termguicolors
" 是否设置termguicolors，默认不设置
let g:set_termguicolors=exists("g:set_termguicolors") 
      \ && g:set_termguicolors 
      \ && exists("&termguicolors")
      \ && exists("&winblend")
let g:load_theme="onedark"
if strlen($term)==0 && has("win32")
  " nvim-qt
  let g:set_termguicolors=1
  " let g:load_theme="NeoSolarized"
  autocmd vimenter * GuiFont! MesloLGS NF:h14
elseif $term=="alacritty"
  " alacritty
  let g:set_termguicolors=1
  let g:neosolarized_termtrans=1
elseif exists("$WEZTERM")
  let g:set_termguicolors=1
else
  " nvim in terminal
  let g:set_termguicolors=0
endif

"=================================================control var end===================================================

"=================================================plug load start===================================================

call plug#begin(get(g:,"plug_install_path"))

  " plenary for {todo.vim,git.vim,telescope.vim}
  LoadScript ./plug_configs/denpendency/plenary.vim
  LoadScript ./plug_configs/theme/onedark.vim
  LoadScript ./plug_configs/vim_surround.vim
  LoadScript ./plug_configs/rainrow.vim
  LoadScript ./plug_configs/ui/indentline.vim
  LoadScript ./plug_configs/tag_bar.vim
  LoadScript ./plug_configs/ui/vim_devicons.vim " 主要为startify 提供icon支持，可选
  LoadScript ./plug_configs/ui/nvim_web_devicons.vim " 主要为bufferline提供icon支持，可选
  LoadScript ./plug_configs/abolish.vim
  LoadScript ./plug_configs/lang_support/plantuml.vim
  LoadScript ./plug_configs/term/vim_floaterm.vim
  LoadLua ./plug_configs/mdSectionNumber.lua
  LoadLua ./plug_configs/kommentary.lua
  LoadLua ./plug_configs/treesitter.lua
  LoadLua ./plug_configs/auto_pair.lua
  LoadLua ./plug_configs/ui/todo-comments.lua
  if g:set_termguicolors 
    LoadLua ./plug_configs/ui/bufferline.lua
    LoadLua ./plug_configs/ui/lualine.lua
    LoadLua ./plug_configs/ui/nvim_colorizer.lua
  endif

  " 加载额外插件
  if !exists('g:skip_project_plugs')
    LoadScript ./plug_configs/ui/starify.vim " 加载这个插件的话，放上面，session关闭时处理相关
    LoadScript ./plug_configs/easy_motion.vim
    LoadScript ./plug_configs/ui/vim_which_key.vim
    LoadScript ./plug_configs/lang_support/vim_markdown.vim
    LoadScript ./plug_configs/prettier.vim
    LoadScript ./plug_configs/md_img_paste.vim
    LoadScript ./plug_configs/snippets.vim
    LoadScript ./plug_configs/vimdoc_cn.vim
    LoadLua ./plug_configs/ui/nvim-tree.lua
    LoadLua ./plug_configs/telescope.lua
    LoadLua ./plug_configs/git.lua
    " LoadScript ./plug_configs/vim_visual_multi.vim" 待安装
    " LoadScript ./plug_configs/term/asyn_run.vim " 功能强大，但是暂时应该用不到

    " 加载lsp相关vim插件
    let g:load_program = 0
    for code_language in g:code_language_list
      if code_language == "rust"
        LoadScript ./plug_configs/lang_support/rust.vim
      endif
      if code_language == "python" | endif
      if code_language == "c"
        " LoadScript ./plug_configs/_pre/debug/nvim_dap.vim
        LoadScript ./plug_configs/_pre/debug/nvim_gdb.vim
      endif
      if code_language == "golang" | endif
      if code_language == "java" | endif
      if code_language == "bash" | endif
      if code_language == "vim" | endif
      if code_language == "lua" 
        LoadScript ./plug_configs/lang_support/lua.vim
        " lua交互buffer，开发的时候用
        LoadScript ./plug_configs/nvim-luapad.lua 
      endif
      if code_language == "front"
        " typescript 和 vscode环境的语言插件
        LoadScript ./plug_configs/lang_support/jsx.vim
        LoadScript ./plug_configs/lang_support/typescript.vim
        LoadScript ./plug_configs/lang_support/auto_tag.vim
        LoadScript ./plug_configs/lang_support/javascript.vim
      endif
      if code_language == "vue" | endif
      if code_language == "latex"
        LoadScript ./plug_configs/lang_support/latex.vim
      endif
    endfor

    if len(g:code_language_list)>0
      let g:load_program = 1
      LoadLua ./plug_configs/lsp/lsp_conf.lua
      LoadLua ./plug_configs/lsp/diagnostics_list.lua
      " lsp不提供格式化的文件类型使用formatter进行格式化
      LoadLua ./plug_configs/formatter.lua
      " lsp不提供lint功能的文件类型使用lint工具(替换efm-lsp)
      LoadLua ./plug_configs/nvim-lint.lua
    endif

    " auto complete config. related with the var "load_program""
    LoadScript ./plug_configs/lsp/auto_complete.lua

  endif

call plug#end()

" 加载lsp配置
for code_language in g:code_language_list
  if exists('g:skip_project_plugs')
    break
  endif
  if code_language == "rust"
    LoadLua ./plug_configs/lsp-server/rust_analyzer_config.lua
  endif
  if code_language == "python"
    " 通过require("python")返回
    LoadLua ./plug_configs/lsp-server/pyright_config.lua
  endif
  if code_language == "c"
    LoadLua ./plug_configs/lsp-server/clangd_config.lua
    " LoadLua ./plug_configs/_pre/debug/debug_dap/lldb.lua
  endif
  if code_language == "golang"
    LoadLua ./plug_configs/lsp-server/golang.lua
  endif
  if code_language == "java"
    LoadLua ./plug_configs/lsp-server/java.lua
  endif
  if code_language == "bash"
    LoadLua ./plug_configs/lsp-server/bash.lua
  endif
  if code_language == "vim"
    LoadLua ./plug_configs/lsp-server/vimls.lua
  endif
  if code_language == "lua"
    LoadLua ./plug_configs/lsp-server/lua_lsp_config.lua
  endif
  if code_language == "front"
    LoadLua ./plug_configs/lsp-server/tsserver.lua 
    " vscode 配套lsp
    LoadLua ./plug_configs/lsp-server/vscode-lsp.lua
    " emmet支持
    LoadLua ./plug_configs/lsp-server/emmet.lua 
    " 不扫描node_module，还没有解决
    " LoadLua ./plug_configs/lsp-server/denols.lua 
    " tailwindcss 框架专属，暂时用不到
    " LoadLua ./plug_configs/lsp-server/tailwindcss.lua
  endif
  if code_language == "vue"
    LoadLua ./plug_configs/lsp-server/vuels.lua
  endif
  if code_language == "latex"
    LoadLua ./plug_configs/lsp-server/texlab.lua
  endif
  if code_language == "dot"
    LoadLua ./plug_configs/lsp-server/dot.lua
  endif
endfor

"=================================================plug load end===================================================

"=================================================theme start===================================================
set synmaxcol=5000       " 高亮显示行数，小一点节省内存，但是可能对大文件出现渲染错误 默认3000
syntax sync minlines=256
syntax enable

if exists("g:load_theme") && strlen(g:load_theme)>0
  set winblend=0
  set wildoptions=pum
  set pumblend=5

  if g:load_theme=="ownTheme"
    " Use own theme
    LoadScript ./colors/ownTheme.vim
  elseif strlen(g:load_theme)>0
    " use plugTheme
    exe 'colorscheme' . " " . g:load_theme

    if strlen($term)>0
      " for opacity in terminal
      autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    endif
  endif
endif

if g:set_termguicolors 
  set termguicolors " make nvim slow in fluent terminal
  set background=dark
else
  set notermguicolors 
endif

"=================================================theme end===================================================

doautocmd User LoadPluginConfig
