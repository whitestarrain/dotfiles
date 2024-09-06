local bigfile_handler = require("wsain.bigfile").bigfile_handler

-- highlight autocmd
local bgHighLightAugroup = vim.api.nvim_create_augroup("BgHighlight", { clear = true })
vim.api.nvim_create_autocmd("WinEnter", {
  group = bgHighLightAugroup,
  callback = function()
    vim.opt.cul = true
  end,
})
vim.api.nvim_create_autocmd("WinLeave", {
  group = bgHighLightAugroup,
  callback = function()
    vim.opt.cul = false
  end,
})

local WsainBigFileHandleGroup = vim.api.nvim_create_augroup("WsainBigFileHandleGroup", { clear = true })
vim.api.nvim_create_autocmd("BufReadPre", {
  group = WsainBigFileHandleGroup,
  callback = function(args) bigfile_handler(args.buf) end,
})

