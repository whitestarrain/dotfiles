local key_binding = require("lsp_keybing_config")

local status, lspconfig = pcall(require, "lspconfig")
local util = require("lspconfig/util")

if not status then
  return
end

lspconfig.jedi_language_server.setup({
  on_attach = key_binding.on_attach,
  root_dir = function(fname)
    return util.root_pattern(
      ".git",
      "setup.py",
      "setup.cfg",
      "pyproject.toml",
      "requirements.txt",
      "pyrightconfig.json"
    )(fname) or util.path.dirname(fname)
  end,
})
