local key_binding = require('lsp_keybing_config')

local capabilities = vim.lsp.protocol.make_client_capabilities()
require'lspconfig'.tsserver.setup {
  on_attach = key_binding.on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities
}
