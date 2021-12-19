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
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- 
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
EOF

nnoremap <silent><leader>ff :Telescope find_files<CR>
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

