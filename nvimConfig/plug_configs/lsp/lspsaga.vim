" lsp ui美化
" 一个fort分支，修了原来分支的bug
Plug 'tami5/lspsaga.nvim'

autocmd User LoadPluginConfig call PlugConfigLspUi()

function! PlugConfigLspUi()

lua <<EOF


EOF

"  nnoremap <silent> gh :Lspsaga lsp_finder<CR>
"  nnoremap <silent> <leader>ca :Lspsaga code_action<CR>
"  nnoremap <silent> K :Lspsaga hover_doc<CR>
"  nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
"  nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
"  nnoremap <silent> gs :Lspsaga signature_help<CR>
"  nnoremap <silent> gr :Lspsaga rename<CR>
"  nnoremap <silent> gd :Lspsaga preview_definition<CR>

endfunction
