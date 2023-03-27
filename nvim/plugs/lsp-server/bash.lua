-- DEPN: npm i -g bash-language-server

local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
lspconfig.bashls.setup({
  -- disable shellcheck in bashls
  cmd_env = { SHELLCHECK_PATH = "" },
  on_attach = key_binding.on_attach,
})
