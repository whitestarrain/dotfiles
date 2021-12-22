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
          }},
          -- 显示lsp报错图标
          ---@diagnostic disable-next-line: unused-local
          diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local s = " "
            -- if context.buffer:current() then
            --   return s
            -- end
            for e, n in pairs(diagnostics_dict) do
              local sym = e == "error" and " "
                or (e == "warning" and " " or "" )
              s = s .. n .. sym
            end
            return s
          end
      }
  }

  -- bufferline 左右Tab切换，buffer已经设置了，这个就不用了
  -- map("n", "<M-h>", ":BufferLineCyclePrev<CR>", opt)
  -- map("n", "<M-l>", ":BufferLineCycleNext<CR>", opt)

EOF


endfunction

if strlen($term)>0
  " for opacity in terminal
  autocmd ColorScheme * hi BufferLineFill guibg=NONE ctermbg=NONE
endif

