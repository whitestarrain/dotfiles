--DEPN: npm install -g typescript typescript-language-server

-- 引入没有import的js 提示(比如在html中引入过了)
-- 使用：/// <reference path="/path/to/js"/>
local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local key_binding = require("lsp_keybing_config")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local command = "typescript-language-server"
if vim.fn.has("win32") == 1 then
  command = command .. ".cmd"
end

lspconfig.tsserver.setup({
  cmd = { command, "--stdio" },
  on_attach = key_binding.on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  init_options = {
    hostInfo = "neovim",
  },
  capabilities = capabilities,
})
