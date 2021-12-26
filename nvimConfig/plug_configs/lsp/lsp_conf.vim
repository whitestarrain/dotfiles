Plug 'neovim/nvim-lspconfig'
" lsp ui美化
Plug 'tami5/lspsaga.nvim'

autocmd User LoadPluginConfig call PlugConfigLSP()

function! PlugConfigLSP()
  LoadLua ./plug_configs/lsp/lsp_keybing_config.lua
endfunction

