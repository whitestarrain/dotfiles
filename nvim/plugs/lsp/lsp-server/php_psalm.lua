-- DEPN: https://github.com/vimeo/psalm
-- composer global require --dev vimeo/psalm

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end

local key_binding = require("lsp_keybing_config")

lspconfig.psalm.setup({
  cmd = { "D:/scoop/persist/composer/home/vendor/bin/psalm-language-server.bat" },
  on_attach = key_binding.on_attach,
})
