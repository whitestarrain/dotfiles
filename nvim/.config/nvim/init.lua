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
local whichkey_plugin_spec = require("wsain.plugin.whichkey").plugin

-- plugin config
local plugin_specs = require("wsain.plugin.plugins")
local plugin_manager = require("wsain.plugin.lazy")
table.insert(plugin_specs, 1, whichkey_plugin_spec)
plugin_manager.load(plugin_specs)

-- hide deprecate info
vim.deprecate = function() end

-- disable treesiter by default
vim.g.ts_start = vim.treesitter.start
vim.treesitter.start = function() end

-- base mapping override plugin mapping
require("wsain.base_mappings")
