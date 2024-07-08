---@diagnostic disable: missing-parameter, missing-parameter, param-type-mismatch

-- load runtimepath
vim.g.absolute_config_path = string.sub(
  vim.fn.expand("<sfile>:p"),
  0,
  string.len(vim.fn.expand("<sfile>:p")) - string.len(vim.fn.expand("<sfile>:t"))
)
vim.opt.rtp:append(string.sub(vim.g.absolute_config_path, 1, -2))

-- basic config
require("wsain.opts")
require("wsain.autocmd")
require("wsain.commands")

-- plugin config
local pluginDatas = require("wsain.plugin.plugins")
local pluginManager = require("wsain.plugin.lazy")
local mappingRegister = require("wsain.plugin.whichkey")
pluginManager.load(pluginDatas)
mappingRegister.register(pluginDatas)

-- base mapping override plugin mapping
require("wsain.base_mappings")
