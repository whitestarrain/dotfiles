-- npm install -g cssmodules-language-server

-- Language server for autocompletion and go-to-definition functionality for CSS modules.

local key_binding = require('lsp_keybing_config')

require'lspconfig'.cssmodules_ls.setup{
    -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "html"},
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  on_attach = key_binding.on_attach,
  init_options = {
      camelCase = 'dashes',
  },
}
