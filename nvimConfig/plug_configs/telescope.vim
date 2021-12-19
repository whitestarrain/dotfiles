Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" 文件模糊查找


autocmd vimenter * call PlugConfigTelescope()
function! PlugConfigTelescope()

lua <<EOF
require('telescope').setup{
  defaults={
    -- lua regex
    file_ignore_patterns={
      "%.png",
      "%.jpg",
      "%.jpeg",
      "%.exe",
      "%.pdf",
      "%.doc",
      "%.docx",
      "%.tux",
      "%.cache",
      ".git"
    }
  }
}
EOF

nnoremap <silent><leader>ff :Telescope git_files<CR>
let g:which_key_map.f.f = 'find buffers'

nnoremap <silent><leader>fb :Telescope buffers<CR>
nnoremap <silent><leader>/ :Telescope buffers<CR>
let g:which_key_map.f.b = 'find files'

nnoremap <silent><leader>fc :Telescope commands<CR>
let g:which_key_map.f.c = 'find command'

nnoremap <silent><leader>fa :Telescope<CR>
let g:which_key_map.f.a = 'all_find_command'

nnoremap <silent><leader>fg :Telescope live_grep<CR>
let g:which_key_map.f.f = 'all_find_command'

endfunction

