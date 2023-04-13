" mapping standard
let mapleader="\<space>"
let g:which_key_map =  {}
let g:which_key_map.z = { 'name' : '[second]' }
let g:which_key_map.s = { 'name' : '[startify]' }
let g:which_key_map.o = { 'name' : '[open in]' }
let g:which_key_map.h = { 'name' : '[hunk]' }
let g:which_key_map.f = { 'name' : '[find]' }
let g:which_key_map.b = { 'name' : '[buffer]' }
let g:which_key_map.c = { 'name' : '[code]' }
let g:which_key_map.h = { 'name' : '[hunk]' }

" By default timeoutlen is 1000 ms
set timeoutlen=500

"map syntax sync fromstart，大文件渲染
nnoremap <leader>p :syntax sync fromstart<cr>
let g:which_key_map.p = "syntax"

" wrap line 移动
nnoremap <silent>j gj
nnoremap <silent>k gk

" 设置插入模式下光标左右移动方式
inoremap <C-l> <Right>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>

" 分屏移动映射
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" 设置窗口大小调整快捷键
nnoremap <silent><c-left> :vertical resize -1<CR>
nnoremap <silent><c-right> :vertical resize +1<CR>
nnoremap <silent><c-up> :resize +1<CR>
nnoremap <silent><c-down> :resize -1<CR>

" 设置缓冲区跳转
noremap <M-h> :bp<cr>
noremap <M-l> :bn<cr>

"设置路径为当前文件所在路径
nnoremap <silent><leader>zp :cd %:h<cr>
let g:which_key_map.z.p = "setPathNow"

nnoremap <silent>o A<cr>

nnoremap <silent><leader>d :bp\|bd # <cr>
let g:which_key_map.d = "deleteBuf"

nnoremap <silent><leader>w :w <cr>
let g:which_key_map.w = "writeBuf"

nnoremap < <<
nnoremap > >>

" 使用中括号进行跳转
" 设置tab跳转
noremap ]t :tabnext <cr>
noremap [t :tabpre<cr>

" open in ...
nnoremap <silent><leader>ob :!chrome %:p <cr> <cr>
nnoremap <silent><leader>ov :!code % <cr> <cr>
let g:which_key_map.o.b = "browser"
let g:which_key_map.o.v = "vscode"

" 压缩空行
nnoremap <leader>zl :g/^$/,/./-j<cr> :/jj<cr>
let g:which_key_map.z.l = "compress empty line"

" markmap 编译
nnoremap <silent><leader>zk :!markmap %  <cr> 
let g:which_key_map.z.k = "markmap"

" 终端模式返回普通模式
tnoremap <c-[> <c-\><c-n>
"上面一句已经包含了<esc>的映射: https://stackoverflow.com/questions/21947783/mapping-to-c-but-not-overriding-esc
tnoremap <Esc> <C-\><C-n> 

" 显示完整文件路径
nnoremap <leader>zf :echo expand("%:p")<cr>
let g:which_key_map.z.f = "show full path"

" 剪切板粘贴
nnoremap <silent><A-p> "+p

" win: disable man
if has("win32")
  nnoremap K <nop>
endif
