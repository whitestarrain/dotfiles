--[[
local key_binding = require('lsp_keybing_config')

require'lspconfig'.java_language_server.setup{
  -- 注意：要使用 java13 执行lsp
  cmd = {"D:/learn/githubRepo/java-language-server/dist/lang_server_windows.cmd"},
  on_attach = key_binding.on_attach,
}
 ]]

-- 上面的有问题，import 时会使用'/'
-- 以后有时间还是配置jdtls看看吧
