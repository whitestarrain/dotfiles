-- encoding config
vim.opt.encoding = "utf-8"
vim.opt.langmenu = "zh_CN.UTF-8"
vim.opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
vim.opt.fileencoding = "utf-8"
vim.opt.compatible = false

-- basic config
vim.cmd("filetype on")
vim.cmd("filetype plugin indent on")
vim.opt.swapfile = false
vim.opt.updatetime = 100

-- show config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.linespace = 0
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.regexpengine = 0
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.laststatus = 3
vim.opt.hidden = true
vim.opt.signcolumn = "auto:2"

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

vim.cmd([[
  syntax enable
  syntax sync minlines=512
]])
vim.opt.synmaxcol = 500

-- log report
vim.opt.report = 0

-- redraw config
vim.opt.ttyfast = true
vim.opt.lazyredraw = false

-- tab and indent config
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.softtabstop = 1
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftround = true
vim.opt.backspace = "indent,eol,start"

-- pair match
vim.opt.showmatch = true
vim.opt.matchtime = 0
vim.opt.matchpairs:append({
  "<:>",
  "《:》",
  "（:）",
  "【:】",
  "“:”",
  "‘:’",
})

-- fold config
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- other config
vim.opt.conceallevel = 0
vim.opt.maxmempattern = 5000

-- quick fix key map
--[[ In the quickfix window, <CR> is used to jump to the error under the
cursor, so undefine the mapping there. ]]
vim.cmd("autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>")

-- complete opt
vim.opt.completeopt = "menuone,noinsert"
