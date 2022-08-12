" encoding config
set encoding=utf-8
set langmenu=zh_CN.UTF-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 
set fileencoding=utf-8
set nocompatible

" basic config
filetype plugin indent on  " Load plugins according to detected filetype.
filetype on                " 开启文档类型检查
set noswapfile
set updatetime=100
set number              " 设置行号
set relativenumber      " 相对行号
set nowrap                 " No Wrap lines 不自动换行
set scrolloff=3
set linespace=0            " 行距
set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.
set re=1                   " 设置regex模式
set incsearch              " 设置增量搜索
set hlsearch               " 设置搜索高亮
set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.
set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

" tab and indent config
set smarttab               " Be smart when using tabs ;)
set expandtab              " Use spaces instead of tabs.
set softtabstop=1          " softtabstop 表示在编辑模式的时候按退格键的时候退回缩进的长度，当使用 expandtab时特别有用。
set shiftwidth=2           " shiftwidth 表示每一级缩进的长度，一般设置成跟 softtabstop 一样。
set tabstop=2              " 设置一个tab的空格长度
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype md setlocal ts=2 sw=2 expandtab
autocmd Filetype markdown setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype java setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype coffeescript setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype cpp setlocal ts=4 sw=4 sts=0 expandtab
autocmd Filetype c setlocal ts=4 sw=4 sts=0 expandtab
set autoindent             " 设置自动缩进
set smartindent            " Smart indent
set shiftround             " >> indents to next multiple of 'shiftwidth'.
set backspace=indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus=2         " Always show statusline.
set display=lastline  " Show as much as possible of the last line.

" 中文符号配对
set showmatch matchtime=0 matchpairs+=<:>,《:》,（:）,【:】,“:”,‘:’

" highlight
set cursorline
set wrapscan         " Searches wrap around end-of-file.
set report=0         " Always report changed lines.
augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END
syntax enable " 语法高亮
syntax sync minlines=256
set synmaxcol=5000

" theme config
set termguicolors
set background=dark

" other config
set maxmempattern=5000 " 提高限制
set foldmethod=indent
set foldlevelstart=99       " 打开文件是默认不折叠代码
set conceallevel=0 " 语法隐藏相关，不进行语法隐藏

