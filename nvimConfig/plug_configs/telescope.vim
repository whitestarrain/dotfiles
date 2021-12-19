Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" 文件模糊查找

autocmd vimenter * call PlugConfigTelescope()
function! PlugConfigTelescope()
  nnoremap <silent><leader>ff :Telescope git_files<CR>
  let g:which_key_map.f.f = 'fzf-file'

  nnoremap <silent><leader>fb :Telescope buffers<CR>
  nnoremap <silent><leader>/ :Telescope buffers<CR>
  let g:which_key_map.f.b = 'fzf-buffer'

  nnoremap <silent><leader>fa :Telescope<CR>
  let g:which_key_map.f.a = 'all_find_command'
endfunction

