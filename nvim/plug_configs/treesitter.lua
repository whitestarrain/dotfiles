
-- NOTE: 手动卸载重装吧，最好不要使用:PlugUpdate进行更新

vim.cmd([[
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
  Plug 'p00f/nvim-ts-rainbow'
  " Plug 'romgrk/nvim-treesitter-context'
  " Plug 'nvim-treesitter/nvim-treesitter-refactor'
  " Plug'nvim-treesitter/playground'
]])

require("au")["User LoadPluginConfig"] = function()
	require("nvim-treesitter.configs").setup({
		-- 安装 language parser。默认不自动安装
		-- :TSInstallInfo 命令查看支持的语言
		-- DEPN: :TSInstall <lang>
		ensure_installed = {
			-- "html", "css", "vim", "lua", "javascript", "typescript", "tsx", "rust", "python", "java"
		},
		-- 启用代码高亮功能
		highlight = {
			enable = true,
			disable = { "markdown" },
			additional_vim_regex_highlighting = false,
		},
		-- 启用增量选择
		incremental_selection = {
			enable = true,
			disable = { "markdown" },
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				node_decremental = "<BS>",
				-- scope_incremental = '<TAB>',
			},
		},
		-- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.

		-- 大多数语言插件会提供indent，个别可以按照需要开启
		indent = {
			disable = true,
			enable = { "vue" },
		},
		rainbow = {
			enable = true,
			disable = { "markdown" },
			-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
			extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			max_file_lines = nil, -- Do not enable for files with more than n lines, int
			-- colors = {}, -- table of hex strings
			-- termcolors = {} -- table of colour name strings
		},
	})
	-- 开启 Folding
	vim.wo.foldmethod = "expr"
	vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
	-- 默认不要折叠
	-- https://stackoverflow.com/questions/8316139/how-to-set-the-default-to-unfolded-when-you-open-a-file
	vim.wo.foldlevel = 99
end

-- 高亮模块  TSBufferToggle highlight 可以查看效果
-- indent模块：gg=G格式化代码，或者高亮选择
-- 增量选择模块：进入可视模式后，enter和Backspace增量选择控制
-- fold模块：zc ,zo zC,zO
