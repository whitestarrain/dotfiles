local Template = {
  -- plugin short url
  shortUrl = nil,
  dir = nil,
  opts = {},
  dependencies = nil,
  branch = nil,
  commit = nil,
  tags = nil,
  pin = nil,
  priority = 50,

  -- global mapping with prefix <leader>
  globalMappings = nil,

  --[[ 
  mapping example:
  -- type1
  {
    key = "<leader>z",
    name = "+others",
  }
  -- type2
  {
    key = "<leader>bd",
    cmd = function() end,
    desc = "delete buffer",
    mode = "n",
    buffer= nil,
    silent = true,
    noremap = true,
    nowait = false, 
  },
  ]]
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
