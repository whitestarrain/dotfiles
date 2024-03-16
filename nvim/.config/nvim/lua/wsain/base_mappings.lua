vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.g.mapleader = " "

local utils = require("wsain.utils")
local keymap = vim.keymap
local default_opts = { silent = true, noremap = true }
local set_mapping = function(mode, key, action, opts)
  vim.keymap.set(mode, key, action, utils.merge_tb(default_opts, opts))
end

-- moving
set_mapping("n", "j", "gj")
set_mapping("n", "k", "gk")
set_mapping("v", "j", "gj")
set_mapping("v", "k", "gk")

-- win resize
set_mapping("n", "<c-left>", ":vertical resize -1<CR>")
set_mapping("n", "<c-right>", ":vertical resize +1<CR>")
set_mapping("n", "<c-up>", ":resize +1<CR>")
set_mapping("n", "<c-down>", ":resize -1<CR>")

-- edting
set_mapping("n", "o", "A<cr>")
set_mapping("n", "<", "<<")
set_mapping("n", ">", ">>")

-- change buffer
set_mapping("n", "<M-h>", ":bp<cr>")
set_mapping("n", "<M-l>", ":bn<cr>")

-- change tab
set_mapping("n", "]t", ":tabnext<cr>")
set_mapping("n", "[t", ":tabpre<cr>")

-- diagnostic
set_mapping("n", "[e", function()
  vim.diagnostic.goto_prev()
end)
set_mapping("n", "]e", function()
  vim.diagnostic.goto_next()
end)

-- term mode
set_mapping("t", "<c-[>", "<c-\\><c-n>")
set_mapping("t", "<Esc>", "<c-\\><c-n>")

-- quickfix
set_mapping("n", "<leader>q", function()
  if utils.check_quickfix_open() then
    pcall(vim.fn.execute, "cclose")
    return
  end
  pcall(vim.fn.execute, "copen")
end, { desc = "quickfix" })
local c_n_mapping_func = utils.get_current_mapping("<C-N>", "n")
set_mapping("n", "<c-n>", function()
  if utils.check_quickfix_open() then
    pcall(vim.fn.execute, "cnext")
    return
  end
  if c_n_mapping_func ~= nil then
    c_n_mapping_func()
    return
  end
  local keys = vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)
set_mapping("n", "<c-p>", function()
  if utils.check_quickfix_open() then
    pcall(vim.fn.execute, "cprevious")
    return
  end
  local keys = vim.api.nvim_replace_termcodes("<C-p>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
end)

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
