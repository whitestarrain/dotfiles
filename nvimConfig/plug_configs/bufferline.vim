Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
" Plug 'ryanoasis/vim-devicons' Icons without colours
Plug 'akinsho/bufferline.nvim'


autocmd vimenter * call PlugConfigBufferLine()

function PlugConfigBufferLine()


lua <<EOF

  vim.opt.termguicolors = true
  require("bufferline").setup {
      options = {
          -- 使用 nvim 内置lsp
          diagnostics = "nvim_lsp",
          -- 左侧让出 nvim-tree 的位置
          offsets = {{
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left"
          }}
      }
  }

  -- bufferline 左右Tab切换，buffer已经设置了，这个就不用了
  -- map("n", "<M-h>", ":BufferLineCyclePrev<CR>", opt)
  -- map("n", "<M-l>", ":BufferLineCycleNext<CR>", opt)

EOF

endfunction


