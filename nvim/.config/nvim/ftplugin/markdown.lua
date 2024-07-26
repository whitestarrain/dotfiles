-- disable default markdown ftplugin
vim.b.did_ftplugin = true

vim.opt.shiftwidth = 2
-- can't right shift line which starts with '#' when smartindent is true
vim.opt.smartindent = false
