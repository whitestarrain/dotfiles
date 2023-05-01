-- check install
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("start clone lazy to " .. lazypath)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy config
local opt = {
  root = vim.g.absolute_config_path .. "lazy_plugins",
  install = {
    missing = true,
  },
  checker = {
    enabled = false,
  },
}

-- plugin config handler
local pluginConfigConvert = function(pluginDatas)
  local result = {}
  for _, originConfig in ipairs(pluginDatas) do
    if originConfig.shortUrl ~= nil then
      table.insert(result, {
        originConfig.shortUrl,
        dir = originConfig.dir,
        cond = originConfig.cond,
        init = originConfig.init,
        config = originConfig.config,
        dependencies = originConfig.dependencies,
        opts = originConfig.opts,
        build = originConfig.build,
        branch = originConfig.branch,
        commit = originConfig.commit,
        pin = originConfig.pin,
        priority = originConfig.priority,
      })
    end
  end
  return result
end

-- return load interface
local loadPlugins = function(pluginDatas)
  local plugins = pluginConfigConvert(pluginDatas)

  -- lazy will delete custom runtimepath
  local recoverLostRTP = require("wsain.utils").recoverLostRuntimepath()
  require("lazy").setup(plugins, opt)
  recoverLostRTP()
end

return {
  load = loadPlugins,
}
