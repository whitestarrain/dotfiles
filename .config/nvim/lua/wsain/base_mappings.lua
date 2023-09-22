vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

keymap.set("n", "<C-l>", "<Right>")
keymap.set("n", "<C-h>", "<Left>")
keymap.set("n", "<C-j>", "<Down>")
keymap.set("n", "<C-k>", "<Up>")

keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

keymap.set("n", "<c-left>", ":vertical resize -1<CR>")
keymap.set("n", "<c-right>", ":vertical resize +1<CR>")
keymap.set("n", "<c-up>", ":resize +1<CR>")
keymap.set("n", "<c-down>", ":resize -1<CR>")

keymap.set("n", "o", "A<cr>")

keymap.set("n", "<M-h>", ":bp<cr>")
keymap.set("n", "<M-l>", ":bn<cr>")

keymap.set("n", "<", "<<")
keymap.set("n", ">", ">>")

keymap.set("n", "]t", ":tabnext<cr>")
keymap.set("n", "[t", ":tabpre<cr>")

keymap.set("t", "<c-[>", "<c-\\><c-n>")
keymap.set("t", "<Esc>", "<c-\\><c-n>")

local esc_func = function()
  local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
  -- disable search
  vim.fn.setreg("/", nil)
end

keymap.set("n", "<Esc>", esc_func)

if require("wsain.utils").getOs() == "win" then
  keymap.set("n", "K", "<nop>")
end
