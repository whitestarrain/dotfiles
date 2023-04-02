-- DEPN: npm install -g intelephense
local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local key_binding = require("lsp_keybing_config")

lspconfig.intelephense.setup({
  on_attach = key_binding.on_attach,
})
