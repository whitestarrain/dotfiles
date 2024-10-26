-- check install
local lazypath = vim.g.absolute_config_path .. ".plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.notify("start clone lazy to " .. lazypath)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  local lazy_lock_file = vim.g.absolute_config_path .. "/lazy-lock.json"
  if vim.loop.fs_stat(lazy_lock_file) then
    local f = io.open(lazy_lock_file)
    local json_str = f:read("*all")
    f:close()
    local plugin_version_table = vim.fn.json_decode(json_str)
    local commit = plugin_version_table["lazy.nvim"]["commit"]
    vim.fn.system({
      "git",
      "-C",
      lazypath,
      "checkout",
      commit,
    })
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazy config
local opt = {
  root = vim.g.absolute_config_path .. ".plugins",
  install = {
    missing = true,
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      reset = false,
      disabled_plugins = {
        "matchit",
      },
    },
  },
  ui = {
    border = "rounded",
  },
  checker = {
    enabled = false,
  },
  lockfile = vim.g.absolute_config_path .. "/lazy-lock.json", -- lockfile generated after running update.
}

-- plugin config handler
local pluginConfigConvert = function(pluginDatas)
  local result = {}
  for _, originConfig in pairs(pluginDatas) do
    if type(originConfig) == "table" and originConfig.shortUrl ~= nil then
      if originConfig.dir ~= nil then
        originConfig.dev = true
      end
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
        tag = originConfig.tag,
        version = originConfig.version,
        pin = originConfig.pin,
        priority = originConfig.priority,
        event = originConfig.loadEvent,
        dev = originConfig.dev,
      })
    end
  end
  return result
end

-- return load interface
local loadPlugins = function(pluginDatas)
  local plugins = pluginConfigConvert(pluginDatas)

  -- lazy will delete custom runtimepath
  require("lazy").setup(plugins, opt)
end

return {
  load = loadPlugins,
}
