Plug 'neovim/nvim-lspconfig'
" lsp ui美化

Plug 'tami5/lspsaga.nvim'
" 按键映射配置放到了./lsp_keybing_config.lua

autocmd User LoadPluginConfig call PlugConfigLSP()

function! PlugConfigLSP()

lua << EOF

  -- icon config
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- handler 配置，添加参数
  local lsp = vim.lsp
  -- Global handlers.
  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, {
    border = "single",
    offset_x = 1,
    width = 100,
  })

  lsp.handlers["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, {
    border = "single",
    width = 100,
  })

EOF

endfunction
