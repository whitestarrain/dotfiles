" nvim-qt 要加上 --no-ext-tabline，才能使用airline的bufferline。加上 --fullscreen全屏显示

"=================================================env config start===================================================
" 定义载入配置命令
" let g:absolute_config_path = expand("%:p")[0:strlen(expand("%:p"))-strlen(expand("%:t"))-1]
let g:absolute_config_path = expand("<sfile>:p")[0:strlen(expand("<sfile>:p"))-strlen(expand("<sfile>:t"))-1]
command! -nargs=1 LoadScript exec 'source' . ' ' . g:absolute_config_path . '<args>'
command! -nargs=1 LoadLua exec 'luafile' . ' ' . g:absolute_config_path . '<args>'

" 添加不在runtimepath中的lua文件的加载路径
lua package.path = package.path .. ";" .. vim.g.absolute_config_path .. "./plug_configs/lsp/?.lua"

" python 环境
let g:python3_host_prog='D:\\learn\\anaconda3\\envs\\learn\\python.exe'

"=================================================env config end===================================================

"=================================================control var start===================================================

" g:load_theme
" g:skip_project_plug
" g:set_termguicolors
" g:python
" g:rust
" g:plug_install_path
" g:python3_host_prog
" g:vscode

if strlen($term)==0
  " nvim-qt
  let g:set_termguicolors=1
  let g:load_theme="onedark"
  " let g:load_theme="NeoSolarized"
  autocmd vimenter * GuiFont! MesloLGS NF:h11
elseif $term=="alacritty"
  " alacritty
  let g:neosolarized_termtrans=1
  let g:set_termguicolors=1
  let g:load_theme="onedark"
elseif exists("$WEZTERM")
  let g:set_termguicolors=1
  let g:load_theme="onedark"
else
  " nvim in terminal
  let g:set_termguicolors=0
  let g:load_theme="onedark"
endif

" 配置项说明
" 配置加载相关变量
if exists("g:load_theme")
  " ownTheme,plugTheme,默认不加载
  let g:load_theme=g:load_theme              
endif
"
" 是否设置termguicolors，默认不设置
let g:set_termguicolors=exists("g:set_termguicolors") && g:set_termguicolors 

if exists("g:plug_install_path")
  " 插件安装路径，不设置，则不会加载插件
  let g:plug_install_path=g:plug_install_path 
endif

if !exists('g:vscode')
    let g:plug_install_path = g:absolute_config_path . "../vim_plug_download"
endif

"=================================================control var end===================================================

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
let g:which_key_map.c = { 'name' : '[comment]' }
let g:which_key_map.h = { 'name' : '[hunk]' }
"=================================================leader group end===================================================

"=================================================plug load start===================================================
if exists("g:plug_install_path") && strlen(g:plug_install_path)>0

  " Specify a directory for plugins
  " - For Neovim: stdpath('data') . '/plugged'  "即 C:\Users\稀落的星\AppData\Local\nvim-data\plugs
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin(get(g:,"plug_install_path"))

  LoadScript ./plug_configs/ui/theme.vim
  LoadScript ./plug_configs/vim_surround.vim
  LoadScript ./plug_configs/rainrow.vim
  LoadScript ./plug_configs/auto_pair.vim
  LoadScript ./plug_configs/ui/indentline.vim
  LoadScript ./plug_configs/nvim_colorizer.vim
  LoadScript ./plug_configs/tag_bar.vim
  LoadScript ./plug_configs/ui/vim_devicons.vim " 主要为startify 提供icon支持，可选
  LoadScript ./plug_configs/ui/nvim_web_devicons.vim " 主要为bufferline提供icon支持，可选
  LoadScript ./plug_configs/ui/bufferline.vim
  LoadScript ./plug_configs/ui/galaxyline.vim
  LoadScript ./plug_configs/ui/nvim-tree.vim
  " LoadScript ./plug_configs/drawit.vim 暂时用不到

  "load selected plugins
  if !exists('g:skip_project_plugs')
    LoadScript ./plug_configs/ui/starify.vim " 加载这个插件的话，放上面，session关闭时处理相关
    " LoadScript ./plug_configs/far.vim
    " LoadScript ./plug_configs/comfortable_motion.vim
    " LoadScript ./plug_configs/nerdcommenter.vim
    " LoadScript ./plug_configs/term/asyn_run.vim " 功能强大，但是暂时应该用不到
    " LoadScript ./plug_configs/debugger.vim " 暂时应该用不上
    LoadScript ./plug_configs/term/vim_floaterm.vim
    LoadScript ./plug_configs/telescope.vim
    LoadScript ./plug_configs/treesitter.vim
    LoadScript ./plug_configs/easy_motion.vim
    LoadScript ./plug_configs/git.vim
    LoadScript ./plug_configs/ui/vim_which_key.vim
    LoadScript ./plug_configs/lang_support/latex.vim
    LoadScript ./plug_configs/lang_support/vim_markdown.vim
    LoadScript ./plug_configs/prettier.vim
    LoadScript ./plug_configs/md_img_paste.vim
    LoadScript ./plug_configs/snippets.vim
    " LoadScript ./plug_configs/vim_visual_multi.vim" 待安装

    let g:load_program = 0
    if exists("g:rust")
      LoadScript ./plug_configs/lang_support/rust.vim
      let g:load_program = 1
    endif

    if exists("g:python")
      let g:load_program = 1
    endif

    if exists("g:c")
      let g:load_program = 1
    endif

    if exists("g:java")
      let g:load_program = 1
    endif

    if exists("g:lua")
      let g:load_program = 1
    endif

    if g:load_program 
      LoadScript ./plug_configs/lsp/lsp_conf.vim
      LoadScript ./plug_configs/lsp/diagnostics_list.vim
    endif

    LoadScript ./plug_configs/lsp/auto_complete.vim

  endif

  call plug#end()

  if exists("g:python")
    " 通过require("python")返回
    LoadLua ./plug_configs/lsp-server/pyright_config.lua
  endif
  if exists("g:rust")
    LoadLua ./plug_configs/lsp-server/rust_analyzer_config.lua
  endif
  if exists("g:lua")
    LoadLua ./plug_configs/lsp-server/lua_lsp_config.lua
  endif

endif
"=================================================plug load end===================================================

"=================================================common config end===================================================
LoadScript common.vim
"=================================================commone config end===================================================

"================================================common =map start===================================================
LoadScript functions.vim
LoadScript mappings.vim
"=================================================common map end===================================================

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
    LoadScript .\colors\theme.vim
  elseif strlen(g:load_theme)>0
    " use plugTheme
    exe 'colorscheme' . " " . g:load_theme

    if strlen($term)>0
      " for opacity in terminal
      autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
    endif
  endif
endif

if exists("&termguicolors") && exists("&winblend") && g:set_termguicolors 
  set termguicolors " make nvim slow in fluent terminal
  set background=dark
else
  set notermguicolors 
endif

"=================================================theme end===================================================

