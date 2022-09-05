vim.cmd([[
  Plug 'akinsho/bufferline.nvim'
]])

require("au")["User LoadPluginConfig"] = function()
	local separator_style = "slant"
	if vim.g.colors_name == "neosolarized" then
		separator_style = { "", "" }
	end
	require("bufferline").setup({
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
			indicator_icon = " ",
			buffer_close_icon = "",
			show_buffer_icons = false,
			modified_icon = "●",
			close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			show_buffer_close_icons = false,
			show_close_icon = false,
			-- 显示lsp报错图标
			---@diagnostic disable-next-line: unused-local
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local s = " "
				-- if context.buffer:current() then
				--   return s
				-- end
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and " " or (e == "warning" and " " or "")
					s = s .. n .. sym
				end
				return s
			end,
		},
	})

	vim.cmd([[
    noremap <M-h> :BufferLineCyclePrev<CR>
    noremap <M-l> :BufferLineCycleNext<CR>
  ]])
end

vim.cmd([[
  if strlen($term)>0
    " for opacity in terminal
    autocmd ColorScheme * hi BufferLineFill guibg=NONE ctermbg=NONE
  endif
]])
