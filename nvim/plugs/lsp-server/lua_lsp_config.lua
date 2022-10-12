-- DEPN: install lsp from https://github.com/sumneko/lua-language-server
-- scoop 安装可能会出问题
-- 参照：https://github.com/folke/dot/blob/master/config/nvim/lua/plugins.lua
local util = require("lspconfig/util")

local key_binding = require('lsp_keybing_config')

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "?.lua")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {vim.g.absolute_config_path  .. "../lsp_exe/lua-language-server/bin/lua-language-server.exe",
          "-E",
          vim.g.absolute_config_path .. "../lsp_exe/lua-language-server/bin/main.lua"},
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
    },
    root_dir = function(fname)
      return util.root_pattern(".git")(fname) or
        util.path.dirname(fname)
    end,
  }
})

require'lspconfig'.sumneko_lua.setup(luadev)
