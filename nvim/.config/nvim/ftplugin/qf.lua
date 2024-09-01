--[[ In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there. ]]
vim.keymap.set("n", "<CR>", "<CR>", { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "q", ":quit<CR>", { silent = true, noremap = true, buffer = 0, nowait = true })
-- don't list quickfix buf
vim.opt_local.buflisted = false

local function remove_qf_item()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
  local qf_list = vim.fn.getqflist()
  table.remove(qf_list, row)
  vim.fn.setqflist(qf_list, "r")
  local current_row = row <= #qf_list and row or #qf_list
  if current_row == 0 then
    current_row = 1
  end
  vim.api.nvim_win_set_cursor(0, { current_row, 0 })
end

vim.keymap.set("n", "dd", remove_qf_item, { silent = true, noremap = true, buffer = 0 })
