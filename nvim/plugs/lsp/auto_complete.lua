vim.cmd([[
  " 补全插件
  Plug 'hrsh7th/nvim-cmp'

  " 补全来源
  if len(g:code_language_list)>0
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
  local status, cmp = pcall(require, "cmp")
  if not status or cmp == nil then
    return
  end

  -- 图标设置
  local function border(hl_name)
    return {
      { "╭", hl_name },
      { "─", hl_name },
      { "╮", hl_name },
      { "│", hl_name },
      { "╯", hl_name },
      { "─", hl_name },
      { "╰", hl_name },
      { "│", hl_name },
    }
  end
  local lspkind = require("lspkind")
  lspkind.init({
    mode = "symbol",
    preset = "codicons",
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

  local lspkind_format = {
    format = lspkind.cmp_format({
      with_text = true,
      maxwidth = 40,
      before = function(entry, vim_item)
        -- Source 显示提示来源
        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
        return vim_item
      end,
    }),
  }

  -- 补全选项
  vim.o.completeopt = "menu"

  -- 自动补全设置
  local amp_sources = {
    { name = "path", priority = 5 },
    { name = "vsnip", priority = 4 },
  }

  -- 编程模式,lsp补全
  if #vim.g.code_language_list > 0 then
    table.insert(amp_sources, { name = "nvim_lsp", priority = 10 })
    -- table.insert(amp_sources, { name = 'buffer', priority = 1 })
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
      completion = {
        -- border = border("CmpBorder"),
        -- winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel",
      },
      documentation = {
        border = border("CmpDocBorder"),
      },
    },

    -- 来源
    sources = cmp.config.sources(amp_sources),

    -- 快捷键
    mapping = {
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
      ["<CR>"] = cmp.mapping.confirm({
        select = true,
      }),
      -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    },

    -- 使用lspkind-nvim显示类型图标
    formatting = lspkind_format,
  })

  -- Use buffer source for `/`.
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
    formatting = lspkind_format,
  })

  -- Use cmdline & path source for ':'.
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
    formatting = lspkind_format,
  })
end
