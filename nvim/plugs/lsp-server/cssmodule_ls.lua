-- npm install -g cssmodules-language-server

-- Language server for autocompletion and go-to-definition functionality for CSS modules.

local key_binding = require('lsp_keybing_config')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssmodules_ls.setup{
    -- filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "html"},
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  on_attach = key_binding.on_attach,
  capabilities = capabilities,
  init_options = {
      camelCase = 'dashes',
  },
}
