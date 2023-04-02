-- DEPN: install lsp from https://github.com/sumneko/lua-language-server
-- scoop 安装可能会出问题
-- 参照：https://github.com/folke/dot/blob/master/config/nvim/lua/plugins.lua

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  return
end
local status, luadev = pcall(require, "lua-dev")
if not status then
  return
end

local util = require("lspconfig/util")

local key_binding = require("lsp_keybing_config")

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "?.lua")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

luadev = luadev.setup({
  lspconfig = {
    cmd = {"lua-language-server.cmd"},
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = runtime_path,
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
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
      return util.root_pattern(".git")(fname) or util.path.dirname(fname)
    end,
  },
})

lspconfig.lua_ls.setup(luadev)
