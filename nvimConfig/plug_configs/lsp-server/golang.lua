local key_binding = require('lsp_keybing_config')

require'lspconfig'.gopls.setup{
  on_attach = key_binding.on_attach,
}
