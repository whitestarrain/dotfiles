local plugin = require("wsain.plugin.template"):new()
plugin.short_url = "famiu/feline.nvim"

local colors = {
  neosolarized = {
    fg = "#839496",
    bg = "#073642",
    blue = "#268bd2",
    oceanblue = "#008080",
    green = "#719e07",
    purple = "#c678dd",
    red1 = "#dc322f",
    red2 = "#dc322f",
    cyan = "#2aa198",
    yellow = "#b58900",
    gray1 = "#93a1a1",
    gray2 = "#93a1a1",

    magenta = "#d33682",
    darkblue = "#073642",

    second_bg = "#93a1a1",
    second_fg = "#073642",
  },
  -- https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/themes/onedark.lua
  onedark = {
    bg = "#282c34",
    fg = "#abb2bf",
    blue = "#61afef",
    oceanblue = "#008080",
    green = "#98c379",
    purple = "#c678dd",
    cyan = "#56b6c2",
    red1 = "#e06c75",
    red2 = "#be5046",
    yellow = "#e5c07b",
    gray1 = "#93a1a1",
    gray2 = "#2c323c",
    orange = "#d19a66",
    white = "#abb2bf",
    black = "#282c34",

    second_fg = "#8EA6B7",
    second_bg = "#3F4452",
  },
}

local mode_colors = {
  neosolarized = {
    ["NORMAL"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.blue, style = "bold" },
    ["COMMAND"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.blue, style = "bold" },
    ["INSERT"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.green, style = "bold" },
    ["VISUAL"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.magenta, style = "bold" },
    ["SELECT"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.magenta, style = "bold" },
    ["BLOCK"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.magenta, style = "bold" },
    ["LINES"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.magenta, style = "bold" },
    ["REPLACE"] = { fg = colors.neosolarized.bg, bg = colors.neosolarized.red1, style = "bold" },
    ["INACTIVE"] = { fg = colors.neosolarized.fg, bg = colors.neosolarized.darkblue, style = "bold" },
  },
  onedark = {
    ["NORMAL"] = { fg = colors.onedark.bg, bg = colors.onedark.green, style = "bold" },
    ["COMMAND"] = { fg = colors.onedark.bg, bg = colors.onedark.yellow, style = "bold" },
    ["INSERT"] = { fg = colors.onedark.bg, bg = colors.onedark.blue, style = "bold" },
    ["VISUAL"] = { fg = colors.onedark.bg, bg = colors.onedark.purple, style = "bold" },
    ["SELECT"] = { fg = colors.onedark.bg, bg = colors.onedark.purple, style = "bold" },
    ["BLOCK"] = { fg = colors.onedark.bg, bg = colors.onedark.purple, style = "bold" },
    ["LINES"] = { fg = colors.onedark.bg, bg = colors.onedark.purple, style = "bold" },
    ["REPLACE"] = { fg = colors.onedark.bg, bg = colors.onedark.red1, style = "bold" },
    ["INACTIVE"] = { fg = colors.onedark.fg, bg = colors.onedark.gray2, style = "bold" },
  },
}

local theme = colors[vim.g.colors_name or "onedark"]
local mode_hl_map = mode_colors[vim.g.colors_name or "onedark"]

plugin.config = function()
  local feline = require("feline")
  local mode_provider = require("feline.providers.vi_mode")
  local cursor_provider = require("feline.providers.cursor")

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

  local function get_mode_hl()
    local hl = mode_hl_map[mode_provider.get_vim_mode()]
    if hl == nil then
      hl = mode_hl_map["NORMAL"]
    end
    return hl
  end

  local function get_lsp_client_name()
    local msg = ""
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_clients()
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

  local function get_diff_status(type)
    -- { added = add_count, modified = modified_count, removed = removed_count }
    local diffStatus = vim.b.gitsigns_status_dict
    if diffStatus == nil then
      return nil
    end
    return diffStatus[type]
  end

  local function columns_width_condition(width)
    return function()
      return vim.o.columns > width
    end
  end

  local function danger_provider()
      local error_num, error_icon = require("feline.providers.lsp").diagnostic_errors()
      if error_num ~= nil and error_num ~= "" and tonumber(error_num) > 0 then
        return " 危 "
      end
      return ""
  end

  local components = {
    -- components when buffer is active
    active = {
      {
        {
          provider = function()
            return " " .. mode_provider.get_vim_mode() .. " "
          end,
          hl = get_mode_hl,
          right_sep = {
            str = icons.right_filled,
            hl = function()
              local hl = mode_hl_map[mode_provider.get_vim_mode()]
              if hl == nil then
                hl = mode_hl_map["NORMAL"]
              end
              local bg = theme.bg
              if vim.b.gitsigns_head ~= nil then
                bg = theme.second_bg
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
            bg = theme.second_bg,
            fg = theme.second_fg,
          },
          right_sep = {
            str = icons.right_filled,
            hl = {
              bg = theme.bg,
              fg = theme.second_bg,
            },
          },
        },
        {
          provider = function()
            if vim.g.enable_linter then
              return " 󱉶"
            end
            return ""
          end,
          hl = {
            bg = theme.bg,
            fg = theme.fg,
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
            local status = get_diff_status("added")
            if status == nil or status == 0 then
              return ""
            end
            return icons.git_added .. " " .. status .. " "
          end,
          hl = {
            fg = theme.green,
          },
          enabled = columns_width_condition(90),
        },
        {
          provider = function()
            local status = get_diff_status("changed")
            if status == nil or status == 0 then
              return ""
            end
            return icons.git_changed .. " " .. status .. " "
          end,
          hl = {
            fg = theme.yellow,
          },
          enabled = columns_width_condition(90),
        },
        {
          provider = function()
            local status = get_diff_status("removed")
            if status == nil or status == 0 then
              return ""
            end
            return icons.git_removed .. " " .. status .. " "
          end,
          hl = {
            fg = theme.red1,
          },
          enabled = columns_width_condition(90),
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
          provider = get_lsp_client_name,
          icon = " LSP:",
          hl = {
            fg = theme.oceanblue,
          },
          enabled = columns_width_condition(110),
        },
      }, -- mid section
      {
        {
          provider = "diagnostic_errors",
          hl = { fg = theme.red1 },
          enabled = columns_width_condition(102),
        },
        {
          provider = "diagnostic_warnings",
          hl = { fg = theme.yellow },
          enabled = columns_width_condition(102),
        },
        {
          provider = "diagnostic_hints",
          hl = { fg = theme.cyan },
          enabled = columns_width_condition(102),
        },
        {
          provider = "diagnostic_info",
          hl = { fg = theme.blue },
          enabled = columns_width_condition(102),
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
            return " " .. cursor_provider.line_percentage() .. " "
          end,
          hl = {
            bg = theme.second_bg,
            fg = theme.second_fg,
          },
          left_sep = {
            str = " " .. icons.left_filled,
            hl = {
              bg = theme.bg,
              fg = theme.second_bg,
            },
          },
        },
        {
          provider = function()
            local position = cursor_provider.position("", {})
            if #position < 7 then
              return string.format("%07s  ", position)
            end
            return " " .. position .. "  "
          end,
          hl = get_mode_hl,
          left_sep = {
            str = icons.left_filled,
            hl = function()
              local hl = mode_hl_map[mode_provider.get_vim_mode()]
              if hl == nil then
                hl = mode_hl_map["NORMAL"]
              end
              return {
                fg = hl.bg,
                bg = theme.second_bg,
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
            return " " .. mode_provider.get_vim_mode() .. " "
          end,
          hl = get_mode_hl,
          right_sep = {
            str = icons.right_filled .. " ",
            hl = function()
              local hl = mode_hl_map[mode_provider.get_vim_mode()]
              if hl == nil then
                hl = mode_hl_map["NORMAL"]
              end
              return {
                fg = hl.bg,
              }
            end,
          },
        },
        {
          provider = function()
            return vim.api.nvim_buf_get_name(0) or vim.fn.getcwd()
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
        "^oil$",
      },
      buftypes = {
        "^terminal$",
      },
      bufnames = {},
    },
  })
end
return plugin
