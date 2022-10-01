"-----------------------------------格式化化插件--------------------------------------
" prettier 格式化插件
" post install (yarn install | npm install) then load plugin only for editing supported files

" DEPN: 安装依赖npm install prettier@1.18.2
Plug 'prettier/vim-prettier'

"-----------------------------------格式化化插件--------------------------------------
autocmd User LoadPluginConfig call PlugConfigPrettier()
function! PlugConfigPrettier()
  " prettier config
  " 取消注解需求
  let g:prettier#autoformat_require_pragma = 0

  " 关闭自动格式化
  let g:prettier#autoformat = 0
  let g:prettier#autoformat_config_present = 0

  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.svelte,*.yaml,*.html Prettier

endfunction
