vim.cmd([[
  Plug 'akinsho/bufferline.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
  local status, bufferline = pcall(require, "bufferline")
  if not status then
    return
  end
  local separator_style = "slant"
  if vim.g.colors_name == "neosolarized" then
    separator_style = { "", "" }
  end

  bufferline.setup({
    options = {
      -- 使用 nvim 内置lsp
      diagnostics = "nvim_lsp",
      separator_style = separator_style,
      -- 左侧让出 nvim-tree 的位置
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "center",
        },
      },
      -- 默认icon
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      indicator = {
        icon = " ",
        style = "icon",
      },
      -- 显示设置
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_buffer_icons = true,
      -- 显示lsp报错图标
      ---@diagnostic disable-next-line: unused-local
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        -- if context.buffer:current() then
        --   return s
        -- end
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end,
    },
    --[[
    --highlights theme for neosolarized
		highlights = {
			fill = {
				guibg = "#073642",
			},
			separator = {
				guifg = "#002b36",
				guibg = "#073642",
			},
			separator_selected = {
				guifg = "#002b36",
			},
			background = {
				guibg = "#073642",
			},
			buffer_selected = {
				guifg = "#fdf6e3",
			},
			modified = {
				guibg = "#073642",
			},
		},
  ]]
  })

  vim.cmd([[
    noremap <M-h> :BufferLineCyclePrev<CR>
    noremap <M-l> :BufferLineCycleNext<CR>
  ]])
end
