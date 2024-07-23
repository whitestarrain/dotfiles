---@diagnostic disable: missing-parameter, missing-parameter, param-type-mismatch

-- load runtimepath
vim.g.absolute_config_path = string.sub(
  vim.fn.expand("<sfile>:p"),
  0,
  string.len(vim.fn.expand("<sfile>:p")) - string.len(vim.fn.expand("<sfile>:t"))
)
vim.opt.rtp:prepend(string.sub(vim.g.absolute_config_path, 1, -2))

-- basic config
require("wsain.opts")
require("wsain.autocmd")
require("wsain.commands")

-- mapping manager
local wk_plugin_data = require("wsain.plugin.whichkey").plugin

-- plugin config
local pluginDatas = require("wsain.plugin.plugins")
local pluginManager = require("wsain.plugin.lazy")
table.insert(pluginDatas, 1, wk_plugin_data)
pluginManager.load(pluginDatas)

-- base mapping override plugin mapping
require("wsain.base_mappings")
