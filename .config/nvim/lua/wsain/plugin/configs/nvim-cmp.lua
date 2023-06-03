local plugin = require("wsain.plugin.template"):new()

plugin.shortUrl = "hrsh7th/nvim-cmp"
plugin.loadEvent = "VeryLazy"
plugin.dependencies = {
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "saadparwaiz1/cmp_luasnip",
  "lukas-reineke/cmp-under-comparator",
  "onsails/lspkind-nvim",
  {
    "L3MON4D3/LuaSnip",
    -- make sure build env is prepared
    build = function () print("(luasnip)please run: make install_jsregexp") end,
    dependencies = { "rafamadriz/friendly-snippets", "honza/vim-snippets" },
  },
}
plugin.config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  --load friendly-snippets
  require("luasnip.loaders.from_vscode").lazy_load()
  -- load vim-snippets
  require("luasnip.loaders.from_snipmate").lazy_load()
  -- load custom snippets
  require("luasnip.loaders.from_snipmate").lazy_load({ paths = vim.g.absolute_config_path .. "others/.snippet" })
  -- can't load vscode snippets without install_jsregexp
  -- require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.absolute_config_path .. "others/.snippet" })

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

  local menuIcon = {
    nvim_lsp = "NLSP",
    nvim_lua = "NLUA",
    luasnip = "LSNP",
    vsnip = "SNIP",
    luasnip = "SNIP",
    buffer = "BUFF",
    path = "PATH",
    cmdline = "CMD",
  }

  local lspkind_format = {
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol",
      with_text = true,
      maxwidth = 20,
      ellipsis_char = "…",
      before = function(entry, vim_item)
        vim_item.menu = "(" .. vim_item.kind .. ")"
        return vim_item
      end,
    }),
  }

  local amp_sources = {
    { name = "nvim_lsp", priority = 10 },
    { name = "path", priority = 5 },
    { name = "luasnip", priority = 4 },
  }

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    -- snippet engine
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    window = {
      completion = {
        border = border("CmpBorder"),
        winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel",
      },
      documentation = {
        border = border("CmpDocBorder"),
        winhighlight = "Normal:CmpDoc",
      },
    },

    -- 来源
    sources = cmp.config.sources(amp_sources),

    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<A-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<CR>"] = cmp.mapping.confirm({
        select = true,
      }),
      -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    },

    formatting = lspkind_format,

    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        require("cmp-under-comparator").under,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
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

return plugin
