" 暂时不用，集合性太大，甚至能debug。

Plug 'ray-x/go.nvim'

autocmd User LoadPluginConfig call PlugConfigGolang()

function PlugConfigGolang()

lua <<EOF
require 'go'.setup({
  goimport = 'gopls', -- if set to 'gopls' will use golsp format
  gofmt = 'gopls', -- if set to gopls will use golsp format
  max_line_len = 120,
  tag_transform = false,
  test_dir = '',
  comment_placeholder = '   ',
  lsp_cfg = true, -- false: use your own lspconfig
  lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = false, -- use on_attach from go.nvim
  dap_debug = false,
})

local protocol = require'vim.lsp.protocol'

EOF

endfunction
