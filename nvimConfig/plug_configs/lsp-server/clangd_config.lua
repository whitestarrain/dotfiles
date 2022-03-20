-- c++ (指不定哪天叛逃到ccls)

local key_binding = require('lsp_keybing_config')

require'lspconfig'.clangd.setup{
    on_attach = key_binding.on_attach,
    flags = {
      debounce_text_changes = 150,
    }
}
