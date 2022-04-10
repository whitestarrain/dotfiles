Plug 'neovim/nvim-lspconfig'
" lsp ui美化

Plug 'tami5/lspsaga.nvim'
" 按键映射配置放到了./lsp_keybing_config.lua

autocmd User LoadPluginConfig call PlugConfigLSP()

function! PlugConfigLSP()
  LoadLua ./plug_configs/lsp/lsp_keybing_config.lua

lua << EOF

  -- icon config
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

EOF

endfunction
