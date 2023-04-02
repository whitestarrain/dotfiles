-- DEPN: npm install -g vim-language-server

local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

lspconfig.vimls.setup({
  on_attach = key_binding.on_attach,
})
