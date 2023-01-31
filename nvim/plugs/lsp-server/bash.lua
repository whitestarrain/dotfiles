-- DEPN: npm i -g bash-language-server

local key_binding = require("lsp_keybing_config")

require("lspconfig").bashls.setup({
  -- disable shellcheck in bashls
  cmd_env = { SHELLCHECK_PATH = '' },
  on_attach = key_binding.on_attach,
})
