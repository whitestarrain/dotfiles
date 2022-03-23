" diagnostics list
Plug 'folke/trouble.nvim'

autocmd User LoadPluginConfig call PlugConfigTrouble()

function! PlugConfigTrouble()
  " 默认值基本就行
  lua require("trouble").setup{}
endfunction


