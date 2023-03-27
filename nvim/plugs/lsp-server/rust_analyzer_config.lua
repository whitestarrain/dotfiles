local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

lspconfig.rust_analyzer.setup({
  on_attach = key_binding.on_attach,
  flags = {
    debounce_text_changes = 150,
  },
})
