Plug 'neovim/nvim-lspconfig'

autocmd vimenter * call PlugConfigLSP()

function! PlugConfigLSP()
  LoadLua ./plug_configs/lsp/lsp_keybing_config.lua
endfunction

