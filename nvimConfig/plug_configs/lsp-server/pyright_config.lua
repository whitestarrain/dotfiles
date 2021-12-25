local key_binding = require('lsp_keybing_config')

require'lspconfig'.pyright.setup{
    on_attach = key_binding.on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}

