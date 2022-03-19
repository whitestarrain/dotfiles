
"------------------------------------auto-pairs-------------------------------------
"括号补全
" Plug 'jiangmiao/auto-pairs'
Plug 'windwp/nvim-autopairs'
"------------------------------------auto-pairs-------------------------------------
"------------------------------------auto-pair-------------------------------------

autocmd User LoadPluginConfig call PlugConfigAutoPair()
function! PlugConfigAutoPair()

lua<<EOF

  require('nvim-autopairs').setup({

  })

 local present, cmp = pcall(require, 'cmp')

  -- 为cmp自动添加括号
  -- If you want insert `(` after select function or method item
  if present then
    -- 为cmp自动添加括号
    -- If you want insert `(` after select function or method item
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

    -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
    cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
  end

EOF

endfunction

"------------------------------------auto-pair-------------------------------------
