-- 暂时不会用

vim.g.markdown_fenced_languages = {
  "ts=typescript",
  "js=javascript",
}
local key_binding = require("lsp_keybing_config")
local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
lspconfig.denols.setup({
  on_attach = key_binding.on_attach,
})
