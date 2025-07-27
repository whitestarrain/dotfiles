--[[ In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there. ]]
vim.keymap.set("n", "<CR>", "<CR>", { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "q", ":quit<CR>", { silent = true, noremap = true, buffer = 0, nowait = true })
-- don't list quickfix buf
vim.opt_local.buflisted = false

local function is_loclist()
  local cur_winid = vim.api.nvim_get_current_win()
  local wininfos = vim.fn.getwininfo(cur_winid)
  if wininfos == nil or next(wininfos) == nil then
    return false
  end
  local wininfo = wininfos[1]
  if wininfo["loclist"] == 1 then
    return true
  end
  return false
end

local function generate_getter_setter()
  local getlist_fn = vim.fn.getqflist
  local setlist_fn = vim.fn.setqflist
  if is_loclist() then
    getlist_fn = function()
      return vim.fn.getloclist(0)
    end
    setlist_fn = function(items)
      vim.fn.setloclist(0, items)
    end
  end
  return getlist_fn, setlist_fn
end

local function remove_qf_item()
  local getlist_fn, setlist_fn = generate_getter_setter()

  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local qf_list = getlist_fn()
  table.remove(qf_list, row)
  setlist_fn(qf_list, "r")

  local current_row = row <= #qf_list and row or #qf_list
  if current_row == 0 then
    current_row = 1
  end
  vim.api.nvim_win_set_cursor(0, { current_row, 0 })
end

local function open_item()
  local getlist_fn, setlist_fn = generate_getter_setter()
  local qf_list = getlist_fn()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local qf_item = qf_list[row]
  -- get valid window
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local valid_win_id = nil
  for _, win_id in ipairs(wins) do
    local buffer_id = vim.api.nvim_win_get_buf(win_id)
    local file_name = vim.api.nvim_buf_get_name(buffer_id)
    if require("wsain.utils").check_file_exist(file_name) then
      valid_win_id = win_id
      break
    end
  end
  if valid_win_id == nil then
    return false
  end
  local qf_item_bufnr = qf_item["bufnr"]
  vim.api.nvim_win_set_buf(valid_win_id, qf_item_bufnr)
  vim.api.nvim_win_set_cursor(valid_win_id, { qf_item["lnum"], qf_item["col"] })
  require("wsain.utils").flash_highlight(qf_item_bufnr, qf_item["lnum"])
  return true
end

-- delete item
vim.keymap.set("n", "dd", remove_qf_item, { silent = true, noremap = true, buffer = 0 })
-- open item
vim.keymap.set("n", "o", open_item, { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "K", function()
  vim.cmd("norm! k")
  open_item()
end, { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "J", function()
  vim.cmd("norm! j")
  open_item()
end, { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "<CR>", function()
  vim.cmd("normal! " .. vim.api.nvim_replace_termcodes("<CR>", true, true, true))
  require("wsain.utils").flash_highlight(0, vim.api.nvim_win_get_cursor(0)[1])
end, { silent = true, noremap = true, buffer = 0 })
