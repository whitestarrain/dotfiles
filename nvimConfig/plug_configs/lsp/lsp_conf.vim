Plug 'neovim/nvim-lspconfig'
" lsp ui美化

Plug 'tami5/lspsaga.nvim'
" 按键映射配置放到了./lsp_keybing_config.lua

autocmd User LoadPluginConfig call PlugConfigLSP()

function! PlugConfigLSP()
  LoadLua ./plug_configs/lsp/lsp_keybing_config.lua
endfunction
