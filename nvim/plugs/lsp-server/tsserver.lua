--DEPN: npm install -g typescript typescript-language-server

local key_binding = require("lsp_keybing_config")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- 引入没有import的js 提示(比如在html中引入过了)
-- 使用：/// <reference path="/path/to/js"/>
require("lspconfig").tsserver.setup({
  cmd = { "typescript-language-server.cmd", "--stdio" },
  on_attach = key_binding.on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim",
  },
  capabilities = capabilities,
})
