-- improve startup time
vim.loader.enable()

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
vim.opt.confirm = true
vim.opt.virtualedit = "block"

-- show config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8
vim.opt.linespace = 0
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.regexpengine = 0
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "screen"
vim.opt.laststatus = 3
vim.opt.hidden = true
vim.opt.signcolumn = "auto:2"
vim.opt.list = false

vim.cmd([[
  syntax enable
  syntax sync minlines=512
  syntax sync maxlines=512
]])
vim.opt.synmaxcol = 1500

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

-- enable(default) editorconfig
vim.g.editorconfig = true
-- disable auto wrap line
require("editorconfig").properties.max_line_length = function() end

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

-- complete opt
vim.opt.completeopt = "menu,menuone,noinsert"

-- pmenu(popup-menu) config
vim.opt.pumheight = 15

-- wildmenu config
vim.opt.wildmode = "longest:full,full"
-- change wildchar to avoid conflict with cmp plugin
vim.cmd([[set wildchar=<C-x>]])

-- highlight
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.pumblend = 0
vim.opt.background = "dark"

-- disable default sql autocompletion mapping
vim.g.omni_sql_no_default_maps = 1
