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
local convert_plugin_specs = function(plugin_specs)
  local result = {}
  for _, spec in pairs(plugin_specs) do
    if type(spec) == "table" and spec.short_url ~= nil then
      if spec.dir ~= nil then
        spec.dev = true
      end
      table.insert(result, {
        spec.short_url,
        dir = spec.dir,
        cond = spec.cond,
        init = spec.init,
        config = spec.config,
        dependencies = spec.dependencies,
        opts = spec.opts,
        build = spec.build,
        branch = spec.branch,
        commit = spec.commit,
        tag = spec.tag,
        version = spec.version,
        pin = spec.pin,
        priority = spec.priority,
        event = spec.load_event,
        dev = spec.dev,
      })
    end
  end
  return result
end

-- return load interface
local load_plugins = function(plugin_specs)
  local plugins = convert_plugin_specs(plugin_specs)

  -- lazy will delete custom runtimepath
  require("lazy").setup(plugins, opt)
end

return {
  load = load_plugins,
}
