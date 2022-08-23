Plug 'liuchengxu/vista.vim'

autocmd User LoadPluginConfig call PlugConfigVista()

" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_icon_indent = ["▸ ", ""]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  " \ 'c++': 'nvim_lsp',
  " \ 'c': 'nvim_lsp',
  " \ 'javascript': 'nvim_lsp',
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']


function! PlugConfigVista()
  augroup VistaMap
      autocmd!
      " autocmd FileType javascript nnoremap <buffer> <leader>t :Vista<CR>
      " autocmd FileType typescript nnoremap <buffer> <leader>t :Vista<CR>
  augroup END
endfunction
