Plug 'norcalli/nvim-colorizer.lua'

autocmd User LoadPluginConfig call PlugConfigColorzer()

function! PlugConfigColorzer()
  lua require 'colorizer'.setup({"json","xml","html","css","ps1","lua"})
endfunction
