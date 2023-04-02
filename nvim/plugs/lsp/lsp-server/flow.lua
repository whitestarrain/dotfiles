-- npm install -g flow-bin

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local key_binding = require("lsp_keybing_config")

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

lspconfig.flow.setup({
  cmd = { "cmd.exe", "/C", "flow", "lsp" },
  on_attach = key_binding.on_attach,
  capabilities = capabilities,
})
