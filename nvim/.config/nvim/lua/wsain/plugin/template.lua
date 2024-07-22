local Template = {
  -- plugin short url
  shortUrl = nil,
  dir = nil,
  opts = {},
  dependencies = nil,
  branch = nil,
  commit = nil,
  tag = nil,
  version = nil,
  pin = nil,
  priority = 50,

  loadEvent = nil,
}

Template.__index = Template

-- control whether the plugin is loaded
function Template:cond()
  return true
end

-- execute before plugin loaded
function Template:init() end

-- execute after plugin loaded。also config dependencies in here
function Template:config() end

-- execute after plugin installed or updated
function Template:build() end

function Template:new(attrs)
  attrs = attrs or {}
  return setmetatable(attrs, self)
end

return Template
