local bigfile_handler = require("wsain.autocmd.bigfile").bigfile_handler

-- highlight autocmd
local bg_highlight_augroup = vim.api.nvim_create_augroup("BgHighlight", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = bg_highlight_augroup,
  callback = function()
    vim.opt.cul = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = bg_highlight_augroup,
  callback = function()
    vim.opt.cul = false
  end,
})

-- bigfile autocmd
local bigfile_handle_augroup = vim.api.nvim_create_augroup("WsainBigFileHandleGroup", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
  group = bigfile_handle_augroup,
  callback = function(args) bigfile_handler(args.buf) end,
})

