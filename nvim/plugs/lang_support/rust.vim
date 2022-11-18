Plug 'rust-lang/rust.vim'
Plug 'tenfyzhong/tagbar-rust.vim'

autocmd User LoadPluginConfig call PlugConfigRust()

function! PlugConfigRust()
  " 保存时代码自动格式化
  let g:rustfmt_autosave = 1
  " vnoremap <leader>rf :RustFmtRange<CR>
  " nnoremap <leader>rt :RustFmt<CR>
  " nnoremap <leader>rr :RustRun<CR>
endfunction
