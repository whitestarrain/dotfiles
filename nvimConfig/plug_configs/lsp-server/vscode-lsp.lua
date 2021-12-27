-- 不能用
local key_binding = require('lsp_keybing_config')
-- 需要以snip的方式加入到补全中中
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
   capabilities = capabilities,
   on_attach = key_binding.on_attach
}

-- format: autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>
require'lspconfig'.eslint.setup{
   capabilities = capabilities,
   on_attach = key_binding.on_attach
}

require'lspconfig'.jsonls.setup {
   capabilities = capabilities,
   on_attach = key_binding.on_attach
}

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
   on_attach = key_binding.on_attach
}

