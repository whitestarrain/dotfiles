-- DEPN: npm install -g @tailwindcss/language-server

local key_binding = require("lsp_keybing_config")
local capabilities = vim.lsp.protocol.make_client_capabilities()

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
lspconfig.tailwindcss.setup({
  on_attach = key_binding.on_attach,
  capabilities = capabilities,
})
