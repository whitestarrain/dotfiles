local key_binding = require('lsp_keybing_config')
local util = require("lspconfig/util")

require'lspconfig'.gopls.setup{
  on_attach = key_binding.on_attach,
  root_dir = util.root_pattern("go.mod")
}

--[[
-- 这个太严格了，用不到
require'lspconfig'.golangci_lint_ls.setup{
  on_attach = key_binding.on_attach,
  root_dir = util.root_pattern("go.mod")
} 
]]
