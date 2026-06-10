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
