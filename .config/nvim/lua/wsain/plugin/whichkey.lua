-- check install
local whichkeyPath = vim.fn.stdpath("data") .. "/whichkey/which-key.nvim"
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

local opts = {
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "  ", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
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
    registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
  },
}

local mappingConvert = function(pluginDatas)
  if pluginDatas == nil or #pluginDatas == 0 then
    return pluginDatas
  end
  local allMappings = {}
  for _, pluginConfig in ipairs(pluginDatas) do
    local mappingConfigs = pluginConfig.globalMappings
    if mappingConfigs ~= nil and #mappingConfigs > 0 then
      for _, mappingConfig in ipairs(mappingConfigs) do
        if mappingConfig["name"] ~= nil then
          allMappings[mappingConfig.key] = {
            name = mappingConfig.name,
          }
        else
          allMappings[mappingConfig.key] = {
            mappingConfig.cmd,
            mappingConfig.desc,
            mode = mappingConfig.mode,
            silent = mappingConfig.silent,
            noremap = mappingConfig.noremap,
            nowait = mappingConfig.nowait,
          }
        end
      end
    end
  end
  return allMappings
end

local registerMapping = function(pluginDatas)
  local mappings = mappingConvert(pluginDatas)
  if mappings == nil then
    return
  end
  local wk = require("which-key")
  wk.setup(opts)
  wk.register(mappings)
end

return {
  register = registerMapping,
}
