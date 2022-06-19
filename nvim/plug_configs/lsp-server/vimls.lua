-- DEPN: npm install -g vim-language-server

local key_binding = require('lsp_keybing_config')

require'lspconfig'.vimls.setup{
  on_attach = key_binding.on_attach,
}
