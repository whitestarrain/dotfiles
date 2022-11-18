Plug 'hrsh7th/vim-vsnip' " snippet 引擎
Plug 'rafamadriz/friendly-snippets' "提供一堆snip


autocmd User LoadPluginConfig call PlugConfigSnippet()

function! PlugConfigSnippet()

  let g:vsnip_snippet_dir = g:absolute_config_path  . "./others/.snippet""
  " Jump forward or backward
  imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
  imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
  smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

endfunction
