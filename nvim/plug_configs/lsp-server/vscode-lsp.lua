-- NOTE: npm i -g vscode-langservers-extracted

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
    -- cmd = { "vscode-eslint-language-server", "--stdio" }
    -- eslint 为解析器，vscode-eslint-language-server是使用eslint这个解析器的lsp，两个不一样。eslint没有自带的lsp模式
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
    filetypes = { 'css', 'scss', 'less', 'html'},
    on_attach = key_binding.on_attach
}

