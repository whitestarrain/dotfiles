-- 注意:3.3版本对中文输入有bug，会导致lsp quit。
--      暂且使用3.0版本吧，没有问题

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local key_binding = require("lsp_keybing_config")

lspconfig.texlab.setup({
  cmd = { vim.g.absolute_config_path .. "../lsp_exe/texlab.exe" },
  on_attach = key_binding.on_attach,
})
