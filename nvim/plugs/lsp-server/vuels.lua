local key_binding = require("lsp_keybing_config")

require("lspconfig").vuels.setup({
  on_attach = key_binding.on_attach,
})
