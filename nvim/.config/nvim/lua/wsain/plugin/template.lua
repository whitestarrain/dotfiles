---@class PluginSpec
---@field short_url? string plugin GitHub short URL (e.g. "user/repo")
---@field dir? string local directory path for dev plugins
---@field opts? table plugin options passed to setup()
---@field dependencies? (string|table)[] plugin dependencies
---@field branch? string git branch
---@field commit? string git commit hash
---@field tag? string git tag
---@field version? string version constraint
---@field pin? boolean pin plugin version
---@field priority? integer load priority (default 50)
---@field load_event? string|string[] lazy.nvim event trigger
---@field dev? boolean whether this is a local dev plugin
local Template = {
  short_url = nil,
  dir = nil,
  opts = {},
  dependencies = nil,
  branch = nil,
  commit = nil,
  tag = nil,
  version = nil,
  pin = nil,
  priority = 50,
  load_event = nil,
}

Template.__index = Template

---@return boolean
function Template:cond()
  return true
end

function Template:init() end

function Template:config() end

function Template:build() end

---@param attrs? table
---@return PluginSpec
function Template:new(attrs)
  attrs = attrs or {}
  return setmetatable(attrs, self)
end

return Template
