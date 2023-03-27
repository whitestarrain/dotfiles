local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

lspconfig.vuels.setup({
  on_attach = key_binding.on_attach,
})
