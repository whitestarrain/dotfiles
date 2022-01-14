-- 不能用
local key_binding = require('lsp_keybing_config')
-- 需要以snip的方式加入到补全中中
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
    capabilities = capabilities,
    on_attach = key_binding.on_attach
}

-- format: autocmd BufWritePre <buffer> <cmd>EslintFixAll<CR>local
-- eslint --init to init eslint config file
-- add node enviroment: https://eslint.org/docs/user-guide/configuring/language-options#specifying-environments
require'lspconfig'.eslint.setup{
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue" },
    on_attach = key_binding.on_attach,
}

require'lspconfig'.jsonls.setup {
    capabilities = capabilities,
    on_attach = key_binding.on_attach
}

require'lspconfig'.cssls.setup {
    capabilities = capabilities,
    on_attach = key_binding.on_attach
}

