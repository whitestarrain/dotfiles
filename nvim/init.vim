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
let g:python3_host_prog='D:/ProgramFiles/scoop/apps/anaconda3/current/envs/develop/python.exe'

"=================================================env config end===================================================

"=================================================control var start===================================================

" g:load_theme
" g:skip_project_plugs
" g:set_termguicolors
" g:plug_install_path
" g:python3_host_prog
" g:vscode
" code
  " g:python
  " g:rust
  " g:c
  " g:java
  " g:lua
  " g:front
  " g:latex
  " g:power_lsp

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

" 配置项说明
" 配置加载相关变量

" 是否设置termguicolors，默认不设置
let g:set_termguicolors=exists("g:set_termguicolors") && g:set_termguicolors && exists("&termguicolors") && exists("&winblend")

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
let g:which_key_map.c = { 'name' : '[code]' }
let g:which_key_map.h = { 'name' : '[hunk]' }
"=================================================leader group end===================================================

"=================================================plug load start===================================================
if exists("g:plug_install_path") && strlen(g:plug_install_path)>0

  " Specify a directory for plugins
  " - For Neovim: stdpath('data') . '/plugged'  "即 C:\Users\稀落的星\AppData\Local\nvim-data\plugs
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin(get(g:,"plug_install_path"))

    " LoadScript ./plug_configs/drawit.vim 暂时用不到
    
    " plenary for {todo.vim,git.vim,telescope.vim}
    LoadScript ./plug_configs/denpendency/plenary.vim
    LoadScript ./plug_configs/ui/theme.vim
    LoadScript ./plug_configs/vim_surround.vim
    LoadScript ./plug_configs/rainrow.vim
    LoadScript ./plug_configs/auto_pair.vim
    LoadScript ./plug_configs/ui/indentline.vim
    LoadScript ./plug_configs/tag_bar.vim
    LoadScript ./plug_configs/ui/vim_devicons.vim " 主要为startify 提供icon支持，可选
    LoadScript ./plug_configs/ui/nvim_web_devicons.vim " 主要为bufferline提供icon支持，可选
    LoadScript ./plug_configs/kommentary.vim
    LoadScript ./plug_configs/treesitter.vim
    LoadScript ./plug_configs/ui/todo.vim
    if g:set_termguicolors 
      LoadScript ./plug_configs/ui/bufferline.vim
      LoadScript ./plug_configs/ui/galaxyline.vim
      LoadScript ./plug_configs/ui/nvim_colorizer.vim
    endif

    "load selected plugins
    if !exists('g:skip_project_plugs')
      LoadScript ./plug_configs/ui/starify.vim " 加载这个插件的话，放上面，session关闭时处理相关
      LoadScript ./plug_configs/term/asyn_run.vim " 功能强大，但是暂时应该用不到
      LoadScript ./plug_configs/term/vim_floaterm.vim
      LoadScript ./plug_configs/git.vim
      LoadScript ./plug_configs/telescope.vim
      LoadScript ./plug_configs/easy_motion.vim
      LoadScript ./plug_configs/ui/nvim-tree.vim
      LoadScript ./plug_configs/ui/vim_which_key.vim
      LoadScript ./plug_configs/lang_support/vim_markdown.vim
      LoadScript ./plug_configs/prettier.vim
      LoadScript ./plug_configs/md_img_paste.vim
      LoadScript ./plug_configs/snippets.vim
      " LoadScript ./plug_configs/vim_visual_multi.vim" 待安装

      " 加载语言相关的vim插件
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
        " LoadScript ./plug_configs/_pre/debug/nvim_dap.vim
        LoadScript ./plug_configs/_pre/debug/nvim_gdb.vim
      endif
      if exists("g:golang")
        let g:load_program = 1
      endif
      if exists("g:java")
        let g:load_program = 1
      endif
      if exists("g:bash")
        let g:load_program = 1
      endif
      if exists("g:lua")
        let g:load_program = 1
      endif
      if exists("g:typescript")
        LoadScript ./plug_configs/lang_support/jsx.vim
        LoadScript ./plug_configs/lang_support/typescript.vim
        LoadScript ./plug_configs/lang_support/auto_tag.vim
        LoadScript ./plug_configs/lang_support/javascript.vim
        let g:load_program = 1
      endif
      if exists("g:vscode")
        " vscode lsp
        LoadScript ./plug_configs/lang_support/auto_tag.vim
        LoadScript ./plug_configs/lang_support/javascript.vim
        let g:load_program = 1
      endif
      if exists("g:latex")
        LoadScript ./plug_configs/lang_support/latex.vim
        let g:load_program = 1
      endif
      if exists("g:front")
        " typescript 和 vscode环境的语言插件
        LoadScript ./plug_configs/lang_support/jsx.vim
        LoadScript ./plug_configs/lang_support/typescript.vim
        LoadScript ./plug_configs/lang_support/auto_tag.vim
        LoadScript ./plug_configs/lang_support/javascript.vim
        let g:load_program = 1
      endif
      if exists("g:vue")
        let g:load_program = 1
      endif
      if exists("g:power_lsp")
        " 全部语言的语言插件
        LoadScript ./plug_configs/lang_support/rust.vim
        " LoadScript ./plug_configs/_pre/debug/nvim_dap.vim
        LoadScript ./plug_configs/lang_support/jsx.vim
        LoadScript ./plug_configs/lang_support/typescript.vim
        LoadScript ./plug_configs/lang_support/auto_tag.vim
        LoadScript ./plug_configs/lang_support/javascript.vim
        LoadScript ./plug_configs/lang_support/latex.vim
        let g:load_program = 1
      endif

      " lsp_config load
      if g:load_program
        LoadScript ./plug_configs/lsp/lsp_conf.vim
        LoadScript ./plug_configs/lsp/diagnostics_list.vim
      endif

      " auto complete config. related with the var "load_program""
      LoadScript ./plug_configs/lsp/auto_complete.vim

    endif

  call plug#end()

  " 加载lsp配置
  if !exists('g:skip_project_plugs')
    if exists("g:python")
      " 通过require("python")返回
      LoadLua ./plug_configs/lsp-server/pyright_config.lua
    endif
    if exists("g:rust")
      LoadLua ./plug_configs/lsp-server/rust_analyzer_config.lua
    endif
    if exists("g:java")
      LoadLua ./plug_configs/lsp-server/java.lua
    endif
    if exists("g:lua")
      LoadLua ./plug_configs/lsp-server/lua_lsp_config.lua
    endif
    if exists("g:typescript")
      " ts和js以及react
      LoadLua ./plug_configs/lsp-server/tsserver.lua 
    endif
    if exists("g:c")
      LoadLua ./plug_configs/lsp-server/clangd_config.lua
      " LoadLua ./plug_configs/_pre/debug/debug_dap/lldb.lua
    endif
    if exists("g:golang")
      LoadLua ./plug_configs/lsp-server/golang.lua
    endif
    if exists("g:latex")
      LoadLua ./plug_configs/lsp-server/texlab.lua
    endif
    if exists("g:vscode")
      " vscode 配套lsp
      LoadLua ./plug_configs/lsp-server/vscode-lsp.lua
      " emmet支持
      LoadLua ./plug_configs/lsp-server/emmet.lua 
      " 不扫描node_module，还没有解决
      " LoadLua ./plug_configs/lsp-server/denols.lua 
      " tailwindcss 框架专属，暂时用不到
      " LoadLua ./plug_configs/lsp-server/tailwindcss.lua
    endif
    if exists("g:front")
      " typescript 和 vscode的lsp
      LoadLua ./plug_configs/lsp-server/tsserver.lua 
      " LoadLua ./plug_configs/lsp-server/flow.lua
      LoadLua ./plug_configs/lsp-server/vscode-lsp.lua
      LoadLua ./plug_configs/lsp-server/emmet.lua 
      " windows上好像用不了
      " LoadLua ./plug_configs/lsp-server/cssmodule_ls.lua
    endif
    if exists("g:vue")
      LoadLua ./plug_configs/lsp-server/tsserver.lua 
      LoadLua ./plug_configs/lsp-server/vuels.lua
      LoadLua ./plug_configs/lsp-server/vscode-lsp.lua
      LoadLua ./plug_configs/lsp-server/emmet.lua 
    endif
    if exists("g:bash")
      LoadLua ./plug_configs/lsp-server/bash.lua
      LoadLua ./plug_configs/lsp-server/efm-lsp.lua
    endif
    " 全部语言lsp
    if exists("g:power_lsp")
      LoadLua ./plug_configs/lsp-server/rust_analyzer_config.lua
      LoadLua ./plug_configs/lsp-server/java.lua
      LoadLua ./plug_configs/lsp-server/lua_lsp_config.lua
      LoadLua ./plug_configs/lsp-server/tsserver.lua 
      LoadLua ./plug_configs/lsp-server/pyright_config.lua
      LoadLua ./plug_configs/lsp-server/vscode-lsp.lua
      LoadLua ./plug_configs/lsp-server/emmet.lua 
      LoadLua ./plug_configs/lsp-server/clangd_config.lua
      LoadLua ./plug_configs/lsp-server/golang.lua
      LoadLua ./plug_configs/lsp-server/texlab.lua
      LoadLua ./plug_configs/lsp-server/vuels.lua
    endif

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
