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
  -- type1, group keymap
  {
    "n", -- mode
    "<leader>z", -- key
    name = "+others", -- group name
  }
  -- type2, common keymap
  {
    "n", -- mode
    "<leader>bd", -- key
    function() end, -- cmd
    "delete buffer", -- desc
    opts = {
      nowait = false, 
      silent = true,
      noremap = true,
    }
  },
  ]]

  -- not general config
  event = nil
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
