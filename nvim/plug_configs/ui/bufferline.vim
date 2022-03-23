Plug 'akinsho/bufferline.nvim'

autocmd User LoadPluginConfig call PlugConfigBufferLine()

function PlugConfigBufferLine()

lua <<EOF

  local separator_style = "thin"
  if(not vim.env.term) then
    -- nvim-qt
    separator_style = "slant"
  end
  require("bufferline").setup {
      options = {
          -- 使用 nvim 内置lsp
          diagnostics = "nvim_lsp",
          separator_style = separator_style,
          -- 左侧让出 nvim-tree 的位置
          offsets = {{
              filetype = "NvimTree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "center"
          }},
          -- 默认icon
          indicator_icon = '▎',
          buffer_close_icon = '',
          modified_icon = '●',
          close_icon = '',
          left_trunc_marker = '',
          right_trunc_marker = '',
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


EOF

  noremap <M-h> :BufferLineCyclePrev<CR>
  noremap <M-l> :BufferLineCycleNext<CR>

endfunction

if strlen($term)>0
  " for opacity in terminal
  autocmd ColorScheme * hi BufferLineFill guibg=NONE ctermbg=NONE
endif

