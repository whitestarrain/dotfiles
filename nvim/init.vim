" nvim-qt option in windows: --no-ext-tabline -fullscreen

" variables: g:skip_project_plugs
"            g:code_language_list

let g:absolute_config_path = simplify(expand("<sfile>:p")[0:strlen(expand("<sfile>:p"))-strlen(expand("<sfile>:t"))-1])
command! -nargs=1 LoadScript exec 'source' . ' ' . simplify(g:absolute_config_path . '<args>')
command! -nargs=1 LoadLua exec 'luafile' . ' ' .  simplify(g:absolute_config_path . '<args>')

let &runtimepath.="," . g:absolute_config_path[0:-2] . "\\runtime" " add runtimepath

LoadScript base/common.vim
LoadScript base/mappings.vim
LoadScript base/functions.vim

if !exists("g:code_language_list") 
  let g:code_language_list=[] 
endif
let g:plug_install_path = g:absolute_config_path . "../vim_plug_download"

if strlen($term)==0 && has("win32")
  " nvim-qt
  autocmd vimenter * GuiFont! MesloLGS NF:h14
endif

call plug#begin(get(g:,"plug_install_path"))

  " plenary for {todo.vim,git.vim,telescope.vim}
  LoadScript ./plugs/denpendency/plenary.vim
  LoadScript ./plugs/vim_surround.vim
  LoadScript ./plugs/rainrow.vim
  LoadScript ./plugs/ui/indentline.vim
  LoadScript ./plugs/tag_bar.vim
  LoadScript ./plugs/ui/vim_devicons.vim " 主要为startify 提供icon支持，可选
  LoadScript ./plugs/ui/nvim_web_devicons.vim " 主要为bufferline提供icon支持，可选
  LoadScript ./plugs/abolish.vim
  LoadScript ./plugs/lang_support/plantuml.vim
  LoadScript ./plugs/term/vim_floaterm.vim
  LoadScript ./plugs/tabular.vim
  LoadLua ./plugs/mdSectionNumber.lua
  LoadLua ./plugs/kommentary.lua
  LoadLua ./plugs/treesitter.lua
  LoadLua ./plugs/auto_pair.lua
  LoadLua ./plugs/ui/todo-comments.lua

  LoadLua ./plugs/theme/neosolarized_nvim.lua

  " plugin that need after theme config
  LoadLua ./plugs/ui/bufferline.lua
  LoadLua ./plugs/ui/lualine.lua
  LoadLua ./plugs/ui/nvim_colorizer.lua

  " extral plugin
  if !exists('g:skip_project_plugs')
    LoadScript ./plugs/ui/starify.vim
    LoadScript ./plugs/easy_motion.vim
    LoadScript ./plugs/ui/vim_which_key.vim
    LoadScript ./plugs/bullets.vim
    LoadScript ./plugs/prettier.vim
    LoadScript ./plugs/md_img_paste.vim
    LoadScript ./plugs/snippets.vim
    LoadScript ./plugs/vimdoc_cn.vim
    LoadLua ./plugs/ui/nvim-tree.lua
    LoadLua ./plugs/telescope.lua
    LoadLua ./plugs/git.lua

    " code language support plugin
    for code_language in g:code_language_list
      if code_language == "rust"
        LoadScript ./plugs/lang_support/rust.vim
      endif
      if code_language == "python" | endif
      if code_language == "c"
        " LoadScript ./plugs/_pre/debug/nvim_dap.vim
        LoadScript ./plugs/_pre/debug/nvim_gdb.vim
      endif
      if code_language == "golang" | endif
      if code_language == "java" | endif
      if code_language == "bash" | endif
      if code_language == "vim" | endif
      if code_language == "lua" 
        LoadLua ./plugs/lang_support/lua_dev.lua
        LoadLua ./plugs/nvim-luapad.lua 
      endif
      if code_language == "front"
        LoadLua ./plugs/lang_support/auto_tag.lua
      endif
      if code_language == "vue" | endif
      if code_language == "latex"
        LoadScript ./plugs/lang_support/latex.vim
      endif
    endfor

    if len(g:code_language_list)>0
      LoadLua ./plugs/lsp/lsp_conf.lua
      LoadLua ./plugs/lsp/diagnostics_list.lua
      LoadLua ./plugs/lsp/symbols_outline.lua
      " lint tool
      LoadLua ./plugs/nvim-lint.lua
    endif

    " auto complete
    LoadScript ./plugs/lsp/auto_complete.lua
    " format tool
    LoadLua ./plugs/formatter.lua

  endif

call plug#end()

" 加载lsp配置
for code_language in g:code_language_list
  if exists('g:skip_project_plugs')
    break
  endif
  if code_language == "rust"
    LoadLua ./plugs/lsp-server/rust_analyzer_config.lua
  endif
  if code_language == "python"
    " 通过require("python")返回
    LoadLua ./plugs/lsp-server/pyright_config.lua
  endif
  if code_language == "c"
    LoadLua ./plugs/lsp-server/clangd_config.lua
    " LoadLua ./plugs/_pre/debug/debug_dap/lldb.lua
  endif
  if code_language == "golang"
    LoadLua ./plugs/lsp-server/golang.lua
  endif
  if code_language == "java"
    LoadLua ./plugs/lsp-server/java.lua
  endif
  if code_language == "bash"
    LoadLua ./plugs/lsp-server/bash.lua
  endif
  if code_language == "vim"
    LoadLua ./plugs/lsp-server/vimls.lua
  endif
  if code_language == "lua"
    LoadLua ./plugs/lsp-server/lua_lsp_config.lua
  endif
  if code_language == "front"
    LoadLua ./plugs/lsp-server/tsserver.lua 
    " vscode 配套lsp
    LoadLua ./plugs/lsp-server/vscode-lsp.lua
    " emmet支持
    LoadLua ./plugs/lsp-server/emmet.lua 
    " 不扫描node_module，还没有解决
    " LoadLua ./plugs/lsp-server/denols.lua 
    " tailwindcss 框架专属，暂时用不到
    " LoadLua ./plugs/lsp-server/tailwindcss.lua
  endif
  if code_language == "vue"
    LoadLua ./plugs/lsp-server/vuels.lua
  endif
  if code_language == "latex"
    LoadLua ./plugs/lsp-server/texlab.lua
  endif
  if code_language == "dot"
    LoadLua ./plugs/lsp-server/dot.lua
  endif
  if code_language == "php"
    LoadLua ./plugs/lsp-server/php_intelephense.lua
  endif
endfor

doautocmd User LoadPluginConfig

delcommand LoadScript
delcommand LoadLua
