local M = {}

---@param group string
---@param options { fg?: string, bg?: string, sp?: string, gui?: string, blend?: integer, ctermfg?: string }
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

---@return string[]|nil
function M.get_visual_selection_text()
  -- https://github.com/Nauticus/dotfiles/blob/master/.config/nvim/lua/config/core/utils.lua
  local mode_info = vim.api.nvim_get_mode()
  local mode = mode_info.mode

  local cursor = vim.api.nvim_win_get_cursor(0)
  local cline, ccol = cursor[1], cursor[2]
  local vline, vcol = vim.fn.line("v"), vim.fn.col("v")

  local sline, scol
  local eline, ecol
  if cline == vline then
    if ccol <= vcol then
      sline, scol = cline, ccol
      eline, ecol = vline, vcol
      scol = scol + 1
    else
      sline, scol = vline, vcol
      eline, ecol = cline, ccol
      ecol = ecol + 1
    end
  elseif cline < vline then
    sline, scol = cline, ccol
    eline, ecol = vline, vcol
    scol = scol + 1
  else
    sline, scol = vline, vcol
    eline, ecol = cline, ccol
    ecol = ecol + 1
  end

  if mode == "V" or mode == "CTRL-V" or mode == "\22" then
    scol = 1
    ecol = nil
  end

  local lines = vim.api.nvim_buf_get_lines(0, sline - 1, eline, false)
  if #lines == 0 then
    return
  end

  local start_text, end_text
  if #lines == 1 then
    start_text = string.sub(lines[1], scol, ecol)
  else
    start_text = string.sub(lines[1], scol)
    end_text = string.sub(lines[#lines], 1, ecol)
  end

  local selection = { start_text }
  if #lines > 2 then
    vim.list_extend(selection, vim.list_slice(lines, 2, #lines - 1))
  end
  table.insert(selection, end_text)

  return selection
end

---@param buffer_filetype string
---@return integer[]
function M.get_winlist_by_filetype(buffer_filetype)
  if buffer_filetype == nil or buffer_filetype == "" then
    return {}
  end
  local winlist = vim.api.nvim_tabpage_list_wins(0)
  if winlist == nil or next(winlist) == nil then
    return {}
  end
  return vim.tbl_filter(function(win_id)
    return vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win_id), "filetype") == buffer_filetype
  end, winlist)
end

---@param buffer_filetype string
---@return boolean
function M.check_buffer_open(buffer_filetype)
  local win_list = M.get_winlist_by_filetype(buffer_filetype)
  return next(win_list) ~= nil
end

---@return boolean
function M.check_quickfix_open()
  return M.check_buffer_open("qf")
end

---@param bufnr integer
---@param lnum integer
---@param duration_ms? integer|boolean
---@param hl_group? string
function M.flash_highlight(bufnr, lnum, duration_ms, hl_group)
  hl_group = hl_group or "Visual"
  if duration_ms == true or duration_ms == 1 or duration_ms == nil then
    duration_ms = 300
  end
  local ns = vim.api.nvim_create_namespace("FlashHighlight")
  local line = vim.api.nvim_buf_get_lines(bufnr, lnum - 1, lnum, true)[1]
  local ext_id = vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, 0, {
    end_col = #line,
    hl_group = hl_group,
  })
  local remove_highlight = function()
    vim.api.nvim_buf_del_extmark(bufnr, ns, ext_id)
  end
  vim.defer_fn(remove_highlight, duration_ms)
end

---@return integer[]
function M.get_visual_range()
  local first_line = vim.fn.line("v")
  local last_line = vim.fn.getpos(".")[2]
  if first_line > last_line then
    return { last_line, first_line }
  end
  return { first_line, last_line }
end

---@param key string
---@param mode string
---@return function|nil
function M.get_current_mapping(key, mode)
  local mapping_list = vim.api.nvim_get_keymap(mode)
  local mapping_map = {}
  for _, mapping in ipairs(mapping_list) do
    mapping_map[mapping["lhs"]] = mapping
  end
  if mapping_map[key] ~= nil then
    if mapping_map[key]["callback"] ~= nil then
      return mapping_map[key]["callback"]
    else
      return function()
        vim.fn.execute(mapping_map[key]["rhs"])
      end
    end
  end
end

return M
