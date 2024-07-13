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
