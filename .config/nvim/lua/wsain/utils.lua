---@diagnostic disable: param-type-mismatch, cast-local-type
local M = {}

function M.emptyFun() end

function M.merge_tb(origin_tb, custom_tb)
  -- use right table's value when conflict
  return vim.tbl_deep_extend("force", origin_tb, custom_tb)
end

function M.getOs()
  if vim.fn.has("macunix") == 1 then
    return "mac"
  end
  if vim.fn.has("win32") == 1 then
    return "win"
  end
  if vim.fn.has("wsl") == 1 then
    return "wsl"
  end
  return "linux"
end

function M.getOpenCommand()
  local os = M.getOs()
  if os == "win" then
    return "start"
  end
  if os == "mac" then
    return "open"
  end
  if os == "linux" or os == "wsl" then
    return "xdg-open"
  end
end

function M.openFileUnderCursor()
  local filePath = vim.fn.expand("<cfile>")
  local relatePath = ""
  if string.sub(filePath, 1, 4) == "http" then
    relatePath = filePath
  else
    local currentFilePath = vim.fn.expand("%:p")
    relatePath = string.sub(currentFilePath, 1, string.len(currentFilePath) - string.len(vim.fn.expand("%:t")) - 2)
    relatePath = relatePath .. "/" .. filePath
    relatePath = vim.fn.substitute(relatePath, "\\", "/", "")
    relatePath = vim.fn.substitute(relatePath, "\\", "/", "")
  end
  vim.fn.execute("!" .. M.getOpenCommand() .. " " .. relatePath)
end

function M.recoverLostRuntimepath()
  local rtpBak = vim.api.nvim_list_runtime_paths()
  return function()
    local rtp = vim.api.nvim_list_runtime_paths()
    local markTbl = {}
    for _, value in ipairs(rtp) do
      markTbl[value] = true
    end
    for _, value in ipairs(rtpBak) do
      if markTbl[value] == nil then
        vim.opt.rtp:append(value)
      end
    end
  end
end

M.colors = {
  dark_blue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
  dark_red = "#BE5046",
  diff_red = "#2c1517",
  dark_green = "#59843b",
  dimm_green = "#41602b",
  diff_green = "#1e2718",
  yellow = "#E5C07B",
  diff_yellow = "#3e2e1e",
  dark_yellow = "#D19A66",
  dimm_blue = "#0d4c7f",
  purple = "#C678DD",
  dimm_purple = "#633c6e",
  diff_purple = "#27182C",
  cyan = "#008080",
  white = "#ABB2BF",
  black = "#1f1f1f",
  dimm_black = "#1c1c1c",
  dark_black = "#1a1a1a",
  grey = "#4e4e4e",
  comment_grey = "#5C6370",
  gutter_fg_grey = "#4B5263",
  cursor_grey = "#2C323C",
  dimm_cursor_grey = "#21262d",
  dark_cursor_grey = "#1d2228",
  visual_grey = "#3E4452",
  special_grey = "#3B4048",
  bracket_grey = "#7C828C",
}

function M.highlight(group, options)
  local guifg = options.fg or "NONE"
  local guibg = options.bg or "NONE"
  local guisp = options.sp or "NONE"
  local gui = options.gui or "NONE"
  local blend = options.blend or 0
  local ctermfg = options.ctermfg or "NONE"

  vim.cmd(
    string.format(
      "highlight %s guifg=%s ctermfg=%s guibg=%s guisp=%s gui=%s blend=%d",
      group,
      guifg,
      ctermfg,
      guibg,
      guisp,
      gui,
      blend
    )
  )
end

return M
