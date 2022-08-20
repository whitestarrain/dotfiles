" nvim-qt option in windows: --no-ext-tabline -fullscreen

" variables: g:skip_project_plugs

let g:absolute_config_path = simplify(expand("<sfile>:p")[0:strlen(expand("<sfile>:p"))-strlen(expand("<sfile>:t"))-1])
command! -nargs=1 LoadScript exec 'source' . ' ' . simplify(g:absolute_config_path . '<args>')
command! -nargs=1 LoadLua exec 'luafile' . ' ' .  simplify(g:absolute_config_path . '<args>')

let &runtimepath.="," . g:absolute_config_path[0:-2] " add runtimepath

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
  LoadScript ./plug_configs/denpendency/plenary.vim
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

  if exists("$WEZTERM") || exists("$ALACRITTY_LOG")
    LoadLua ./plug_configs/theme/neosolarized_nvim.lua
  else 
    LoadScript ./plug_configs/theme/onedark.vim
  endif

  " plugin that need after theme config
  LoadLua ./plug_configs/ui/bufferline.lua
  LoadLua ./plug_configs/ui/lualine.lua
  LoadLua ./plug_configs/ui/nvim_colorizer.lua

  " extral plugin
  if !exists('g:skip_project_plugs')
    LoadScript ./plug_configs/ui/starify.vim
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

    " code language support plugin
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
        LoadScript ./plug_configs/nvim-luapad.lua 
      endif
      if code_language == "front"
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
    endif

    " format and lint tool
    LoadLua ./plug_configs/formatter.lua
    LoadLua ./plug_configs/nvim-lint.lua

    " auto complete
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

doautocmd User LoadPluginConfig

