local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "famiu/feline.nvim"
plugin.config = function()
  local feline = require("feline")
  local vi_mode = require("feline.providers.vi_mode")
  local solarized = {
    fg = "#839496",
    bg = "#073642",
    yellow = "#b58900",
    orange = "#cb4b16",
    red = "#dc322f",
    magenta = "#d33682",
    violet = "#6c71c4",
    blue = "#268bd2",
    cyan = "#2aa198",
    green = "#719e07",
    black = "#3c3836",
    skyblue = "#83a598",
    oceanblue = "#076678",
    gray = "#93a1a1",
    darkblue = "#073642",
  }

  local theme = solarized

  local modeColors = {
    ["NORMAL"] = { fg = theme.bg, bg = theme.blue },
    ["COMMAND"] = { fg = theme.bg, bg = theme.blue },
    -- ["COMMAND"] = { fg = theme.bg, bg = theme.skyblue },
    ["INSERT"] = { fg = theme.bg, bg = theme.green },
    ["VISUAL"] = { fg = theme.bg, bg = theme.magenta },
    ["BLOCK"] = { fg = theme.bg, bg = theme.magenta },
    ["REPLACE"] = { fg = theme.bg, bg = theme.red },
    ["INACTIVE"] = { fg = theme.fg, bg = theme.darkblue },
  }

  local icons = {
    locker = "", -- #f023
    page = "☰", -- 2630
    line_number = "", -- e0a1
    connected = "", -- f817
    dos = "", -- e70f
    unix = "", -- f17c
    mac = "", -- f179
    mathematical_L = "𝑳",
    vertical_bar = "┃",
    vertical_bar_thin = "│",
    left = "",
    right = "",
    block = "█",
    left_filled = "",
    right_filled = "",
    slant_left = "",
    slant_left_thin = "",
    slant_right = "",
    slant_right_thin = "",
    slant_left_2 = "",
    slant_left_2_thin = "",
    slant_right_2 = "",
    slant_right_2_thin = "",
    left_rounded = "",
    left_rounded_thin = "",
    right_rounded = "",
    right_rounded_thin = "",
    circle = "●",
    git_added = "",
    git_changed = "",
    git_removed = "",
  }
  local function modeHl()
    local hl = modeColors[vi_mode.get_vim_mode()]
    if hl == nil then
      hl = modeColors["NORMAL"]
    end
    return hl
  end

  local function getDiffStatus(type)
    -- { added = add_count, modified = modified_count, removed = removed_count }
    local diffStatus = vim.b.gitsigns_status_dict
    local result = ""
    if diffStatus == nil then
      return result
    end
    result = diffStatus[type] or result
    return result
  end

  local components = {
    -- components when buffer is active
    active = {
      {
        {
          provider = function()
            return " " .. vi_mode.get_vim_mode() .. " "
          end,
          hl = modeHl,
          right_sep = {
            str = icons.right_filled,
            hl = function()
              local hl = modeColors[vi_mode.get_vim_mode()]
              if hl == nil then
                hl = modeColors["NORMAL"]
              end
              local bg = theme.bg
              if vim.b.gitsigns_head ~= nil then
                bg = theme.gray
              end
              return {
                fg = hl.bg,
                bg = bg,
              }
            end,
          },
        },
        {
          provider = function()
            local branch = vim.b.gitsigns_head or ""
            return " " .. branch .. " "
          end,
          hl = {
            bg = theme.gray,
            fg = theme.bg,
          },
          right_sep = {
            str = icons.right_filled,
            hl = {
              bg = theme.bg,
              fg = theme.gray,
            },
          },
        },
        {
          provider = {
            name = "file_info",
            opts = {
              type = "base-only",
              file_modified_icon = "[+]",
            },
          },
          left_sep = " ",
          right_sep = " ",
        },
        {
          provider = function()
            return icons.git_added .. " " .. getDiffStatus("added") .. " "
          end,
          hl = {
            fg = theme.green,
          },
        },
        {
          provider = function()
            return icons.git_changed .. " " .. getDiffStatus("changed") .. " "
          end,
          hl = {
            fg = theme.yellow,
          },
        },
        {
          provider = function()
            return icons.git_removed .. " " .. getDiffStatus("removed") .. " "
          end,
          hl = {
            fg = theme.red,
          },
        },
      }, -- left section
      {}, -- mid section
      {}, -- right section
    },
    -- components when buffer is inactive
    inactive = {
      {
        {},
      }, -- left section
      {
        {
          provider = icons.block,
          hl = {
            bg = theme.fg,
            fg = theme.bg,
          },
        },
      }, -- right section
    },
  }

  feline.setup({
    --[[ theme = theme,
    components = components, ]]
  })
end
return plugin
