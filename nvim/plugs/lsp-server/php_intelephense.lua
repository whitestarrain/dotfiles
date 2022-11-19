-- DEPN: npm install -g intelephense
local key_binding = require("lsp_keybing_config")

require("lspconfig").intelephense.setup({
  on_attach = key_binding.on_attach,
})
