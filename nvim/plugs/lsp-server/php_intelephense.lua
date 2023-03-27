-- DEPN: npm install -g intelephense
local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
lspconfig.intelephense.setup({
  on_attach = key_binding.on_attach,
})
