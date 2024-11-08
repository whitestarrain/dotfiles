vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.g.mapleader = " "

local utils = require("wsain.utils")
local keymap = vim.keymap
local default_opts = { silent = true, noremap = true }
local set_mapping = function(mode, key, action, opts)
  vim.keymap.set(mode, key, action, utils.merge_tb(default_opts, opts))
end

local put_empty_line = function(put_above)
  return function()
    local target_line = vim.fn.line(".") - (put_above and 1 or 0)
    vim.fn.append(target_line, vim.fn["repeat"]({ "" }, vim.v.count1))
  end
end

-- normal mode moving
set_mapping({ "n", "x", "v" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
set_mapping({ "n", "x", "v" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- command mode moving (help  tcsh-style)
vim.cmd([[
  cnoremap <C-A> <Home>
  cnoremap <C-F> <Right>
  cnoremap <C-B> <Left>
  cnoremap <M-b> <S-Left>
  cnoremap <M-f> <S-Right>
]])

-- win resize
set_mapping("n", "<c-left>", ":vertical resize -1<CR>")
set_mapping("n", "<c-right>", ":vertical resize +1<CR>")
set_mapping("n", "<c-up>", ":resize +1<CR>")
set_mapping("n", "<c-down>", ":resize -1<CR>")

-- edting
set_mapping("n", "o", "A<cr>")
set_mapping("n", "<", "<<")
set_mapping("n", ">", ">>")
set_mapping("n", "gO", put_empty_line(true), { desc = "Put empty line above" })
set_mapping("n", "go", put_empty_line(false), { desc = "Put empty line below" })

-- copy/paste
set_mapping({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
set_mapping("n", "gp", '"+p', { desc = "Paste from system clipboard" })
set_mapping("v", "gp", '"+p', { desc = "Paste from system clipboard" })
-- - Paste in Visual with `P` to not copy selected text (`:h v_P`)
set_mapping("n", "gP", '"+P', { desc = "Paste from system clipboard" })
set_mapping("v", "gP", '"+P', { desc = "Paste from system clipboard" })

-- Reselect latest changed, put, or yanked text
set_mapping(
  "n",
  "gV",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, replace_keycodes = false, desc = "Visually select changed text" }
)

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
set_mapping("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- support block replace.
set_mapping("x", "gs", function()
  local search_str = vim.fn.getreg("/")
  if search_str == nil or search_str == "v:null" then
    search_str = ""
  end
  vim.api.nvim_feedkeys(":s/\\%V" .. search_str, "n", "false")
end, { silent = false, desc = "Block replace search" })

if vim.fn.has("nvim-0.10") == 0 then
  set_mapping("x", "*", [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { desc = "Search forward" })
  set_mapping("x", "#", [[y?\V<C-R>=escape(@", '?\')<CR><CR>]], { desc = "Search backward" })
end

-- change buffer
set_mapping("n", "<M-h>", ":bp<cr>")
set_mapping("n", "<M-l>", ":bn<cr>")

-- change tab
set_mapping("n", "]t", ":tabnext<cr>")
set_mapping("n", "[t", ":tabpre<cr>")

-- diagnostic
set_mapping("n", "[d", function()
  vim.diagnostic.goto_prev()
end, {
  desc = "goto prev diagnostic",
})
set_mapping("n", "]d", function()
  vim.diagnostic.goto_next()
end, {
  desc = "goto next diagnostic",
})

-- term mode
set_mapping("t", "<c-[>", "<c-\\><c-n>")
set_mapping("t", "<Esc>", "<c-\\><c-n>")

-- quickfix
set_mapping("n", "]q", ":silent! cnewer<cr>")
set_mapping("n", "[q", ":silent! colder<cr>")
set_mapping("n", "<leader>q", function()
  if utils.check_quickfix_open() then
    pcall(vim.fn.execute, "cclose")
    return
  end
  pcall(vim.fn.execute, "copen")
end, { desc = "quickfix" })

-- quickfix or other error
set_mapping("n", "]e", function()
  if utils.check_quickfix_open() then
    pcall(vim.fn.execute, "cnext")
    return
  end
  if utils.check_buffer_open("compilation") then
    pcall(vim.fn.execute, "NextError")
    return
  end
end)
set_mapping("n", "[e", function()
  if utils.check_quickfix_open() then
    pcall(vim.fn.execute, "cprevious")
    return
  end
  if utils.check_buffer_open("compilation") then
    pcall(vim.fn.execute, "PrevError")
    return
  end
end)

-- esc mapping
local esc_func = function()
  local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(keys, "n", false)
  -- disable search
  local searching_str = vim.fn.getreg("/")
  if searching_str ~= nil and searching_str ~= "v:null" then
    vim.fn.setreg("/", nil)
    return
  end
  local changed = vim.fn.getbufinfo(vim.api.nvim_get_current_buf())[1].changed
  if changed == 1 and utils.check_file_exist(vim.fn.expand("%:p")) then
    vim.cmd("w")
  end
end
keymap.set("n", "<Esc>", esc_func)

-- disable `K` query mandoc in windows
if require("wsain.utils").getOs() == "win" then
  keymap.set("n", "K", "<nop>")
end

-- emacs like mapping on insert mode
vim.cmd([[
  inoremap        <C-A> <C-O>^
  inoremap <expr> <C-E> col('.')>strlen(getline('.'))<bar><bar>pumvisible()?"\<Lt>C-E>":"\<Lt>End>"
  cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
]])

-- duplidate line in insert mode
keymap.set("i", "<C-l>", "<C-o>:execute('.copy.')<cr>")
