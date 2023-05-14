local plugin = require("wsain.plugin.template"):new()
plugin.shortUrl = "famiu/feline.nvim"
plugin.config = function()
  local feline = require("feline")
  local modeProvider = require("feline.providers.vi_mode")
  local cursorProvider = require("feline.providers.cursor")
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
    oceanblue = "#008080",
    gray = "#93a1a1",
    darkblue = "#073642",
    white = "#FFFFFF",

    second_comp = "#93a1a1",
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
    local hl = modeColors[modeProvider.get_vim_mode()]
    if hl == nil then
      hl = modeColors["NORMAL"]
    end
    return hl
  end

  local function getLspClientName()
    local msg = ""
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if client.name ~= "null-ls" and filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end

  local function getDiffStatus(type)
    -- { added = add_count, modified = modified_count, removed = removed_count }
    local diffStatus = vim.b.gitsigns_status_dict
    if diffStatus == nil then
      return nil
    end
    return diffStatus[type]
  end

  local function columnsWidthCondition(width)
    return function()
      return vim.o.columns > width
    end
  end

  local components = {
    -- components when buffer is active
    active = {
      {
        {
          provider = function()
            return " " .. modeProvider.get_vim_mode() .. " "
          end,
          hl = modeHl,
          right_sep = {
            str = icons.right_filled,
            hl = function()
              local hl = modeColors[modeProvider.get_vim_mode()]
              if hl == nil then
                hl = modeColors["NORMAL"]
              end
              local bg = theme.bg
              if vim.b.gitsigns_head ~= nil then
                bg = theme.second_comp
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
            if vim.b.gitsigns_head then
              return "  " .. vim.b.gitsigns_head .. " "
            end
            return ""
          end,
          hl = {
            bg = theme.second_comp,
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
            local status = getDiffStatus("added")
            if status == nil or status == 0 then
              return ""
            end
            return icons.git_added .. " " .. status .. " "
          end,
          hl = {
            fg = theme.green,
          },
          enabled = columnsWidthCondition(90),
        },
        {
          provider = function()
            local status = getDiffStatus("changed")
            if status == nil or status == 0 then
              return ""
            end
            return icons.git_changed .. " " .. status .. " "
          end,
          hl = {
            fg = theme.yellow,
          },
          enabled = columnsWidthCondition(90),
        },
        {
          provider = function()
            local status = getDiffStatus("removed")
            if status == nil or status == 0 then
              return ""
            end
            return icons.git_removed .. " " .. status .. " "
          end,
          hl = {
            fg = theme.red,
          },
          enabled = columnsWidthCondition(90),
        },
      }, -- left section
      {
        {
          provider = function()
            return "%="
          end,
          left_sep = "",
          right_sep = "",
        },
        {
          provider = getLspClientName,
          icon = " LSP:",
          hl = {
            fg = theme.oceanblue,
          },
          enabled = columnsWidthCondition(110),
        },
      }, -- mid section
      {
        {
          provider = "diagnostic_errors",
          hl = { fg = theme.red },
          enabled = columnsWidthCondition(102),
        },
        {
          provider = "diagnostic_warnings",
          hl = { fg = theme.yellow },
          enabled = columnsWidthCondition(102),
        },
        {
          provider = "diagnostic_hints",
          hl = { fg = theme.green },
          enabled = columnsWidthCondition(102),
        },
        {
          provider = "diagnostic_info",
          hl = { fg = theme.blue },
          enabled = columnsWidthCondition(102),
        },
        {
          provider = function()
            return vim.bo.fileformat
          end,
          left_sep = {
            str = " ",
          },
        },
        {
          provider = function()
            return vim.bo.fenc
          end,
          left_sep = {
            str = " " .. icons.left .. " ",
            hl = {
              bg = theme.bg,
              fg = theme.fg,
            },
          },
        },
        {
          provider = function()
            return vim.bo.filetype
          end,
          left_sep = {
            str = " " .. icons.left .. " ",
            hl = {
              bg = theme.bg,
              fg = theme.fg,
            },
          },
        },
        {
          provider = function()
            return " " .. cursorProvider.line_percentage() .. " "
          end,
          hl = {
            bg = theme.second_comp,
            fg = theme.bg,
          },
          left_sep = {
            str = " " .. icons.left_filled,
            hl = {
              bg = theme.bg,
              fg = theme.gray,
            },
          },
        },
        {
          provider = function()
            local position = cursorProvider.position("", {})
            if #position < 7 then
              return string.format("%07s  ", position)
            end
            return " " .. position .. "  "
          end,
          hl = modeHl,
          left_sep = {
            str = icons.left_filled,
            hl = function()
              local hl = modeColors[modeProvider.get_vim_mode()]
              if hl == nil then
                hl = modeColors["NORMAL"]
              end
              return {
                fg = hl.bg,
                bg = theme.second_comp,
              }
            end,
          },
        },
      }, -- right section
    },
    -- components when buffer is inactive
    inactive = {
      {
        {
          provider = function()
            return " " .. modeProvider.get_vim_mode() .. " "
          end,
          hl = modeHl,
          right_sep = {
            str = icons.right_filled .. " ",
            hl = function()
              local hl = modeColors[modeProvider.get_vim_mode()]
              if hl == nil then
                hl = modeColors["NORMAL"]
              end
              return {
                fg = hl.bg,
              }
            end,
          },
        },
        {
          provider = function()
            return vim.fn.getcwd()
          end,
        },
      }, -- left section
      {}, -- right section
    },
  }

  feline.setup({
    theme = theme,
    components = components,
    force_inactive = {
      filetypes = {
        "^NvimTree$",
        "^packer$",
        "^startify$",
        "^fugitive$",
        "^fugitiveblame$",
        "^qf$",
        "^help$",
        "^msnumber$",
      },
      buftypes = {
        "^terminal$",
      },
      bufnames = {},
    },
  })
end
return plugin
