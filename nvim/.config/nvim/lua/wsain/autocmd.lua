local quickfixAugroup = vim.api.nvim_create_augroup("quickfixAugroup", { clear = true })
-- quick fix key map
--[[ In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there. ]]
vim.api.nvim_create_autocmd("BufReadPost", {
  group = quickfixAugroup,
  pattern = { "quickfix", "qf" },
  callback = function(ev)
    vim.cmd("nnoremap <buffer> <CR> <CR>")
  end,
})
-- don't list quickfix buf
vim.api.nvim_create_autocmd("FileType", {
  group = quickfixAugroup,
  pattern = { "quickfix", "qf" },
  callback = function()
    vim.cmd("set nobuflisted")
  end,
})

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
