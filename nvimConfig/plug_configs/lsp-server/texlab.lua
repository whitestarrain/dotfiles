local key_binding = require('lsp_keybing_config')

require'lspconfig'.texlab.setup{
  cmd = {"D:/ProgramFiles/lsp/texlab.exe"},
  on_attach = key_binding.on_attach,
}
