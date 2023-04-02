-- DEPN: npm install -g @tailwindcss/language-server

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local key_binding = require("lsp_keybing_config")
local capabilities = vim.lsp.protocol.make_client_capabilities()

lspconfig.tailwindcss.setup({
  on_attach = key_binding.on_attach,
  capabilities = capabilities,
})
