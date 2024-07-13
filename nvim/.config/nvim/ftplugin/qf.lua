--[[ In the quickfix window, <CR> is used to jump to the error under the cursor, so undefine the mapping there. ]]
vim.keymap.set("n", "<CR>", "<CR>", { silent = true, noremap = true, buffer = 0 })
vim.keymap.set("n", "q", ":quit<CR>", { silent = true, noremap = true, buffer = 0, nowait = true })
-- don't list quickfix buf
vim.opt_local.buflisted = false
