local key_binding = require('lsp_keybing_config')

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
local runtime_path = {}
table.insert(runtime_path,"?.lua")
require'lspconfig'.sumneko_lua.setup{
  cmd = {"D:/ProgramFiles/lua-language-server/bin/lua-language-server.exe", "-E", "D:/ProgramFiles/lua-language-server/bin/main.lua"},
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = key_binding.on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}
