-- check install
local whichkeyPath = vim.g.absolute_config_path .. ".managers/whichkey"
if not vim.loop.fs_stat(whichkeyPath) then
  print("start clone whichkey to " .. whichkeyPath)
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/which-key.nvim",
    "--branch=main",
    whichkeyPath,
  })
end
vim.opt.rtp:prepend(whichkeyPath)

local utils = require("wsain.utils")
local opts = {
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "  ", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  key_labels = {
    ["<space>"] = "SPC",
    ["<cr>"] = "CR",
    ["<tab>"] = "TAB",
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 1, 0, 1 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
    padding = { 0, 0, 0, 0 }, -- extra window padding [top, right, bottom, left]
    winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    zindex = 1000, -- positive value to position WhichKey above other floating windows.
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  triggers_nowait = {
    -- marks
    "`",
    "'",
    "g`",
    "g'",
    -- registers
    -- '"',
    "<c-r>",
    -- spelling
    "z=",
  },
}

local mappingConvert = function(pluginDatas)
  local leader = "<leader>"
  local result = {
    leaderMappings = {},
    noLeaderMappings = {},
  }
  if pluginDatas == nil or #pluginDatas == 0 then
    return {}
  end
  for _, pluginConfig in ipairs(pluginDatas) do
    local mappingConfigs = pluginConfig.globalMappings
    if mappingConfigs ~= nil and #mappingConfigs > 0 then
      for _, mappingConfig in ipairs(mappingConfigs) do
        if string.sub(mappingConfig[2], 1, #leader) == leader then
          if mappingConfig["name"] ~= nil then
            result.leaderMappings[mappingConfig[2]] = {
              name = mappingConfig.name,
            }
          else
            local mappingOpts = utils.defaultIfNil(mappingConfig.opts, {})
            result.leaderMappings[mappingConfig[2]] = {
              mappingConfig[3],
              mappingConfig[4],
              mode = mappingConfig[1],
              silent = utils.defaultIfNil(mappingOpts.silent, true),
              noremap = utils.defaultIfNil(mappingOpts.noremap, true),
              nowait = utils.defaultIfNil(mappingOpts.nowait, false),
            }
          end
        else
          result.noLeaderMappings[#result.noLeaderMappings + 1] = {
            mode = mappingConfig[1],
            key = mappingConfig[2],
            cmd = mappingConfig[3],
            opts = utils.merge_tb(mappingConfig[5], { desc = mappingConfig[4] }),
          }
        end
      end
    end
  end
  return result
end

local registerMapping = function(pluginDatas)
  local mappings = mappingConvert(pluginDatas)
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(mappings.leaderMappings)
  for _, mapping in ipairs(mappings.noLeaderMappings) do
    vim.keymap.set(mapping.mode, mapping.key, mapping.cmd, mapping.opts)
  end
end

return {
  register = registerMapping,
}
