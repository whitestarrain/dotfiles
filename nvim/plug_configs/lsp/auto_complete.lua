-- DEPN: git checkout -b use 71d7f46
-- 最新版本和当前配置不兼容。有时间再调
-- 新版本中c-n需要手动配置 https://github.com/hrsh7th/nvim-cmp/commit/93cf84f7deb2bdb640ffbb1d2f8d6d412a7aa558

vim.cmd([[

" 补全插件
Plug 'hrsh7th/nvim-cmp'

" 补全来源

if g:load_program 
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer' " 编辑文档比较多，一般还是别开buffer补全了
endif

Plug 'hrsh7th/cmp-path' "路径补全一定要加
Plug 'hrsh7th/cmp-cmdline' " 命令模式补全
Plug 'hrsh7th/cmp-nvim-lua'

Plug 'hrsh7th/cmp-vsnip' " vsnip snippet 补全。 NOTE: 切换snip插件也要切换这个

" 图标
Plug 'onsails/lspkind-nvim' "代码提示中，显示分类的小图标支持

]])

require("au")["User LoadPluginConfig"] = function()
	-- 图标设置
	local lspkind = require("lspkind")
	lspkind.init({
		-- default: true
		-- with_text = true,
		-- defines how annotations are shown
		-- default: symbol
		-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
		mode = "symbol_text",
		-- default symbol map
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		--
		-- default: 'default'
		preset = "codicons",
		-- override preset symbols
		--
		-- default: {}
		symbol_map = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	})

	-- 自动补全设置
	local cmp = require("cmp")

	-- 补全选项
	vim.g.completeopt = "menu,menuone,noinsert"

	-- 快捷键配置
	local cmp_keymap = function(cmp)
		return {
			-- 上一个
			["<C-p>"] = cmp.mapping.select_prev_item(),
			-- 下一个
			["<C-n>"] = cmp.mapping.select_next_item(),
			-- doc浏览
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			-- 补全
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			-- 出现补全
			["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			-- 取消
			["<A-,>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			-- 确认
			-- Accept currently selected item. If none selected, `select` first item.
			-- Set `select` to `false` to only confirm explicitly selected items.
			["<CR>"] = cmp.mapping.confirm({
				select = true,
				-- behavior = cmp.ConfirmBehavior.Replace
			}),
			-- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		}
	end

	local amp_sources = {
		{ name = "path", priority = 5 },
		{ name = "vsnip", priority = 4 },
	}

	-- 编程模式,lsp补全
	if 1 == vim.g.load_program then
		table.insert(amp_sources, { name = "nvim_lsp", priority = 10 })
		-- table.insert(amp_sources,{ name = 'buffer', priority = 1 })
		-- buffer补全暂不开启
	end

	---@diagnostic disable-next-line: redundant-parameter
	cmp.setup({
		-- 指定 snippet 引擎
		snippet = {
			expand = function(args)
				-- For `vsnip` users.
				vim.fn["vsnip#anonymous"](args.body)

				-- For `luasnip` users.
				-- require('luasnip').lsp_expand(args.body)

				-- For `ultisnips` users.
				-- vim.fn["UltiSnips#Anon"](args.body)

				-- For `snippy` users.
				-- require'snippy'.expand_snippet(args.body)
			end,
		},

		window = {
			-- completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},

		-- 来源
		sources = cmp.config.sources(amp_sources),

		-- 快捷键
		mapping = cmp_keymap(cmp),

		-- 使用lspkind-nvim显示类型图标
		formatting = {
			format = lspkind.cmp_format({
				with_text = true, -- do not show text alongside icons
				maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
				before = function(entry, vim_item)
					-- Source 显示提示来源
					vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
					return vim_item
				end,
			}),
		},
	})

	-- Use buffer source for `/`.
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- Use cmdline & path source for ':'.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{ name = "cmdline" },
		}),
	})
end
