-- 注意:3.3版本对中文输入有bug，会导致lsp quit。
--      暂且使用3.0版本吧，没有问题

local key_binding = require('lsp_keybing_config')

require'lspconfig'.texlab.setup{
  cmd = {"D:/ProgramFiles/lsp/texlab.exe"},
  on_attach = key_binding.on_attach,
}
