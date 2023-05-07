local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "famiu/feline.nvim"
plugin.config = function()
  local feline = require("feline")
  local vi_mode = require("feline.providers.vi_mode")
  local solarized = {
    base03 = "#002b36",
    base02 = "#073642",
    base01 = "#586e75",
    base00 = "#657b83",
    base0 = "#839496",
    base1 = "#93a1a1",
    base2 = "#eee8d5",
    base3 = "#fdf6e3",
    fg = "#839496",
    bg = "#073642",
    yellow = "#b58900",
    orange = "#cb4b16",
    red = "#dc322f",
    magenta = "#d33682",
    violet = "#6c71c4",
    blue = "#268bd2",
    cyan = "#2aa198",
    green = "#859900",
    black = "#3c3836",
    skyblue = "#83a598",
    oceanblue = "#076678",
    gray = "#93a1a1",
  }

  -- vi mode color configuration
  local modeColors = {
    ["NORMAL"] = { fg = solarized.base03, bg = solarized.blue },
    ["COMMAND"] = { fg = solarized.base03, bg = solarized.skyblue },
    ["INSERT"] = { fg = solarized.base03, bg = solarized.green },
    ["VISUAL"] = { fg = solarized.base03, bg = solarized.magenta },
    ["BLOCK"] = { fg = solarized.base03, bg = solarized.magenta },
    ["REPLACE"] = { fg = solarized.base03, bg = solarized.red },
    ["INACTIVE"] = { fg = solarized.base0, bg = solarized.base02 },
  }

  local components = {
    -- components when buffer is active
    active = {
      {}, -- left section
      {}, -- mid section
      {}, -- right section
    },
    -- components when buffer is inactive
    inactive = {
      {}, -- left section
      {}, -- right section
    },
  }

  local spliceComponentCount = 1
  local function getSpliceComponent(left, right, provider)
    spliceComponentCount = spliceComponentCount + 1
    return {
      name = "spliceComponent" .. spliceComponentCount,
      provider = provider,
      hl = {
        bg = right.hl.bg,
        fg = left.hl.bg,
      },
    }
  end

  feline.setup({
    --[[ theme = solarized,
    components = components, ]]
  })
end
return plugin
