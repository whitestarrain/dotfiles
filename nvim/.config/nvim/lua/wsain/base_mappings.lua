vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.g.mapleader = " "

local keymap = vim.keymap
local default_opts = { silent = true, noremap = true }
local set_mapping = function(mode, key, action)
  vim.keymap.set(mode, key, action, default_opts)
end

set_mapping("n", "j", "gj")
set_mapping("n", "k", "gk")
set_mapping("v", "j", "gj")
set_mapping("v", "k", "gk")

set_mapping("n", "<c-left>", ":vertical resize -1<CR>")
set_mapping("n", "<c-right>", ":vertical resize +1<CR>")
set_mapping("n", "<c-up>", ":resize +1<CR>")
set_mapping("n", "<c-down>", ":resize -1<CR>")

set_mapping("n", "o", "A<cr>")

set_mapping("n", "<M-h>", ":bp<cr>")
set_mapping("n", "<M-l>", ":bn<cr>")

set_mapping("n", "<", "<<")
set_mapping("n", ">", ">>")

set_mapping("n", "]t", ":tabnext<cr>")
set_mapping("n", "[t", ":tabpre<cr>")

set_mapping("n", "[e", function()
  vim.diagnostic.goto_prev()
end)
set_mapping("n", "]e", function()
  vim.diagnostic.goto_next()
end)

set_mapping("t", "<c-[>", "<c-\\><c-n>")
set_mapping("t", "<Esc>", "<c-\\><c-n>")

local esc_func = function()
  local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
  -- disable search
  local searching_str = vim.fn.getreg("/")
  if searching_str ~= nil and searching_str ~= "v:null" then
    vim.fn.setreg("/", nil)
    return
  end
end

keymap.set("n", "<Esc>", esc_func)

if require("wsain.utils").getOs() == "win" then
  keymap.set("n", "K", "<nop>")
end
